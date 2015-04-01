package queryprovenance.harness;

import ilog.cplex.IloCplex;

import java.io.BufferedReader;
import java.io.FileReader;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
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
import queryprovenance.problemsolution.Complaint;
import queryprovenance.problemsolution.QueryLog;
import queryprovenance.problemsolution.Solution;
import queryprovenance.query.InsertQuery;
import queryprovenance.query.Query;
import queryprovenance.query.Query.Type;
import queryprovenance.query.SetClause;
import queryprovenance.query.SetExpr;
import queryprovenance.query.UpdateQuery;
import queryprovenance.query.WhereClause;
import queryprovenance.query.WhereExpr;
import queryprovenance.query.WhereExpr.Op;

public class SyntheticHarness {

	DatabaseHandler handler = null;
	int cid = -1;
	String tableBase = null;
	QueryLog cleanQueries = null;
	queryprovenance.problemsolution.QueryLog dirtyQueries = null;
	DatabaseStates cleanDss = null;
	DatabaseStates dirtyDss = null;
	Complaint complaints = null;

	int passtype, 
	optchoice, 
	qfixtype,
	niterations;
	int rollbackbatch;
	float epsilon, M; 
	boolean approx, prune;
	boolean oneerror = true; // true for single error fix. 
	boolean print = false; // print cplex solver status
	boolean feasible = false;
	boolean falsepositive = false;

	public SyntheticHarness(DatabaseHandler handler, int cid, QueryLog cleanQs, QueryLog dirtyQs) throws Exception {
		this.handler = handler;
		this.cid = cid;
		this.tableBase = "synth_" + cid;		
		this.cleanQueries = cleanQs;
		this.dirtyQueries = dirtyQs;
		this.cleanDss = loadDatabaseStates(handler, cid, "clean"); 
		this.dirtyDss = loadDatabaseStates(handler, cid, "dirty"); 
		this.complaints = new Complaint(cleanDss.get(cleanDss.size()-1), dirtyDss.get(cleanDss.size()-1));
		loadConfigParams();
	}

	public void loadConfigParams() throws Exception {
		String q = "SELECT passtype, optchoice, qfixtype, niterations, epsilon, M, approx, prune, rollbackbatch, p_fp FROM configs WHERE id = " + cid;
		ResultSet rset = handler.queryExecution(q);
		rset.next();
		passtype = rset.getInt(1);
		optchoice = rset.getInt(2);
		qfixtype = rset.getInt(3);
		niterations = rset.getInt(4);
		epsilon = rset.getFloat(5);
		M = rset.getFloat(6);
		approx = rset.getBoolean(7);
		prune = rset.getBoolean(8);
		rollbackbatch = rset.getInt(9);
		falsepositive = rset.getFloat(10) > 0; 
		//oneerror = rset.getBoolean(10);
		//feasible = rset.getBoolean(11);
		//falsepositive = rset.getBoolean(12);
		//print = rset.getBoolean(13);
	}


	/*
	 * XXX: xiaolan: fill in with execution and metrics code
	 */
	public void run() throws Exception {
		QueryLog fixedQueries = new QueryLog();

		// CPLEX stuff
		IloCplex cplex = new IloCplex();
		int solverind = -1;
		String[] options = new String[]{"-M", String.valueOf(solverind) , "-E", "0.1", "-O", "abs"};

		Complaint _complaints = complaints.clone();
		Solution solver = new Solution(handler, dirtyDss, dirtyQueries, _complaints);
		boolean preproc = optchoice == 2;
		boolean usecplex = qfixtype == 1;



		QueryLog fixedlog = null;
		DatabaseStates fixeddss = null;
		switch(passtype) {
		case 1: // one pass alg
			fixedlog = solver.onePassSolution(cplex, epsilon, M, preproc, feasible, falsepositive, oneerror, options);
			break;
		case 2: // rollback only
			fixeddss = solver.rollback(cplex, epsilon, M, preproc, rollbackbatch, options);
			break;
		case 3: // query fix only (no rollback)
			fixedlog = solver.qfixOnlySolution(cplex, this.cleanDss, epsilon, M, preproc, feasible, falsepositive, rollbackbatch, options);
			break;
		case 4: // two pass algorithm
			fixedlog = solver.twoPassSolution(cplex, epsilon, M, preproc, feasible, falsepositive, rollbackbatch, options);
			break;
		case 5:
			for (int iterationIdx = 0; iterationIdx < niterations; iterationIdx++) {
				fixedlog = solver.onePassSolution(cplex, epsilon, M, preproc, feasible, falsepositive, oneerror, options);
				DatabaseStates fixedds = fixedlog.execute(tableBase, handler);
				computeMetrics(fixedlog, fixedds, solver, complaints, iterationIdx);

				// update complaint set
				Complaint newcmp = new Complaint(cleanDss.get(cleanDss.size()-1), fixedds.get(fixedds.size()-1));
				newcmp = Complaint.getPartial(newcmp, 10);
				_complaints.addAll(newcmp);

				System.out.println("Finished iteration " + iterationIdx);
			}
			return;
		}

		DatabaseStates fixedds = fixedlog.execute(tableBase, handler);
		computeMetrics(fixedlog, fixedds, solver, complaints, 0);

		System.out.println("finished fixeng");
		System.out.println(fixedlog);
	}

