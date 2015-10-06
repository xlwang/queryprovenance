package queryprovenance.solve;

import queryprovenance.problemsolution.SingleComplaint;
import ilog.concert.IloNumVar;
import ilog.cplex.IloCplex;

public class varX {
	public SingleComplaint scp;
	public IloNumVar var; // IloVariable
	public String expr; // expression in the query: where expression in where
						// clause or insert query
	public double solvedval; // solved value
	public double origval; // original value
	IloCplex cplex;

	/**
	 * Initialization
	 * 
	 * @param cplex
	 *            IloCplex
	 * @param expr
	 *            where expression
	 * @param origval
	 *            original satisfactory
	 */
	public varX(IloCplex cplex_, SingleComplaint scp_, String expr_, double origval_)
			throws Exception {
		scp = scp_;
		cplex = cplex_;
		var = cplex.numVar(0, 1);
		expr = expr_;
		origval = origval_;
		solvedval = -1; // unsolved value
	}

	/**
	 * Initialization
	 */
	public varX(IloCplex cplex_, SingleComplaint scp_, String expr_, double origval_,
			double solvedval_) throws Exception {
		cplex = cplex_;
		var = cplex.numVar(0, 1);
		expr = expr_;
		origval = origval_;
		solvedval = solvedval_; // unsolved value

	}

	/** Function clone : clone the variable */
	public varX clone() {
		try {
			return new varX(cplex, scp, expr, origval, solvedval);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}
	}
}
