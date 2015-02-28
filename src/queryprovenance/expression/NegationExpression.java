package queryprovenance.expression;

import ilog.concert.IloNumExpr;
import ilog.concert.IloNumVar;
import ilog.cplex.IloCplex;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import queryprovenance.database.Table;
import queryprovenance.query.CplexHandler;

public class NegationExpression extends OperationExpression{
	
	public NegationExpression(Expression expr){
		this.left = expr;
		super.type = Type.NAGATION;
	}
	
	public double Evaluate() {
		return -this.left.Evaluate();
	}

	public String toString() {	 
		return "-" + this.left.toString();
	}

	public double getPar(Expression ex) {
		double par = -left.getPar(ex);
		return par;
	}

	public double getAssignedEval() {
		double lefteval = left.getAssignedEval();
		return -lefteval;
	}

	public Expression clone(){
		return new NegationExpression(this.left.clone());
	}
	@Override
	public IloNumExpr convertExpr(IloCplex cplex, HashMap<IloNumVar, Double> varmap, HashMap<Expression, IloNumVar> exprmap, IloNumVar[] preattribute, Table table,
			boolean option) throws Exception {
		IloNumExpr rightexpr = super.right.convertExpr(cplex, varmap, exprmap, preattribute, table, option);
		IloNumExpr leftexpr = super.left.convertExpr(cplex, varmap,exprmap, preattribute, table, option);
		IloNumExpr current = cplex.diff(leftexpr, rightexpr);
		return current;
	}
	
	@Override
	public void fixExpression(HashMap<IloNumVar, Double> fixedmap,
			HashMap<Expression, IloNumVar> expressionmap) throws Exception {
		right.fixExpression(fixedmap, expressionmap);
		left.fixExpression(fixedmap, expressionmap);
		
	}
}