	/*
	 * @arg iterationIdx in the iterative approach to the onepass algorithm, it runs in multiple passes.  
	 */
	public void computeMetrics(QueryLog fixedqlog, DatabaseStates fixedds, Solution solver, Complaint complaints, int iterationIdx) throws Exception {
		Metrics.Index diff = Metrics.compare(dirtyQueries, fixedqlog, 0.1);
		HashSet<Integer> updated = new HashSet<Integer>();

		updated.clear();
		updated.addAll(diff);
		HashMap<Metrics.Type, Double> metrics = Metrics.evaluateAll2(cleanQueries, cleanDss, dirtyQueries, dirtyDss, fixedqlog, fixedds);

		String metric_value = Metrics.toString(metrics);
		long[] time = solver.getTime();
		double[] computetime = new double[time.length];
		for(int j = 0; j < computetime.length; ++j) {
			computetime[j] = time[j] / 1000000000.0;
			if(computetime[j] == 0)
				System.out.print(" ");
		}


		// insert data into result table
		String params = String.format(
				"DEFAULT, %d, %d, %d, %d, %f, %f, '%s', '%s', %f, %f, %f, %f",
				cid,
				iterationIdx,
				//metrics.get(Metrics.Type.BADCOMPLAINT).intValue(),
				complaints.size(),
				metrics.get(Metrics.Type.FIXEDCOMPLAINT).intValue(),
				metrics.get(Metrics.Type.REMOVEDRATE),
				metrics.get(Metrics.Type.NOISERATE),
				"",
				diff,
				computetime[0],
				computetime[1],
				computetime[2],
				computetime[3]
				);
		String q = String.format("INSERT INTO exps VALUES(%s)", params);
		handler.queryExecution(q);

		
		SyntheticHarness.saveQueries(this.handler, this.tableBase, cid, fixedqlog);

		// write out fixed query log
		/*
		dataout.write("query log, bad query log, fixed query log"); dataout.newLine();
		for(int i = 0; i < qlog.size(); ++i){
			dataout.write(qlog.get(i) + "," + badqlog.get(i) + "," + fixedqlog.get(i));
			dataout.newLine();
		}
		dataout.close();
		 */		
	}


	static SyntheticHarness loadHarness(DatabaseHandler handler, Table table, int cid) throws Exception {
		String q = "SELECT qidx, type, vals, set, wherec, query, oldtname, newtname FROM qlogs WHERE cid = %d AND mode = '%s' ORDER BY qidx";
		String cleanq = String.format(q, cid, "clean");
		String dirtyq = String.format(q, cid, "dirty");

		QueryLog cleanQueries = loadQueries(handler, table, "clean", cleanq);
		QueryLog dirtyQueries = loadQueries(handler, table, "dirty", dirtyq);

		return new SyntheticHarness(handler, cid, cleanQueries, dirtyQueries);
	}

