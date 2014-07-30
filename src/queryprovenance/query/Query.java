package queryprovenance.query;

import java.sql.*;
import java.util.ArrayList;

import queryprovenance.problemsolution.DatabaseHandler;
import queryprovenance.problemsolution.DatabaseState;


public class Query {
	protected String query; // query content
	protected String type; // query type: Insert, Delete, Update, Select
	protected ArrayList<Partition> groups; // a set of groups, select from, set, where, insert into,etc.
	
	public Query(){
	}
	/* initialize query with query string and query type*/
	public Query(String query_, String type_){
		// preprocess the query
		query = query_;
		query = query.trim().toLowerCase();
		type = type_;
		groups = new ArrayList<Partition>();
	}
	
	/* construct query groups*/
	public void construct(){
		String subquery = query; // current subquery
		for(Partition part:groups){
			if(subquery!=null&&subquery.length()>0)
				subquery = part.getContentSplit(subquery); // process partition into partition name and content sets
			else
				break;
		}
	}
	/* get query initialized */
	public void queryInitialize(){
		System.out.println("type not supported");
	}
	/* add partition regular expressions, and content split regular expression */
	public void addPartition(String contentSplitPattern_, String bodySplitPattern_){
		groups.add(new Partition(contentSplitPattern_, bodySplitPattern_));
	}
	/* return groups */
	public ArrayList<Partition> getGroups(){
		return groups;
	}
	/* reture query type */
	public String getType(){
		return type;
	}
	/* return original query */
	public String getQuery(){
		return query;
	}
	/* solve query by previous database state and next database state*/
	public String solve(DatabaseState pre, DatabaseState next, String[] options) throws Exception{
		return null;
	}
	/* return table names involved in this query*/
	public ArrayList<String> getTables(){
		if(type.equals("insert"))
			for(Partition part:groups)
				if(part.getPartitionName().equals("insert into"))
					return part.getSplitedContent();
		if(type.equals("update"))
			for(Partition part:groups)
				if(part.getPartitionName().equals("update"))
					return part.getSplitedContent();
		if(type.equals("delete"))
			for(Partition part:groups)
				if(part.getPartitionName().equals("delete from"))
					return part.getSplitedContent();
		return null;
	}
	
}
