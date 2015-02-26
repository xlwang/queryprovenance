package queryprovenance.harness;

import java.io.BufferedReader;
import java.io.FileReader;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;

import queryprovenance.database.DatabaseHandler;
import queryprovenance.database.DatabaseState;
import queryprovenance.database.DatabaseStates;
import queryprovenance.database.Table;
import queryprovenance.expression.AdditionExpression;
import queryprovenance.expression.Expression;
import queryprovenance.expression.VariableExpression;
import queryprovenance.query.InsertQuery;
import queryprovenance.query.Query;
import queryprovenance.query.SetClause;
import queryprovenance.query.SetExpr;
import queryprovenance.query.UpdateQuery;
import queryprovenance.query.WhereClause;
import queryprovenance.query.WhereExpr;

public class SyntheticHarness {
	
	DatabaseHandler handler = null;
	int cid = -1;
	String tableBase = null;
	QueryLog cleanQueries = null;
	QueryLog dirtyQueries = null;
	DatabaseStates cleanDss = null;
	DatabaseStates dirtyDss = null;
	
	int passtype, optchoice, qfixtype;
	int rollbackbatch;
	float epsilon, M; 
	boolean approx, prune;
	
	public SyntheticHarness(DatabaseHandler handler, int cid, QueryLog cleanQs, QueryLog dirtyQs) throws Exception {
		this.handler = handler;
		this.cid = cid;
		this.tableBase = "synth_" + cid;		
		this.cleanQueries = cleanQs;
		this.dirtyQueries = dirtyQs;
		this.cleanDss = loadDatabaseStates(handler, cleanQueries);
		this.dirtyDss = loadDatabaseStates(handler, dirtyQueries);
	}
	
	public void loadConfigParams() throws Exception {
		String q = "SELECT passtype, optchoice, qfixtype, epsilon, M, approx, prune, rollbackbatch FROM configs WHERE cid = " + cid;
		ResultSet rset = handler.queryExecution(q);
		passtype = rset.getInt(0);
		optchoice = rset.getInt(1);
		qfixtype = rset.getInt(2);
		epsilon = rset.getFloat(3);
		M = rset.getFloat(4);
		approx = rset.getBoolean(5);
		prune = rset.getBoolean(6);
		rollbackbatch = rset.getInt(7);
	}
	
	
	/*
	 * XXX: xiaolan: fill in with execution and metrics code
	 */
	public void run() throws Exception {
		QueryLog fixedQueries = new QueryLog();
		
		// single pass alg
		if (passtype == 1) {
			// no preprocessing
			if (optchoice == 1) {
				
			} 
			// pre processing
			else {

			}
		}
		// rollback only experiment
		else if (passtype == 2) {
			
		}
		// query fix only, no rollback (single query in the log)
		else if (passtype == 3) {
			
		}
		// two pass alg
		else {
			// no preprocessing
			if (optchoice == 1) {
				// qfixtype = 1 if CPLEX
				// qfixtype = 2 if decision tree
			} 
			// preprocessing
			else {

			}
			
		}
		if (true) return;
		
		//
		// Metrics
		//
		long totalTime = 0;
		long rollbackTime = 0;
		long cplexEncodingTime = 0;
		long solverTime = 0;

		DatabaseStates fixedDss = fixedQueries.execute(tableBase, handler);
		HashMap<Metrics.Type, Double> metrics = Metrics.evaluateAll2(cleanQueries, cleanDss, dirtyQueries, dirtyDss, fixedQueries, fixedDss);
		String metric_value = Metrics.toString(metrics);
		Metrics.Index diff = Metrics.compare(dirtyQueries, fixedQueries, 0.1);
		
		
		// Store run results in database
		Object[] results = new Object[]{
				cid,
				/*percentage,
				solver,
				clause_count,
				qlog_count,
				tuple_count,
				preprocess,
				metric_value,
				qidx,
				diff,*/
				totalTime,
				rollbackTime,
				cplexEncodingTime,
				solverTime
		};
		String sql = String.format("INSERT INTO exps VALUES (default, %s)", Util.join(results, ","));
		handler.queryExecution(sql);
		
	}


	
	static SyntheticHarness loadHarness(DatabaseHandler handler, Table table, int cid) throws Exception {
		String q = "SELECT qidx, type, vals, set, wherec, query FROM qlogs WHERE cid = %d AND isclean = %s ORDER BY qidx";
		String cleanq = String.format(q, cid, true);
		String dirtyq = String.format(q, cid, false);

		QueryLog cleanQueries = loadQueries(handler, table, "clean", cleanq);
		QueryLog dirtyQueries = loadQueries(handler, table, "dirty", dirtyq);
		
		
		
		return new SyntheticHarness(handler, cid, cleanQueries, dirtyQueries);
	}
	
