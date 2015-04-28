package queryprovenance.solve;

import ilog.concert.IloNumVar;
import ilog.cplex.IloCplex;
import queryprovenance.expression.VariableExpression;

public class varQuery {

	public IloNumVar var; // IloVariable
	public VariableExpression expr; // expression in the query
	public double fixedval;
	public boolean incurrentcycle;
	public IloCplex cplex;

	/**
	 * Initialization
	 * 
	 * @throws Exception
	 */
	public varQuery(IloCplex cplex_, VariableExpression expr_) throws Exception {
		cplex = cplex_;
		var = cplex.numVar(Double.MIN_VALUE, Double.MAX_VALUE);
		expr = expr_;
		fixedval = Double.MAX_VALUE;
		incurrentcycle = false;
	}

	/**
	 * Initialization
	 * 
	 * @throws Exception
	 */
	public varQuery(IloCplex cplex_, VariableExpression expr_, double fixedval_)
			throws Exception {
		cplex = cplex_;
		var = cplex.numVar(Double.MIN_VALUE, Double.MAX_VALUE);
		expr = expr_;
		fixedval = fixedval_;
		incurrentcycle = false;
	}

	/** Function clone : clone the variable */
	public varQuery clone() {
		try {
			return new varQuery(cplex, expr, fixedval);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}
	}
}
