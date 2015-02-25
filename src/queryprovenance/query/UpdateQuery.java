package queryprovenance.query;

import queryprovenance.database.DatabaseState;
import queryprovenance.database.Table;
import queryprovenance.problemsolution.Complaint;

public class UpdateQuery extends Query{
	//long[] timestamps = new long[4];
	
	public UpdateQuery(int id, SetClause set, Table table, WhereClause where){
		super(id, set, table, where, Query.Type.UPDATE);
	}
	

	
	/* solve insert query by previous correct db state and next correct db state, return fixed query or null if not solvable*/
	public Query solve(CplexHandler cplex, DatabaseState pre, DatabaseState next, DatabaseState bad, String[] options) throws Exception{
		
		// send to where clause. 
		WhereClause fixed_where = where.solve(cplex, pre, next, bad, options);
		Query q = clone();
		// update timestamps
		super.times = where.getTime();
		
		if(fixed_where!=null && fixed_where.getWhereExprs() != null) {
			q.where = fixed_where;			
			return q;
		}
		
		
		// send to set clause
		SetClause fixed_set = set.solve(pre, next, options);
		
		// update timestamps
		for(int i = 0; i < super.times.length; ++i) 
			super.times[i] = super.times[i] + set.getTime()[i];
		
		if(fixed_set !=null && fixed_set.getSetExprs() != null) {
			q.set = fixed_set;
			super.times = set.getTime();
		}
		return q;
	}
	
	public long[] getTime(){
		return times;
	}
	
	public Query solve(CplexHandler cplex, DatabaseState pre, DatabaseState bad, Complaint complaint, String[] options) throws Exception{
		WhereClause fixed_where = where.solve(cplex, pre, bad, complaint, options);
		Query q = clone();
		super.times = where.getTime();
		if(fixed_where!=null && fixed_where.getWhereExprs() != null) {
			q.where = fixed_where;			
			return q;
		}
		return null;
	}
}
