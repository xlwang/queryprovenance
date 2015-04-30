package queryprovenance.solve;

import ilog.concert.IloConstraint;
import ilog.concert.IloNumExpr;
import ilog.concert.IloNumVar;
import ilog.concert.IloObjective;
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

	private double epsilon;
	private double M;
	private int digits; // fix value precision

	private boolean print = false;

	private QueryLog fixedQueries; // fixed query log
	private DatabaseStates badDss; // bad database states
	private Complaint complaints; // complaints
	private Table table; // table

	private double objective = 0;
	public HashMap<VariableExpression, varQuery> varQMap; // query variable map
	private HashMap<SingleComplaint, ArrayList<HashMap<String, varX>>> varXMap; // complaint-where
																				// clause
																				// satisfactory
																				// conditions
																				// map
	private HashSet<Integer> queryToFix;
	public HashSet<varQuery> currentVar;
	public HashSet<varX> currentX;
	public HashMap<Query, varX> removeList;

	private int solvedvar = 0, remain = 0;
	public boolean stop = false;

	private Boolean[] queryStatus; // query status: true, already processed;
									// false otherwise

	private static double TIMELIMTI = 1; // maximum time to escape from cplex
											// solver

	private static double NOTEXIST = Double.MAX_VALUE; // value for null

	ArrayList<IloConstraint> constraints = new ArrayList<IloConstraint>();
	int variables = 0;

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
	 * 
	 * */
	public Linearization(
			double epsilon_,
			double M_,
			DatabaseStates badDss_,
			QueryLog fixedQueries_,
			Complaint complaints_,
			HashMap<VariableExpression, varQuery> varQMap_,
			HashMap<SingleComplaint, ArrayList<HashMap<String, varX>>> varXMap_,
			HashSet<Integer> queryToFix_) {
		epsilon = epsilon_;
		M = M_;
		digits = (int) Math.pow(10, (double) (String.valueOf(epsilon).length()
				- String.valueOf(epsilon).lastIndexOf(".") - 1));
		badDss = badDss_;
		fixedQueries = fixedQueries_;
		complaints = complaints_;
		table = badDss.get(0).getTable();
		varQMap = clonevarQMap(varQMap_);
		varXMap = clonevarXMap(varXMap_);
		removeList = new HashMap<Query, varX>();
		queryStatus = new Boolean[fixedQueries.size()];
		for (int i = 0; i < queryStatus.length; ++i) {
			queryStatus[i] = false;
		}
		constraints.clear();
		queryToFix = queryToFix_;
		// update remaining variables to solve
		remain = 0;
		for (int i : queryToFix) {
			remain += fixedQueries.get(i).getVariable().size();
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
		if (!print)
			cplex.setOut(null);
		constraints.clear();
		currentVar = new HashSet<varQuery>();
		currentX = new HashSet<varX>();
		variables = 0;
	}

	/**
	 * Function setPrint: change print preference
	 * 
	 * @param p_
	 *            true, print cplex status; false otherwise
	 */
	public void setPrint(boolean p_) {
		print = p_;
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
			List<String> currAttrs, long[] times, int startidx)
			throws Exception {

		// time variable
		long starttime = 0, endtime = 0;
		// add constraints
		HashMap<String, Integer> attrs = new HashMap<String, Integer>();
		for (int i = 0; i < currAttrs.size(); ++i) {
			attrs.put(currAttrs.get(i), i);
		}
		// prepare: clean model
		if (print)
			System.out.println("Start solving : clear model");
		// clear model
		this.clear(cplex);

		// decide the end current processing index
		starttime = System.nanoTime();
		// create current variable map and current variable X map
		IloNumExpr objpart1 = addConstraints(cplex, attrs, startidx);

		// add objective function
		IloNumExpr objpart2 = addObjective(cplex);
		// IloObjective maxobj = cplex.addMinimize(cplex.sum(objpart1,
		// objpart2));
		IloObjective maxobj = cplex.addMinimize(objpart2);
		endtime = System.nanoTime();
		times[1] += endtime - starttime;

		// solve
		starttime = System.nanoTime();
		boolean solved = cplex.solve();
		endtime = System.nanoTime();
		times[2] += endtime - starttime;
		// System.out.println(endtime -starttime);

		// process result
		starttime = System.nanoTime();

		if (solved) {

			// get fixed value

			for (varQuery var : currentVar) {
				var.fixedval = (double) Math.round(cplex.getValue(var.var)
						* digits)
						/ digits;
				objective += Math.abs(var.fixedval - var.expr.getValue());
				// System.out.println(var.expr + ":" + var.fixedval);
			}
			solvedvar += currentVar.size();
			if (solvedvar < remain && attrs.size() < table.getColumns().length) {

				// solve value for each complaint
				for (varX x : currentX) {
					if (x.solvedval == -1) {
						double sat = (double) Math.round(cplex.getValue(x.var)
								* digits)
								/ digits;
						x.solvedval = sat == 1 ? 1.0 : 0.0;
						//System.out.println(
						//x.expr + " : " + x.solvedval);
					}
				}
			} else {
				stop = true;
			}
		}
		variables += currentVar.size() + currentX.size();
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
		return objective;
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
		ArrayList<IloNumExpr> difflist = new ArrayList<IloNumExpr>();
		for (varQuery var : varQMap.values()) {
			if (var.incurrentcycle && var.fixedval == Double.MAX_VALUE) {
				difflist.add(cplex.abs(cplex.diff(var.var, var.expr.getValue())));
			}
		}
		IloNumExpr[] list = difflist.toArray(new IloNumExpr[difflist.size()]);
		vardiff = cplex.prod(100000, cplex.sum(list));
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
			HashMap<String, Integer> attrs, int startidx) throws Exception {

		// add constraints
		IloNumExpr compldiff;
		ArrayList<IloNumExpr> difflist = new ArrayList<IloNumExpr>();
		// get proceed information
		boolean[] proceed = new boolean[fixedQueries.size()];
		for (int i = startidx; i < fixedQueries.size(); ++i) {
			proceed[i] = false;
			Query query = fixedQueries.get(i);
			// if current query already considered or set attribute in the
			// current currAttrs set
			for (String attr : query.getWhereAttr()) {
				if (attrs.containsKey(attr)) {
					proceed[i] |= true;
					break;
				}
			}
			proceed[i] &= this.queryStatus[i];
			for (String attr : query.getSetAttr()) {
				if (attrs.containsKey(attr)) {
					proceed[i] |= true;
					this.queryStatus[i] = true;
					break;
				}
			}
		}
		// start processing
		for (SingleComplaint scp : complaints.compmap.values()) {
			// create initial variable list
			IloNumVar[] prestate = cplex.numVarArray(attrs.size(),
					Double.MIN_VALUE, Double.MAX_VALUE);
			variables += attrs.size();
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
						attrs, varXMap.get(scp).get(i), fix, difflist);
			}
			// get initial value and final value for the current complaint
			String[] initialval = badDss.get(startidx).getTuple(scp.key).values;
			String[] finalval = scp.values;
			// add corresponding constraints
			addEqCondition(cplex, attrs, prestate, initialval);
			addEqCondition(cplex, attrs, nextstate, finalval);
		}
		IloNumExpr[] list = difflist.toArray(new IloNumExpr[difflist.size()]);
		compldiff = cplex.sum(list);
		return compldiff;
	}

	/**
	 * Function addEqCondition : add equivalent constraints on initial database
	 * state and final correct database state
	 */
	public void addEqCondition(IloCplex cplex, HashMap<String, Integer> attrs,
			IloNumVar[] varary, String[] values) throws Exception {
		// for each variable
		for (String attr : attrs.keySet()) {
			int varidx = attrs.get(attr);
			int idx = table.getColumnIdx(attr);
			double value = values == null ? NOTEXIST : Double
					.valueOf(values[idx]);
			constraints.add(cplex.addEq(varary[varidx], value));
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
			HashMap<String, Integer> attrs, HashMap<String, varX> scpvarXMap,
			boolean fix, ArrayList<IloNumExpr> difflist) throws Exception {
		// define next database states
		IloNumVar[] nextstate = null;
		IloNumVar X = cplex.numVar(0, 1);
		// decide actions for current query
		switch (query.getType()) {
		case UPDATE:
			this.addWhere(cplex, query.getWhere(), X, prestate, attrs,
					scpvarXMap, fix, difflist); // add conditions for where
												// clause
			nextstate = this.addSet(cplex, query.getSet(), X, prestate, attrs,
					scpvarXMap, fix);
			break;
		case INSERT:
			varX x = scpvarXMap.get(query.toString());
			currentX.add(x);
			nextstate = this.addOther(cplex, query, x.var, prestate, attrs,
					scpvarXMap, fix);
			if(!removeList.containsKey(query)) {
				removeList.put(query, x);
			}
			break;
		case DELETE:
			this.addWhere(cplex, query.getWhere(), X, prestate, attrs,
					scpvarXMap, fix, difflist);
			nextstate = this.addOther(cplex, query, X, prestate, attrs,
					scpvarXMap, fix);
			break;
		default:
			break;
		}
		
		// add number of variables
		variables += nextstate.length + 1;
		return nextstate;
	}

	/** Function addOther : add constraints for Insert query and Delete query */
	public IloNumVar[] addOther(IloCplex cplex, Query query, IloNumVar X,
			IloNumVar[] prestate, HashMap<String, Integer> attrs,
			HashMap<String, varX> scpvarXMap, boolean fix) throws Exception {
		// create one variable for the insert query
		IloNumVar[] nextstate = cplex.numVarArray(prestate.length,
				Double.MIN_VALUE, Double.MAX_VALUE);
		for (String attr : attrs.keySet()) {
			int idx = attrs.get(attr);
			IloNumExpr nextvalue = null;
			if (query.getType() == Query.Type.DELETE) {
				constraints.add(cplex.addEq(nextvalue, NOTEXIST));
			} else {
				nextvalue = query
						.getValue()
						.get(idx)
						.convertExpr(cplex, attrs, prestate, varQMap,
								currentVar, fix);
			}
			// linearize
			// create for previous value
			IloNumVar pre = cplex.numVar(Double.MIN_VALUE, Double.MAX_VALUE);
			constraints.add(cplex.addLe(pre, prestate[idx]));
			constraints.add(cplex.addLe(pre, cplex.prod(cplex.diff(1, X), M)));
			constraints.add(cplex.addGe(pre,
					cplex.diff(prestate[idx], cplex.prod(X, M))));

			// create for set value
			IloNumVar next = cplex.numVar(Double.MIN_VALUE, Double.MAX_VALUE);
			constraints.add(cplex.addLe(next, nextvalue));
			constraints.add(cplex.addLe(next, cplex.prod(X, M)));
			constraints.add(cplex.addGe(next,
					cplex.diff(nextvalue, cplex.prod(cplex.diff(1, X), M))));

			// add condition
			constraints.add(cplex.addEq(nextstate[idx], cplex.sum(pre, next)));
		}
		
		return nextstate;
	}

	/** Function addSet : add constraints for set clause */
	public IloNumVar[] addSet(IloCplex cplex, SetClause set, IloNumVar X,
			IloNumVar[] prestate, HashMap<String, Integer> attrs,
			HashMap<String, varX> scpvarXMap, boolean fix) throws Exception {
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
			if (attrs.containsKey(attr.toString())) {
				// get the index of modified attribute
				int idx = attrs.get(attr.toString());

				IloNumExpr nextvalue = setfunc.convertExpr(cplex, attrs,
						prestate, varQMap, currentVar, fix);
				// create for previous value
				IloNumVar pre = cplex
						.numVar(Double.MIN_VALUE, Double.MAX_VALUE);
				constraints.add(cplex.addLe(pre, prestate[idx]));
				constraints.add(cplex.addLe(pre,
						cplex.prod(cplex.diff(1, X), M)));
				constraints.add(cplex.addGe(pre,
						cplex.diff(prestate[idx], cplex.prod(X, M))));

				// create for set value
				IloNumVar next = cplex.numVar(Double.MIN_VALUE,
						Double.MAX_VALUE);
				constraints.add(cplex.addLe(next, nextvalue));
				constraints.add(cplex.addLe(next, cplex.prod(X, M)));
				constraints
						.add(cplex.addGe(
								next,
								cplex.diff(nextvalue,
										cplex.prod(cplex.diff(1, X), M))));

				// add condition
				constraints.add(cplex.addEq(nextstate[idx],
						cplex.sum(pre, next)));
				modified.add(attr.toString());
			}
		}
		// connect attributes that are not modified
		for (String attr : attrs.keySet()) {
			if (!modified.contains(attr)) {
				// maintain the same value
				int idx = attrs.get(attr);
				constraints.add(cplex.addEq(nextstate[idx], prestate[idx]));
			}
		}
		return nextstate;
	}

	/** Function addWhere : add constraints for where clause */
	public void addWhere(IloCplex cplex, WhereClause where, IloNumVar X,
			IloNumVar[] prestate, HashMap<String, Integer> attrs,
			HashMap<String, varX> scpvarXMap, boolean fix,
			ArrayList<IloNumExpr> difflist) throws Exception {
		List<WhereExpr> whereexprs = where.getWhereExprs();
		IloConstraint[] cons = new IloConstraint[scpvarXMap.size()];
		for (int i = 0; i < whereexprs.size(); ++i) {
			WhereExpr whereexpr = whereexprs.get(i);
			varX x = scpvarXMap.get(whereexpr.toString());
			// check if current where clause should be considered
			for (String attr : whereexpr.attrs) {
				if (attrs.containsKey(attr)) {
					// consider current where expression
					IloNumExpr left = whereexpr.getAttrExpr().convertExpr(
							cplex, attrs, prestate, varQMap, currentVar, fix);
					IloNumExpr right = whereexpr.getVarExpr().convertExpr(
							cplex, attrs, prestate, varQMap, currentVar, fix);
					WhereExpr.Op op = whereexpr.getOperator();
					IloNumExpr condition = null;
					switch (op) {
					case g:
						condition = cplex.ge(left, cplex.sum(epsilon, right));
						break;
					case l:
						condition = cplex.le(left, cplex.sum(-epsilon, right));
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
					constraints.add(cplex.addEq(x.var, condition));
					break;
				}
			}
			cons[i] = cplex.eq(x.var, 1);
			// currentX.add(x);
			// add objective value
			if (x.solvedval == -1) {
				// when current variable is not solved yet
				difflist.add(cplex.abs(cplex.diff(x.var, x.origval)));
				currentX.add(x);
			} else {
				// add constraints on processed varX
				double solvedval = x.solvedval == 1 ? 1 : 0;
				constraints.add(cplex.addEq(x.var, solvedval));
			}
		}
		if (where.getOperator().equals(WhereClause.Op.CONJ)) {
			// every condition must satisfy 'isTrue' value
			constraints.add(cplex.addEq(X, cplex.and(cons)));
		} else {
			// one of the consition must satisfy 'isTrue' value
			constraints.add(cplex.addEq(X, cplex.or(cons)));
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
