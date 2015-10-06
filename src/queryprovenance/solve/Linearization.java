package queryprovenance.solve;

import ilog.concert.IloConstraint;
import ilog.concert.IloNumExpr;
import ilog.concert.IloNumVar;
import ilog.concert.IloObjective;
import ilog.concert.IloRange;
import ilog.cplex.IloCplex;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;

import queryprovenance.database.DatabaseStates;
import queryprovenance.database.Table;
import queryprovenance.expression.Expression;
import queryprovenance.expression.VariableExpression;
import queryprovenance.problemsolution.Complaint;
import queryprovenance.problemsolution.QueryLog;
import queryprovenance.problemsolution.SingleComplaint;
import queryprovenance.query.Query;
import queryprovenance.query.SetClause;
import queryprovenance.query.SetExpr;
import queryprovenance.query.WhereClause;
import queryprovenance.query.WhereExpr;

public class Linearization {
	// Define class for linearization process
	public class LinearizationProcs {
		public int num_solved_var = 0; // number of query that already solved
		public int num_var_to_solve = 0; // number of query to be solved
		public boolean stop_procs = false; // finish searching all variables
		public Boolean[] query_status; // current status of query: true: solved;
										// false: otherwise.
		public int num_cplex_var = 0;
	}

	// maximum time to escape from cplex solver
	private static final double TIMELIMTI = 1;
	// value for null
	private static final double NOTEXIST = Double.MIN_VALUE;

	// Solver parameters
	public FixQueryLogParams params;
	public LinearizationProcs linearization_procs = new LinearizationProcs();

	// Problem related: querylog, databasestate, table definition and complaint
	// set.
	private QueryLog fixedQueries; // querylog to fix
	private DatabaseStates badDss; // bad database states
	private Complaint complaints; // complaints
	private Table table; // table

	// Solver related: objective value, variable map
	// varQMap: variables in query log
	// varXMap: satisfactory variables for each complaint
	private double objVal = 0;
	public HashMap<VariableExpression, varQuery> varQMap;
	private HashMap<SingleComplaint, ArrayList<HashMap<String, varX>>> varXMap;

	// Solved variables.
	private HashSet<Integer> queryToFix; // list of query to parameterize
	public HashSet<varQuery> querySolvedVar = new HashSet<varQuery>(); // variables
																		// get
																		// solved
	public HashMap<Query, varX> queryRemoveList; // query to be removed

	// Constraints for cplex solver
	ArrayList<IloConstraint> cplexConstraints = new ArrayList<IloConstraint>();

	/**
	 * Initialize Linearization
	 * 
	 * @param epsilon_
	 *            epsilon for inequalities: 0~1
	 * @param M_
	 *            M for a large number above domain maximum
	 * @param badDss_
	 *            Bad database states
	 * @param fixedQueries_
	 *            query log to fix
	 * @param complaints_
	 *            Complaints
	 * @param varQMap_
	 *            variable map for queries
	 * @param varXMap_
	 *            complaint-where clause satisfactory conditions map
	 * @throws Exception 
	 * 
	 * */
	public Linearization(
			DatabaseStates badDss_,
			QueryLog fixedQueries_,
			Complaint complaints_,
			HashMap<VariableExpression, varQuery> varQMap_,
			HashMap<SingleComplaint, ArrayList<HashMap<String, varX>>> varXMap_,
			HashSet<Integer> queryToFix_, FixQueryLogParams params_) throws Exception {
		params = params_;
		badDss = badDss_;
		fixedQueries = fixedQueries_;
		complaints = complaints_;
		table = badDss.get(0).getTable();
		varQMap = clonevarQMap(varQMap_);
		varXMap = clonevarXMap(varXMap_);
		queryRemoveList = new HashMap<Query, varX>();
		linearization_procs.query_status = new Boolean[fixedQueries.size()];
		for (int i = 0; i < fixedQueries.size(); ++i) {
			linearization_procs.query_status[i] = false;
		}
		cplexConstraints.clear();
		queryToFix = queryToFix_;
		// update remaining variables to solve
		for (int i : queryToFix) {
			linearization_procs.num_var_to_solve += fixedQueries.get(i)
					.getVariable().size();
		}
	}

