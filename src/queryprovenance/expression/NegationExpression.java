package queryprovenance.expression;

import java.util.List;

public class NegationExpression extends OperationExpression{
	
	public NegationExpression(Expression expr){
		this.left = expr;
		super.type = Type.NAGATION;
	}
	
	public double Evaluate() {
		return -this.left.Evaluate();
	}

	public String toString() {	 
		return "-" + this.left.toString();
	}

	public double getPar(Expression ex) {
		double par = -left.getPar(ex);
		return par;
	}

	public double getAssignedEval() {
		double lefteval = left.getAssignedEval();
		return -lefteval;
	}

	public Expression clone(){
		return new NegationExpression(this.left.clone());
	}
}
