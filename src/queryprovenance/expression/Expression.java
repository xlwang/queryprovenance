package queryprovenance.expression;

import java.util.List;

public abstract class Expression {
	public abstract double Evaluate();
	public abstract String toString();
	public abstract void setVariable(Expression ex, Double val);
	public abstract List<Expression> getVariable();
}
