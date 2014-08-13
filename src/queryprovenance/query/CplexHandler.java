package queryprovenance.query;

import ilog.concert.IloConstraint;
import ilog.concert.IloNumVar;
import ilog.cplex.IloCplex;

import java.util.*;

import queryprovenance.database.DatabaseState;
import queryprovenance.expression.Expression;

public class CplexHandler {
	// build cplex solver
	IloCplex cplex;
	IloNumVar[] var;
	IloNumVar[] obj;

	double epsilon;
	/* Initialize cplex solver */
	public CplexHandler(double ep) throws Exception{
		cplex = new IloCplex();
		epsilon = ep;
	}
	/* solve cplex */
	public List<WhereExpr> solve(WhereClause where, DatabaseState pre, HashMap<String, String> classinfo, String method) throws Exception{
		double[] fixed_values = new double[where.getWhereExprs().size()];
		
		// add constraints
		this.addAllConstraint(where, pre, classinfo);
		
		// add objective function
		this.prepareObj(where, method);
		
		// solve cplex
		if(cplex.solve()){
			cplex.output().println("Solution status = " + cplex.getStatus());
			cplex.output().println("Solution value = " + cplex.getObjValue());
			for(int i = 0; i < fixed_values.length; ++i)
				fixed_values[i] = (double) Math.round(cplex.getValue(var[i])*100)/100;
			return this.toConditionRules(where, fixed_values);
		}
		else
			return null;
		
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
	public void addAllConstraint(WhereClause where, DatabaseState pre, HashMap<String, String> classinfo) throws Exception {
		// check input parameters
		if(pre.size() != classinfo.size()){
			System.out.println("Where Clause Error: value length not equals to class information");
			return;
		}
		// prepare cplex variables
		var = cplex.numVarArray(where.getWhereExprs().size(), Double.MIN_VALUE, Double.MAX_VALUE);

		// for each tuple, add constraints
		for(String key:pre.getKeySet()){			
			String[] values = pre.getTuple(key);
			boolean isTrue = classinfo.get(key).equals("b")?true:false;
			this.addConstraint(where, pre.getColumnNames(), values, isTrue);
		}
			
	}
	/* prepare constraints for cplex solver */
	public void addConstraint(WhereClause where, String[] column_names, String[] values, boolean isTrue) throws Exception{

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
				leftexpr.setVariable(column_names[j], Double.valueOf(values[j]));
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
		
		if((isTrue && operation.equals("and"))||(!isTrue && operation.equals("or"))){
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
}
