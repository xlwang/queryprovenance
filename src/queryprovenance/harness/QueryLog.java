package queryprovenance.harness;

import java.util.ArrayList;

import queryprovenance.database.DatabaseHandler;
import queryprovenance.database.DatabaseState;
import queryprovenance.database.DatabaseStates;
import queryprovenance.query.Query;
import queryprovenance.query.Table;

public class QueryLog extends ArrayList<Query>{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 5327786044304140040L;


	/*
	 * Run the queries in the query log on the database in sequence.
	 * For each query, create a unique table for the state
	 * 
	 * Assumptions: database state is a single table
	 */
	public DatabaseStates execute(DatabaseHandler handler) throws Exception {
		String baseTableName = this.get(0).getTable().getName();
		ArrayList<String> tablenames = new ArrayList<String>();
		String prevTable = baseTableName;
		String qstr = "";
		int i = 0;
		for (Query q : this) {
			String tmpName = baseTableName + "_" + i; 
			
			q = q.clone();
			q.setTable(new Table(prevTable, null, -1));
			qstr = q.toString();
			qstr = "CREATE TABLE " + tmpName + " AS ("+ qstr +")";
			try {
				handler.queryExecution("DROP TABLE " + tmpName);
			} catch (Exception e) {
				// meh
			}
			handler.queryExecution(qstr);
			
			prevTable = tmpName;
			tablenames.add(tmpName);
			i++;
		}
		
		// turn tablenames into a list of DatabaseStates
		DatabaseStates dss = new DatabaseStates();
		for (String tablename : tablenames) {
			DatabaseState ds = new DatabaseState(handler, tablename);
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

