package queryprovenance.query;

import queryprovenance.problemsolution.*;

public class UpdateQuery extends Query{
	WhereClause where_clause;
	SetClause set_clause;
	
	public UpdateQuery(String query_, String type_){
		super(query_,type_);
	}
	
	/* initialize update query by a set of regular expressions*/
	public void queryInitialize(){
		
		super.addPartition("(update) (.+) (set) (.+)", "[,]");
		super.addPartition("(set) (.+) (where|;) (.+)","[,]");
		super.addPartition("(where) (.+;)","(and|or)");
		
		// construct query
		super.construct();
		
		// prepare where clause and set clause
		where_clause = new WhereClause(groups, this.getTables());
		set_clause = new SetClause(groups);
	}
	
	/* solve insert query by previous correct db state and next correct db state, return fixed query or null if not solvable*/
	public String solve(DatabaseState pre, DatabaseState next, String[] options) throws Exception{
		
		String result = "";
		
		// send to where clause. 
		result = where_clause.solve(pre, next, options);
		String fixed_query = super.query;
		if(result!=null&&result.length()>0){
			fixed_query = fixed_query.replaceAll("(where.*;)", "where "+result+";");
		}
		
		// send to set clause
		result = set_clause.solve(pre, next);
		if(result!=null && result.length()>0){
			String temp = fixed_query.replaceAll("set.*where", "set "+result+" where");
			if(!temp.equals(fixed_query))
				fixed_query = temp;
			else
				fixed_query = fixed_query.replaceAll("set.*;", "set "+result+";");
		}
		//System.out.println(result);
		return fixed_query;
	}
}
