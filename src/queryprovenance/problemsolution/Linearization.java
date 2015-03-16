package queryprovenance.problemsolution;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;

import ilog.concert.IloConstraint;
import ilog.concert.IloNumExpr;
import ilog.concert.IloNumVar;
import ilog.cplex.IloCplex;
import queryprovenance.database.DatabaseState;
import queryprovenance.database.DatabaseStates;
import queryprovenance.database.Table;
import queryprovenance.database.Tuple;
import queryprovenance.expression.Expression;
import queryprovenance.query.Query;
import queryprovenance.query.SetClause;
import queryprovenance.query.SetExpr;
import queryprovenance.query.WhereClause;
import queryprovenance.query.WhereExpr;

public class Linearization {
		
	private double epsilon;
	private double M;
	
	private HashMap<IloNumVar, Double> varmap; // variables to fix in the query
	private HashMap<Expression, IloNumVar> exprmap; // Expression variable map
	private HashMap<IloNumVar, Double> fixedmap; // fixed variables
	private HashMap<IloNumVar, Query> removemap;
	private HashMap<List<String>, IloNumVar[]> insrtmap;
	
	//ArrayList<IloNumVar> xlist; // to delete
	private HashMap<Tuple, IloNumVar[]> rollbackmap; // tuples need to rollback
	
	private HashMap<Query, ArrayList<IloNumVar>> varquerymap;
	
	private boolean print = false;
	
	
	long[] times = new long[3]; // execution time
	/* initialize */
	public Linearization(double e_, double m_) {
		
		epsilon = e_;
		M = m_;
		
		// initial variables
		varmap = new HashMap<IloNumVar, Double>();
		fixedmap = new HashMap<IloNumVar, Double>();
		exprmap = new HashMap<Expression, IloNumVar>();
		insrtmap = new HashMap<List<String>, IloNumVar[]>();
		rollbackmap = new HashMap<Tuple, IloNumVar[]>();
		removemap = new HashMap<IloNumVar, Query>();
		varquerymap = new HashMap<Query, ArrayList<IloNumVar>>();
		
	}
	
	/* clear model */
	public void clear() {
		varmap.clear();
		fixedmap.clear();
		exprmap.clear();
		insrtmap.clear();
		rollbackmap.clear();removemap.clear();
	}
	
