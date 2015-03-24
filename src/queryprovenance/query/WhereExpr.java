package queryprovenance.query;

import ilog.concert.IloNumVar;

import java.util.HashMap;

import queryprovenance.expression.Expression;
public class WhereExpr {
	public  static  enum Op {
		l,  // <
		le, // <=
		g,  // >
		ge, // >=
		eq, // =
		ne  // !=
	}
	// Assume the given expression in the form of <attribute arithmetic expression> <Op> <variable>
	protected Expression attr_expr; // expression that is fixed: no revision needed
	protected Op operator; // relationship between two expressions
	protected Expression var; // expression need revision
	
	/* initialize where expression */
	public WhereExpr(Expression attr_expr_, Op operator_, Expression var_){
		this.attr_expr = attr_expr_;
		this.operator = operator_;
		this.var = var_;
	}
	
	/* initialize where expression */
	public WhereExpr(Expression attr_expr_, String op_, Expression var_){
		this.attr_expr = attr_expr_;
		this.operator = this.getOperator(op_);
		this.var = var_;
	}
	
	/* return attr_expr */
	public Expression getAttrExpr(){
		return this.attr_expr;
	}
	
	/* return var value */
	public double getVar(){
		return this.var.Evaluate();
	}
	
	/* return operation */
	public Op getOperator(){
		return this.operator;
	}
	
	public String getOperatorString() {
		if (this.operator == Op.l)  return "<"; 
		if (this.operator == Op.le) return "<=";
		if (this.operator == Op.g) return ">";
		if (this.operator == Op.ge) return ">=";
		if (this.operator == Op.eq) return "=";
		if (this.operator == Op.ne) return "!=";
		return "";
	}
	
	public static Op getOperator(String op){
		switch(op){
		case ">=": return Op.ge;
		case "<=": return Op.le;
		case ">" : return Op.g;
		case "<" : return Op.l;
		case "!=": return Op.ne;
		case "=" : return Op.eq;
		}
		return null;
	}
	
	public String toString(){
		String str = attr_expr.toString();
		String op = "";
		switch(operator){
		case l: op = "<";break;
		case le: op = "<=";break;
		case g: op = ">";break;
		case ge: op = ">=";break;
		case eq: op = "=";break;
		case ne: op = "!=";break;
		default: return null;
		}
		return String.format("%s %s %s",  attr_expr.toString(), op, var.toString());
	}
	
	/* clone expression */
	public WhereExpr clone(){
		return new WhereExpr(this.attr_expr.clone(), this.operator, this.var.clone());
	}
	
	/* get var expression */
	public Expression getVarExpr(){
		return this.var;
	}
	
	public void fix(HashMap<IloNumVar, Double> fixedmap, HashMap<Expression, IloNumVar> expressionmap) throws Exception {
		// this.attr_expr.fixExpression(fixedmap, expressionmap);
		this.var.fixExpression(fixedmap, expressionmap);
	}
	
}
