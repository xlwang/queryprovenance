package queryprovenance.query;

import queryprovenance.database.DatabaseState;

public class DeleteQuery extends Query{
	WhereClause where_clause;
	//long[] timestamps = new long[4];
	
	public DeleteQuery(int id, Table from, WhereClause where) {
		super(id, null, from, where, Query.Type.DELETE);
		where_clause = where;
	}
	
	
	/* 
	 * solve insert query by previous correct db state and 
	 * next correct db state, return fixed query or null 
	 * if not solvable
	 * 
	 * Caller's responsibilty to set Query.id
	 * 
	 */
	public Query solve(CplexHandler cplex, DatabaseState pre, DatabaseState next, DatabaseState bad, String[] options) throws Exception{
		// check whether this query should be deleted or not
		// XXX: is this correct?  shouldn't it return this?
		if(pre.size() == next.size())
			return new Query(-1);
		else{
			Query q = clone();
			WhereClause fixed_where = where_clause.solve(cplex, pre, next, bad, options);
			if(fixed_where != null){
				q.where = fixed_where;
				timestamps = fixed_where.getTimeStamps();
				return q;
			}
			else
				return null;
		}
	}
	
	public long[] getTimeStamps(){
		return timestamps;
	}
}
