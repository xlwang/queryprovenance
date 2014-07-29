package queryprovenance.query;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;

import weka.classifiers.rules.JRip;
import weka.classifiers.trees.J48;
import weka.classifiers.trees.j48.ClassifierTree;
import weka.core.Instances;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.regex.Pattern;
import java.util.regex.Matcher;

public class DecisionTreeHandler {

	private JRip rule; // J48 tree classification type
	HashMap<String, Condition> attribute_condition_map;
	
	public DecisionTreeHandler(){
		rule = new JRip();
	}
	
	/* build decision tree given fileanme and parameters */
	public String buildTree(String filename) throws Exception{
		// read file 
		BufferedReader reader = new BufferedReader( 
				 new FileReader(filename));
		Instances data = new Instances(reader); 
		reader.close(); 
		
		// Prepare parameters
		data.setClassIndex(data.numAttributes() - 1); 
			
		//ClassifierTree 
		rule.buildClassifier(data);
		
		// print tree
		return rule.toString();
	}
	
	/* convert tree into a set of condition rules*/
	public String toConditionRules(String rulelist, WhereClause where){
		String fixed_where = null;
		// process generated rules
		String[] lines = rulelist.split(System.getProperty("line.separator"));
		Pattern pattern = Pattern.compile("(.+)(=> class=b)");
		for(String line:lines){
			Matcher matcher = pattern.matcher(line);
			if(matcher.find())
				fixed_where = matcher.group(1);
		}
		// replace feature by attributes
		for(String feature: attribute_condition_map.keySet()){
			Pattern pattern3 = Pattern.compile(feature);
			Matcher matcher = pattern3.matcher(fixed_where);
			if(matcher.find())
				fixed_where = fixed_where.replaceAll(feature, attribute_condition_map.get(feature).getLeft());
			else{
				return null;
			}
		}
		// processing fixed_where 
		fixed_where = fixed_where.replaceAll("[\\(\\)]", "");
		fixed_where.trim();
		
		// check structure: operator must be the same with given query
		// decompose fixed_where clause
		Pattern pattern2 = Pattern.compile("(and|or)");
		Matcher matcher = pattern2.matcher(fixed_where);
		String fixed_operator=null;
		if(matcher.find())
			fixed_operator = matcher.group();
		else
			fixed_operator = "";
		
		// condition rules connection must be the same
		if(!fixed_operator.equals(where.getOperator())){
			return null;
		}
		
		// cardinality must be the same
		Partition fixed_where_part = new Partition("(where) (.+)","(and|or)");
		fixed_where_part.getContentSplit("where "+fixed_where);
		
		// get a list of condition rules;
		ArrayList<String> fixed_contents = fixed_where_part.getSplitedContent();
		//System.out.println(String.valueOf(fixed_contents.size()));
		//System.out.println(String.valueOf(where_conditions.length));
		if(!(fixed_contents.size() == where.getConditions().length)){
			return null;
		}
		return fixed_where;
	}
	
	/* prepare input file for Decision tree solver */
	public void prepareARFF(ArrayList<String[]> features, String[] classinfo, WhereClause where) throws Exception {
		
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
		for(int i = 0; i < where.getConditions().length; ++i){
			writer.write("@ATTRIBUTE" + " col"+String.valueOf(i) + " NUMERIC"); writer.newLine();
			attribute_condition_map.put("col"+String.valueOf(i) , where.getConditions()[i]);
		}
		
		// write class information
		writer.write("@ATTRIBUTE class {g,b}"); writer.newLine();
		
		// write data
		writer.write("@DATA"); writer.newLine();
		for(int i = 0; i < classinfo.length; ++i){
			for(int j = 0; j < features.size(); ++j)
				writer.write(features.get(j)[i]+",");
			writer.write(classinfo[i]); writer.newLine();
		}
		// finish prepare file for DT solver
		writer.close();	
	}
	
}
