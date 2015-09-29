package queryprovenance.harness;

import ilog.cplex.IloCplex;

import java.sql.ResultSet;
import java.util.HashMap;

import org.json.simple.JSONArray;
import org.json.simple.JSONValue;

import queryprovenance.database.DatabaseHandler;
import queryprovenance.database.DatabaseStates;
import queryprovenance.database.Table;
import queryprovenance.problemsolution.Complaint;
import queryprovenance.problemsolution.QueryLog;
import queryprovenance.problemsolution.Solution;
import queryprovenance.solve.FixQueryLog;

public class WorkloadHarness extends HarnessBase{
	static final String TABNAME_QLOG = "CLEANQLOGS";
	static final String QLOG_QUERY = "SELECT id, type, setc, wherec, vals, query FROM "
			+ TABNAME_QLOG + " ORDER BY id;";
	static final String TAB_QUERY = "SELECT DISTINCT table_names FROM "
			+ TABNAME_QLOG;

	// Define required parameters
	DatabaseHandler handler = null;
	Table table = null;
	String tablebase = null;
	QueryLog cleanQueries = null;
	queryprovenance.problemsolution.QueryLog dirtyQueries = null;
	DatabaseStates cleanDss = null;
	DatabaseStates dirtyDss = null;
	Complaint complaints = null;

	public WorkloadHarness(DatabaseHandler handler_) {
		handler = handler_;
	}

	// load clean querylog
	void loadQueries(int max_qlog_size) throws Exception {
		cleanQueries = new QueryLog();
		// process table name
		ResultSet tab_rset = handler.queryExecution(TAB_QUERY);
		while (tab_rset.next()) {
			table = Table.tableFromDB(handler,
					tab_rset.getString("table_names") + "_ini");
			tablebase = tab_rset.getString("table_names") + "_ini";
			break;
		}
		// process querylogs
		ResultSet query_rset = handler.queryExecution(QLOG_QUERY);
		int query_count = 0;
		while (query_rset.next() && query_count < max_qlog_size) {
			int qidx = query_rset.getInt("id");
			String type = query_rset.getString("type");
			String vals_str = query_rset.getString("vals");
			String set_str = query_rset.getString("setc");
			String where_str = query_rset.getString("wherec");

			JSONArray valsjson = (JSONArray) JSONValue.parse(vals_str);
			JSONArray setjson = (JSONArray) JSONValue.parse(set_str);
			JSONArray wherejson = (JSONArray) JSONValue.parse(where_str);
			String curTablename = tablebase + "_"
					+ String.valueOf(query_count++);

			// String curTablename = String.format("%s_%s_%d", table.getName(),
			// mode, qidx);
			Table curTable = table.clone();
			curTable.setName(curTablename);

			switch (type) {
			case "update":
				cleanQueries.add(Util.jsonToUpdateQuery(qidx, curTable,
						setjson, wherejson));
				break;
			case "insert":
				cleanQueries.add(Util.jsonToInsertQuery(qidx, curTable,
						valsjson));
				break;
			}
		}
	}

	// Transform the querylog
	void transformQueries(ExpParams params) throws Exception {
		Transform trans = Transform.generate(params, 1);
		dirtyQueries = trans.apply(cleanQueries);
		// Get database states
		cleanDss = cleanQueries.execute(table.getName(), handler);
		dirtyDss = dirtyQueries.execute(table.getName(), handler);
		Complaint complaint = new Complaint(cleanDss.get(cleanDss.size() - 1),
				dirtyDss.get(dirtyDss.size() - 1));
		while (complaint.size() < 1) {
			dirtyQueries = trans.apply(cleanQueries);
			dirtyDss = dirtyQueries.execute(table.getName(), handler);
		}
	}

