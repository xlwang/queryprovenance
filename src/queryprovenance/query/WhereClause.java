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
	private String where;
	private Condition[] where_conditions; // a set of conditions
	private String operator; // disjunction/conjunction
	private ArrayList<String> table_names;
	private HashMap<String, Condition> attribute_condition_map;
	/* construct the where clause given a query*/
	public WhereClause(ArrayList<Partition> groups_, ArrayList<String> querytables){
		for(Partition part: groups_){
			if(part.getPartitionName().equals("where")){
				where = part.getContent();
				Pattern pattern = Pattern.compile("(and|or)");
				Matcher matcher = pattern.matcher(where);
				if(matcher.find())
					operator = matcher.group();
				else
					operator = "";
				ArrayList<String> contents = part.getSplitedContent();
				where_conditions = new Condition[contents.size()];
				for(int i=0; i<contents.size(); ++i){
					where_conditions[i] = new Condition(contents.get(i));
				}
				table_names = querytables;
				break;
			}
		}
	}
	
	/* solve the where clause given the previous/next db states */
	public String solve(DatabaseHandler database, DatabaseState pre, int option) throws Exception{
		String result = "";
		switch(option){
		case 0: result = solveDT(database, pre); break;
		case 1: break;
		default: break;
		}
		return result;
	}
	public String solveDT(DatabaseHandler database, DatabaseState pre) throws Exception{
		// prepare input for Decision Tree solver
		
		// prepare class infomation
		ArrayList<String> classinfo = new ArrayList<String>();
		String featurequery = getDTQuery();
		ArrayList<String> features = new ArrayList<String>();
		while(pre.next()){
			String[] predata = pre.getColumns();
			String checkquery = pre.getCheckQuery(predata);
			ResultSet rowexists = database.queryExecution(checkquery);
			String temp_class = "g";
			if(rowexists.next()){
				// this records exists, check whether every element is the same
				for(int i=1; i<=predata.length; ++i){
					if(!predata[i-1].equals(rowexists.getString(i))){
						temp_class = "b";
						break;
					}
				}
				
			}
			else
				return null;
			String featurequerycurrent = featurequery+pre.getCheckCondition(predata);
			ResultSet featurevalues = database.queryExecution(featurequerycurrent);
			String featuretemp = "";
			if(featurevalues.next())
			for(int i=1; i<= where_conditions.length;++i)
				featuretemp = featuretemp+featurevalues.getString(i)+",";
			features.add(featuretemp);
			classinfo.add(temp_class);
		}
		
		//ResultSet features = database.queryExecution(featurequery);
		prepareARFF(features, classinfo);
		// buid tree
		DecisionTreeHandler tree = new DecisionTreeHandler();
		tree.buildTree("./data/feature.arff");
		
		return null;
	}
	public void prepareARFF(ArrayList<String> features, ArrayList<String> classinfo) throws Exception {
		attribute_condition_map = new HashMap<String, Condition>();
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
		// write classinformation
		writer.write("@ATTRIBUTE class {g,b}"); writer.newLine();
		// write data
		writer.write("@DATA"); writer.newLine();
		for(int i=0; i<features.size(); ++i){
			writer.write(features.get(i));
			writer.write(classinfo.get(i)); writer.newLine();
		}
		writer.close();		
	}
	public String getDTQuery(){
		String queryDT = "select ";
		for(Condition subcond:where_conditions){
			queryDT = queryDT + subcond.getLeft()+",";
		}
		queryDT = queryDT.substring(0, queryDT.length()-1) + " from ";
		for(String tabname: table_names)
			queryDT = queryDT + tabname+",";
		queryDT = queryDT.substring(0, queryDT.length()-1) ;
		return queryDT;
	}

}
