package queryprovenance.harness;

import queryprovenance.database.Table;
import queryprovenance.query.Query;

/*
 * Parameters for generating a Query object
 */
public class QueryParams {
	private static QueryParams instance = new QueryParams();
	public Query.Type queryType = null;
	public Table from = null;
	public int nclauses = 2;
	
	
	public static QueryParams instance() {
		return instance;
	}
	
	
}