	static QueryLog loadQueries(DatabaseHandler handler, Table table, String mode, String query) throws Exception {
		QueryLog queries = new QueryLog();
		System.out.println("query");
		ResultSet rset = handler.queryExecution(query);
		while(rset.next()) {
			int qidx = rset.getInt("qidx");
			String type = rset.getString("type");
			String vals_str = rset.getString("vals");
			String set_str = rset.getString("set");
			String where_str = rset.getString("wherec");
			String query_str = rset.getString("query");
			String curTablename = rset.getString("oldtname");

			JSONArray valsjson = (JSONArray)JSONValue.parse(vals_str);
			JSONArray setjson = (JSONArray)JSONValue.parse(set_str);
			JSONArray wherejson = (JSONArray)JSONValue.parse(where_str);

			//String curTablename = String.format("%s_%s_%d", table.getName(), mode, qidx);
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
	
	
	static void saveQueries(DatabaseHandler handler, String table, int cid, QueryLog qlog) throws Exception {
		//sql = "INSERT INTO qlog VALUES (default, cid, qidx, oldtname, newtname, "fixed", type, valsjson, setjson, wherejson, query)"
		String sql_base = "INSERT INTO qlogs VALUES (DEFAULT, %d, %d, '%s', '%s', 'fixed', '%s', '%s', '%s', '%s', '%s');";
		for (Query q : qlog) {
			String type_str = null;
			Type type = q.getType();
			String vals_str = "";
			String set_str = "";
			String where_str ="";
			int qid = q.getId();
			
			if (type == Query.Type.INSERT) {
				JSONArray vals = new JSONArray();
				vals.addAll(q.getValue());
				vals_str = vals.toJSONString();
				type_str = "INSERT";
			} else if (type == Query.Type.UPDATE) {
				JSONArray where = whereToJSON(q.getWhere());
				JSONArray set = setToJSON(q.getSet());
				where_str = where.toJSONString();
				set_str = set.toJSONString();
				type_str = "UPDATE";
			}
			
			
			String sql = String.format(sql_base, 
					cid, qid, 
					table, table,
					type_str, vals_str, set_str, where_str, 
					q.toString());
			handler.queryExecution(sql);
			System.out.println("saved fixed query " + table + "  " + qid);
			
		}
		
	}
	

	static DatabaseStates loadDatabaseStates(DatabaseHandler handler, int cid, String mode)  throws Exception{
		DatabaseStates dss = new DatabaseStates();

		String cq = "SELECT oldtname as tname FROM qlogs WHERE qidx = 0 and cid=" + cid + " and mode = '" + mode + "'";
		String dq = "SELECT qidx, newtname as tname FROM qlogs WHERE cid=" + cid + " and mode = '" + mode + "' ORDER BY qidx";
		System.out.println(cq);
		ResultSet rset = handler.queryExecution(cq);
		rset.next();
		System.out.println(rset.getString("tname"));
		dss.add(new DatabaseState(handler, rset.getString("tname")));

		System.out.println(dq);
		rset = handler.queryExecution(dq);
		while (rset.next()) {
			String tname = rset.getString("tname");
			System.out.println(" " + tname);
			DatabaseState ds = new DatabaseState(handler, tname);
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

	
	public static JSONArray whereToJSON(WhereClause where) {
		JSONArray ret = new JSONArray();
		for (WhereExpr expr : where.getWhereExprs()) {
			Op op = expr.getOperator();
			JSONArray wa = new JSONArray();
			wa.add(expr.getAttrExpr().toString());
			wa.add(expr.getOperatorString());
			wa.add(expr.getVar());
			ret.add(wa);
		}
		return ret;		
	}
	
	public static JSONArray setToJSON(SetClause set) {
		JSONArray ret = new JSONArray();
		for (SetExpr expr : set.getSetExprs()) {
			JSONArray sa = new JSONArray();
			String col = expr.getAttr().toString();
			sa.add(col);
			if (expr.getExpr() instanceof AdditionExpression) {
				JSONArray exprjson = new JSONArray();
				exprjson.add(col);
				exprjson.add("=");
				List<Expression> addExprs = expr.getExpr().getVariable();
				double val = addExprs.get(addExprs.size()-1).getAssignedEval();
				exprjson.add(val);
				sa.add(exprjson);
			} else {
				sa.add(expr.getExpr().getAssignedEval());
			}
			ret.add(sa);
		}
		return ret;
	}

	public static InsertQuery jsonToInsertQuery(int qid, Table table, JSONArray vals) {
		List<String> realvals = new ArrayList<String>();
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
