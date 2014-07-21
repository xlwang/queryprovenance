package queryprovenance.problemsolution;

import java.util.*;

import queryprovenance.query.Query;

public class SolveAll {
	private DatabaseState[] _db_org; // D, a sequence of db states given a seq of queries. 
	private DatabaseState[] _db_fix; // D*, a sequence of correct db states
	
	private Query[] _query_seq; // a seq of queries includes errors. 
	private Query[] _query_seq_fix; // a seq of queries with no error, ground truth, (optional)
	
	
	public SolveAll(){

	}
	
	/* initialize problem given a sequence of wrong queries, and a sequence of corresponding true queries*/
	public void prepareProbOnQ(Query[] _wrong_query, Query[] _true_query) throws Exception {
		
	}
	
	/* solve the problem by returning Q_seq*, a seq of query that produce the correct db state*/
	public Query[] solve() throws Exception{
		
	}
}
