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

	public HashMap<VariableExpression, varQuery> varQMap; // query variable map
	private HashMap<SingleComplaint, ArrayList<HashMap<String, varX>>> varXMap; // complaint-where
																				// clause
																				// satisfactory
																				// conditions
																				// map

	private Boolean[] queryStatus; // query status: true, already processed;
									// false otherwise

	private static double TIMELIMTI = 120; // maximum time to escape from cplex
											// solver

	private static double NOTEXIST = Double.MAX_VALUE; // value for null

	ArrayList<IloConstraint> constraints = new ArrayList<IloConstraint>();

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
	public Linearization(double epsilon_, double M_, DatabaseStates badDss_,
			QueryLog fixedQueries_, Complaint complaints_,
			HashMap<VariableExpression, varQuery> varQMap_,
			HashMap<SingleComplaint, ArrayList<HashMap<String, varX>>> varXMap_) {
		epsilon = epsilon_;
		M = M_;
		digits = (int) Math.pow(10, (double) (String.valueOf(epsilon).length()
				- String.valueOf(epsilon).lastIndexOf(".") - 1));
		badDss = badDss_;
		fixedQueries = fixedQueries_;
		complaints = complaints_;
		table = badDss.get(0).getTable();
		varQMap = varQMap_;
		varXMap = varXMap_;
		queryStatus = new Boolean[fixedQueries.size()];
		for (int i = 0; i < queryStatus.length; ++i) {
			queryStatus[i] = false;
		}
		constraints.clear();
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
		if (!print)
			cplex.setOut(null);
		constraints.clear();
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
	public void fixParameters(IloCplex cplex, List<String> currAttrs,
			int batchsize, long[] times) throws Exception {
		// prepare variables
		double bestobjval = Double.MAX_VALUE;
		HashMap<VariableExpression, varQuery> bestvars = null;
		HashMap<SingleComplaint, ArrayList<HashMap<String, varX>>> bestvarxs = null;
		// time variable
		long starttime = 0, endtime = 0;
		// add constraints
		HashMap<String, Integer> attrs = new HashMap<String, Integer>();
		for (int i = 0; i < currAttrs.size(); ++i) {
			attrs.put(currAttrs.get(i), i);
		}
		for (int i = 0; i < fixedQueries.size(); i = i + batchsize) {
			// prepare: clean model
			if (print)
				System.out.println("Start solving : clear model");
			// clear model
			this.clear(cplex);

			// decide the end current processing index
			starttime = System.nanoTime();
			int endidx = fixedQueries.size() > i + batchsize ? i + batchsize
					: fixedQueries.size();
			// create current variable map and current variable X map
			HashMap<VariableExpression, varQuery> curvars = clonevarQMap(varQMap);
			HashMap<SingleComplaint, ArrayList<HashMap<String, varX>>> curxs = clonevarXMap(varXMap);
			IloNumExpr objpart1 = addConstraints(cplex, attrs, curvars, curxs,
					i, endidx);

			// add objective function
			IloNumExpr objpart2 = addObjective(cplex, curvars);
			IloObjective maxobj = cplex.addMinimize(cplex.sum(objpart1,
					objpart2));
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
				// compare objective value
				double objval = cplex.getObjValue();
				if (objval < bestobjval) {
					bestobjval = objval;
					bestvars = curvars;
					bestvarxs = curxs;
					// get fixed value
					for (varQuery var : bestvars.values()) {
						if (var.incurrentcycle) {
							var.incurrentcycle = false;
							var.fixedval = (double) Math.round(cplex
									.getValue(var.var) * digits)
									/ digits;
						}
					}
					// solve value for each complaint
					for (SingleComplaint scp : curxs.keySet()) {
						ArrayList<HashMap<String, varX>> scpcurxs = curxs
								.get(scp);
						int count = 0;
						for (HashMap<String, varX> querycurxs : scpcurxs) {
							if (queryStatus[count++]) {
								for (varX var : querycurxs.values()) {
									if (var.solvedval == -1) {
										var.solvedval = (double) Math
												.round(cplex.getValue(var.var)
														* digits)
												/ digits;
										// System.out.println(scp + ":" +
										// var.expr + " :" + var.solvedval);
									}
								}
							}
						}
					}
				}
			}
			cplex.remove(maxobj);
			endtime = System.nanoTime();
			times[3] += endtime - starttime;
		}
		// save the best solution with minimum objective value
		if (bestvars != null && bestvarxs != null) {
			// update query variable map
			varQMap = bestvars;
			// update varX variable map
			varXMap = bestvarxs;
		}
	}

	/**
	 * Function addObjective: add objective function for variables in the query
	 * log
	 * 
	 * @param cplex
	 *            IloCplex
	 * @param curVars
	 *            current variable map
	 */
	public IloNumExpr addObjective(IloCplex cplex,
			HashMap<VariableExpression, varQuery> curvars) throws Exception {
		IloNumExpr vardiff = cplex.numVar(Double.MIN_VALUE, Double.MAX_VALUE);
		ArrayList<IloNumExpr> difflist = new ArrayList<IloNumExpr>();
		for (varQuery var : curvars.values()) {
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
	 * @param varQMap
	 *            variable map
	 * @param varXMap
	 *            complaint-where clause satisfactory conditions map
	 * @param startidx
	 *            start query index to fix
	 * @param endidx
	 *            end query index to fix
	 * @throws Exception
	 */
	public IloNumExpr addConstraints(IloCplex cplex,
			HashMap<String, Integer> attrs,
			HashMap<VariableExpression, varQuery> varQMap,
			HashMap<SingleComplaint, ArrayList<HashMap<String, varX>>> varXMap,
			int startidx, int endidx) throws Exception {

		// add constraints
		IloNumExpr compldiff;
		ArrayList<IloNumExpr> difflist = new ArrayList<IloNumExpr>();
		for (SingleComplaint scp : complaints.compmap.values()) {
			// create initial variable list
			IloNumVar[] prestate = cplex.numVarArray(attrs.size(),
					Double.MIN_VALUE, Double.MAX_VALUE);
			IloNumVar[] nextstate = prestate;
			for (int i = 0; i < fixedQueries.size(); ++i) {
				// get current query
				Query query = fixedQueries.get(i);
				// if current query already considered or set attribute in the
				// current currAttrs set
				boolean proceed = this.queryStatus[i];
				for (String attr : query.getSetAttr()) {
					if (attrs.containsKey(attr))
						proceed |= true;
					if (proceed)
						break;
				}
				this.queryStatus[i] |= proceed;
				if (!proceed) {
					// skip current query
					continue;
				}
				// check if query is in the current fix range
				boolean fix = i >= startidx && i < endidx;
				nextstate = addTuplePerQuery(cplex, query, nextstate, scp,
						attrs, varQMap, varXMap.get(scp).get(i), fix);
				// add objective value
				int index = 0;
				for (varX var : varXMap.get(scp).get(i).values()) {
					if (var.solvedval == -1) {
						// when current variable is not solved yet
						difflist.add(cplex.abs(cplex.diff(var.var, var.origval)));
					} else {
						// add constraints on processed varX
						double solvedval = var.solvedval > 0.5 ? 1 : 0;
						constraints.add(cplex.addEq(var.var, solvedval));
					}
				}
			}
			// get initial value and final value for the current complaint
			String[] initialval = badDss.get(0).getTuple(scp.key).values;
			String[] finalval = scp.values;
			// add corresponding constraints
			addEqCondition(cplex, varQMap, attrs, prestate, initialval);
			addEqCondition(cplex, varQMap, attrs, nextstate, finalval);
		}
		IloNumExpr[] list = difflist.toArray(new IloNumExpr[difflist.size()]);
		compldiff = cplex.sum(list);
		return compldiff;
	}

	/**
	 * Function addEqCondition : add equivalent constraints on initial database
	 * state and final correct database state
	 */
	public void addEqCondition(IloCplex cplex,
			HashMap<VariableExpression, varQuery> varQMap,
			HashMap<String, Integer> attrs, IloNumVar[] varary, String[] values)
			throws Exception {
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
			HashMap<String, Integer> attrs,
			HashMap<VariableExpression, varQuery> varQMap,
			HashMap<String, varX> scpvarXMap, boolean fix) throws Exception {
		// define next database states
		IloNumVar[] nextstate = null;
		IloNumVar X = cplex.numVar(0, 1);
		// decide actions for current query
		switch (query.getType()) {
		case UPDATE:
			this.addWhere(cplex, query.getWhere(), X, prestate, attrs, varQMap,
					scpvarXMap, fix); // add conditions for where clause
			nextstate = this.addSet(cplex, query.getSet(), X, prestate, attrs,
					varQMap, scpvarXMap, fix);
			break;
		case INSERT:
			nextstate = this.addOther(cplex, query, X, prestate, attrs,
					varQMap, scpvarXMap, fix);
			break;
		case DELETE:
			this.addWhere(cplex, query.getWhere(), X, prestate, attrs, varQMap,
					scpvarXMap, fix);
			nextstate = this.addOther(cplex, query, X, prestate, attrs,
					varQMap, scpvarXMap, fix);
			break;
		default:
			break;
		}
		return nextstate;
	}

	/** Function addOther : add constraints for Insert query and Delete query */
	public IloNumVar[] addOther(IloCplex cplex, Query query, IloNumVar X,
			IloNumVar[] prestate, HashMap<String, Integer> attrs,
			HashMap<VariableExpression, varQuery> varQMap,
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
				nextvalue = query.getValue().get(idx)
						.convertExpr(cplex, attrs, prestate, varQMap, fix);
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
			HashMap<VariableExpression, varQuery> varQMap,
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
						prestate, varQMap, fix);
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
			HashMap<VariableExpression, varQuery> varQMap,
			HashMap<String, varX> scpvarXMap, boolean fix) throws Exception {
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
							cplex, attrs, prestate, varQMap, fix);
					IloNumExpr right = whereexpr.getVarExpr().convertExpr(
							cplex, attrs, prestate, varQMap, fix);
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
