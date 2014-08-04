package queryprovenance.query;

import queryprovenance.database.DatabaseState;

public class DeleteQuery extends Query{
	WhereClause where_clause;
	
	public DeleteQuery(Table from, WhereClause where) {
		super(null, from, where, Query.Type.DELETE);
		where_clause = where;
	}
	
	
	/* solve insert query by previous correct db state and next correct db state, return fixed query or null if not solvable*/
	public Query solve(DatabaseState pre, DatabaseState next, String[] options) throws Exception{
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
