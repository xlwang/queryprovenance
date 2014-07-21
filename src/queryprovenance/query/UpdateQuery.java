package queryprovenance.query;

import queryprovenance.problemsolution.DatabaseState;

public class UpdateQuery {
	Where _where_clause;
	Set _set_clause;
	/* solve insert query by previous correct db state and next correct db state, return fixed query or null if not solvable*/
	public Query solve(DatabaseState pre, DatabaseState next) throws Exception{
		
	}
}
