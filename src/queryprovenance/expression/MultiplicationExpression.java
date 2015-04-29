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

public class MultiplicationExpression extends OperationExpression{

	/* initialize */
	public MultiplicationExpression(Expression left_, Expression right_){
		this.right = right_;
		this.left = left_;
		super.type = Type.MUTIPLICATION;
	}
	
	/* calculate for values */
	public double Evaluate() {
		return this.left.Evaluate()*this.right.Evaluate();
	}

	public String toString() {	 
		return  this.left.toString() + "*" + this.right.toString();
	}

	/* get parameter for a given variable expression */
	public double getPar(Expression ex) {
		boolean isLeft = left.containsVar(ex);
		boolean isRight = right.containsVar(ex);
		if(isLeft&&!isRight){
			double leftpar = left.getPar(ex);
			double rightpar = right.getAssignedEval();
			return leftpar*rightpar;
		}
		else if(!isLeft&&isRight){
			double leftpar = left.getAssignedEval();
			double rightpar = right.getPar(ex);
			return leftpar*rightpar;
		}
		else if(!isLeft && !isRight)
			return 0;
		else
			throw new IllegalArgumentException("Set Expression not linear");
	}

	/* evaluate values for assigned(fixed) variable expressions */
	public double getAssignedEval() {
		double lefteval = left.getAssignedEval();
		double righteval = right.getAssignedEval();
		return lefteval*righteval;
	}

	public Expression clone(){
		return new MultiplicationExpression(this.left.clone(), this.right.clone());
	}
	
	@Override
	public IloNumExpr convertExpr(IloCplex cplex, HashMap<IloNumVar, Double> varmap, HashMap<Expression, IloNumVar> exprmap, IloNumVar[] preattribute, Table table,
			boolean option) throws Exception {
		IloNumExpr rightexpr = super.right.convertExpr(cplex, varmap, exprmap, preattribute, table, option);
		IloNumExpr leftexpr = super.left.convertExpr(cplex, varmap, exprmap, preattribute, table, option);
		IloNumExpr current = cplex.prod(leftexpr, rightexpr);
		return current;
	}

	public IloNumExpr convertExpr(IloCplex cplex, HashMap<IloNumVar, Double> varmap, HashMap<Expression, IloNumVar> exprmap, HashMap<Query, ArrayList<IloNumVar>> varquerymap, Query query, IloNumVar[] preattribute, Table table,
			boolean option) throws Exception {
		IloNumExpr rightexpr = super.right.convertExpr(cplex, varmap, exprmap, varquerymap, query, preattribute, table, option);
		IloNumExpr leftexpr = super.left.convertExpr(cplex, varmap,exprmap, varquerymap, query, preattribute, table, option);
		IloNumExpr current = cplex.prod(leftexpr, rightexpr);
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
			IloNumExpr current = cplex.prod(leftexpr, rightexpr);
			return current;
		}
	}
	
}
