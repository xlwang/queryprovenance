package queryprovenance.problemsolution;

import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;

import queryprovenance.database.DatabaseHandler;
import queryprovenance.database.DatabaseState;
import queryprovenance.database.DatabaseStates;
import queryprovenance.database.Table;
import queryprovenance.harness.ExpParams;
import queryprovenance.harness.QueryParams;
import queryprovenance.query.Query;

public class QueryLog extends ArrayList<Query>{
	
	public QueryLog() {
		super();
	} 
	/**
	 * 
	 */
	private final long serialVersionUID = 5327786044304140040L;

	
	/*
	 * Run the queries in the query log on the database in sequence.
	 * For each query, create a unique table for the state
	 * 
	 * Assumptions: database state is a single table
	 */
	public DatabaseStates execute(String baseTableName, DatabaseHandler handler) throws Exception {
		//String baseTableName = this.get(0).getTable().getName();
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

	public List<String> difference(QueryLog o) {
		Hashtable<Integer, Query> ht = new Hashtable<Integer, Query>();
		List<String> diffs = new ArrayList<String>();
		for (Query q : o) {
			ht.put(q.getId(), q);
		}
		for (Query q : this) {
			if (ht.contains(q.getId())) {
				Query q2 = ht.get(q.getId());
				if (!q.equals(q2)) {
					diffs.add(q.toString());
				}
			} else {
				// query should exist but doesn't
				diffs.add("deleted: " + this.toString());
			}
		}
		return diffs;
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
			qparams.nclauses = params.ql_nclauses;
			qparams.queryType = Query.Type.UPDATE;
			Query q = Query.generate(qparams);
			ql.add(q);
			
		}
		return ql;
	}
	
	public QueryLog clone() {
		QueryLog cloned = new QueryLog();
		for(Query query : this) {
			cloned.add(query.clone());
		}
		return cloned;
	}
	
	public QueryLog subList(int start, int end) {
		QueryLog copy = new QueryLog();
		for(int i = start; i < end; ++i)
			copy.add(this.get(i));
		return copy;
	}
	
}