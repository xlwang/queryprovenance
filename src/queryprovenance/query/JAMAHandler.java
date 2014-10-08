package queryprovenance.query;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.script.ScriptEngine;
import javax.script.ScriptEngineManager;

import queryprovenance.expression.Expression;
import Jama.Matrix;
public class JAMAHandler {
	Matrix A;
	Matrix b;
	Matrix x;
	double[][] arrayA;
	double[][] arrayb;
	double[][] arrayx;
	List<Expression> variables;
	long[] timestamps = new long[4];
	
	/* JAMA solver */
	public JAMAHandler(){	
		variables = new ArrayList<Expression>();
	}
	
	/* Solve set clause*/
	public List<SetExpr> solve(SetClause set, String[] column_names, ArrayList<String[]> pre_values_all, ArrayList<String[]> next_values_all) throws Exception {
		if(pre_values_all == null || next_values_all == null || pre_values_all.size() == 0 || next_values_all.size() == 0)
			return null;
		for(String[] vallist:pre_values_all){
			if(!(vallist.length > 0))
				return null;
		}
		timestamps[0] = System.nanoTime();
		// prepare data
		this.prepareData(set, column_names, pre_values_all, next_values_all);
		A = new Matrix(arrayA);
		b = new Matrix(arrayb);
		timestamps[1] = System.nanoTime();
		try{
		x = A.solve(b);
		
		timestamps[2] = System.nanoTime();
		arrayx = x.getArray();
		// convert back
		List<SetExpr> fixed_set = this.toConditionRules(set);
		timestamps[3] = System.nanoTime();
		return fixed_set;
		} catch (RuntimeException e){
			System.out.print("error");
			return null;
		}
	}
	
	public long[] getTimeStamps(){
		return timestamps;
	}
 	/* Initialize solver by assign A, b matrix values*/
	public void prepareData(SetClause set, String[] column_names, ArrayList<String[]> pre_values_all, ArrayList<String[]> next_values_all) throws Exception{
		int numOfTuple = pre_values_all.size();
		arrayA = new double[0][0];
		arrayb = new double[0][1]; 
		// get matrix size information
		int sizem = set.getSetExprs().size();
		int sizen = 0;
		for(SetExpr con: set.getSetExprs())
			sizen += con.getVariableCount();
		// get variables
		int varcount = 0;
		for(int i = 0; i < sizem; ++i){
			Expression expr = set.getSetExprs().get(i).getExpr();
			List<Expression> list_of_var = expr.getUnassignedVariable();
			for(Expression var: list_of_var){
				expr.setName(var, "var"+String.valueOf(varcount++));
				variables.add(var);
			}
		}
		// for each tuple
		for(int i = 0; i < numOfTuple; ++i){
			// initialize matrix
			double[][] temparrayA = new double[sizem][sizen];
			double[][] temparrayb = new double[sizem][1];
			
			// prepare values
			HashMap<String, String> preValues = new HashMap<String, String>();
			HashMap<String, String> nextValues = new HashMap<String, String>();
			for(int j = 0; j < column_names.length; ++j){
				preValues.put(column_names[j], pre_values_all.get(i)[j]);
				nextValues.put(column_names[j], next_values_all.get(i)[j]);
			}
			// prepare for the parameters: matrix
			getPar(set, preValues, nextValues, temparrayA, temparrayb);
			
			// connects matrix
			double[][] arrayAAdd = new double[arrayA.length+temparrayA.length][];
			double[][] arraybAdd = new double[arrayb.length+temparrayb.length][];
			System.arraycopy(arrayA, 0, arrayAAdd, 0, arrayA.length);
			System.arraycopy(temparrayA, 0, arrayAAdd, arrayA.length, temparrayA.length);
			System.arraycopy(arrayb, 0, arraybAdd, 0, arrayb.length);
			System.arraycopy(temparrayb, 0, arraybAdd, arrayb.length, temparrayb.length);
			
			arrayA = arrayAAdd;
			arrayb = arraybAdd;
		}
		
 	}
	
	/* prepare single tuple parameters */
	public void getPar(SetClause set, HashMap<String, String> preValues, HashMap<String, String> nextValues, double[][] arrayA, double[][] arrayb) throws Exception{
		int sizem = arrayb.length;
	    int count = 0;
		// process each condition in Set clause
		for(int i = 0; i< sizem; i++){
			
			// process the attribute
			Expression attr = set.getSetExprs().get(i).getAttr();
			Expression expr = set.getSetExprs().get(i).getExpr();
			// set value for attribute
			for(String key:nextValues.keySet())
				attr.setVariable(key, Double.valueOf(nextValues.get(key)));
			// update matrix b
			arrayb[i][0] = attr.Evaluate();
			// set value for set expression
			for(String key:preValues.keySet())
				expr.setVariable(key, Double.valueOf(preValues.get(key)));
			// update matrix a
			for(int j=0; j < variables.size(); ++j){
				Expression var = variables.get(j);
				double par = expr.getPar(var);
				arrayA[i][j] = par;
			}
			arrayb[i][0] -= expr.getAssignedEval();
		}		
	}
	
	/* convert solved values into set clause */
	public List<SetExpr> toConditionRules(SetClause set){
		
		int sizem = set.getSetExprs().size();
		List<SetExpr> fixed_set_exprs = new ArrayList<SetExpr>();
		List<SetExpr> set_exprs = set.getSetExprs();
	    for(SetExpr expr:set_exprs)
	    	fixed_set_exprs.add(expr.clone());
	    int count = 0;
		// process each condition in Set clause
		for(int i = 0; i< sizem; i++){
			Expression expr = fixed_set_exprs.get(i).getExpr();
			for(int j = 0; j < arrayx.length; ++j){
				double variable = arrayx[count++][0];
				variable = (double) Math.round(variable*100)/100;
				expr.setVariable("var"+String.valueOf(j), variable);
			}	
		}
		return fixed_set_exprs;
	}

	public boolean isNumeric(String str)  
	{  
	  try  
	  {  
	    double d = Double.parseDouble(str);  
	  }  
	  catch(NumberFormatException nfe)  
	  {  
	    return false;  
	  }  
	  return true;  
	}

}
