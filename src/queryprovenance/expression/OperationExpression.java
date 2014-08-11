package queryprovenance.expression;

import java.util.ArrayList;
import java.util.List;

public abstract class OperationExpression extends Expression{

	protected Expression left, right;
	 
	public abstract  double Evaluate();
	public abstract String toString();
	
	/* set value for a given variable expression */
	public void setVariable(Expression ex, Double val) {
		this.left.setVariable(ex, val);
		this.right.setVariable(ex, val);	
	}

	/* get all variable expressions */
	public List<Expression> getVariable() {
		List<Expression> list = new ArrayList<Expression>();
		list.addAll(this.left.getVariable());
		list.addAll(this.right.getVariable());
		return list;
	}
	
	/* get all unassigned variable expressions (variable expressions that are suppose to be fixed) */
	public List<Expression> getUnassignedVariable(){
		List<Expression> list = new ArrayList<Expression>();
		list.addAll(this.left.getUnassignedVariable());
		list.addAll(this.right.getUnassignedVariable());
		return list;
	}
	
	/* return whether this expression contain some variable expression */
	public boolean containsVar(Expression ex){
		return this.left.containsVar(ex) || this.right.containsVar(ex);
	}
	
	 /* set variable expression value given expression name */
	public void setVariable(String ex_name, Double val) {
		this.left.setVariable(ex_name, val);
		this.right.setVariable(ex_name, val);
	}
	
	/* set given variable expression value */
	public void setName(Expression ex, String name_){
		this.left.setName(ex, name_);
		this.right.setName(ex, name_);
	}
	
}
