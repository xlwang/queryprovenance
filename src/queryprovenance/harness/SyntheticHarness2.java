package queryprovenance.harness;

import ilog.cplex.IloCplex;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import org.json.simple.JSONArray;
import org.json.simple.JSONValue;

import queryprovenance.database.DatabaseHandler;
import queryprovenance.database.DatabaseStates;
import queryprovenance.database.Table;
import queryprovenance.problemsolution.Complaint;
import queryprovenance.problemsolution.QueryLog;
import queryprovenance.query.Query;
import queryprovenance.solve.FixQueryLog;
import queryprovenance.solve.FixQueryLogParams;

public class SyntheticHarness2 {

	public static final String TNAME = "synth";

	public static int num_compl = 10;
	public static String pid_sql = "SELECT DISTINCT pid FROM qlogs ORDER BY pid ASC;";
	public static String test_sql = "SELECT DISTINCT test_size FROM qlogs ORDER BY test_size ASC";
	public static String clean_qlog_sql = "SELECT id, qidx, type, vals, attrs, setc, wherec FROM qlogs where pid = %d and "
			+ "mode = 'clean' ORDER BY qidx LIMIT %d;";
	public static String dirty_qlog_sql = "SELECT id, qidx, type, vals, attrs, setc, wherec FROM qlogs where pid = %d and "
			+ "mode = 'dirty' and test_size = %d ORDER BY qidx;";

	public static String insert_sql = "INSERT INTO exps VALUES (DEFAULT, %d, %d, %f, %f, '%s', %d, %d, %d, %d, %d, %d, %d, %f, %f, '%s', "
			+ "'%s', %f, %f, %f, %f, %f, %d)";

	public static String dirty_query_idx_sql = " SELECT a1.qidx FROM qlogs as a1  where a1.query not in (select query "
			+ "from qlogs where pid = %d and mode = 'dirty' and test_size = %d) and pid = %d and mode = 'clean' and qidx < %d;";
	
	public static String update_query = "UPDATE qlogs set query = '%s' where id = %d";

	public static void Run(DatabaseHandler handler, IloCplex cplex, int pid,
			int test_size) throws Exception {
		// set experiment settings
		int max_attr = 11, min_attr = 1;
		int[] num_attr = { -1, max_attr, -1, -1, min_attr, 5};
		boolean[] preproc = { false, true, true, true, true, true};
		boolean[] preattr = { true, false, true, true, true, true};
		int[] objimpt = { 0, 0, 0, 1, 0, 0};
		int[] randomnum = { 0, 0, 0, 0, 0, 0};
		// load the problem
		Table table = Table.tableFromDB(handler, TNAME);
		String c_qlog_sql = String.format(clean_qlog_sql, pid, test_size);
		QueryLog cleanQueries = SyntheticHarness2.loadQueries(handler,
				c_qlog_sql);
		String d_qlog_sql = String.format(dirty_qlog_sql, pid, test_size);
		QueryLog dirtyQueries = SyntheticHarness2.loadQueries(handler,
				d_qlog_sql);

		// Get database states
		DatabaseStates cleanDss = cleanQueries.execute(table.getName(),
				"clean", handler, false);
		DatabaseStates dirtyDss = dirtyQueries.execute(table.getName(),
				"dirty", handler, false);
		Complaint complaints = new Complaint(cleanDss.get(cleanDss.size() - 1),
				dirtyDss.get(dirtyDss.size() - 1));

		// Load partial complaints
		cleanDss.loadPartial(complaints);
		dirtyDss.loadPartial(complaints);

		// Get ground truth
		ResultSet rset_groundtruth = handler.queryExecution(String.format(
				dirty_query_idx_sql, pid, test_size, pid, test_size));
		ArrayList<String> dirty_query_index = new ArrayList<String>();
		while (rset_groundtruth.next()) {
			dirty_query_index.add(rset_groundtruth.getString("qidx"));
		}

		for (int i = 0; i < num_attr.length; ++i) {
			System.out.println("Pid: " + pid + " test_size: " + test_size
					+ " # alg: " + i);
			
			// Set parameters
			FixQueryLogParams params = new FixQueryLogParams();
			params.attr_per_iteration = num_attr[i];
			params.pre_proc = preproc[i];
			params.fix_relv_attr = preattr[i];
			params.random_num = randomnum[i];
			params.objective_attr_impact = objimpt[i];
			//params.batch_per_iteration = dirtyQueries.size();
			
			QueryLog fixedQueries = new QueryLog();

			FixQueryLog fix_query_solver = new FixQueryLog();
			// do the fix
			if (complaints.size() == 0) {
				fixedQueries = dirtyQueries;
			} else {
				fix_query_solver.initialize(cplex, handler, dirtyDss,
						dirtyQueries, complaints);
				fixedQueries = fix_query_solver.fixQueries(cplex, params);
			}
			// save queries
			SyntheticDataGenHarness.SaveQueries(handler, "fixed", fixedQueries,
					pid, test_size);

			// Gather stats
			DatabaseStates fixedDss = fixedQueries.execute(table.getName(),
					"fixed", handler, false);
			fixedDss.loadPartial(complaints);

			HashMap<Metrics.Type, Double> metrics = Metrics.evaluateAll2(
					cleanQueries, cleanDss, dirtyQueries, dirtyDss,
					fixedQueries, fixedDss);

			long[] time = fix_query_solver.getTime();
			double[] computetime = new double[time.length];
			for (int j = 0; j < computetime.length; ++j) {
				computetime[j] = time[j] / 1000000000.0;
			}
			// define number of constraints and variables
			// insert data into result table

			String insert_detail = String.format(insert_sql, pid, test_size,
					1.0, 1.0, "cplex", preproc[i] == true ? 1 : 0,
					preattr[i] == true ? 1 : 0,
					fix_query_solver.num_relv_query,
					fix_query_solver.num_relv_attr, i, complaints.size(), metrics
							.get(Metrics.Type.FIXEDCOMPLAINT).intValue(),
					metrics.get(Metrics.Type.REMOVEDRATE), metrics
							.get(Metrics.Type.NOISERATE), Util.join(
							dirty_query_index, ","), Util.join(
							fix_query_solver.modifiedList, ","),
					computetime[0], computetime[1], computetime[2],
					computetime[3], computetime[4],
					fix_query_solver.avgconstraint);
			//System.out.println(metrics.get(Metrics.Type.REMOVEDRATE) + ":::::" + metrics
			//		.get(Metrics.Type.NOISERATE));
			handler.updateExecution(insert_detail);
		}
	}

