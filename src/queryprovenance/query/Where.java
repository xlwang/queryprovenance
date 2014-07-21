package queryprovenance.query;

import queryprovenance.problemsolution.DatabaseState;

public class Where {
	private String where;
	private Condition[] _where_conditions; // a set of conditions
	private String operator; // disjunction/conjunction
	
	/* construct the where clause given a query*/
	public Where(Query query){
		
	}
	
	/* solve the where clause given the previous/next db states */
	public String solve(DatabaseState pre, DatabaseState next) throws Exception{
		
	}
}
