package queryprovenance.query;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.script.ScriptEngine;
import javax.script.ScriptEngineManager;

import Jama.Matrix;
public class JAMAHandler {
	Matrix A;
	Matrix b;
	Matrix x;
	double[][] arrayA;
	double[][] arrayb;
	double[][] arrayx;
	
	/* JAMA solver */
	public JAMAHandler(){		
	}
	
	/* Solve set clause*/
	public List<SetExpr> solve(SetClause set, String[] column_names, ArrayList<String[]> pre_values_all, ArrayList<String[]> next_values_all) throws Exception {
		for(String[] vallist:pre_values_all){
			if(!(vallist.length > 0))
				return null;
		}
		// prepare data
		this.prepareData(set, column_names, pre_values_all, next_values_all);
		A = new Matrix(arrayA);
		b = new Matrix(arrayb);
		try{
		x = A.solve(b);
		arrayx = x.getArray();
		// convert back
		List<SetExpr> fixed_set = this.toConditionRules(set);
		return fixed_set;
		} catch (RuntimeException e){
			return null;
		}
	}
	
 	/* Initialize solver by assign A, b matrix values*/
	public void prepareData(SetClause set, String[] column_names, ArrayList<String[]> pre_values_all, ArrayList<String[]> next_values_all) throws Exception{
		int numOfTuple = pre_values_all.get(0).length;
		arrayA = new double[0][0];
		arrayb = new double[0][1]; 
		// get matrix size information
		int sizem = set.getSetExprs().size();
		int sizen = 0;
		for(SetExpr con: set.getSetExprs())
			sizen += con.getVariableCount();
		// for each tuple
		for(int i = 0; i < numOfTuple; ++i){
			// initialize matrix
			double[][] temparrayA = new double[sizem][sizen];
			double[][] temparrayb = new double[sizem][1];
			
			// prepare values
			HashMap<String, String> preValues = new HashMap<String, String>();
			HashMap<String, String> nextValues = new HashMap<String, String>();
			for(int j = 0; j < column_names.length; ++j){
				preValues.put(column_names[j], pre_values_all.get(j)[i]);
				nextValues.put(column_names[j], next_values_all.get(j)[i]);
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
			int j = 0;
			String preop = "";
			
			// process the attribute
			String attr = set.getSetExprs().get(i).getAttr();
			arrayb[i][0] = Double.valueOf(nextValues.get(attr));
			
			// process the expression
			String expr = set.getSetExprs().get(i).getRevisedExpr();
			while(expr.length()>0){
				
				// check every components
				Pattern pattern = Pattern.compile("(.+)\\s*(\\+|-)\\s*(.+)");
				Matcher matcher = pattern.matcher(expr);
				if(matcher.find()){
					String current = matcher.group(1);
					if(current.length()>0){
						if(j < updateMatrix(arrayA, arrayb, i, j, count, current, preop, preValues)){
							j++;
							count++;
						}					
					}
					preop = matcher.group(2);
					expr = matcher.group(3);
				}
				else
					break;
			}
			if(expr.length()>0){
				if(j < updateMatrix(arrayA, arrayb, i, j, count, expr, preop, preValues)){
					j++; count++;
				}
			}
		}		
	}
	
	/* convert solved values into set clause */
	public List<SetExpr> toConditionRules(SetClause set){
		
		int sizem = arrayA[0].length;
		List<SetExpr> fixed_set_conditions = new ArrayList<SetExpr>();
		List<SetExpr> set_conditions = set.getSetExprs();
	   
	    int count = 0;
		// process each condition in Set clause
		for(int i = 0; i< sizem; i++){
			
			// process the right side
			String fixed_expr = set_conditions.get(i).getRevisedExpr();
			for(int j = 0; j <set_conditions.get(i).getVariableCount(); ++j){
				double variable = arrayx[count++][0];
				variable = Math.round(variable*100)/100;
				fixed_expr = fixed_expr.replaceAll("var"+String.valueOf(j), String.valueOf(variable));
			}
			fixed_set_conditions.add(new SetExpr(set_conditions.get(i).getAttr(), fixed_expr));
		}

		return fixed_set_conditions;
	}
	
	/* update values in the parameter matrix*/
	public int updateMatrix(double[][] arrayA, double[][] arrayb, int i, int j, int count, String str, String preop, HashMap<String, String> preValues) throws Exception{
		// equation solver
		ScriptEngineManager mgr = new ScriptEngineManager();
	    ScriptEngine engine = mgr.getEngineByName("JavaScript");
	    
		// check whether it contains a variable or not
		Pattern pattern2 = Pattern.compile("var"+String.valueOf(j));
		Matcher matcher2 = pattern2.matcher(str);
		
		// prepare values: replace column names with tuple values in previous state
		String currentval = str.replaceAll("var"+String.valueOf(j), "");
		for(String colname: preValues.keySet())
			currentval = currentval.replaceAll(colname, preValues.get(colname));
		double val;
		if(this.isNumeric(currentval))
			val = Double.valueOf(engine.eval(preop+currentval).toString());
		else
			val = 1;
		
		if(matcher2.find()){
			// if this component contains a variable
			arrayA[i][count] = val;
			j++;
		}
		else{
			arrayb[i][0] -= val;
		}
		return j;
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