	/* change print preference */
	public void setPrint(boolean p_) {
		print = p_;
	}
	/* solve parameter fix problem: baseline */	
	public QueryLog fixParameters(IloCplex cplex, Table table, QueryLog badqlog, DatabaseStates badds, Complaint compset, HashSet<Integer> candidate, int startidx, int endidx) throws Exception {
		if(print)
			System.out.println("Start solving : clear model");
		// clear model
		//IloEvn env;
		cplex.clearModel();
		if(!print)
			cplex.setOut(null);
		this.clear();
		// define constraint array
		ArrayList<IloConstraint> constraints = new ArrayList<IloConstraint>();
		// define fixed query log
		QueryLog qlogfix = new QueryLog();
		for(int i = 0; i < badqlog.size(); ++i) {
			qlogfix.add(badqlog.get(i).clone());
		}
		//System.out.println(qlogfix.size());
		// prepare conditions
		long starttime = System.nanoTime();
		if(print)
			System.out.println("Start solving : prepare constraints");
		this.addAll(cplex, constraints, table, qlogfix, badds, compset, true, candidate, startidx, endidx);
		long endtime = System.nanoTime();
		times[0] = endtime - starttime;
		
		
		// solve problem
		if(print)
			System.out.println("Start solving : solve");
		starttime = System.nanoTime();
		// cplex.setParam(IloCplex.DoubleParam.TimeLimit, 60);
		// cplex.setParam(IloCplex.IntParam.MIPOrdType, 3);
		
		//cplex.addMIPStart(arg0, arg1);
		
		boolean solved = cplex.solve();
	
		endtime = System.nanoTime();
		times[1] = endtime - starttime;
		//System.out.println("finish");
		// process result
		if(print)
			System.out.println("Start solving : process result");
		starttime = System.nanoTime();
		if(solved) {
			//System.out.println("End solving: " + cplex.getObjValue());
			// remove queries 
			HashSet<Query> removeset = new HashSet<Query>();
			for(IloNumVar var : removemap.keySet()) {
				int digits = (int) Math.pow(10, (double) (String.valueOf(epsilon).length() - String.valueOf(epsilon).lastIndexOf(".") - 1));
				 double value = (double) Math.round(cplex.getValue(var)*digits)/digits;
				 if(value == 0)
					 removeset.add(removemap.get(var));
			}
			//System.out.println("get values");
			 for(IloNumVar var : varmap.keySet()) {
				 int digits = (int) Math.pow(10, (double) (String.valueOf(epsilon).length() - String.valueOf(epsilon).lastIndexOf(".") - 1));
				 double value = (double) Math.round(cplex.getValue(var)*digits)/digits;
				 fixedmap.put(var, value);
			 }
			
            // convert querylog
			QueryLog temp = new QueryLog();
            for(int i = 0; i < qlogfix.size(); ++i) {
            	Query query = qlogfix.get(i);
            	if(!removeset.contains(query)) {
            		query.fix(fixedmap, exprmap);
            		query.fixInsert(fixedmap, insrtmap);
            		temp.add(query);
            	}
            }
            qlogfix = temp;
		} else {/* get solution when infeasible
			IloConstraint[] constraintsary = constraints.toArray(new IloConstraint[constraints.size()]);
			double[] prefs = new double[constraintsary.length];
            for (int c1 = 0; c1 < constraintsary.length; c1++)
            {
                //System.out.println(constraints[c1]);
                prefs[c1] = 1.0;//change it per your requirements
            }
            if(print)
    			System.out.println("infeasible solved" + cplex.feasOpt(constraintsary, prefs));*/
		}
		//System.out.println("done");
		endtime = System.nanoTime();
		times[2] = endtime - starttime;
		if(print)
			System.out.println("End solving");
		// return result
		cplex.endModel();
		if(solved)
			return qlogfix;
		else
			return null;
	}
	public Complaint rollBack(IloCplex cplex, Table table, QueryLog qlog, DatabaseStates badds, Complaint compset, int steps, int startidx, int endidx) throws Exception {
		// 
		if(startidx >= endidx)
			return compset;
		if (steps >= (endidx - startidx)) {
			return rollBack(cplex, table, qlog, badds, compset, startidx, endidx);
		} else {
			Complaint rolledback = compset;
			for(int i = endidx; i > startidx; i = i - steps) {
				int preidx = i - steps >= 0 ? i - steps : 0;
				rolledback = rollBack(cplex, table, qlog, badds, rolledback, preidx, preidx + steps);
			}
			return rolledback;
		}
	}
	/* roll back db states*/
	public Complaint rollBack(IloCplex cplex, Table table, QueryLog qlog, DatabaseStates badds, Complaint compset, int startidx, int endidx) throws Exception {
		// clear model
		cplex.clearModel();
		this.clear();
		ArrayList<IloConstraint> constraints = new ArrayList<IloConstraint>();
		
		Complaint rollback = new Complaint(); 
		QueryLog qlogback = new QueryLog();
		for(int i = 0; i < qlog.size(); ++i) {
			Query query = qlog.get(i);
			qlogback.add(query.clone());
		}
		
		// prepare conditions
		long starttime = System.nanoTime();
		this.addAll(cplex, constraints, table, qlogback, badds, compset, false, new HashSet<Integer>(), startidx, endidx);
		long endtime = System.nanoTime();
		times[0] = endtime - starttime;
		
		// solve problem
		starttime = System.nanoTime();
		boolean solved = cplex.solve();
		endtime = System.nanoTime();
		times[1] = endtime - starttime;
		
		// process result
		starttime = System.nanoTime();
		if(solved) {
			// get value for each tuple
			for(Tuple tuple : rollbackmap.keySet()) {
				IloNumVar[] vars = rollbackmap.get(tuple); // attribute values
				String[] values = new String[tuple.size()]; // rollbacked values
				for(int i = 0; i < vars.length; ++i) {
					IloNumVar var = vars[i]; // get variable 
					int digits = (int) Math.pow(10, (double) (String.valueOf(epsilon).length() - String.valueOf(epsilon).lastIndexOf(".") - 1));
					values[i] = String.valueOf((double) Math.round(cplex.getValue(var)*digits)/digits); // get value
				}
				// round key value
				int keyvalue = (int) Math.round(Double.valueOf(values[table.getKeyIdx()]));
				rollback.add(keyvalue, values); // update rollback list
			}	
		}
		endtime = System.nanoTime();
		times[2] = endtime - starttime;
		
		// return result
		return rollback;
		
	}
	
