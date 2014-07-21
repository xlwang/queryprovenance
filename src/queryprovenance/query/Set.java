package queryprovenance.query;

import queryprovenance.problemsolution.DatabaseState;

public class Set {
	private String set;
	private Condition[] _set_conditions; // a set of conditions
	
	/* construct the where clause given a query*/
	public Set(Query query){
		
	}
	
	/* solve the where clause given the previous/next db states */
	public String solve(DatabaseState pre, DatabaseState next) throws Exception{
		
	}
}
