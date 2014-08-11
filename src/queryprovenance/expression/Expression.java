package queryprovenance.expression;

import java.util.List;
/**
 * 
 * @author xlwang
 * Term of usage:
 * For example create an expression: 100*a + 20*b + 50; a,b are two attributes; 100, 20, 50 are three variables we would like to fix
 * Expression var1 = new VariableExpression(100, false); // or new Expression("var1", 100, false);
 * Expression var2 = new VariableExpression(20, false); 
 * Expression var3 = new VariableExpression(50, false);
 * Expression a = new VariableExpression("a", true);
 * Expression b = new VariableExpression("b", true);
 * Expression expr = new AdditionExpression(new AdditionExpression(new MultiplicationExpression(var1, a), new MultiplicationExpression(var2,b)), var3);
 * 
 * set attribute value:
 * expr.set(a, 40); 
 * expr.set(b, 20);
 * 
 * get parameter for a variable
 * expr.get(var1);
 * 
 */
public abstract class Expression {
	public static enum Type {
		VARIABLE, ADDITION, DIVISION, MUTIPLICATION, NAGATION;
	};
	
	Type type; // Expression Type
	
	public abstract double Evaluate(); // Evaluate expression value
	
	public abstract String toString(); 
	
	public abstract void setVariable(Expression ex, Double val); // set VariableExpression value, given VariableExpression
	
	public abstract void setVariable(String ex_name, Double val); // set VariableExpression value, given Variable Expression name
	
	public abstract List<Expression> getVariable(); // get all VariableExressions
	
	public abstract List<Expression> getUnassignedVariable(); // get all VariableExpression that do not have assigned value. List of variables to solve in SetExpr or WhereExpr
	
	public abstract boolean containsVar(Expression ex); // check whether given VariableExpression is included
	
	public abstract double getPar(Expression ex); // get parameters for a given VariableExpression
	
	public abstract double getAssignedEval(); // get accumulated sum of variables that do not need to solve
	
	public abstract Expression clone(); // clone Expression
	
	public abstract void setName(Expression ex, String name_); // set VariableExpression name 
	
	/* return Expression type */
	public Type getType(){ 
		return type;
	}
}
