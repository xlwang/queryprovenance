package queryprovenance.query;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import queryprovenance.database.DatabaseState;
import queryprovenance.harness.QueryParams;


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
	
	
	public static Query generate(QueryParams params) {
		String s = null;
		String clause = null, set = null;
		switch(params.queryType) {
		case "insert":
			// generate values
			s = String.format("INSERT INTO %1 VALUES(%2)", null, Util.join(null, ", "));
		case "update":
			clause = Where.generate(params).toString();
			set = SetExpr.generate(params).toString();
			s = String.format("UPDATE %1 SET %2 WHERE %3", null, set, clause);
		case "delete":
			clause = Where.generate(params).toString();
			set = SetExpr.generate(params).toString();
			s = String.format("DELETE %1 SET %2 WHERE %3", null, set, clause);
		}
		if (s != null)
			return new Query(s, params.queryType);
		return null;
	}
	}

class SetExpr extends ArrayList<SClause> {
	public static SetExpr generate(QueryParams params) {
		return null;
	}
	
	public String toString() {
		return Util.join(this, ", ");
	}
}

class SClause {
	public String toString() {
		return "";
	}
}
	
class Where extends ArrayList<Object>{
	public static Where generate(QueryParams params) {
		Where ret = new Where();
		for (int i = 0; i < params.nclauses; i++) {
			if (true) {
				ret.add(new WClause(null, false, new float[]{1}));
			} else {
				
			}			
		}
		return ret;
	}
	
	public String toString() {
		return Util.join(this, " and ");
	}
}
	
class WClause {
	public String attr;
	public boolean is_continuous;
	public float[] values;
	public WClause(String attr, boolean is_continuous, float[] values) {
		this.attr = attr;
		this.is_continuous = is_continuous;
		this.values = values;
	}
	
	public String toString() {
		List<String> arr = new ArrayList<String>();
		if (this.is_continuous) {
			if (this.values[0] != Float.MIN_VALUE)
				arr.add(String.format("%1 >= %2", this.attr, this.values[0]));
			if (this.values[1] != Float.MAX_VALUE)
				arr.add(String.format("%1 < %2", this.attr, this.values[1]));
			return Util.join(arr, " and ");
		} else {
			return Util.join(Arrays.asList(values), ", ");
		}
	}
}

class Util {
	static String join(List<? extends Object> l, String sep) {
		String s = "";
		for (int i = 0; i < l.size(); i++) {
			s += l.get(i).toString();
			if (i < l.size() - 1) {
				s += sep;
			}		
		}
		return s;

	}
}
