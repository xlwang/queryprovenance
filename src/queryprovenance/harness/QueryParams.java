package queryprovenance.harness;

import queryprovenance.query.Query;
import queryprovenance.query.Table;

/*
 * Parameters for generating a Query object
 */
public class QueryParams {
	private static QueryParams instance = new QueryParams();
	public Query.Type queryType = null;
	public Table from = null;
	public int nclauses = 1;
	
	
	public static QueryParams instance() {
		return instance;
	}
	
	
}
