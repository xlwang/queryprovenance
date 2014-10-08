package queryprovenance.query;

import queryprovenance.database.DatabaseState;

public class UpdateQuery extends Query{
	//long[] timestamps = new long[4];
	
	public UpdateQuery(int id, SetClause set, Table table, WhereClause where){
		super(id, set, table, where, Query.Type.UPDATE);
	}
	

	
	/* solve insert query by previous correct db state and next correct db state, return fixed query or null if not solvable*/
	public Query solve(CplexHandler cplex, DatabaseState pre, DatabaseState next, DatabaseState bad, String[] options) throws Exception{
		
		String result = "";
		// send to where clause. 
		WhereClause fixed_where = where.solve(cplex, pre, next, bad, options);
		Query q = clone();
		super.timestamps = where.getTimeStamps();
		if(fixed_where!=null && fixed_where.getWhereExprs() != null) {
			q.where = fixed_where;			
			return q;
		}
		
		
		// send to set clause
		SetClause fixed_set = set.solve(pre, next, options);
		super.timestamps[0] = super.timestamps[0] + set.getTimeStamps()[0];
		super.timestamps[1] = super.timestamps[1] + set.getTimeStamps()[1];
		super.timestamps[2] = super.timestamps[2] + set.getTimeStamps()[2];
		super.timestamps[3] = super.timestamps[3] + set.getTimeStamps()[3];
		if(fixed_set !=null && fixed_set.getSetExprs() != null) {
			q.set = fixed_set;
			super.timestamps = set.getTimeStamps();
		}
		return q;
	}
	
	public long[] getTimeStamps(){
		return timestamps;
	}
}