	/**
	 * Function clear: clear model
	 * 
	 * @param cplex
	 *            IloCplex
	 * @throws Exception
	 */
	public void clear(IloCplex cplex) throws Exception {
		cplex.clearModel();
		cplex.setParam(IloCplex.IntParam.PrePass, 4);
		cplex.setParam(IloCplex.DoubleParam.TiLim, TIMELIMTI);
		cplex.setWarning(null);
		if (!params.print)
			cplex.setOut(null);
		cplexConstraints.clear();
	}

	/**
	 * Function fixParameters: fix parameters for current query log
	 * 
	 * @param cplex
	 *            IloCplex
	 * @param currAttrs
	 *            current attribute list to fix
	 * @param batchsize
	 *            batch size, solve k queries at a time 1 ~ total number of
	 *            queries
	 * @param times
	 *            execution time
	 * */
	public HashMap<VariableExpression, varQuery> fixParameters(IloCplex cplex,
			List<String> curr_attrs, long[] times, int startidx)
			throws Exception {

		// time variable
		long starttime = 0, endtime = 0;
		// add constraints
		HashMap<String, Integer> attrs_map = new HashMap<String, Integer>();
		for (int i = 0; i < curr_attrs.size(); ++i) {
			attrs_map.put(curr_attrs.get(i), i);
		}
		// prepare: clean model
		if (params.print)
			System.out.println("Start solving : clear model ");
		// clear model
		this.clear(cplex);

		// decide the end current processing index
		starttime = System.nanoTime();
		// create current variable map and current variable X map
		HashSet<varQuery> current_var = new HashSet<varQuery>();
		HashSet<varX> current_x = new HashSet<varX>();
		IloNumExpr query_sat_obj = addConstraints(cplex, attrs_map,
				current_var, current_x, startidx);

		// add objective function
		IloNumExpr query_var_obj = addObjective(cplex);
		IloObjective maxobj;
		if (params.objective_full) {
			maxobj = cplex.addMinimize(cplex.sum(query_sat_obj, query_var_obj));
		} else {
			maxobj = cplex.addMinimize(query_var_obj);
		}
		endtime = System.nanoTime();
		times[1] += endtime - starttime;

		// solve
		starttime = System.nanoTime();
		boolean solved = cplex.solve();
		endtime = System.nanoTime();
		times[2] += endtime - starttime;

		// process result
		starttime = System.nanoTime();

		if (solved) {

			// get fixed value

			for (varQuery var : current_var) {
				var.fixedval = (double) Math.round(cplex.getValue(var.var)
						* params.precision)
						/ params.precision;
				querySolvedVar.add(var);
				objVal += Math.abs(var.fixedval - var.expr.getValue());
				// System.out.println(var.expr + ":" + var.fixedval);
			}
			linearization_procs.num_solved_var += current_var.size();
			if (linearization_procs.num_solved_var < linearization_procs.num_var_to_solve
					&& attrs_map.size() < table.getColumns().length) {

				// solve value for each complaint
				for (varX x : current_x) {
					if (x.solvedval == -1) {
						double sat = (double) Math.round(cplex.getValue(x.var)
								* params.precision)
								/ params.precision;
						x.solvedval = sat == 1 ? 1.0 : 0.0;
						// System.out.println(
						// x.expr + " : " + x.solvedval);
					}
				}
			} else {
				linearization_procs.stop_procs = true;
			}
			linearization_procs.num_cplex_var = current_var.size()
					+ current_x.size();
		}
		endtime = System.nanoTime();
		times[3] += endtime - starttime;
		cplex.remove(maxobj);
		if (solved) {
			return varQMap;
		} else {
			return null;
		}
	}

	public double getObjective() {
		return objVal;
	}

