package queryprovenance.expression;

import java.util.List;

public class DivisionExpression extends OperationExpression{

	public DivisionExpression(Expression left_, Expression right_){
		this.right = right_;
		this.left = left_;
		super.type = Type.DIVISION;
	}
	
	public double Evaluate() {
		return this.left.Evaluate()/this.right.Evaluate();
	}

	public String toString() {	 
		return  this.left.toString() + "/" + this.right.toString();
	}

	public double getPar(Expression ex) {
		double par;
		if(left.containsVar(ex)){
			par = right.Evaluate();
			return left.getPar(ex)/par;
		}
		else if(right.containsVar(ex))
			throw new IllegalArgumentException("Set Expression not linear");
		else
			return 0;
	}

	public double getAssignedEval() {
		double lefteval = left.getAssignedEval();
		double righteval = right.getAssignedEval();
		if(righteval != 0)
			return lefteval/righteval;
		else
			return 0;
	}
	
	public Expression clone(){
		return new DivisionExpression(this.left.clone(), this.right.clone());
	}

}
