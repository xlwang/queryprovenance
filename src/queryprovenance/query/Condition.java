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
	
	public Condition(String condition_){
		variables = new HashMap<String, String>();
		condition = condition_;
		revised = "";
		variablecount = 0;
		Pattern pattern = Pattern.compile("(.+)\\s*([><!]=?)\\s*(.+)");
		Pattern pattern2 = Pattern.compile("(.+)\\s*(=)\\s*(.+)");
		Matcher matcher = pattern.matcher(condition);
		if(matcher.find()||(matcher = pattern2.matcher(condition)).find()){
			left = matcher.group(1);
			operator = matcher.group(2);
			right = matcher.group(3);
			processVar(left);
			revised = revised + operator;
			processVar(right);
		}
	}
	public void processVar(String str){
		String current = str;
		while(current.length()>0){
			Pattern pattern2 = Pattern.compile("(.+)\\s*(\\+|-|\\*|/)\\s*(.+)");
			Matcher matcher2 = pattern2.matcher(current);
			if(!matcher2.find())
				break;
			String temp = matcher2.group(1).trim();
			if(isNumber(temp)){
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
	}
	
	public String getOperator(){
		return this.operator;
	}
	
	public boolean isNumber(String str){
		Pattern pattern3 = Pattern.compile(".*\\D.*");
		Matcher matcher3 = pattern3.matcher(str);
		return !matcher3.find();
	}
	
	public String getLeft(){
		return left;
	}
	
	public String getRight(){
		return right;
	}
}