	/**
	 * Function addObjective: add objective function for variables in the query
	 * log
	 * 
	 * @param cplex
	 *            IloCplex
	 */
	public IloNumExpr addObjective(IloCplex cplex) throws Exception {
		IloNumExpr vardiff = cplex.numVar(Double.MIN_VALUE, Double.MAX_VALUE);
		ArrayList<IloNumExpr> var_difflist = new ArrayList<IloNumExpr>();
		for (varQuery var : varQMap.values()) {
			if (var.incurrentcycle && var.fixedval == Double.MAX_VALUE) {
				var_difflist.add(cplex.abs(cplex.diff(var.var,
						var.expr.getValue())));
			}
		}
		IloNumExpr[] list = var_difflist.toArray(new IloNumExpr[var_difflist
				.size()]);
		vardiff = cplex.prod(10, cplex.sum(list));
		return vardiff;
	}

	/**
	 * Function addConstraints: add constraints for the subproblem
	 * 
	 * @param cplex
	 *            IloCplex
	 * @param attr
	 *            attribute-index map
	 * @param queryToFix
	 *            list of queries to fix
	 * @throws Exception
	 */
	public IloNumExpr addConstraints(IloCplex cplex,
			HashMap<String, Integer> attrs_map, HashSet<varQuery> current_var,
			HashSet<varX> current_x, int startidx) throws Exception {

		// add constraints
		IloNumExpr compldiff;
		ArrayList<IloNumExpr> x_difflist = new ArrayList<IloNumExpr>();
		// get proceed information
		boolean[] proceed = new boolean[fixedQueries.size()];
		for (int i = startidx; i < fixedQueries.size(); ++i) {
			proceed[i] = false;
			Query query = fixedQueries.get(i);
			// if current query already considered or set attribute in the
			// current currAttrs set
			for (String attr : query.getWhereAttr()) {
				if (attrs_map.containsKey(attr)) {
					proceed[i] |= true;
					break;
				}
			}
			if (params.fix_all_query) {
				proceed[i] &= linearization_procs.query_status[i];
			}
			for (String attr : query.getSetAttr()) {
				if (attrs_map.containsKey(attr)) {
					proceed[i] |= true;
					linearization_procs.query_status[i] = true;
					break;
				}
			}
		}
		// start processing
		for (SingleComplaint scp : complaints.compmap.values()) {
			// create initial variable list
			IloNumVar[] prestate = cplex.numVarArray(attrs_map.size(),
					Double.MIN_VALUE, Double.MAX_VALUE);
			IloNumVar[] nextstate = prestate;
			for (int i = startidx; i < fixedQueries.size(); ++i) {
				// get current query
				Query query = fixedQueries.get(i);
				if (!proceed[i]) {
					// skip current query
					continue;
				}
				// check if query is in the current fix range
				boolean fix = queryToFix.contains(i);
				nextstate = addTuplePerQuery(cplex, query, nextstate, scp,
						attrs_map, varXMap.get(scp).get(i), current_var, fix,
						x_difflist, current_x);
			}
			// get initial value and final value for the current complaint
			String[] initialval = badDss.get(startidx).getTuple(scp.key).values;
			String[] finalval = scp.values;
			// add corresponding constraints
			addEqCondition(cplex, attrs_map, prestate, initialval);
			addEqCondition(cplex, attrs_map, nextstate, finalval);
		}
		IloNumExpr[] list = x_difflist
				.toArray(new IloNumExpr[x_difflist.size()]);
		compldiff = cplex.sum(list);
		return compldiff;
	}

