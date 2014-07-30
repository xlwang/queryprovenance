package queryprovenance.query;

import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.regex.Pattern;
import java.util.regex.Matcher;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;

import queryprovenance.problemsolution.*;


public class WhereClause {
	private String where; // original where clause
	private Condition[] where_conditions; // a set of conditions
	private String operator; // disjunction/conjunction
	private ArrayList<String> table_names; // tables involved in the where clause
	private HashMap<String, Condition> attribute_condition_map; // 
	private String fixed_where; // fixed where clasue
	
	/* construct the where clause given a query*/
	public WhereClause(ArrayList<Partition> groups_, ArrayList<String> querytables){
		
		// find where clause partition in the query 
		for(Partition part: groups_){
			
			if(part.getPartitionName().equals("where")){
				where = part.getContent();
				
				// decompose where clause into condition rules 
				Pattern pattern = Pattern.compile("(and|or)");
				Matcher matcher = pattern.matcher(where);
				
				if(matcher.find())
					operator = matcher.group();
				else
					operator = "";
				
				// get a list of condition rules;
				ArrayList<String> contents = part.getSplitedContent();
				
				// initialize each condition rules
				where_conditions = new Condition[contents.size()];
				for(int i=0; i<contents.size(); ++i){
					where_conditions[i] = new Condition(contents.get(i));
				}
				
				// get table names
				table_names = querytables;
				break;
			}
		}
	}
	
	/* solve the where clause given the previous/next db states */
	public String solve(DatabaseState pre, DatabaseState next, String[] option) throws Exception{
		
		String result = "";
		
		// prepare for options
		if(option.length%2>0){
			System.out.println("option not supported by Where clause solver");
			return null;
		}
		for(int i=0; i<option.length; i=i+2){
			String op = option[i];
			switch(op){
			case "-M": // method choosed for where clause solver
				if(option[i+1].equals("0")) // "0" for Decision tree solver
					result = solveDT(pre,next);
				else if(option[i+1].equals("1")) //"1" for MILP solver
					result = solveMILP(pre,next, 0.1);
				else
					result = null;
				break;
			}
		}
		
		// return results as a revised query
		return result;
	}
	
	/* solve the where clause by MILP cplex*/
	public String solveMILP(DatabaseState pre, DatabaseState next, double ep) throws Exception{
		// build cplex solver
		CplexHandler cplex = new CplexHandler(ep);
		// prepare class information
		String[] classinfo;
		
		// prepare feature information
		ArrayList<String[]> valuesAll = new ArrayList<String[]>();
		String[] value_names = this.getFeature().split(",");
		
		// gather class information
		classinfo = pre.compare(next);
		
		// gather feature information
		for(String fname:value_names){
			fname.trim();
			String[] value = pre.getFeature(fname);
			valuesAll.add(value);
		}
		
		// prepare cplex
		double[] fixed_values = cplex.solve(this, valuesAll, classinfo, "abs");
		
		// get fixed where
		if(fixed_values != null)
			fixed_where = cplex.toConditionRules(this, fixed_values);
		else
			fixed_where = null;
		return fixed_where;
	}
	/* solve the where clause by decision tree */
	public String solveDT(DatabaseState pre, DatabaseState next) throws Exception{
		// prepare input for Decision Tree solver
		// buid tree
		DecisionTreeHandler tree = new DecisionTreeHandler();
		
		// prepare class information
		String[] classinfo;
		
		// prepare feature information
		ArrayList<String[]> features = new ArrayList<String[]>();
		String[] feature_names = this.getFeature().split(",");
		
		// gather class information
		classinfo = pre.compare(next);
		
		// gather feature information
		for(String fname:feature_names){
			fname.trim();
			String[] value = pre.getFeature(fname);
			features.add(value);
		}
		
		//ResultSet features = database.queryExecution(featurequery);
		tree.prepareARFF(features, classinfo, this);
		
		// solve 
		String rulelist = tree.buildTree("./data/feature.arff");
		
		//convertIntoRules(rulelist);
		fixed_where = tree.toConditionRules(rulelist, this);
		
		//System.out.println(getFixedClause());
		return fixed_where;
	}
	
	/* get decision tree features: represented as arithmetic expressions, connected by "," */
	public String getFeature(){
		String feature = "";
		for(Condition subcond:where_conditions){
			feature = feature + subcond.getLeft()+",";
		}
		return feature;
	}
	
	/* return node type */
	public int getNodeType(String str){
		return 0;
	}
	/* get fixed where clause*/
	public String getFixedClause(){
		return fixed_where;
	}
	
	/* get list of feature - attributes mapping list*/
	public HashMap<String, Condition> getAttributeMap(){
		return this.attribute_condition_map;
	}
	
	/* get operator */
	public String getOperator(){
		return this.operator;
	}
	
	/* get condition sets*/
	public Condition[] getConditions(){
		return this.where_conditions;
	}

}
