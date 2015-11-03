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
import queryprovenance.query.Query;
import queryprovenance.solve.FixQueryLog;

public class WorkloadHarness extends HarnessBase {
	static final String TABNAME_QLOG = "num_CLEANQLOGS";
	static final String QLOG_QUERY = "SELECT id, type, setc, wherec, vals, attrs, query FROM "
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
					tab_rset.getString("table_names"));
			tablebase = tab_rset.getString("table_names");
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
			String attr_str = query_rset.getString("attrs");

			JSONArray valsjson = (JSONArray) JSONValue.parse(vals_str);
			JSONArray attrsjson = (JSONArray) JSONValue.parse(attr_str);
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
						valsjson, attrsjson));
				break;
			}
		}
	}

	// Transform the querylog
	void transformQueries(ExpParams params, int qlogsize) throws Exception {
		fix_params.attr_per_iteration = 5;
		int pre = cleanQueries.size();
		Transform trans = new Transform(pre);
		trans.generate(params, cleanQueries, 0.5);
		dirtyQueries = trans.apply(cleanQueries);
		// Get database states
		cleanDss = cleanQueries.execute(table.getName(), "clean", handler,
				false);
		dirtyDss = dirtyQueries.execute(table.getName(), "dirty", handler,
				false);
		complaints = new Complaint(cleanDss.get(cleanDss.size() - 1),
				dirtyDss.get(dirtyDss.size() - 1));
		while (complaints.size() < 1 && trans.pre > 0) {
			trans.generate(params, cleanQueries, 0.5);
			System.out.println(trans.qidx);
			dirtyQueries = trans.apply(cleanQueries);
			dirtyDss = dirtyQueries.execute(table.getName(), "dirty", handler,
					false);
			complaints = new Complaint(cleanDss.get(cleanDss.size() - 1),
					dirtyDss.get(dirtyDss.size() - 1));
		}
		cleanDss.loadPartial(complaints);
		dirtyDss.loadPartial(complaints);
		if (trans.qidx >= 0) {
			String cleanqparam = String.format(
					"DEFAULT, %d, %d, '%s', '%s', 'clean', "
							+ "'%s', '%s', '%s', '%s', '%s'",
					qlogsize,
					trans.qidx,
					table.getName() + "_clean_" + trans.qidx,
					table.getName() + "_clean_"
							+ String.valueOf(trans.qidx + 1), trans.type, "",
					"", "", cleanQueries.get(trans.qidx));
			String dirtyqparam = String.format(
					"DEFAULT, %d, %d, '%s', '%s', 'dirty', "
							+ "'%s', '%s', '%s', '%s', '%s'",
					qlogsize,
					trans.qidx,
					table.getName() + "_dirty_" + trans.qidx,
					table.getName() + "_dirty_"
							+ String.valueOf(trans.qidx + 1), trans.type, "",
					"", "", dirtyQueries.get(trans.qidx));
			String cleanq = String.format("INSERT INTO qlogs VALUES(%s)",
					cleanqparam);
			String dirtyq = String.format("INSERT INTO qlogs VALUES(%s)",
					dirtyqparam);
			handler.updateExecution(cleanq);
			handler.updateExecution(dirtyq);
		}
	}

	// Run solver
	void run(int cid) throws Exception {
		fix_params.batch_per_iteration = this.dirtyQueries.size();
		QueryLog fixedQueries = new QueryLog();

		// CPLEX stuff
		IloCplex cplex = new IloCplex();

		Complaint _complaints = complaints.clone();
		// sample 10 complaint
		Complaint _complaints_sub = Complaint.getPartial(_complaints,
				prob_params.n_compl);
		// _complaints = Complaint.addNoise(_complaints, handler, fp, fn);

		// define new algorithm
		FixQueryLog solver2 = new FixQueryLog();

		prob_params.p_fn = (double) (_complaints_sub.size() == 0 ? 1
				: _complaints_sub.size() / _complaints.size());
		/*
		 * passtype = 0: onepass algorithm passtype > 0: new algorithm_passtype,
		 * passtype = number of attributes to consider
		 */
		for (int iterationIdx = 0; iterationIdx < prob_params.niterations
				&& complaints.size() > 0; iterationIdx++) {
			if (complaints.size() == 0) {
				fixedQueries = this.dirtyQueries;
			} else {
				solver2.initialize(cplex, handler, dirtyDss, dirtyQueries,
						_complaints_sub);
				fixedQueries = solver2.fixQueries(cplex, fix_params);
			}
			// update exprs result
			DatabaseStates fixedds = fixedQueries.execute(table.getName(),
					"fixed", handler, false);
			fixedds.loadPartial(_complaints_sub);
			computeMetrics(cid, fixedQueries, fixedds, solver2, complaints, 0);
			// update complaint set
			Complaint newcmp = new Complaint(cleanDss.get(cleanDss.size() - 1),
					fixedds.get(fixedds.size() - 1));
			newcmp = Complaint.getPartial(newcmp, prob_params.n_compl_iter);
			_complaints.addAll(newcmp);

			for (int modified : solver2.modifiedList) {
				String fixedqparam = String.format(
						"DEFAULT, %d, %d, '%s','%s', 'fixed', "
								+ "'%s', '%s', '%s', '%s', '%s'",
						dirtyQueries.size(),
						modified,
						table.getName() + "_fixed_" + modified,
						table.getName() + "_fixed_" + String.valueOf(modified + 1),
						"",
						"", "", "", fixedQueries.get(modified));
				String fixedq = String.format("INSERT INTO qlogs VALUES(%s)",
						fixedqparam);
				System.out.println(fixedq);
				handler.updateExecution(fixedq);
			}
			System.out.println("Finished iteration " + iterationIdx);
		}

		System.out.println("finished fixeng");
		System.out.println(fixedQueries);
	}

	public void computeMetrics(int cid, QueryLog fixedqlog,
			DatabaseStates fixedds, FixQueryLog solver2, Complaint complaints,
			int iterationIdx) throws Exception {

		HashMap<Metrics.Type, Double> metrics = Metrics.evaluateAll2(
				cleanQueries, cleanDss, dirtyQueries, dirtyDss, fixedqlog,
				fixedds);

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
				"DEFAULT, %d, %d, %d, %d, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f",
				cid,
				iterationIdx,
				// metrics.get(Metrics.Type.BADCOMPLAINT).intValue(),
				complaints.size(), metrics.get(Metrics.Type.FIXEDCOMPLAINT)
						.intValue(), metrics.get(Metrics.Type.REMOVEDRATE),
				metrics.get(Metrics.Type.NOISERATE), computetime[0],
				computetime[1], computetime[2], computetime[3], computetime[4],
				prob_params.p_fp, nconstraints, nvariables);
		String q = String.format("INSERT INTO exps VALUES(%s)", params);
		System.out.println(Metrics.Type.REMOVEDRATE + "\t" + Metrics.Type.NOISERATE);
		handler.updateExecution(q);
	}

	public static void main(String[] args) throws Exception {
		String dbconfigname = args[0];
		String dbsetupname = args[1];
		DatabaseHandler handler = new DatabaseHandler();
		handler.getConnected(dbconfigname);
		// handler.executePrepFile(dbsetupname);
		// int[] test_size = {150, 160, 170, 180, 190, 200};
		for (int i = 10; i < 500; i = i+10) {
			System.out.println("CURSIZE:" + i);
			int cur_size = i;
			ExpParams params = ExpParams.instance();
			WorkloadHarness harness = new WorkloadHarness(handler);
			harness.loadQueries(cur_size);
			params.table = harness.table;
			params.ql_nqueries = cur_size;
			params.ql_nclauses = 6;
			params.ql_qtypes = new Query.Type[cur_size];
			for (int qidx = 0; qidx < cur_size; ++qidx) {
				params.ql_qtypes[qidx] = harness.cleanQueries.get(qidx)
						.getType();
			}

			harness.transformQueries(params, cur_size);
			harness.run(i);

		}
	}
}