	/**
	 * Function addEqCondition : add equivalent constraints on initial database
	 * state and final correct database state
	 */
	public void addEqCondition(IloCplex cplex,
			HashMap<String, Integer> attrs_map, IloNumVar[] cplex_varary,
			String[] org_valary) throws Exception {
		// for each variable
		for (String attr : attrs_map.keySet()) {
			int varidx = attrs_map.get(attr);
			int idx = table.getColumnIdx(attr);
			try {
				double value = org_valary == null || org_valary[idx] == null ? NOTEXIST
						: Double.valueOf(org_valary[idx]);
				
				cplexConstraints.add(cplex.addEq(cplex_varary[varidx], value));
			} catch (Exception e) {
				System.out.println(org_valary[idx]);
				boolean temp = org_valary == null || org_valary[idx] == null;
				throw e;
			}
			/*
			 * check conflict constraints IloConstraint[] constraintsary =
			 * constraints.toArray(new IloConstraint[constraints.size()]);
			 * double[] prefs = new double[constraintsary.length]; for (int c1 =
			 * 0; c1 < constraintsary.length; c1++) {
			 * //System.out.println(constraints[c1]); prefs[c1] = 1.0;//change
			 * it per your requirements } if (
			 * cplex.refineConflict(constraintsary, prefs) ) { ConflictStatus[]
			 * conflict = cplex.getConflict(constraintsary); int i = 0;
			 * for(IloConstraint con : constraintsary) { System.out.println(con
			 * + ":" + conflict[i++]); } } for (varQuery var : varQMap.values())
			 * { if(var.incurrentcycle) {
			 * System.out.print(cplex.getValue(var.var)); } }
			 */
		}
	}

	/**
	 * Function addTuplePerQuery : add constraints for given complaint and query
	 */
	public IloNumVar[] addTuplePerQuery(IloCplex cplex, Query query,
			IloNumVar[] prestate, SingleComplaint scp,
			HashMap<String, Integer> attrs_map,
			HashMap<String, varX> scpvarXMap, HashSet<varQuery> current_var,
			boolean fix, ArrayList<IloNumExpr> x_difflist,
			HashSet<varX> current_x) throws Exception {
		// define next database states
		IloNumVar[] nextstate = null;
		IloNumVar X = cplex.numVar(0, 1);
		// decide actions for current query
		switch (query.getType()) {
		case UPDATE:
			this.addWhere(cplex, query.getWhere(), X, prestate, attrs_map,
					scpvarXMap, current_var, fix, x_difflist, current_x); // add
																			// conditions
																			// for
																			// where
			// clause
			nextstate = this.addSet(cplex, query.getSet(), X, prestate,
					attrs_map, scpvarXMap, current_var, fix);
			break;
		case INSERT:
			varX x = scpvarXMap.get(query.toString());
			current_x.add(x);
			nextstate = this.addOther(cplex, query, x.var, prestate, attrs_map,
					scpvarXMap, current_var, fix);
			if (!queryRemoveList.containsKey(query)) {
				queryRemoveList.put(query, x);
			}
			break;
		case DELETE:
			this.addWhere(cplex, query.getWhere(), X, prestate, attrs_map,
					scpvarXMap, current_var, fix, x_difflist, current_x);
			nextstate = this.addOther(cplex, query, X, prestate, attrs_map,
					scpvarXMap, current_var, fix);
			break;
		default:
			break;
		}

		// add number of variables
		return nextstate;
	}

