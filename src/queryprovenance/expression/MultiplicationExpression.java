package queryprovenance.expression;

import java.util.List;

public class MultiplicationExpression extends OperationExpression{

	/* initialize */
	public MultiplicationExpression(Expression left_, Expression right_){
		this.right = right_;
		this.left = left_;
		super.type = Type.MUTIPLICATION;
	}
	
	/* calculate for values */
	public double Evaluate() {
		return this.left.Evaluate()*this.right.Evaluate();
	}

	public String toString() {	 
		return  this.left.toString() + "*" + this.right.toString();
	}

	/* get parameter for a given variable expression */
	public double getPar(Expression ex) {
		boolean isLeft = left.containsVar(ex);
		boolean isRight = right.containsVar(ex);
		if(isLeft&&!isRight){
			double leftpar = left.getPar(ex);
			double rightpar = right.getAssignedEval();
			return leftpar*rightpar;
		}
		else if(!isLeft&&isRight){
			double leftpar = left.getAssignedEval();
			double rightpar = right.getPar(ex);
			return leftpar*rightpar;
		}
		else if(!isLeft && !isRight)
			return 0;
		else
			throw new IllegalArgumentException("Set Expression not linear");
	}

	/* evaluate values for assigned(fixed) variable expressions */
	public double getAssignedEval() {
		double lefteval = left.getAssignedEval();
		double righteval = right.getAssignedEval();
		return lefteval*righteval;
	}

	public Expression clone(){
		return new MultiplicationExpression(this.left.clone(), this.right.clone());
	}
}
