package queryprovenance.expression;

import java.util.ArrayList;
import java.util.EmptyStackException;
import java.util.List;

public class VariableExpression extends Expression{
	String name;
	Double value;
	boolean isTrue;
	
	/* initialize variable expression: true(variable corresponding to an attribute or variable that is guaranteed as correct); otherwise, false */
	public VariableExpression(boolean isTrue_){
		isTrue = isTrue_;
		value = Double.MAX_VALUE;
		super.type = Type.VARIABLE;
	}
	
	/* initialize variable expression */
	public VariableExpression(String var_, boolean isTrue_){
		isTrue = isTrue_;
		name = (String) var_;
		value = Double.MAX_VALUE;
		super.type = Type.VARIABLE;
	}
	
	/* initialize variable expression */
	public VariableExpression(double value_, boolean isTrue_){
		isTrue = isTrue_;
		name = "unnamed variable";
		value = value_;
		super.type = Type.VARIABLE;
	}
	
	/* initial variable expression */	
	public VariableExpression(String var_, double value_, boolean isTrue_){
		isTrue = isTrue_;
		name = var_;
		value = value_;
		super.type = Type.VARIABLE;
	}
	
	/* set variable expression value */
	public void setVariable(Expression ex, Double value_){
		if(ex.equals(this))
			value = value_;
	}
	
	/* set variable expression value */
	public void setVariable(String ex_name, Double val) {
		if(ex_name.equals(this.name))
			value = val;
	}
	
	/* return variable expression value */
	public double Evaluate(){
		if(value == Double.MAX_VALUE)
			throw new IllegalArgumentException("must set Variable: " + name);
		else
			return value;
	}
	
	/* to string*/
	public String toString(){
		if(isTrue)
			return name;
		else
			return String.valueOf(value);
	}

	/* get variable*/
	public List<Expression> getVariable() {
		List<Expression> list = new ArrayList<Expression>();
		list.add(this);
		return list;
	}
	
	/* get unassigned variable */
	public List<Expression> getUnassignedVariable(){
		List<Expression> list = new ArrayList<Expression>();
		if(!isTrue)
			list.add(this);
		return list;
	}
	
	/* check whether it is the same with a given variable */
	public boolean containsVar(Expression ex){
		if(ex.equals(this))
			return true;
		else
			return false;
	}
	
	/* get parameters for a given VariableExpression */
	public double getPar(Expression ex){
		if(ex.equals(this))
			return 1;
		else
			return 0;
	}
	
	/* evaluate assigned part */
	public double getAssignedEval() {
		if(isTrue)
			return value;
		else
			return 0;
	}
	
	/* set variable name */
	public void setName(Expression ex, String name_){
		if(ex.equals(this))
			this.name = name_;
	}
	
	/* clone variable */
	public Expression clone(){
		return new VariableExpression(this.name, this.value, this.isTrue);
	}
}