	/** Function addOther : add constraints for Insert query and Delete query */
	public IloNumVar[] addOther(IloCplex cplex, Query query, IloNumVar X,
			IloNumVar[] prestate, HashMap<String, Integer> attrs_map,
			HashMap<String, varX> scpvarXMap, HashSet<varQuery> current_var,
			boolean fix) throws Exception {
		// create one variable for the insert query
		IloNumVar[] nextstate = cplex.numVarArray(prestate.length,
				Double.MIN_VALUE, Double.MAX_VALUE);
		for (String attr : attrs_map.keySet()) {
			int idx = attrs_map.get(attr);
			IloNumExpr nextvalue = null;
			if (query.getType() == Query.Type.DELETE) {
				cplexConstraints.add(cplex.addEq(nextvalue, NOTEXIST));
			} else {
				nextvalue = query
						.getValue()
						.get(idx)
						.convertExpr(cplex, attrs_map, prestate, varQMap,
								current_var, fix);
			}
			// linearize
			// create for previous value
			IloNumVar pre = cplex.numVar(Double.MIN_VALUE, Double.MAX_VALUE);
			cplexConstraints.add(cplex.addLe(pre, prestate[idx]));
			cplexConstraints.add(cplex.addLe(pre,
					cplex.prod(cplex.diff(1, X), params.M)));
			cplexConstraints.add(cplex.addGe(pre,
					cplex.diff(prestate[idx], cplex.prod(X, params.M))));

			// create for set value
			IloNumVar next = cplex.numVar(Double.MIN_VALUE, Double.MAX_VALUE);
			cplexConstraints.add(cplex.addLe(next, nextvalue));
			cplexConstraints.add(cplex.addLe(next, cplex.prod(X, params.M)));
			cplexConstraints.add(cplex.addGe(
					next,
					cplex.diff(nextvalue,
							cplex.prod(cplex.diff(1, X), params.M))));

			// add condition
			cplexConstraints.add(cplex.addEq(nextstate[idx],
					cplex.sum(pre, next)));
		}

		return nextstate;
	}

	/** Function addSet : add constraints for set clause */
	public IloNumVar[] addSet(IloCplex cplex, SetClause set, IloNumVar X,
			IloNumVar[] prestate, HashMap<String, Integer> attrs_map,
			HashMap<String, varX> scpvarXMap, HashSet<varQuery> current_var,
			boolean fix) throws Exception {
		List<SetExpr> setexprs = set.getSetExprs();
		IloNumVar[] nextstate = cplex.numVarArray(prestate.length,
				Double.MIN_VALUE, Double.MAX_VALUE);
		HashSet<String> modified = new HashSet<String>();
		for (int i = 0; i < setexprs.size(); ++i) {
			// get attribute modified by current set function
			SetExpr setexpr = setexprs.get(i);
			Expression attr = setexpr.getAttr();
			// get set function expression
			Expression setfunc = setexpr.getExpr();
			if (attrs_map.containsKey(attr.toString())) {
				// get the index of modified attribute
				int idx = attrs_map.get(attr.toString());

				IloNumExpr nextvalue = setfunc.convertExpr(cplex, attrs_map,
						prestate, varQMap, current_var, fix);
				// create for previous value
				IloNumVar pre = cplex
						.numVar(Double.MIN_VALUE, Double.MAX_VALUE);
				cplexConstraints.add(cplex.addLe(pre, prestate[idx]));
				cplexConstraints.add(cplex.addLe(pre,
						cplex.prod(cplex.diff(1, X), params.M)));
				cplexConstraints.add(cplex.addGe(pre,
						cplex.diff(prestate[idx], cplex.prod(X, params.M))));

				// create for set value
				IloNumVar next = cplex.numVar(Double.MIN_VALUE,
						Double.MAX_VALUE);
				cplexConstraints.add(cplex.addLe(next, nextvalue));
				cplexConstraints
						.add(cplex.addLe(next, cplex.prod(X, params.M)));
				cplexConstraints.add(cplex.addGe(
						next,
						cplex.diff(nextvalue,
								cplex.prod(cplex.diff(1, X), params.M))));

				// add condition
				cplexConstraints.add(cplex.addEq(nextstate[idx],
						cplex.sum(pre, next)));
				modified.add(attr.toString());
			}
		}
		// connect attributes that are not modified
		for (String attr : attrs_map.keySet()) {
			if (!modified.contains(attr)) {
				// maintain the same value
				int idx = attrs_map.get(attr);
				cplexConstraints
						.add(cplex.addEq(nextstate[idx], prestate[idx]));
			}
		}
		return nextstate;
	}

