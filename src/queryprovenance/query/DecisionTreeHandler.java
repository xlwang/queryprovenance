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
import java.util.List;
import java.util.regex.Pattern;
import java.util.regex.Matcher;

public class DecisionTreeHandler {

	private JRip rule; // J48 tree classification type
	HashMap<String, WhereExpr> attribute_condition_map;
	
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
	public List<WhereExpr> toConditionRules(String rulelist, WhereClause where){
		String fixed_rule = "";
		// process generated rules
		String[] lines = rulelist.split(System.getProperty("line.separator"));
		Pattern pattern = Pattern.compile("(.+)(=> class=b)");
		for(String line:lines){
			Matcher matcher = pattern.matcher(line);
			if(matcher.find())
				fixed_rule = matcher.group(1).trim();
		}
		if(fixed_rule == null||fixed_rule.length()<1){
			pattern = Pattern.compile("(.+)(=> class=g)");
			for(String line:lines){
				Matcher matcher = pattern.matcher(line);
				if(matcher.find())
					fixed_rule = matcher.group(1);
			}
			fixed_rule = fixed_rule.replace(">=", "<=");
			fixed_rule = fixed_rule.replace("<=", ">=");
			fixed_rule = fixed_rule.replace("and", "or");
			fixed_rule = fixed_rule.replace("or", "and");
		}
		// replace feature by attributes
		for(String feature: attribute_condition_map.keySet()){
			Pattern pattern3 = Pattern.compile(feature);
			Matcher matcher = pattern3.matcher(fixed_rule);
			if(matcher.find())
				fixed_rule = fixed_rule.replaceAll(feature, attribute_condition_map.get(feature).getAttrExpr());
			else{
				return null;
			}
		}
		// processing fixed_where 
		fixed_rule = fixed_rule.replaceAll("[\\(\\)]", "");
		fixed_rule.trim();
		
		// check structure: operator must be the same with given query
		// decompose fixed_rule clause
		Pattern pattern2 = Pattern.compile("(and|or)");
		Matcher matcher = pattern2.matcher(fixed_rule);
		WhereClause.Op fixed_operator=null;
		if(matcher.find())
			fixed_operator = matcher.group().trim().equals("and")?WhereClause.Op.CONJ:WhereClause.Op.DISJ;
		else
			fixed_operator = null;
		
		// condition rules connection must be the same
		if(!(fixed_operator == null && where.getOperator() == null) || fixed_operator != where.getOperator()){
			return null;
		}
		
		// cardinality must be the same
		String[] conditionrules = fixed_rule.split("(and|or");
		//System.out.println(String.valueOf(fixed_contents.size()));
		//System.out.println(String.valueOf(where_conditions.length));
		if(!(conditionrules.length == where.getWhereExprs().size())){
			return null;
		}
		
		List<WhereExpr> fixed_where_rules = new ArrayList<WhereExpr>();
		for(int i = 0; i < conditionrules.length; ++i){
			Pattern pattern3 = Pattern.compile("(>=|<=)");
			Matcher matcher3 = pattern3.matcher(fixed_rule);
			if(matcher3.find()){
				String[] attr_var = conditionrules[i].split("(>=|<=)");
				fixed_where_rules.add(new WhereExpr(attr_var[0], matcher3.group(), attr_var[1]));
			}
		}
		return fixed_where_rules;
	}
	
	/* prepare input file for Decision tree solver */
	public void prepareARFF(ArrayList<String[]> features, String[] classinfo, WhereClause where) throws Exception {
		
		// prepare map between featureID and original condition
		attribute_condition_map = new HashMap<String, WhereExpr>();
		
		// prepare file for Decision tree solver
		File filename = new File("./data/feature.arff");
		if(!filename.exists())
			filename.createNewFile();
		FileWriter filewriter = new FileWriter(filename);
		BufferedWriter writer = new BufferedWriter(filewriter); 
		
		// write data name
		writer.write("@RELATION test"); writer.newLine();
		
		// write feature/attributes names
		for(int i = 0; i < where.getWhereExprs().size(); ++i){
			writer.write("@ATTRIBUTE" + " col"+String.valueOf(i) + " NUMERIC"); writer.newLine();
			attribute_condition_map.put("col"+String.valueOf(i) , where.getWhereExprs().get(i));
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