	static QueryLog loadQueries(DatabaseHandler handler, Table table, String mode, String query) throws Exception {
		QueryLog queries = new QueryLog();
		ResultSet rset = handler.queryExecution(query);
		while(rset.next()) {
			int qidx = rset.getInt("qidx");
			String type = rset.getString("type");
			String vals_str = rset.getString("vals");
			String set_str = rset.getString("set");
			String where_str = rset.getString("wherec");
			String query_str = rset.getString("query");
			
			JSONArray valsjson = (JSONArray)JSONValue.parse(vals_str);
			JSONArray setjson = (JSONArray)JSONValue.parse(set_str);
			JSONArray wherejson = (JSONArray)JSONValue.parse(where_str);
			
			String curTablename = String.format("%s_%s_%d", table.getName(), mode, qidx);
			Table curTable = table.clone();
			curTable.setName(curTablename);
			
			switch(type) {
			case "UPDATE":
				queries.add(jsonToUpdateQuery(qidx, curTable, setjson, wherejson));
				break;
			case "INSERT":
				queries.add(jsonToInsertQuery(qidx, curTable, valsjson));
				break;
			}
		}
		return queries;
	}
	
	static DatabaseStates loadDatabaseStates(DatabaseHandler handler, QueryLog queries)  throws Exception{
		DatabaseStates dss = new DatabaseStates();
		for (Query q : queries) {
			DatabaseState ds = new DatabaseState(handler, q.getTable());
			dss.add(ds);
		}
		return dss;
	}
	

	
	
	
	
	public static List<Query> loadQueryLog(String fname, Table table) throws Exception {
		List<Query> qlog = new ArrayList<Query>();
		BufferedReader fr = new BufferedReader(new FileReader(fname));
		String line = null;
		int qid = 0;
		
		while ((line = fr.readLine()) != null) {
			JSONObject qjson = (JSONObject)JSONValue.parse(line.trim());
			String qtype = (String)qjson.get("type");
			JSONArray vals = (JSONArray)qjson.get("vals");
			JSONArray set = (JSONArray)qjson.get("set");
			JSONArray where = (JSONArray)qjson.get("where");
			String tname = (String)qjson.get("table");
			
			switch(qtype) {
			case "UPDATE":
				WhereClause wclause = jsonToWhereClause(where);
				SetClause sclause = jsonToSetClause(set);
				qlog.add(new UpdateQuery(qid, sclause, table, wclause));
				break;
			case "INSERT":
				List<String> realvals = new ArrayList<String>();
				for (Object s : vals) { 
					realvals.add((String)s);
				}
				qlog.add(new InsertQuery(qid, table, realvals));
				
			}
			qid++;
		}
		return qlog;
	}

	public static InsertQuery jsonToInsertQuery(int qid, Table table, JSONArray vals) {
		List<String> realvals = new ArrayList<String>();
		realvals.add("default");
		for (Object s : vals) { 
			realvals.add(String.valueOf(s));
		}
		return new InsertQuery(qid, table, realvals);
	}
	
