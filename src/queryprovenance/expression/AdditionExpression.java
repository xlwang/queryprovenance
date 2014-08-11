package queryprovenance.expression;

import java.util.ArrayList;
import java.util.List;

public class AdditionExpression extends OperationExpression{
	 
	public AdditionExpression(Expression left_, Expression right_){
		this.left = left_;
		this.right = right_;
		super.type = Type.ADDITION;
	}
	public double Evaluate() {
		return this.left.Evaluate() + this.right.Evaluate();
	}

 
	public String toString() {
		return "("+ this.left.toString() + "+" + this.right.toString()+")";
	}
	
	public double getPar(Expression ex){
		// Expression ex and either in left side or right side
		double par = 0;
		if(left.containsVar(ex))
			par = left.getPar(ex);
		if(right.containsVar(ex))
			par += right.getPar(ex);
		return par;
	}
 
	public double getAssignedEval() {
		double lefteval = left.getAssignedEval();
		double rightevel = right.getAssignedEval();
		return lefteval + rightevel;
	}
	
	public Expression clone(){
		return new AdditionExpression(this.left.clone(), this.right.clone());
	}

}