	/* construct the problem: add conditions & set objective function */
	public void addAll(IloCplex cplex, ArrayList<IloConstraint> constraints, Table table, QueryLog badqlog, DatabaseStates badds, Complaint compset, boolean fix, HashSet<Integer> candidate, int startidx, int endidx) throws Exception {
		// process each complaint in the complaint set
		//System.out.println(compset.size());
		for(Integer key : compset.keySet()) {
			if(key == null) {
				continue;
			}
			// get initial values from state0
			SingleComplaint cp = compset.get(key);
			DatabaseState state0 = badds.get(startidx);
			Tuple tupleinit= state0.getTuple(key);
			// get final values from complaint
			Tuple tuplefinl = new Tuple(table.getColumns().length, cp.values);
			// System.out.println(tuplefinl);
			// add conditions
			this.addTuple(cplex, constraints, table, badqlog, tupleinit, tuplefinl, fix, candidate, startidx, endidx);
		}
		//System.out.println(compset.size());
		// add objective function
		this.addObjective(cplex, constraints,  table, badds, fix);
		//this.addModificationSize(cplex, constraints, 1);
		
		
		//System.out.println("done");
	}
	public void addModificationSize(IloCplex cplex, ArrayList<IloConstraint> constraints, int k) throws Exception {
		IloNumVar sumy = cplex.numVar(Double.MIN_VALUE, Double.MAX_VALUE);
		IloNumVar[] y = cplex.numVarArray(varquerymap.size(), Double.MIN_VALUE, Double.MAX_VALUE);
		int count = 0;
		for(Query query : varquerymap.keySet()) {
			ArrayList<IloNumVar> list = varquerymap.get(query); // get list of variables
			IloConstraint[] constrs = new IloConstraint[list.size()];
			for(int i = 0; i < list.size(); ++i) {
				IloNumVar var = list.get(i);
				double orgval = varmap.get(var);
				constrs[i] = cplex.eq(var, orgval);
			}
			constraints.add(cplex.addEq(y[count++], cplex.diff(1, cplex.and(constrs))));
		}
		cplex.eq(sumy, cplex.sum(y));
		constraints.add(cplex.addLe(sumy, k));
	}
	/* add objective functions */
	public void addObjective(IloCplex cplex, ArrayList<IloConstraint> constraints, Table table, DatabaseStates badds, boolean fix) throws Exception {
		
		if(fix) {
			// add objective for fix parameters: minimize the difference from original parameters
			IloNumVar[] obj = cplex.numVarArray(varmap.size(), Double.MIN_VALUE, Double.MAX_VALUE);
			
			int i = 0;
			//IloNumVar[] variables = new IloNumVar[varmap.size()];
			//double[] orgvalues = new double[varmap.size()];
			for(IloNumVar var : varmap.keySet()){
				double orgval = varmap.get(var);
				//variables[i] = var;
				//orgvalues[i] = varmap.get(var);
				constraints.add(cplex.addEq(obj[i++], cplex.abs(cplex.diff(var, orgval))));
				//System.out.println(exprmap.get(var) + ": " + orgval);
			}
			//cplex.addMIPStart(variables, orgvalues);
			cplex.minimize(cplex.sum(obj));
		} else {
			// add objective for rollback: maximize the difference from original values
			int tuplesize = table.getColumns().length;
			IloNumVar[] obj = cplex.numVarArray(rollbackmap.size() * tuplesize, Double.MIN_VALUE, Double.MAX_VALUE);
			int count = 0;
			for(Tuple tuple : rollbackmap.keySet()) {
				IloNumVar[] vars = rollbackmap.get(tuple); // get variables
				// Tuple init = badds.get(0).getTuple(Integer.valueOf(tuple.getValue(table.getKeyIdx()))); // get original value
				int tmppk = Float.valueOf(tuple.getValue(table.getKeyIdx())).intValue(); 
				Tuple init = badds.get(0).getTuple(tmppk);
				for(int i = 0; i < vars.length; ++i) {
					IloNumVar var = vars[i];
					double orgval = Double.valueOf(init.getValue(i));
					constraints.add(cplex.addEq(obj[count++], cplex.abs(cplex.sum(var, -orgval)))); // difference
				}
			}
			cplex.minimize(cplex.sum(obj)); // maximize total differences
		}
	}
	