	// Run solver
	void run(int cid) throws Exception {
		QueryLog fixedQueries = new QueryLog();

		// CPLEX stuff
		IloCplex cplex = new IloCplex();
		int solverind = -1;
		String[] options = new String[] { "-M", String.valueOf(solverind),
				"-E", "0.1", "-O", "abs" };

		Complaint _complaints = complaints.clone();
		// sample 10 complaint
		Complaint _complaints_sub = Complaint.getPartial(_complaints,
				prob_params.n_compl);
		// _complaints = Complaint.addNoise(_complaints, handler, fp, fn);

		// define new algorithm
		FixQueryLog solver2 = new FixQueryLog();

		prob_params.p_fp = (double) (_complaints_sub.size() == 0 ? 1
				: _complaints_sub.size() / _complaints.size());
		QueryLog fixedlog = null;
		/*
		 * passtype = 0: onepass algorithm passtype > 0: new algorithm_passtype,
		 * passtype = number of attributes to consider
		 */
		for (int iterationIdx = 0; iterationIdx < prob_params.niterations; iterationIdx++) {
			solver2.initialize(cplex, handler, dirtyDss, dirtyQueries,
					_complaints_sub);
			fixedlog = solver2.fixQueries(cplex, fix_params);
			// update exprs result
			DatabaseStates fixedds = fixedlog.execute(table.getName(), handler);
			computeMetrics(cid, fixedlog, fixedds, solver2, complaints, 0);
			// update complaint set
			Complaint newcmp = new Complaint(cleanDss.get(cleanDss.size() - 1),
					fixedds.get(fixedds.size() - 1));
			newcmp = Complaint.getPartial(newcmp, prob_params.n_compl_iter);
			_complaints.addAll(newcmp);

			System.out.println("Finished iteration " + iterationIdx);
		}

		System.out.println("finished fixeng");
		System.out.println(fixedlog);
	}
	
	public void computeMetrics(int cid, QueryLog fixedqlog, DatabaseStates fixedds,
			FixQueryLog solver2, Complaint complaints,
			int iterationIdx) throws Exception {

		HashMap<Metrics.Type, Double> metrics = Metrics.evaluateAll2(
				cleanQueries, cleanDss, dirtyQueries, dirtyDss, fixedqlog,
				fixedds);

		String metric_value = Metrics.toString(metrics);
		long[] time = solver2.getTime();
		double[] computetime = new double[time.length];
		for (int j = 0; j < computetime.length; ++j) {
			computetime[j] = time[j] / 1000000000.0;
			if (computetime[j] == 0)
				System.out.print(" ");
		}
		// define number of constraints and variables
		double nconstraints = solver2.avgconstraint;
		double nvariables = solver2.avgvariable;
		// insert data into result table
		String params = String.format(
				"DEFAULT, %d, %d, %d, %d, %f, %f, %f, %f, %f, %f, %f, %d, %d",
				cid,
				iterationIdx,
				// metrics.get(Metrics.Type.BADCOMPLAINT).intValue(),
				complaints.size(), metrics.get(Metrics.Type.FIXEDCOMPLAINT)
						.intValue(), metrics.get(Metrics.Type.REMOVEDRATE),
				metrics.get(Metrics.Type.NOISERATE), computetime[0],
				computetime[1], computetime[2], computetime[3],
				prob_params.p_fp, nconstraints, nvariables);
		String q = String.format("INSERT INTO exps VALUES(%s)", params);
		handler.queryExecution(q);
	}
	
	public static void main(String[] args) throws Exception {
		String dbconfigname = args[0];
		DatabaseHandler handler = new DatabaseHandler();
		handler.getConnected(dbconfigname);

		for (int i = 100; i < 1000; i = i + 100) {
			ExpParams params = ExpParams.instance();
			WorkloadHarness harness = new WorkloadHarness(handler);
			harness.loadQueries(i);
			params.table = harness.table;
			params.ql_nqueries = i;
			params.ql_nclauses = 3;
			params.ql_qtypes = null;
			
			harness.transformQueries(params);
			harness.run(i);

		}
	}
}
