package queryprovenance.query;

import ilog.concert.IloNumVar;

import java.util.HashMap;
import java.util.HashSet;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import queryprovenance.expression.*;

// ewu: I don't understand what SetExpr.expr is...
// xl: SetExpr is for set clause expressions, e.f. salary = salary * 1.2;
// salary is the attribute that is modified; salary * 1.2 is the expression of how it is modified.
// set expression need to be modified as: salary (value in Di+1) = salary (value in Di) + variable;
// A linear system solver is used to solve variables.

public class SetExpr {

	protected Expression attr;
	protected Expression expr;
	public HashSet<String> attrs = new HashSet<String>();
	
	public SetExpr(Expression attr_, Expression expr_){
		this.attr = attr_;
		this.expr = expr_; 
		attrs.addAll(attr.getAssignedVariable());
		attrs.addAll(expr.getAssignedVariable());
	}
	
	public String toString(){
		return attr+" = "+ expr;
	}
	
	public SetExpr clone(){
		return new SetExpr(this.attr.clone(), this.expr.clone());
	}

	/* return whether a string is a number */
	public boolean isNumber(String str){
		Pattern pattern3 = Pattern.compile(".*\\D.*");
		Matcher matcher3 = pattern3.matcher(str);
		return !matcher3.find();
	}
	
	/* return number of unassigned variables */
	public int getVariableCount(){
		return this.expr.getUnassignedVariable().size();
	}
	
	/* return attribute that is updated */
	public Expression getAttr(){
		return this.attr;
	}
	
	/* get expression */
	public Expression getExpr(){
		return this.expr;
	}
	
	public void fix(HashMap<IloNumVar, Double> fixedmap, HashMap<Expression, IloNumVar> expressionmap) throws Exception {
		expr.fixExpression(fixedmap, expressionmap);
	}
	
	// Update where expr by converting string value into integer value
	public void StrToNum(HashMap<String, Integer> attr_value_map, String attr_) {
		// check if current expression is involved in the update
		if(attr.containsVar(attr_)) {
			expr.StrToNum(attr_value_map, attr_);
		}
	}
	
	// Convert set expression into JSON format
	public String QueryToJSON() {
		String setexpr_json = "\"" + attr.toString() + "\"" + "," +
			 "\"" + expr.toString() + "\"";
		return setexpr_json;
	}
}