	/* add conditions for each tuple, assign tuple values */
	public void addTuple(IloCplex cplex, ArrayList<IloConstraint> constraints, Table table, QueryLog qlog, Tuple tupleinit, Tuple tuplefinl, boolean fix, HashSet<Integer> candidate, int startidx, int endidx) throws Exception {
		// tupleinitial is the initial values of the tuple and tuplefinal is the final state values
		// define initial variables
		IloNumVar[] preattr = new IloNumVar[table.getColumns().length];
		for(int i = 0; i < preattr.length; ++i) {
			preattr[i] = cplex.numVar(Double.MIN_VALUE, Double.MAX_VALUE);
			//constraints.add(preattr[i]);
		}
		if(!fix) {
			rollbackmap.put(tupleinit, preattr);
		}
		
		// add conditions for each query in the query log
		IloNumVar[] curr = preattr;
		double keyvalue = Double.valueOf(tupleinit.getValue(table.getKeyIdx())) != Double.MIN_VALUE ? Double.valueOf(tupleinit.getValue(table.getKeyIdx())) : Double.valueOf(tuplefinl.getValue(table.getKeyIdx()));
		for(int i = startidx; i < endidx; ++i) {
			Query query = qlog.get(i);
			if(fix && candidate.contains(i)) {
				curr = this.addConstraint(cplex, constraints, table, query, keyvalue, curr, true);
			} else {
				curr = this.addConstraint(cplex, constraints, table, query, keyvalue, curr, false);
			}
			//curr = this.addConstraint(cplex, table, query, curr, fix); // add conditions
		}
		// add constraint for final tuple values based complaints
		for(int i = 0; i < curr.length; ++i) {
			if (fix)
				constraints.add(cplex.addEq(preattr[i], Double.valueOf(tupleinit.getValue(i))));
			constraints.add(cplex.addEq(curr[i], Double.valueOf(tuplefinl.getValue(i))));
		}
		//cplex.minimize(cplex.sum(preattr[1], 0));
		//System.out.println(tupleinit.getValue(table.getKeyIdx()) + " : " + cplex.solve());
	}
	
	/* add conditions by tuple & query */
	public IloNumVar[] addConstraint(IloCplex cplex, ArrayList<IloConstraint> constraints, Table table, Query query, double key, IloNumVar[] preattr, boolean fix) throws Exception {
		// option: false: linearize tuple; true: linearize tuple & query
		WhereClause where = query.getWhere();
		SetClause set = query.getSet();
		List<String> values = query.getValue();
		IloNumVar x = cplex.numVar(0.0, 1.0);
		IloNumVar[] nextattr = cplex.numVarArray(preattr.length, Double.MIN_VALUE, Double.MAX_VALUE);
		switch(query.getType()) {
		case UPDATE:
			this.addWhere(cplex, query, constraints, where, table, preattr, x, fix); // add conditions for where clause
			nextattr = this.addSet(cplex, query, constraints, set, table, preattr, x, fix); // add conditions for set clause
			break;
		case INSERT: 
			constraints.add(cplex.addEq(x, cplex.eq(key, nextattr[table.getKeyIdx()])));
			nextattr = this.addInsert(cplex, query, constraints, values, table, preattr, x, fix);
			if(fix)
				removemap.put(x, query); //solve x, if x < 0.5, move this query
			break;
		case DELETE:
			this.addWhere(cplex, query, constraints, where, table, preattr, x, fix);
			nextattr = this.addDelete(cplex, query, constraints, table, preattr, x, fix);
		}
		// add constraints to where clause
		cplex.add(x); // add variable x
		return nextattr;
	}

