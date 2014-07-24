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
					result = solveMILP(pre,next);
				else
					result = null;
				break;
			}
		}
		
		// return results as a revised query
		return result;
	}
	
	/* solve the where clause by MILP cplex*/
	public String solveMILP(DatabaseState pre, DatabaseState next) throws Exception{
		return "Function not implemented";
	}
	/* solve the where clause by decision tree */
	public String solveDT(DatabaseState pre, DatabaseState next) throws Exception{
		// prepare input for Decision Tree solver
		
		// prepare class information
		String[] classinfo;
		
		// prepare feature information
		ArrayList<String[]> features = new ArrayList<String[]>();
		String[] feature_names = getDTFeature().split(",");
		
		// if size of previous state and next state is different, this query cannot be solved by revise where clause
		if(pre.size()!=next.size())
			return null;
		
		// gather class information
		classinfo = pre.compare(next);
		
		// gather feature information
		for(String fname:feature_names){
			fname.trim();
			String[] value = pre.getFeature(fname);
			features.add(value);
		}
		
		//ResultSet features = database.queryExecution(featurequery);
		prepareARFF(features, classinfo);
		
		// buid tree
		DecisionTreeHandler tree = new DecisionTreeHandler();
		String rulelist = tree.buildTree("./data/feature.arff");

		convertIntoRules(rulelist);
		//System.out.println(getFixedClause());
		return getFixedClause();
	}
	
	/* convert rule string into condition rules*/
	public void convertIntoRules(String rulelist){
		fixed_where = null;
		// process generated rules
		String[] lines = rulelist.split(System.getProperty("line.separator"));
		Pattern pattern = Pattern.compile("(.+)(=> class=b)");
		for(String line:lines){
			Matcher matcher = pattern.matcher(line);
			if(matcher.find())
				fixed_where = matcher.group(1);
		}

		for(String feature: attribute_condition_map.keySet()){
			Pattern pattern3 = Pattern.compile(feature);
			Matcher matcher = pattern3.matcher(fixed_where);
			if(matcher.find())
				fixed_where = fixed_where.replaceAll(feature, attribute_condition_map.get(feature).getLeft());
			else{
				fixed_where = null;
				return;
			}
		}
		
		fixed_where = fixed_where.replaceAll("[\\(\\)]", "");
		fixed_where.trim();
		// check structure
		// decompose fixed_where clause
		Pattern pattern2 = Pattern.compile("(and|or)");
		Matcher matcher = pattern2.matcher(fixed_where);
		String fixed_operator=null;
		if(matcher.find())
			fixed_operator = matcher.group();
		else
			fixed_operator = "";
		
		// condition rules connection must be the same
		if(!fixed_operator.equals(operator)){
			fixed_where = null;
			return;
		}
		
		// cardinality must be the same
		Partition fixed_where_part = new Partition("(where) (.+)","(and|or)");
		fixed_where_part.getContentSplit("where "+fixed_where);
		
		// get a list of condition rules;
		ArrayList<String> fixed_contents = fixed_where_part.getSplitedContent();
		//System.out.println(String.valueOf(fixed_contents.size()));
		//System.out.println(String.valueOf(where_conditions.length));
		if(!(fixed_contents.size()==where_conditions.length)){
			fixed_where = null;
			return;
		}	
	}
	
	/* get fixed where clause*/
	public String getFixedClause(){
		return fixed_where;
	}
	/* prepare input file for Decision tree solver */
	public void prepareARFF(ArrayList<String[]> features, String[] classinfo) throws Exception {
		
		// prepare map between featureID and original condition
		attribute_condition_map = new HashMap<String, Condition>();
		
		// prepare file for Decision tree solver
		File filename = new File("./data/feature.arff");
		if(!filename.exists())
			filename.createNewFile();
		FileWriter filewriter = new FileWriter(filename);
		BufferedWriter writer = new BufferedWriter(filewriter); 
		
		// write data name
		writer.write("@RELATION test"); writer.newLine();
		
		// write feature/attributes names
		for(int i=0; i<where_conditions.length; ++i){
			writer.write("@ATTRIBUTE" + " col"+String.valueOf(i) + " NUMERIC"); writer.newLine();
			attribute_condition_map.put("col"+String.valueOf(i) , where_conditions[i]);
		}
		
		// write class information
		writer.write("@ATTRIBUTE class {g,b}"); writer.newLine();
		
		// write data
		writer.write("@DATA"); writer.newLine();
		for(int i=0; i<classinfo.length; ++i){
			for(int j=0; j<features.size(); ++j)
				writer.write(features.get(j)[i]+",");
			writer.write(classinfo[i]); writer.newLine();
		}
		// finish prepare file for DT solver
		writer.close();		
	}
	
	/* get decision tree features: represented as arithmetic expressions, connected by "," */
	public String getDTFeature(){
		String featureDT = "";
		for(Condition subcond:where_conditions){
			featureDT = featureDT + subcond.getLeft()+",";
		}
		return featureDT;
	}

}
