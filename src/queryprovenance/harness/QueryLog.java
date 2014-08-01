package queryprovenance.harness;

import java.util.ArrayList;

import queryprovenance.database.DatabaseHandler;
import queryprovenance.database.DatabaseState;
import queryprovenance.database.DatabaseStates;
import queryprovenance.query.Query;

public class QueryLog extends ArrayList<Query>{
	
	/*
	 * Run the queries in the query log on the database in sequence.
	 * For each query, create a unique table for the state
	 * 
	 * Assumptions: database state is a single table
	 */
	public DatabaseStates execute(DatabaseHandler handler) throws Exception {
		String base_table_name = "";  // table that queries reference
		ArrayList<String> tablenames = new ArrayList<String>();
		for (Query q : this) {
			// execute q using handler
			tablenames.add("");
		}
		
		// turn tablenames into a list of DatabaseStates
		DatabaseStates dss = new DatabaseStates();
		for (String tablename : tablenames) {
			String s = "SELECT * FROM " + tablename;
			DatabaseState ds = new DatabaseState(handler, new Query(s, "select"));
			dss.add(ds);
		}
		return dss;
	}
	
	
	/*
	 * Generates a sequence of queries based on distribution information in the 
	 * params passed in
	 * @param params 
	 */
	public static QueryLog generate(ExpParams params) {
		QueryLog ql = new QueryLog();
		for (int i = 0; i < params.ql_nqueries; i++) {
		}
		int nqueries;
		float[] percs;  // probabilities for each query type
		//query type mixture
		//number of tuples
		//number of similar queries with similar structure
		//query log length
		return null;
	}
	
	
}

