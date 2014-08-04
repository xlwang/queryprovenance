package queryprovenance.query;

import ilog.concert.IloConstraint;
import ilog.concert.IloNumVar;
import ilog.cplex.IloCplex;
import java.util.*;

public class CplexHandler {
	// build cplex solver
	IloCplex cplex;
	IloNumVar[] var;
	IloNumVar[] obj;

	double epsilon;
	/* Initialize cplex solver */
	public CplexHandler(double ep) throws Exception{
		cplex = new IloCplex();
		epsilon = ep;
	}
	/* solve cplex */
	public double[] solve(WhereClause where, ArrayList<String[]> values_all, String[] classinfo, String method) throws Exception{
		double[] fixed_values = new double[where.getConditions().size()];
		
		// add constraints
		this.addAllConstraint(where, values_all, classinfo);
		
		// add objective function
		this.prepareObj(where, method);
		// solve cplex
		if(cplex.solve()){
			cplex.output().println("Solution status = " + cplex.getStatus());
			cplex.output().println("Solution value = " + cplex.getObjValue());
			for(int i = 0; i < fixed_values.length; ++i)
				fixed_values[i] = Math.round(cplex.getValue(var[i])*100)/100;
			return fixed_values;
		}
		else
			return null;
	}
	/* prepare objective function */
	public void prepareObj(WhereClause where, String method) throws Exception{
		// prepare input parameters
		List<Condition> conditions = where.getConditions();
		int size = conditions.size();
		obj = cplex.numVarArray(size, Double.MIN_VALUE, Double.MAX_VALUE);
		
		switch(method){
		case "abs":
			for(int i = 0; i < conditions.size(); ++i){
				double orgvar = Double.valueOf(conditions.get(i).getRight());
				cplex.add(cplex.eq(obj[i], cplex.abs(cplex.sum(var[i], -orgvar))));
			}
		}
		cplex.minimize(cplex.sum(obj));
	}
	
	/* prepare all constraints */
	public void addAllConstraint(WhereClause where, ArrayList<String[]> values_all, String[] classinfo) throws Exception {
		// check input parameters
		if(values_all.get(0).length != classinfo.length){
			System.out.println("Where Clause Error: value length not equals to class information");
			return;
		}
		// prepare cplex variables
		var = cplex.numVarArray(where.getConditions().size(), Double.MIN_VALUE, Double.MAX_VALUE);
		int current = 0;
		double[] values = new double[values_all.size()];
		// for each tuple, add constraints
		for(int i = 0; i < values_all.get(0).length; ++i){
			
			for(int j = 0; j < values_all.size(); ++j)
				values[j] = Double.valueOf(values_all.get(j)[i]);
			boolean isTrue = classinfo[current++].equals("b")?true:false;
			this.addConstraint(where, values, isTrue);
		}
			
	}
	/* prepare constraints for cplex solver */
	public void addConstraint(WhereClause where, double[] values, boolean isTrue) throws Exception{
		// check input parameters
		// values length must equals to where clause condition size
		if(where.getConditions().size() != values.length){
			System.out.println("Where Clause Error: value length not equals to condition size");
			return;
		}
		
		// prepare input parameters
		List<Condition> conditions = where.getConditions();
		int size = conditions.size();
		WhereClause.Op operation = where.getOperator();

		//IloNumVar[] obj = cplex.numVarArray(size, Double.MIN_VALUE, Double.MAX_VALUE);
		
		// prepare constraints
		IloConstraint[] cons = new IloConstraint[size];
		for(int i = 0; i < size; ++i){
			// for every constraint
			Condition.Op op = conditions.get(i).getOperator();
			switch(op){
			case g:
				if(isTrue)
					cons[i] = cplex.le(var[i], values[i]-epsilon);
				else
					cons[i] = cplex.ge(var[i], values[i]);
				break;
			case l:
				if(isTrue)
					cons[i] = cplex.ge(var[i], values[i]+epsilon);
				else
					cons[i] = cplex.le(var[i], values[i]);
				break;
			case ge:
				if(isTrue)
					cons[i] = cplex.le(var[i], values[i]);
				else
					cons[i] = cplex.ge(var[i], values[i]+epsilon);
				break;
			case le:
				if(isTrue)
					cons[i] = cplex.ge(var[i], values[i]);
				else
					cons[i] = cplex.le(var[i], values[i]-epsilon);
				break;
			case eq:
				if(isTrue)
					cons[i] = cplex.eq(var[i], values[i]);
				else
					cons[i] = cplex.eq(cplex.eq(var[i], values[i]), 0);
				break;
			case ne: 
				if(isTrue)
					cons[i] = cplex.eq(cplex.eq(var[i], values[i]), 0);
				else
					cons[i] = cplex.eq(var[i], values[i]);
				break;
			}
		}
		
		if((isTrue && operation.equals("and"))||(!isTrue && operation.equals("or"))){
			// every condition must satisfy 'isTrue' value
			cplex.add(cplex.and(cons));
		}
		else{
			// one of the consition must satisfy 'isTrue' value
			cplex.add(cplex.or(cons));
		}
	}
	
	/* return fixed where clause: transfer cplex results into condition rules */
	public String toConditionRules(WhereClause where, double[] fixed_values){
		String fixed_where = "";
		int size =  where.getConditions().size();
		// for each condition
		for(int i = 0; i < size-1; ++i){
			Condition condition = where.getConditions().get(i);
			fixed_where = fixed_where + condition.getLeft() + condition.getOperator() + String.valueOf(fixed_values[i++]);
			fixed_where = fixed_where +" " + where.getOperator()+" ";
		}
		Condition condition = where.getConditions().get(where.getConditions().size() - 1);
		fixed_where = fixed_where + condition.getLeft() + condition.getOperator() + String.valueOf(fixed_values[size-1]);
		
		return fixed_where;
	}
}
