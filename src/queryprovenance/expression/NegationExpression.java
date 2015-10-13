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
	
	public IloNumExpr convertExpr(IloCplex cplex, HashMap<IloNumVar, Double> varmap, HashMap<Expression, IloNumVar> exprmap, HashMap<Query, ArrayList<IloNumVar>> varquerymap, Query query, IloNumVar[] preattribute, Table table,
			boolean option) throws Exception {
		IloNumExpr rightexpr = super.right.convertExpr(cplex, varmap, exprmap, varquerymap, query, preattribute, table, option);
		IloNumExpr leftexpr = super.left.convertExpr(cplex, varmap,exprmap, varquerymap, query, preattribute, table, option);
		IloNumExpr current = cplex.diff(leftexpr, rightexpr);
		return current;
	}

	@Override
	public IloNumExpr convertExpr(IloCplex cplex,
			HashMap<String, Integer> attrs, IloNumVar[] prestate,
			HashMap<VariableExpression, varQuery> varQMap, HashSet<varQuery> currentVar,
			boolean fix) throws Exception {
		IloNumExpr rightexpr = super.right.convertExpr(cplex, attrs, prestate, varQMap, currentVar, fix);
		IloNumExpr leftexpr = super.left.convertExpr(cplex, attrs, prestate, varQMap, currentVar, fix);
		if(rightexpr == null || leftexpr == null) {
			return null;
		} else {
			IloNumExpr current = cplex.diff(leftexpr, rightexpr);
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
