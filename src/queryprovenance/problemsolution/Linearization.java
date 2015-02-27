package queryprovenance.problemsolution;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;

import ilog.concert.IloConstraint;
import ilog.concert.IloNumExpr;
import ilog.concert.IloNumVar;
import ilog.cplex.IloCplex;
import queryprovenance.database.DatabaseHandler;
import queryprovenance.database.DatabaseState;
import queryprovenance.database.DatabaseStates;
import queryprovenance.database.Table;
import queryprovenance.database.Tuple;
import queryprovenance.expression.AdditionExpression;
import queryprovenance.expression.Expression;
import queryprovenance.expression.VariableExpression;
import queryprovenance.query.DeleteQuery;
import queryprovenance.query.InsertQuery;
import queryprovenance.query.Query;
import queryprovenance.query.SetClause;
import queryprovenance.query.SetExpr;
import queryprovenance.query.UpdateQuery;
import queryprovenance.query.WhereClause;
import queryprovenance.query.WhereExpr;
import queryprovenance.query.Query.Type;

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
		
	}
	
	/* clear model */
	public void clear() {
		varmap.clear();
		fixedmap.clear();
		exprmap.clear();
		insrtmap.clear();
		rollbackmap.clear();removemap.clear();
	}
	
	/* solve parameter fix problem: baseline */	
	public QueryLog fixParameters(IloCplex cplex, Table table, QueryLog badqlog, DatabaseStates badds, Complaint compset, HashSet<Integer> candidate, int startidx, int endidx) throws Exception {
		// clear model
		cplex.clearModel();
		this.clear();
		// define fixed query log
		QueryLog qlogfix = new QueryLog();
		for(int i = startidx; i < endidx; ++i) {
      System.out.println(" " + badqlog.get(i));
			qlogfix.add(badqlog.get(i).clone());
		}
		
		// prepare conditions
		long starttime = System.nanoTime();
		this.addAll(cplex, table, qlogfix, badds, compset, true, candidate, startidx, endidx);
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
			System.out.println("solved");
			// remove queries 
			HashSet<Query> removeset = new HashSet<Query>();
			for(IloNumVar var : removemap.keySet()) {
				int digits = (int) Math.pow(10, (double) (String.valueOf(epsilon).length() - String.valueOf(epsilon).lastIndexOf(".") - 1));
				 double value = (double) Math.round(cplex.getValue(var)*digits)/digits;
				 if(value == 0)
					 removeset.add(removemap.get(var));
			}
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
		}
		endtime = System.nanoTime();
		times[2] = endtime - starttime;
		
		// return result
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
		
		Complaint rollback = new Complaint(); 
		QueryLog qlogback = new QueryLog();
		for(int i = startidx; i < endidx; ++i) {
			Query query = qlog.get(i);
			qlogback.add(query.clone());
		}
		
		// prepare conditions
		long starttime = System.nanoTime();
		this.addAll(cplex, table, qlogback, badds, compset, false, new HashSet<Integer>(), startidx, endidx);
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
	public void addAll(IloCplex cplex, Table table, QueryLog badqlog, DatabaseStates badds, Complaint compset, boolean fix, HashSet<Integer> candidate, int startidx, int endidx) throws Exception {
		// process each complaint in the complaint set
		for(Integer key : compset.keySet()) {
			// get initial values from state0
			SingleComplaint cp = compset.get(key);
			DatabaseState state0 = badds.get(startidx);
			Tuple tupleinit= state0.getTuple(key);
			// get final values from complaint
			Tuple tuplefinl = new Tuple(table.getColumns().length, cp.values);
			// add conditions
			this.addTuple(cplex, table, badqlog, tupleinit, tuplefinl, fix, candidate);
		}
		// add objective function
		this.addObjective(cplex, table, badds, fix);
	}
	
	/* add objective functions */
	public void addObjective(IloCplex cplex, Table table, DatabaseStates badds, boolean fix) throws Exception {
		
		if(fix) {
			// add objective for fix parameters: minimize the difference from original parameters
			IloNumVar[] obj = cplex.numVarArray(varmap.size(), Double.MIN_VALUE, Double.MAX_VALUE);
			
			int i = 0;
			for(IloNumVar var : varmap.keySet()){
				double orgval = varmap.get(var);
				cplex.add(cplex.eq(obj[i++], cplex.abs(cplex.sum(var, -orgval))));
			}
			cplex.minimize(cplex.sum(obj));
		} else {
			// add objective for rollback: maximize the difference from original values
			int tuplesize = table.getColumns().length;
			IloNumVar[] obj = cplex.numVarArray(rollbackmap.size() * tuplesize, Double.MIN_VALUE, Double.MAX_VALUE);
			int count = 0;
			for(Tuple tuple : rollbackmap.keySet()) {
				IloNumVar[] vars = rollbackmap.get(tuple); // get variables
				Tuple init = badds.get(0).getTuple(Integer.valueOf(tuple.getValue(table.getKeyIdx()))); // get original value
				for(int i = 0; i < vars.length; ++i) {
					IloNumVar var = vars[i];
					double orgval = Double.valueOf(init.getValue(i));
					cplex.add(cplex.eq(obj[count++], cplex.abs(cplex.sum(var, -orgval)))); // difference
				}
			}
			cplex.minimize(cplex.sum(obj)); // maximize total differences
		}
	}
	
	/* add conditions for each tuple, assign tuple values */
	public void addTuple(IloCplex cplex, Table table, QueryLog qlog, Tuple tupleinit, Tuple tuplefinl, boolean fix, HashSet<Integer> candidate) throws Exception {
		// tupleinitial is the initial values of the tuple and tuplefinal is the final state values
		// define initial variables
		IloNumVar[] preattr = new IloNumVar[table.getColumns().length];
		for(int i = 0; i < preattr.length; ++i) {
			preattr[i] = cplex.numVar(Double.MIN_VALUE, Double.MAX_VALUE);
			//cplex.add(preattr[i]);
		}
		if(!fix) {
			rollbackmap.put(tupleinit, preattr);
		}
		
		// add conditions for each query in the query log
		IloNumVar[] curr = preattr;
		double keyvalue = Double.valueOf(tupleinit.getValue(table.getKeyIdx())) != Double.MIN_VALUE ? Double.valueOf(tupleinit.getValue(table.getKeyIdx())) : Double.valueOf(tuplefinl.getValue(table.getKeyIdx()));
		for(int i = 0; i < qlog.size(); ++i) {
			Query query = qlog.get(i);
			if(fix && candidate.contains(i)) {
				curr = this.addConstraint(cplex, table, query, keyvalue, curr, true);
			} else {
				curr = this.addConstraint(cplex, table, query, keyvalue, curr, false);
			}
			//curr = this.addConstraint(cplex, table, query, curr, fix); // add conditions
		}
		// add constraint for final tuple values based complaints
		for(int i = 0; i < curr.length; ++i) {
			if (fix)
				cplex.add(cplex.eq(preattr[i], Double.valueOf(tupleinit.getValue(i))));
			cplex.add(cplex.eq(curr[i], Double.valueOf(tuplefinl.getValue(i))));
		}
		//cplex.minimize(cplex.sum(preattr[1], 0));
		//System.out.println(tupleinit.getValue(table.getKeyIdx()) + " : " + cplex.solve());
	}
	
	/* add conditions by tuple & query */
	public IloNumVar[] addConstraint(IloCplex cplex, Table table, Query query, double key, IloNumVar[] preattr, boolean fix) throws Exception {
		// option: false: linearize tuple; true: linearize tuple & query
		WhereClause where = query.getWhere();
		SetClause set = query.getSet();
		List<String> values = query.getValue();
		IloNumVar x = cplex.numVar(0.0, 1.0);
		IloNumVar[] nextattr = cplex.numVarArray(preattr.length, Double.MIN_VALUE, Double.MAX_VALUE);
		switch(query.getType()) {
		case UPDATE:
			this.addWhere(cplex, where, table, preattr, x, fix); // add conditions for where clause
			nextattr = this.addSet(cplex, set, table, preattr, x, fix); // add conditions for set clause
			break;
		case INSERT: 
			cplex.add(cplex.eq(x, cplex.eq(key, nextattr[table.getKeyIdx()])));
			nextattr = this.addInsert(cplex, values, table, preattr, x, fix);
			if(fix)
				removemap.put(x, query); //solve x, if x < 0.5, move this query
			break;
		case DELETE:
			this.addWhere(cplex, where, table, preattr, x, fix);
			nextattr = this.addDelete(cplex, table, preattr, x, fix);
		}
		// add constraints to where clause
		cplex.add(x); // add variable x
		return nextattr;
	}

	/* add conditions for insert query */
	public IloNumVar[] addInsert(IloCplex cplex, List<String> values, Table table, IloNumVar[] preattr, IloNumVar x, boolean fix) throws Exception {
		// create one variable for the insert query
		IloNumVar[] nextattr = new IloNumVar[preattr.length];
		IloNumVar[] vars = new IloNumVar[preattr.length];
		for(int i = 0; i < table.getColumns().length; ++i) {
			IloNumVar curattr = cplex.numVar(Double.MIN_VALUE, Double.MAX_VALUE); // initialize current attribute variable
			IloNumVar insertvalue = cplex.numVar(Double.MIN_VALUE, Double.MAX_VALUE);
			
			// linearize
			// create for previous value
			IloNumVar pre = cplex.numVar(Double.MIN_VALUE, Double.MAX_VALUE);
			cplex.add(cplex.le(pre, preattr[i]));
			cplex.add(cplex.le(pre, cplex.prod(cplex.diff(1, x), M)));
			cplex.add(cplex.ge(pre, cplex.diff(preattr[i], cplex.prod(x, M))));
			
			// create for set value
			IloNumVar next = cplex.numVar(Double.MIN_VALUE, Double.MAX_VALUE);
			cplex.add(cplex.le(next, insertvalue));
			cplex.add(cplex.le(next, cplex.prod(x, M)));
			cplex.add(cplex.ge(next, cplex.diff(insertvalue, cplex.prod(cplex.diff(1, x), M))));
			
			// add condition
			cplex.add(cplex.eq(curattr, cplex.sum(pre, next)));
			if(fix) {
				varmap.put(insertvalue, Double.valueOf(values.get(i)));
				vars[i] = insertvalue;
			} else {
				cplex.add(cplex.eq(insertvalue, Double.valueOf(values.get(i))));
			}
			nextattr[i] = curattr;
		}
		insrtmap.put(values, vars);
		return nextattr;
	}
	
	/* add conditions for delete query */
	public IloNumVar[] addDelete(IloCplex cplex, Table table, IloNumVar[] preattr, IloNumVar x, boolean fix) throws Exception {
		// create one variable for the insert query
		IloNumVar[] nextattr = new IloNumVar[preattr.length];
		for(int i = 0; i < table.getColumns().length; ++i) {
			IloNumVar curattr = cplex.numVar(Double.MIN_VALUE, Double.MAX_VALUE); // initialize current attribute variable
			double deletevalue = Double.MIN_VALUE;
			
			// linearize
			// create for previous value
			IloNumVar pre = cplex.numVar(Double.MIN_VALUE, Double.MAX_VALUE);
			cplex.add(cplex.le(pre, preattr[i]));
			cplex.add(cplex.le(pre, cplex.prod(cplex.diff(1, x), M)));
			cplex.add(cplex.ge(pre, cplex.diff(preattr[i], cplex.prod(x, M))));
			
			// create for set value
			IloNumVar next = cplex.numVar(Double.MIN_VALUE, Double.MAX_VALUE);
			cplex.add(cplex.le(next, deletevalue));
			cplex.add(cplex.le(next, cplex.prod(x, M)));
			cplex.add(cplex.ge(next, cplex.diff(deletevalue, cplex.prod(cplex.diff(1, x), M))));
			
			// add condition
			cplex.add(cplex.eq(curattr, cplex.sum(pre, next)));
			nextattr[i] = curattr;
		}
		return nextattr;
	}
	
	/* add conditions for set clause */
	public IloNumVar[] addSet(IloCplex cplex, SetClause set, Table table, IloNumVar[] preattr, IloNumVar x, boolean fix) throws Exception {
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
			IloNumExpr setexpr = setfunc.convertExpr(cplex, varmap, exprmap, preattr, table, fix); // get cplex expression
			
			// linearize
			// create for previous value
			IloNumVar pre = cplex.numVar(Double.MIN_VALUE, Double.MAX_VALUE);
			cplex.add(cplex.le(pre, preattr[idx]));
			cplex.add(cplex.le(pre, cplex.prod(cplex.diff(1, x), M)));
			cplex.add(cplex.ge(pre, cplex.diff(preattr[idx], cplex.prod(x, M))));
			
			// create for set value
			IloNumVar next = cplex.numVar(Double.MIN_VALUE, Double.MAX_VALUE);
			cplex.add(cplex.le(next, setexpr));
			cplex.add(cplex.le(next, cplex.prod(x, M)));
			cplex.add(cplex.ge(next, cplex.diff(setexpr, cplex.prod(cplex.diff(1, x), M))));

			// add condition
			cplex.add(cplex.eq(curattr, cplex.sum(pre, next)));
			nextattr[idx] = curattr;
			modifiedset.add(idx);
		}
		for(int i = 0; i < preattr.length; ++i) {
			if(!modifiedset.contains(i)) {
				nextattr[i] = cplex.numVar(Double.MIN_VALUE, Double.MAX_VALUE);
				cplex.add(cplex.eq(nextattr[i], preattr[i]));
			}
		}
		return nextattr;
	}
	
	/* add conditions for where clause */
	public void addWhere(IloCplex cplex, WhereClause where, Table table, IloNumVar[] preattr, IloNumVar x, boolean fix) throws Exception {
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
			
			IloNumExpr left = leftexpr.convertExpr(cplex, varmap, exprmap, preattr, table, false); // expression in left side is guarantee correct
			IloNumExpr right = rightexpr.convertExpr(cplex, varmap, exprmap, preattr, table, fix); // add variables based on fix flag
	
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
		cplex.add(cplex.eq(x, whereexpr));
	}
	
	/* return execution time */
	public long[] getTime() {
		return times;
	}
	/* for test purpose only*/
	public static void main(String[] args) throws Exception {
		int tuple_count = 100;
		//DataGenerator datagenerator = new DataGenerator(tuple_count);
		//arg = new String[]{"-M","1", "-E", "0.1", "-O", "abs"};
		//SolveAll solver = new SolveAll(arg);
		DatabaseHandler handler = new DatabaseHandler();
		handler.getConnected("dbconn.config");
		handler.executePrepFile("./data/setup.sql");
		handler.executePrepFile("./data/inserts.sql");
		handler.executePrepFile("./data/result.sql");
		
		String[] cols = new String[]{"employeeId", "level", "age", "employmentyear", "tax", "salary"};
		Table.Type[] types = new Table.Type[]{Table.Type.NUM, Table.Type.NUM, Table.Type.NUM, Table.Type.NUM, Table.Type.NUM, Table.Type.NUM};
		Object[] domains = new Object[]{new int[]{0, 10},new int[]{20, 60}, new int[]{0, 40}, new int[]{1, 6}, new int[]{0, 9000}, new int[]{0, 300000}};
		Table table = new Table("Employee", cols, types, domains, 0);
		 
		// check update query
		System.out.println();
		System.out.println("###################");
		System.out.println("UPDATE QUERY DEMO: ");
		
		// set up wrong query
		 
		List<SetExpr> set_clause = new ArrayList<SetExpr>();
		Expression attr1 = new VariableExpression("age", true);
		Expression exprattr1 = new VariableExpression("age", true);
		Expression exprvar1 = new VariableExpression("", 3, false);
		//Expression exprvar2 = new VariableExpression("", 1.1, false);
		//Expression setexpr1 = new MultiplicationExpression(exprattr1, exprvar2);
		Expression setexpr2 = new AdditionExpression(exprattr1, exprvar1);
		set_clause.add(new SetExpr(attr1,setexpr2));
		SetClause set = new SetClause(set_clause);
		
		List<WhereExpr> where_clause = new ArrayList<WhereExpr>();
		Expression var1 = new VariableExpression("employeeid", true);
		Expression var2 = new VariableExpression("var", 10, false);
		where_clause.add(new WhereExpr(var1,WhereExpr.Op.le, var2));
		WhereClause where = new WhereClause(where_clause,WhereClause.Op.CONJ);// (int id, SetClause set, Table from, WhereClause where, Query.Type type_)
		Query wquery = new UpdateQuery(1, set, table, where);



		
		
		// set up true query
		List<SetExpr> set_clause_t = new ArrayList<SetExpr>();
		Expression attr1_t = new VariableExpression("age", true);
		Expression exprattr1_t = new VariableExpression("age", true);
		Expression exprvar1_t = new VariableExpression("", 3, false);
		//Expression exprvar2_t = new VariableExpression("", 1.1, false);
		//Expression setexpr1_t = new MultiplicationExpression(exprattr1_t, exprvar2_t);
		Expression setexpr2_t = new AdditionExpression(exprattr1_t, exprvar1_t);	
		set_clause_t.add(new SetExpr(attr1_t, setexpr2_t));
		SetClause set1 = new SetClause(set_clause_t);
		
		List<WhereExpr> where_clause1 = new ArrayList<WhereExpr>();
		Expression var1_t = new VariableExpression("employeeid", true);
		Expression var2_t = new VariableExpression("var", 20, false);
		where_clause1.add(new WhereExpr(var1_t,WhereExpr.Op.le, var2_t));		
		WhereClause where1 = new WhereClause(where_clause1,WhereClause.Op.CONJ);
		Query tquery = new UpdateQuery(1, set1, table ,where1);
		
		List<String> insertvalues = new ArrayList<String>();
		String[] tempvalues = new String[]{"1000","0","53","32","9952","66353"};
		for(String temp : tempvalues)
			insertvalues.add(temp);
		List<String> test = insertvalues.subList(0, 1);
		/*
		List<String> insertvalues = new ArrayList<String>();
		String[] tempvalues = new String[]{"1000","0","53","32","9952","66353"};
		for(String temp : tempvalues)
			insertvalues.add(temp);
		Query wquery = new InsertQuery(1000, table, insertvalues);
		
		List<String> insertvalues2 = new ArrayList<String>();
		String[] tempvalues2 = new String[]{"1000","1","53","32","9952","66353"};
		for(String temp : tempvalues2)
			insertvalues2.add(temp);
		Query tquery = new Query(1000, table, insertvalues2);
		*/
		QueryLog badqlog = new QueryLog();
		badqlog.add(wquery);
		DatabaseStates badds = badqlog.execute(table.getName(), handler);
		QueryLog qlog = new QueryLog();
		qlog.add(tquery);
		DatabaseStates ds = qlog.execute(table.getName(), handler);
		
		// test for MILP
		// arg = new String[]{"-M", "0"}; // for Decision Tree
		
		// get complaint set: good ds vs. bad ds
		Complaint compset = new Complaint(ds.get(ds.size()-1), badds.get(badds.size()-1));
		//Complaint smallsize = compset.getPart(0.05);
				
		Linearization linearizesolver = new Linearization(0, 300000.0);
		QueryLog fixed = new QueryLog();
		Complaint rollback = new Complaint();
		IloCplex cplex = new IloCplex();
		HashSet<Integer> candidate = new HashSet<Integer>();
		candidate.add(0);
		System.out.println("Before" + compset.size());
		for(Integer key : compset.keySet()) {
			System.out.println(compset.get(key));
		}
		fixed = linearizesolver.fixParameters(cplex, table, badqlog, badds, compset, candidate, 0, 1);
		//compset = linearizesolver.rollBack(cplex, table, qlog, badds, compset, 1, 0, 1);
		System.out.println("After");
		for(Integer key : compset.keySet()) {
			System.out.println(compset.get(key));
		}
		
		System.out.println("TRUE QUERY: "+ qlog);
		System.out.println("FIXED QUERY: "+ fixed);
		//System.out.print("FIXED QUERY: "+fquery);
	}
}
