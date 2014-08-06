package queryprovenance.query;

import java.util.HashMap;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import queryprovenance.expression.*;

// ewu: I don't understand what SetExpr.expr is...
// xl: SetExpr is for set clause expressions, e.f. salary = salary * 1.2;
// salary is the attribute that is modified; salary * 1.2 is the expression of how it is modified.
// set expression need to be modified as: salary (value in Di+1) = salary (value in Di) + variable;
// A linear system solver is used to solve variables.

public class SetExpr {

	protected String attr;
	protected Expression expr;
	//protected String revised; // expression with variable index
	//protected int variablecount;
	
	public SetExpr(String attr_, String expr_){
		this.attr = attr_;
		this.expr = expr_; 
	}
	
	public String toString(){
		return attr+" = "+ expr;
	}
	public void processVar(){
		variablecount = 0;
		revised = "";
		String current = this.expr;
		while(current.length()>0){
			Pattern pattern2 = Pattern.compile("(.+)\\s*(\\+|-|\\*|/)\\s*(.+)");
			Matcher matcher2 = pattern2.matcher(current);
			if(!matcher2.find())
				break;
			String temp;
			if(isNumber(temp = matcher2.group(1).trim())){
				revised = revised+"var"+String.valueOf(variablecount++);
			}
			else
				revised = revised+temp;
			revised = revised + matcher2.group(2);
			current = matcher2.group(3);
		}
		if(current.length()>0)
			if(isNumber(current)){
				revised = revised+"var"+String.valueOf(variablecount++);
			}
			else
				revised = revised + current;
		revised = revised.replaceAll("/var", "\\*var");
	}
	
	/* return whether a string is a number */
	public boolean isNumber(String str){
		Pattern pattern3 = Pattern.compile(".*\\D.*");
		Matcher matcher3 = pattern3.matcher(str);
		return !matcher3.find();
	}
	
	public int getVariableCount(){
		return this.variablecount;
	}
	
	public String getAttr(){
		return this.attr;
	}
	
	public String getExpr(){
		return this.expr;
	}
	
	public String getRevisedExpr(){
		return this.revised;
	}
	
}