	/* add conditions for insert query */
	public IloNumVar[] addInsert(IloCplex cplex, Query query, ArrayList<IloConstraint> constraints, List<String> values, Table table, IloNumVar[] preattr, IloNumVar x, boolean fix) throws Exception {
		// create one variable for the insert query
		IloNumVar[] nextattr = new IloNumVar[preattr.length];
		IloNumVar[] vars = new IloNumVar[preattr.length];
		ArrayList<IloNumVar> list = new ArrayList<IloNumVar>();
		for(int i = 0; i < table.getColumns().length; ++i) {
			IloNumVar curattr = cplex.numVar(Double.MIN_VALUE, Double.MAX_VALUE); // initialize current attribute variable
			IloNumVar insertvalue = cplex.numVar(Double.MIN_VALUE, Double.MAX_VALUE);
			
			// linearize
			// create for previous value
			IloNumVar pre = cplex.numVar(Double.MIN_VALUE, Double.MAX_VALUE);
			constraints.add(cplex.addLe(pre, preattr[i]));
			constraints.add(cplex.addLe(pre, cplex.prod(cplex.diff(1, x), M)));
			constraints.add(cplex.addGe(pre, cplex.diff(preattr[i], cplex.prod(x, M))));
			
			// create for set value
			IloNumVar next = cplex.numVar(Double.MIN_VALUE, Double.MAX_VALUE);
			constraints.add(cplex.addLe(next, insertvalue));
			constraints.add(cplex.addLe(next, cplex.prod(x, M)));
			constraints.add(cplex.addGe(next, cplex.diff(insertvalue, cplex.prod(cplex.diff(1, x), M))));
			
			// add condition
			constraints.add(cplex.addEq(curattr, cplex.sum(pre, next)));
			if(fix) {
				if(i == table.getKeyIdx()) {
					constraints.add(cplex.addEq(insertvalue, Double.valueOf(values.get(i))));
				}
				varmap.put(insertvalue, Double.valueOf(values.get(i)));
				vars[i] = insertvalue;
				list.add(insertvalue);
			} else {
				constraints.add(cplex.addEq(insertvalue, Double.valueOf(values.get(i))));
			}
			nextattr[i] = curattr;
		}
		if(fix) {
			varquerymap.put(query, list);
			insrtmap.put(values, vars);
		}	
		return nextattr;
	}
	
	/* add conditions for delete query */
	public IloNumVar[] addDelete(IloCplex cplex, Query query, ArrayList<IloConstraint> constraints, Table table, IloNumVar[] preattr, IloNumVar x, boolean fix) throws Exception {
		// create one variable for the insert query
		IloNumVar[] nextattr = new IloNumVar[preattr.length];
		for(int i = 0; i < table.getColumns().length; ++i) {
			IloNumVar curattr = cplex.numVar(Double.MIN_VALUE, Double.MAX_VALUE); // initialize current attribute variable
			double deletevalue = Double.MIN_VALUE;
			
			// linearize
			// create for previous value
			IloNumVar pre = cplex.numVar(Double.MIN_VALUE, Double.MAX_VALUE);
			constraints.add(cplex.addLe(pre, preattr[i]));
			constraints.add(cplex.addLe(pre, cplex.prod(cplex.diff(1, x), M)));
			constraints.add(cplex.addGe(pre, cplex.diff(preattr[i], cplex.prod(x, M))));
			
			// create for set value
			IloNumVar next = cplex.numVar(Double.MIN_VALUE, Double.MAX_VALUE);
			constraints.add(cplex.addLe(next, deletevalue));
			constraints.add(cplex.addLe(next, cplex.prod(x, M)));
			constraints.add(cplex.addGe(next, cplex.diff(deletevalue, cplex.prod(cplex.diff(1, x), M))));
			
			// add condition
			constraints.add(cplex.addEq(curattr, cplex.sum(pre, next)));
			nextattr[i] = curattr;
		}
		return nextattr;
	}
	
