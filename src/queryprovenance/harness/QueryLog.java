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
		DatabaseStates dss = new DatabaseStates();
		DatabaseState ds = new DatabaseState(handler, baseTableName);
		dss.add(ds);
		String primarykey = ds.getPrimaryKey();
		//this.add(0, null);
		for (int i = 0; i < this.size(); ++i) {
			
			// create a copy of the previous table so we can run update query
			// on it
			String curTable = baseTableName + "_" + i;
			qstr = "SELECT * from " + prevTable;
			try {
				handler.queryExecution("DROP TABLE " + curTable);
			} catch(Exception e) {
				// XXX: should do something with this?
			}
			handler.queryExecution("CREATE TABLE " + curTable + " AS (" + qstr + ");");
			handler.queryExecution("ALTER TABLE " +  curTable + " ADD PRIMARY KEY (" + primarykey +");");
			
			// execute
			Query q = this.get(i);
			q = q.clone();
			q.setTable(new Table(curTable, null, null, null, -1));
			qstr = q.toString();
			handler.queryExecution(qstr);
			prevTable = curTable;
			tablenames.add(curTable);
		}
		
		// turn tablenames into a list of DatabaseStates
		
		for (String tablename : tablenames) {
			ds = new DatabaseState(handler, tablename);
			//System.out.println(ds.size());
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
			// generate a QueryParam
			QueryParams qparams = new QueryParams();
			qparams.from = params.table;
			qparams.nclauses = 1;
			qparams.queryType = Query.Type.UPDATE;
			Query q = Query.generate(qparams);
			ql.add(q);
			
		}
		return ql;
	}
	
	
}

