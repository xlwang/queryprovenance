package queryprovenance.problemsolution;
import ilog.concert.*;
import ilog.cplex.*;

public class cplextest {
	public static void main(String[] args) {
		double epsilon = 0.1;
		try {
			IloCplex cplex = new IloCplex();
			IloCplexModeler Model = new IloCplexModeler();
			IloNumVar x1 = cplex.numVar(Double.MIN_VALUE, Double.MAX_VALUE);
			IloNumVar x2 = cplex.numVar(Double.MIN_VALUE, Double.MAX_VALUE);
			IloNumVar x = cplex.numVar(Double.MIN_VALUE, Double.MAX_VALUE);
			IloNumVar y = cplex.numVar(Double.MIN_VALUE, Double.MAX_VALUE);
			IloConstraint[] cons = new IloConstraint[2];
			cons[0] = cplex.ge(x1, 2+epsilon);
			cons[1] = cplex.le(x2, 68000);
			cplex.add(cplex.or(cplex.ge(x1, 1+epsilon),cplex.le(x2, 60000)));
			cplex.add(cplex.or(cons));
			cplex.add(cplex.and(cplex.le(x1, 3),cplex.ge(x2, 76000+epsilon)));
			cplex.add(cplex.eq(x, cplex.abs(cplex.sum(x1, -2))));
			cplex.add(cplex.eq(y, cplex.abs(cplex.sum(x2, -80000))));
			cplex.minimize(cplex.sum(x,y));
		if (cplex.solve()) {
		cplex.output().println("Solution status = " + cplex.getStatus());
		cplex.output().println("Solution value = " + cplex.getObjValue());
		double val = cplex.getValue(x1);
		cplex.output().println(" Value = " + val);
		double val2 = cplex.getValue(x2);
		cplex.output().println(" Value = " + val2);
		cplex.end();
		}
		} catch (IloException e) {
		System.err.println("Concert exception '" + e + "' caught");
		}
		}
}