	/* add conditions for set clause */
	public IloNumVar[] addSet(IloCplex cplex, Query query, ArrayList<IloConstraint> constraints, SetClause set, Table table, IloNumVar[] preattr, IloNumVar x, boolean fix) throws Exception {
		List<SetExpr> set_exprs = set.getSetExprs();
		int size = set_exprs.size(); //get set clause cardinality
		// for each set function
		IloNumVar[] nextattr = new IloNumVar[preattr.length];
		
		HashSet<Integer> modifiedset = new HashSet<Integer>();
		
		for(int i = 0; i < size; ++i) {
			Expression attr = set_exprs.get(i).getAttr(); // get attribute modified by current set function
			Expression setfunc = set_exprs.get(i).getExpr(); // get set function expression
			int idx = table.getColumnIdx(attr.toString()); // get the index of modified attribute
			
			IloNumVar curattr = cplex.numVar(Double.MIN_VALUE, Double.MAX_VALUE); // initialize current attribute variable
			//IloNumExpr setexpr = setfunc.convertExpr(cplex, varmap, exprmap, preattr, table, fix); // get cplex expression
			IloNumExpr setexpr = setfunc.convertExpr(cplex, varmap, exprmap, varquerymap, query, preattr, table, fix);
			// linearize
			// create for previous value
			IloNumVar pre = cplex.numVar(Double.MIN_VALUE, Double.MAX_VALUE);
			constraints.add(cplex.addLe(pre, preattr[idx]));
			constraints.add(cplex.addLe(pre, cplex.prod(cplex.diff(1, x), M)));
			constraints.add(cplex.addGe(pre, cplex.diff(preattr[idx], cplex.prod(x, M))));
			
			// create for set value
			IloNumVar next = cplex.numVar(Double.MIN_VALUE, Double.MAX_VALUE);
			constraints.add(cplex.addLe(next, setexpr));
			constraints.add(cplex.addLe(next, cplex.prod(x, M)));
			constraints.add(cplex.addGe(next, cplex.diff(setexpr, cplex.prod(cplex.diff(1, x), M))));

			// add condition
			constraints.add(cplex.addEq(curattr, cplex.sum(pre, next)));
			nextattr[idx] = curattr;
			modifiedset.add(idx);
		}
		for(int i = 0; i < preattr.length; ++i) {
			if(!modifiedset.contains(i)) {
				nextattr[i] = cplex.numVar(Double.MIN_VALUE, Double.MAX_VALUE);
				constraints.add(cplex.addEq(nextattr[i], preattr[i]));
			}
		}
		return nextattr;
	}
	
	/* add conditions for where clause */
	public void addWhere(IloCplex cplex, Query query, ArrayList<IloConstraint> constraints, WhereClause where, Table table, IloNumVar[] preattr, IloNumVar x, boolean fix) throws Exception {
		// prepare input parameters
		List<WhereExpr> where_exprs = where.getWhereExprs();
		int size = where_exprs.size();
		WhereClause.Op operation = where.getOperator();

		//IloNumVar[] obj = cplex.numVarArray(size, Double.MIN_VALUE, Double.MAX_VALUE);
		
		// prepare constraints
		IloConstraint[] cons = new IloConstraint[size];
		for(int i = 0; i < size; ++i){
			// for every constraint
			WhereExpr.Op op = where_exprs.get(i).getOperator();
			// calculate value for left side
			Expression leftexpr = where_exprs.get(i).getAttrExpr();
			Expression rightexpr = where_exprs.get(i).getVarExpr();
			
			//IloNumExpr left = leftexpr.convertExpr(cplex, varmap, exprmap, preattr, table, false); // expression in left side is guarantee correct
			IloNumExpr left = leftexpr.convertExpr(cplex, varmap, exprmap, varquerymap, query, preattr, table, false);
			//IloNumExpr right = rightexpr.convertExpr(cplex, varmap, exprmap, preattr, table, fix); // add variables based on fix flag
			IloNumExpr right = rightexpr.convertExpr(cplex, varmap, exprmap, varquerymap, query, preattr, table, fix);
			
			// for multiple comparison operators
			switch(op){
			case g:
				cons[i] = cplex.ge(left, cplex.sum(epsilon, right));
				break;
			case l:
				cons[i] = cplex.le(left, cplex.sum(-epsilon, right));
				break;
			case ge:
				cons[i] = cplex.ge(left, right);
				break;
			case le:
				cons[i] = cplex.le(left, right);
				break;
			case eq:
				cons[i] = cplex.eq(left, right);
				break;
			case ne: 
				cons[i] = cplex.eq(cplex.eq(left, right), 0);
				break;
			}
		}
		
		IloNumExpr whereexpr; // define expression for where clause
		
		if(operation.equals(WhereClause.Op.CONJ)){
			// every condition must satisfy 'isTrue' value
			whereexpr = cplex.and(cons);
		}
		else{
			// one of the consition must satisfy 'isTrue' value
			whereexpr = cplex.or(cons);
		}
		// add constraint
		constraints.add(cplex.addEq(x, whereexpr));
	}
	
	/* return execution time */
	public long[] getTime() {
		return times;
	}
}
