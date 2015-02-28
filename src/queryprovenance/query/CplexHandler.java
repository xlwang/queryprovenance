package queryprovenance.query;

 
import ilog.concert.IloConstraint;
import ilog.concert.IloException;
import ilog.concert.IloNumVar;
import ilog.cplex.IloCplex;

import java.util.*;

import queryprovenance.database.DatabaseState;
import queryprovenance.database.Tuple;
import queryprovenance.expression.Expression;

public class CplexHandler {
	// build cplex solver
	public IloCplex cplex;
	IloNumVar[] var; // variables
	IloNumVar[] obj; // objective
	
	double epsilon; 
	
	long[] times = new long[3];
	//long[] timestamps = new long[4];
	
	/* Initialize cplex solver */
	public CplexHandler() throws Exception{
		cplex = new IloCplex();
	}
	
	public void initial(double ep) throws IloException{
		epsilon = ep;
		cplex.clearModel();
	}
	/* solve cplex */
	public List<WhereExpr> solve(WhereClause where, DatabaseState pre, HashMap<Integer, String> classinfo, String method) throws Exception{
		double[] fixed_values = new double[where.getWhereExprs().size()];
		
		long starttime = System.nanoTime(); // get time stamp
		// add constraints
		this.addAllConstraintIncomplete(where, pre, classinfo);
		
		// add objective function
		this.prepareObj(where, method);
		
		long endtime = System.nanoTime(); // get time stamp
		times[0] = (endtime - starttime);
		starttime = System.nanoTime();
		
		boolean solved = cplex.solve();
		endtime = System.nanoTime(); // get time stamp
		times[1] = (endtime - starttime);
		
		// solve cplex
		if(solved){
			starttime = System.nanoTime();
            for(int i = 0; i < fixed_values.length; ++i){
				int digits = (int) Math.pow(10, (double) (String.valueOf(epsilon).length() - String.valueOf(epsilon).lastIndexOf(".") - 1));
				fixed_values[i] = (double) Math.round(cplex.getValue(var[i])*digits)/digits;
			}
            List<WhereExpr> result = this.toConditionRules(where, fixed_values);
            endtime = System.nanoTime(); // get time stamp
            times[2] = (endtime - starttime);
            
            return result;
		}
		else{
			times[2] = 0;
			return null;
		}
		
	}
	
	/* prepare objective function */
	public void prepareObj(WhereClause where, String method) throws Exception{
		// prepare input parameters
		List<WhereExpr> where_exprs = where.getWhereExprs();
		int size = where_exprs.size();
		obj = cplex.numVarArray(size, Double.MIN_VALUE, Double.MAX_VALUE);
		
		switch(method){
		case "abs": // minimize the differences
			for(int i = 0; i < where_exprs.size(); ++i){
				double orgvar = where_exprs.get(i).getVar();
				cplex.add(cplex.eq(obj[i], cplex.abs(cplex.sum(var[i], -orgvar))));
			}
		}
		cplex.minimize(cplex.sum(obj));
	}
	
	/* prepare all constraints */
	public void addAllConstraint(WhereClause where, DatabaseState pre, HashMap<Integer, String> classinfo) throws Exception {
		// check input parameters
		if(pre.size() != classinfo.size()){
			System.out.println("Where Clause Error: value length not equals to class information");
			return;
		}
		// prepare cplex variables
		var = cplex.numVarArray(where.getWhereExprs().size(), Double.MIN_VALUE, Double.MAX_VALUE);

		// for each tuple, add constraints
		for(Integer key:pre.getKeySet()){			
			Tuple tuple = pre.getTuple(key);
			boolean isTrue = classinfo.get(key).equals("b") ? true : false;
			this.addConstraint(where, pre.getColumnNames(), tuple, isTrue);
		}
			
	}
	
	/* prepare all constraints */
	public void addAllConstraintIncomplete(WhereClause where, DatabaseState pre, HashMap<Integer, String> classinfo) throws Exception {
		// prepare cplex variables
		var = cplex.numVarArray(where.getWhereExprs().size(), Double.MIN_VALUE, Double.MAX_VALUE);

		// for each tuple, add constraints
		for(Integer key : classinfo.keySet()){	
			Tuple tuple = pre.getTuple(key);
			boolean isTrue = classinfo.get(key).equals("b")?true:false;
			this.addConstraint(where, pre.getColumnNames(), tuple, isTrue);
		}
			
	}
	/* prepare constraints for cplex solver */
	public void addConstraint(WhereClause where, String[] column_names, Tuple tuple, boolean isTrue) throws Exception{

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
			for(int j = 0; j < column_names.length; ++j)
				leftexpr.setVariable(column_names[j], Double.valueOf(tuple.getValue(j)));
			double leftvalue = leftexpr.Evaluate();
			switch(op){
			case g:
				if(isTrue)
					cons[i] = cplex.le(var[i], leftvalue-epsilon);
				else
					cons[i] = cplex.ge(var[i], leftvalue);
				break;
			case l:
				if(isTrue)
					cons[i] = cplex.ge(var[i], leftvalue+epsilon);
				else
					cons[i] = cplex.le(var[i], leftvalue);
				break;
			case ge:
				if(isTrue)
					cons[i] = cplex.le(var[i], leftvalue);
				else
					cons[i] = cplex.ge(var[i], leftvalue+epsilon);
				break;
			case le:
				if(isTrue)
					cons[i] = cplex.ge(var[i], leftvalue);
				else
					cons[i] = cplex.le(var[i], leftvalue-epsilon);
				break;
			case eq:
				if(isTrue)
					cons[i] = cplex.eq(var[i], leftvalue);
				else
					cons[i] = cplex.eq(cplex.eq(var[i], leftvalue), 0);
				break;
			case ne: 
				if(isTrue)
					cons[i] = cplex.eq(cplex.eq(var[i], leftvalue), 0);
				else
					cons[i] = cplex.eq(var[i], leftvalue);
				break;
			}
		}
		
		if((isTrue && operation.equals(WhereClause.Op.CONJ))||(!isTrue && operation.equals(WhereClause.Op.DISJ))){
			// every condition must satisfy 'isTrue' value
			
			cplex.add(cplex.and(cons));
		}
		else{
			// one of the consition must satisfy 'isTrue' value
			cplex.add(cplex.or(cons));
		}
	}
	
	/* return fixed where clause: transfer cplex results into condition rules */
	public List<WhereExpr> toConditionRules(WhereClause where, double[] fixed_values){
		List<WhereExpr> fixed_where_exprs = new ArrayList<WhereExpr>();
		int size =  where.getWhereExprs().size();
		// for each condition
		for(int i = 0; i < size; ++i){
			WhereExpr where_expr = where.getWhereExprs().get(i);
			// clone where expression
			WhereExpr fixed_expr = where_expr.clone();
			// fix value
			fixed_expr.getVarExpr().setVariable(fixed_expr.getVarExpr().getVariable().get(0), fixed_values[i]);
			
			// add into result
			fixed_where_exprs.add(fixed_expr);		
		}
		return fixed_where_exprs;
	}
	
	/* return execution time */
	public long[] getTime(){
		return times;
	}
}
