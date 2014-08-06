package queryprovenance.expression;

import java.util.List;

public class VariableExpression extends Expression{
	String name;
	Double value;
	public VariableExpression(){
		
	}
	
	public VariableExpression(String var_){
		name = (String) var_;
	}
	
	public void setVariable(Expression ex, Double val_){
		value = val_;
	}
	
	public double Evaluate(){
		// TODO Auto-generated method stub
		return 0;
	}
	
	public String toString(){
		return String.valueOf(value);
	}

	@Override
	public List<Expression> getVariable() {
		// TODO Auto-generated method stub
		return null;
	}
}
