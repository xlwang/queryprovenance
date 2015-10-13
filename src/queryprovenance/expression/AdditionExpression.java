package queryprovenance.expression;

import ilog.concert.IloNumExpr;
import ilog.concert.IloNumVar;
import ilog.cplex.IloCplex;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;

import queryprovenance.database.Table;
import queryprovenance.query.Query;
import queryprovenance.solve.varQuery;

public class AdditionExpression extends OperationExpression{
	 
	public AdditionExpression(Expression left_, Expression right_){
		this.left = left_;
		this.right = right_;
		super.type = Type.ADDITION;
	}
	public double Evaluate() {
		return this.left.Evaluate() + this.right.Evaluate();
	}

 
	public String toString() {
		return "("+ this.left.toString() + "+" + this.right.toString()+")";
	}
	
	public double getPar(Expression ex){
		// Expression ex and either in left side or right side
		double par = 0;
		if(left.containsVar(ex))
			par = left.getPar(ex);
		if(right.containsVar(ex))
			par += right.getPar(ex);
		return par;
	}
 
	public double getAssignedEval() {
		double lefteval = left.getAssignedEval();
		double rightevel = right.getAssignedEval();
		return lefteval + rightevel;
	}
	
	public Expression clone(){
		return new AdditionExpression(this.left.clone(), this.right.clone());
	}
	@Override
	public IloNumExpr convertExpr(IloCplex cplex, HashMap<IloNumVar, Double> varmap, HashMap<Expression, IloNumVar> exprmap, IloNumVar[] preattribute, Table table,
			boolean option) throws Exception {
		IloNumExpr rightexpr = super.right.convertExpr(cplex, varmap, exprmap, preattribute, table, option);
		IloNumExpr leftexpr = super.left.convertExpr(cplex, varmap, exprmap, preattribute, table, option);
		IloNumExpr current = cplex.sum(leftexpr, rightexpr);
		return current;
	}
	
	public IloNumExpr convertExpr(IloCplex cplex, HashMap<IloNumVar, Double> varmap, HashMap<Expression, IloNumVar> exprmap, HashMap<Query, ArrayList<IloNumVar>> varquerymap, Query query, IloNumVar[] preattribute, Table table,
			boolean option) throws Exception {
		IloNumExpr rightexpr = super.right.convertExpr(cplex, varmap, exprmap, varquerymap, query, preattribute, table, option);
		IloNumExpr leftexpr = super.left.convertExpr(cplex, varmap,exprmap, varquerymap, query, preattribute, table, option);
		IloNumExpr current = cplex.sum(leftexpr, rightexpr);
		return current;
	}
	@Override
	public IloNumExpr convertExpr(IloCplex cplex,
			HashMap<String, Integer> attrs, IloNumVar[] prestate,
			HashMap<VariableExpression, varQuery> varQMap, 
			HashSet<varQuery> currentVar, boolean fix) throws Exception {
		IloNumExpr rightexpr = super.right.convertExpr(cplex, attrs, prestate, varQMap, currentVar, fix);
		IloNumExpr leftexpr = super.left.convertExpr(cplex, attrs, prestate, varQMap, currentVar, fix);
		if(rightexpr == null || leftexpr == null) {
			return null;
		} else {
			IloNumExpr current = cplex.sum(leftexpr, rightexpr);
			return current;
		}
	}
	@Override
	public void StrToNum(HashMap<String, Integer> attr_value_map, String attr) {
		// TODO Auto-generated method stub
		this.right.StrToNum(attr_value_map, attr);
		this.left.StrToNum(attr_value_map, attr);
	}

}
