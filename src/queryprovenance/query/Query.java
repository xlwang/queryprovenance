package queryprovenance.query;

import java.sql.*;
import java.util.ArrayList;

import queryprovenance.problemsolution.DatabaseHandler;
import queryprovenance.problemsolution.DatabaseState;


public class Query {
	protected String query; // query content
	protected String type; // query type: Insert, Delete, Update, Select
	protected ArrayList<Partition> groups;
	public Query(){
		
	}
	/* initialize query*/
	public Query(String query_, String type_){
		// preprocess the query
		query = query_;
		query = query.trim().toLowerCase();
		type = type_;
		groups = new ArrayList<Partition>();
	}
	public void construct(){
		String subquery = query;
		for(Partition part:groups){
			if(subquery.length()>0)
				subquery = part.getContentSplit(subquery);
			else
				break;
		}
	}
	public void queryInitialize(){
		System.out.println("type not supported");
	}
	public void addPartition(String contentSplitPattern_, String bodySplitPattern_){
		groups.add(new Partition(contentSplitPattern_, bodySplitPattern_));
	}
	public ArrayList<Partition> getGroups(){
		return groups;
	}
	public String getType(){
		return type;
	}
	public String getQuery(){
		return query;
	}
	public String solve(DatabaseHandler database, DatabaseState pre) throws Exception{
		return null;
	}
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
