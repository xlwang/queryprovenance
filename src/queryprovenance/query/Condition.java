package queryprovenance.query;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.regex.Pattern;
import java.util.regex.Matcher;

public class Condition {
	protected String left; // left side of equation or inequality; fixed;
	protected HashMap<String, String> variables;
	protected String operator; // operator connects left and right side; =/>/</>=/<=.
	protected String right; // variables to be solved;
	protected String revised;
	protected String condition;
	protected int variablecount;
	
	/* Construct condition: separate left, right, and operator */
	public Condition(String condition_){
		variables = new HashMap<String, String>();
		condition = condition_;
		revised = "";
		variablecount = 0;
		Pattern pattern = Pattern.compile("(.+)\\s*([><!]=?)\\s*(.+)");
		Pattern pattern2 = Pattern.compile("(.+)\\s*(=)\\s*(.+)");
		Matcher matcher = pattern.matcher(condition);
		if(matcher.find()||(matcher = pattern2.matcher(condition)).find()){
			left = matcher.group(1).trim();
			operator = matcher.group(2).trim();
			right = matcher.group(3).trim();
			//processVar(left);
			//revised = revised + operator;
			processVar(right);
		}
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
	public String getOperator(){
		return this.operator;
	}
	
	/* return revised right side */
	public String getRevisedRight(){
		return this.revised;
	}
}