	/** Function addWhere : add constraints for where clause */
	public void addWhere(IloCplex cplex, WhereClause where, IloNumVar X,
			IloNumVar[] prestate, HashMap<String, Integer> attrs,
			HashMap<String, varX> scpvarXMap, HashSet<varQuery> current_var,
			boolean fix, ArrayList<IloNumExpr> x_difflist,
			HashSet<varX> current_x) throws Exception {
		List<WhereExpr> whereexprs = where.getWhereExprs();
		IloConstraint[] cons = new IloConstraint[scpvarXMap.size()];
		for (int i = 0; i < whereexprs.size(); ++i) {
			WhereExpr whereexpr = whereexprs.get(i);
			varX x = scpvarXMap.get(whereexpr.toString());
			boolean current_expr = false;
			// check if current where clause should be considered
			for (String attr : whereexpr.attrs) {
				if (attrs.containsKey(attr)) {
					current_expr = true;
					// consider current where expression
					IloNumExpr left = whereexpr.getAttrExpr().convertExpr(
							cplex, attrs, prestate, varQMap, current_var, fix);
					IloNumExpr right = whereexpr.getVarExpr().convertExpr(
							cplex, attrs, prestate, varQMap, current_var, fix);
					WhereExpr.Op op = whereexpr.getOperator();
					IloNumExpr condition = null;
					switch (op) {
					case g:
						condition = cplex.ge(left,
								cplex.sum(params.epsilon, right));
						break;
					case l:
						condition = cplex.le(left,
								cplex.sum(-params.epsilon, right));
						break;
					case ge:
						condition = cplex.ge(left, right);
						break;
					case le:
						condition = cplex.le(left, right);
						break;
					case eq:
						condition = cplex.eq(left, right);
						break;
					case ne:
						condition = cplex.eq(cplex.eq(left, right), 0);
						break;
					}
					cplexConstraints.add(cplex.addEq(x.var, condition));
					break;
				}
			}
			cons[i] = cplex.eq(x.var, 1);
			// currentX.add(x);
			// add objective value
			if (x.solvedval == -1) {
				// when current variable is not solved yet
				x_difflist.add(cplex.abs(cplex.diff(x.var, x.origval)));
				current_x.add(x);
				
			} else {
				// add constraints on processed varX
				double solvedval = x.solvedval == 1 ? 1 : 0;
				cplexConstraints.add(cplex.addEq(x.var, solvedval));
			}
		}
		if (where.getOperator().equals(WhereClause.Op.CONJ)) {
			// every condition must satisfy 'isTrue' value
			cplexConstraints.add(cplex.addEq(X, cplex.and(cons)));
		} else {
			// one of the consition must satisfy 'isTrue' value
			cplexConstraints.add(cplex.addEq(X, cplex.or(cons)));
		}
	}

	/** Function clonevarQMap : clone varQMap */
	public HashMap<VariableExpression, varQuery> clonevarQMap(
			HashMap<VariableExpression, varQuery> varmap) {
		// define cloned map
		HashMap<VariableExpression, varQuery> cloned = new HashMap<VariableExpression, varQuery>();
		for (VariableExpression key : varmap.keySet()) {
			cloned.put(key, varmap.get(key).clone());
		}
		return cloned;
	}

	/** Function clonevarXMap : clone varXMap */
	public HashMap<SingleComplaint, ArrayList<HashMap<String, varX>>> clonevarXMap(
			HashMap<SingleComplaint, ArrayList<HashMap<String, varX>>> varmap) {
		// define cloned map
		HashMap<SingleComplaint, ArrayList<HashMap<String, varX>>> cloned = new HashMap<SingleComplaint, ArrayList<HashMap<String, varX>>>();
		for (SingleComplaint scp : varmap.keySet()) {
			// add variable x list for each complaint
			ArrayList<HashMap<String, varX>> sublist = new ArrayList<HashMap<String, varX>>();
			for (HashMap<String, varX> map : varmap.get(scp)) {
				HashMap<String, varX> clonedmap = new HashMap<String, varX>();
				for (String str : map.keySet()) {
					clonedmap.put(str, map.get(str).clone());
				}
				sublist.add(clonedmap);
			}
			cloned.put(scp, sublist);
		}
		return cloned;
	}

}
