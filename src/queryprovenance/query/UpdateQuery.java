package queryprovenance.query;

import queryprovenance.database.DatabaseState;

public class UpdateQuery extends Query{
	
	public UpdateQuery(SetClause set, Table table, WhereClause where){
		super(set, table, where, Query.Type.UPDATE);
	}
	

	
	/* solve insert query by previous correct db state and next correct db state, return fixed query or null if not solvable*/
	public Query solve(DatabaseState pre, DatabaseState next, DatabaseState bad, String[] options) throws Exception{
		
		String result = "";
		
		// send to where clause. 
		WhereClause fixed_where = where.solve(pre, next, bad, options);
		Query q = clone();
		if(fixed_where!=null && fixed_where.getWhereExprs() != null) {
			q.where = fixed_where;
			return q;
		}
		
		// send to set clause
		SetClause fixed_set = set.solve(pre, next, options);
		if(fixed_set !=null && fixed_set.getSetExprs() != null) {
			q.set = fixed_set;
		}
		return q;
	}
}