	public static QueryLog loadQueries(DatabaseHandler handler, String qlog_sql)
			throws Exception {
		QueryLog queries = new QueryLog();
		// process table name
		Table table = Table.tableFromDB(handler, TNAME);
		// process querylogs
		ResultSet query_rset = handler.queryExecution(qlog_sql);
		int query_count = 0;
		while (query_rset.next()) {
			int id = query_rset.getInt("id");
			int qidx = query_rset.getInt("qidx");
			String type = query_rset.getString("type").toLowerCase();
			String vals_str = query_rset.getString("vals").toLowerCase();
			String set_str = query_rset.getString("setc").toLowerCase();
			String where_str = query_rset.getString("wherec").toLowerCase();
			String attr_str = query_rset.getString("attrs").toLowerCase();

			JSONArray valsjson = (JSONArray) JSONValue.parse(vals_str);
			JSONArray attrsjson = (JSONArray) JSONValue.parse(attr_str);
			JSONArray setjson = (JSONArray) JSONValue.parse(set_str);
			JSONArray wherejson = (JSONArray) JSONValue.parse(where_str);
			String curTablename = TNAME + "_" + String.valueOf(query_count++);

			// String curTablename = String.format("%s_%s_%d", table.getName(),
			// mode, qidx);
			Table curTable = table.clone();
			curTable.setName(curTablename);
			Query query = null;
			switch (type) {
			case "update":
				query = Util.jsonToUpdateQuery(qidx, curTable, setjson,
						wherejson);
				break;
			case "insert":
				query = Util.jsonToInsertQuery(qidx, curTable, valsjson,
						attrsjson);
				break;
			}
			
			queries.add(query);
			// update query
			handler.updateExecution(String.format(update_query, query.toString().toLowerCase(), id));
			
		}
		return queries;
	}

	public static void main(String[] argv) throws Exception {
		int portnumber = Integer.valueOf(argv[0]);
		DatabaseHandler handler = new DatabaseHandler(portnumber);
		handler.getConnected(argv[1]);
		IloCplex cplex = new IloCplex();

		ResultSet rset_test = handler.queryExecution(test_sql);
		while (rset_test.next()) {
			for (int test_case = 2; test_case < argv.length; ++test_case) {
				int pid = Integer.valueOf(argv[test_case]);
				int test_size = rset_test.getInt(1);
				SyntheticHarness2.Run(handler, cplex, pid, test_size);
			}
		}
	}
}
