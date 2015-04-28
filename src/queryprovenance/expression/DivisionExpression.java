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

public class DivisionExpression extends OperationExpression{

	public DivisionExpression(Expression left_, Expression right_){
		this.right = right_;
		this.left = left_;
		super.type = Type.DIVISION;
	}
	
	public double Evaluate() {
		return this.left.Evaluate()/this.right.Evaluate();
	}

	public String toString() {	 
		return  this.left.toString() + "/" + this.right.toString();
	}

	public double getPar(Expression ex) {
		double par;
		if(left.containsVar(ex)){
			par = right.Evaluate();
			return left.getPar(ex)/par;
		}
		else if(right.containsVar(ex))
			throw new IllegalArgumentException("Set Expression not linear");
		else
			return 0;
	}

	public double getAssignedEval() {
		double lefteval = left.getAssignedEval();
		double righteval = right.getAssignedEval();
		if(righteval != 0)
			return lefteval/righteval;
		else
			return 0;
	}
	
	public Expression clone(){
		return new DivisionExpression(this.left.clone(), this.right.clone());
	}

	@Override
	public IloNumExpr convertExpr(IloCplex cplex, HashMap<IloNumVar, Double> varmap, HashMap<Expression, IloNumVar> exprmap, IloNumVar[] preattribute, Table table,
			boolean option) throws Exception {
		IloNumExpr leftexpr = super.left.convertExpr(cplex, varmap, exprmap, preattribute, table, option);
		// right expression must be a constant value
		Double rightval = Double.valueOf(this.right.toString());
		IloNumExpr current = cplex.prod(leftexpr, 1.0/rightval);
		return current;
	}

	public IloNumExpr convertExpr(IloCplex cplex, HashMap<IloNumVar, Double> varmap, HashMap<Expression, IloNumVar> exprmap, HashMap<Query, ArrayList<IloNumVar>> varquerymap, Query query, IloNumVar[] preattribute, Table table,
			boolean option) throws Exception {
		IloNumExpr leftexpr = super.left.convertExpr(cplex, varmap, exprmap, varquerymap, query, preattribute, table, option);
		Double rightval = Double.valueOf(this.right.toString());
		IloNumExpr current = cplex.prod(leftexpr, 1.0/rightval);
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
			IloNumExpr current = cplex.diff(leftexpr, rightexpr);
			return current;
		}
	}
}