	public static UpdateQuery jsonToUpdateQuery(int qid, Table table, JSONArray setjson, JSONArray wherejson) {
		WhereClause where = jsonToWhereClause(wherejson);
		SetClause set = jsonToSetClause(setjson);
		return new UpdateQuery(qid, set, table, where);
	}
	
	public static WhereClause jsonToWhereClause(JSONArray where) {
		List<WhereExpr> exprs = new ArrayList<WhereExpr>();
		for (Object wc : where) {
			JSONArray wa = (JSONArray)wc;
			String col = (String)wa.get(0);
			String op = (String)wa.get(1);
			long v = (long)wa.get(2);
			WhereExpr expr = new WhereExpr(
				new VariableExpression(col, true),
				WhereExpr.getOperator(op),
				new VariableExpression(v, false));
			exprs.add(expr);
		}
		return new WhereClause(exprs, WhereClause.Op.CONJ);
	}
	
	public static SetClause jsonToSetClause(JSONArray set) {
		List<SetExpr> setexprs = new ArrayList<SetExpr>();
		for (Object setc : set) {
			VariableExpression lhs = null;
			Expression rhs = null;
			JSONArray seta = (JSONArray)setc;
			String col = (String) seta.get(0);
			lhs = new VariableExpression(col, true);
			
			if (seta.get(1) instanceof JSONArray ) {
				JSONArray exprjson = (JSONArray)seta.get(1); 
				String exprcol = (String)exprjson.get(0);
				String exprop = (String)exprjson.get(1);
				float exprv = (float)exprjson.get(2);
				rhs = new AdditionExpression(
						new VariableExpression(col, true), 
						new VariableExpression(exprv, false));
			} else {
				long exprv = (long)seta.get(1);
				rhs = new VariableExpression(exprv, false);
			}
			
			setexprs.add(new SetExpr(lhs, rhs));
		}
		return new SetClause(setexprs);
	}
	
	/*
	 *  config array:
	 *		[
	 *		 N_D, N_dim, N_q, N_pred, N_ins, N_set, N_where, idx, 
	 *		 p_I, p_pk, p_fp, p_fn,
	 *		 exptype, passtype, optchoice, qfixtype,
	 *		 epsilon, M, approx, prune
	 *		] 
	 *	exptype:
	 *		1: synthetic
	 *		2: tpcc
	 *  passtype:
	 *  	1: one pass solution
	 *  	2: rollback only
	 *  optchoice:
	 *  	1: no preprocssing
	 *  	2: preprocessing
	 *  qfixtype:
	 *  	1: cplex
	 *  	2: decision tree
	 *  approx: if cplex is infeasible
	 *  	true/false
	 *  prune: prune false positives w/ density
	 *  	true/false
	 */ 
	public static List<float[]> loadConfig(String fname) throws Exception{
		BufferedReader fr = new BufferedReader(new FileReader(fname));
		String line = null;
		List<float[]> ret = new ArrayList<float[]>();
		while ((line = fr.readLine()) != null) {
			String[] arr = line.split(",");
			float[] params = new float[arr.length];
			for (int i = 0; i < arr.length; i++) {
				params[i] = Float.parseFloat(arr[i]);
			}
			ret.add(params);
			
		}
		return ret;
		

	}
	
	
	
	/*
	 * arguments
	 * 	java SyntheticHarness dbConfigfile configid, configid, ... 
	 * 
	 * configid is the id value in the configs table
	 * 
	 */
	public static void main(String[] args) throws Exception {
		String dbconfigname = args[0];
		DatabaseHandler handler = new DatabaseHandler();
		handler.getConnected(dbconfigname);
		
		for (int i = 1; i < args.length; i++) {
			int cid = Integer.parseInt(args[i]);
			String tablebase = "synth_" + cid;
			Table table = Table.tableFromDB(handler, tablebase);
			SyntheticHarness harness = loadHarness(handler, table, cid);
			harness.run();
			
		}
	}

}
