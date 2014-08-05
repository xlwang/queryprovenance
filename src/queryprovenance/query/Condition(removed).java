package queryprovenance.query;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import queryprovenance.harness.Util;

public class Condition {
	public static enum Op {
		l,  // <
		le, // <=
		g,  // >
		ge, // >=
		eq, // =
		ne  // !=
	}
	protected String left; // left side of equation or inequality; fixed;
	protected HashMap<String, String> variables;
	protected Op operator; // operator connects left and right side; =/>/</>=/<=.
	protected String right; // variables to be solved;
	protected String revised;
	protected int variablecount;
	
	/* Construct condition: separate left, right, and operator */
	public Condition(String left, Op op, String right){
		this.left = left;
		this.operator = op;
		this.right = right;
		
		// XXX: I don't understand the format you expect left and right to be.  
		//      Need to talk about it.
		processVar(right);
	}
	
	/* rewrite right side of the condition into the form of columns + variables */
	public void processVar(String str){
		String current = str;
		while(current.length()>0){
			Pattern pattern2 = Pattern.compile("(.+)\\s*(\\+|-|\\*|/)\\s*(.+)");
			Matcher matcher2 = pattern2.matcher(current);
			if(!matcher2.find())
				break;
			String temp;
			if(isNumber(temp = matcher2.group(1).trim())){
				variables.put("var"+String.valueOf(variablecount++), temp);
				revised = revised+"var"+String.valueOf(variablecount-1);
			}
			else
				revised = revised+temp;
			revised = revised + matcher2.group(2);
			current = matcher2.group(3);
		}
		if(current.length()>0)
			if(isNumber(current)){
				variables.put("var"+String.valueOf(variablecount++), current);
				revised = revised+"var"+String.valueOf(variablecount-1);
			}
			else
				revised = revised + current;
		revised = revised.replaceAll("/var", "\\*var");
	}
	
	public String toString() {
		List<String> arr = new ArrayList<String>();
		String _op = "=";
		switch(this.operator) {
		case l: _op = "<";
		case le: _op = "<=";
		case g: _op = ">";
		case ge: _op = ">=";
		case eq: _op = "=";
		case ne: _op = "!=";
		};
		
		// XXX: not sure how to implement this function
		return "";
	}
	
	/* return whether a string is a number */
	public boolean isNumber(String str){
		Pattern pattern3 = Pattern.compile(".*\\D.*");
		Matcher matcher3 = pattern3.matcher(str);
		return !matcher3.find();
	}
	
	/* return left side*/
	public String getLeft(){
		return left;
	}
	
	/* return right side*/
	public String getRight(){
		return right;
	}
	
	/* return number of variables */
	public int getVariableCount(){
		return this.variablecount;
	}
	
	/* return operator connects left and right side */
	public Op getOperator(){
		return this.operator;
	}
	
	/* return revised right side */
	public String getRevisedRight(){
		return this.revised;
	}
}
