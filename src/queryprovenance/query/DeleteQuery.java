package queryprovenance.query;

import queryprovenance.database.DatabaseState;

public class DeleteQuery extends Query{
	WhereClause where_clause;
	
	public DeleteQuery(String query_, String type_){
		super(query_,type_);
	}
	
	public void queryInitialize(){
		super.addPartition("(delete from) (.+) (where|;) (.+)", "[,]");
		super.addPartition("(where) (.+;)","(and|or)");
		super.construct();
		
		// prepare where clause
		where_clause = new WhereClause(groups, this.getTables());
	}
	
	/* solve insert query by previous correct db state and next correct db state, return fixed query or null if not solvable*/
	public String solve(DatabaseState pre, DatabaseState next, String[] options) throws Exception{
		// check whether this query should be deleted or not
		if(pre.size() == next.size())
			return "DELETE:"+super.query;
		else{
			String result = where_clause.solve(pre, next, options);
			String fixed_query = super.query;
			if(result!=null&&result.length()>0){
				fixed_query = fixed_query.replaceAll("(where.*;)", "where "+result+";");
				return fixed_query;
			}
			else
				return null;
		}
	}
}
