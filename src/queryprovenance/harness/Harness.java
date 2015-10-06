package queryprovenance.harness;

import ilog.cplex.IloCplex;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;

import queryprovenance.database.DataGenerator;
import queryprovenance.database.DatabaseHandler;
import queryprovenance.database.DatabaseState;
import queryprovenance.database.DatabaseStates;
import queryprovenance.database.Table;
import queryprovenance.falsepositive.FalsePositiveAll;
import queryprovenance.problemsolution.Complaint;
import queryprovenance.problemsolution.QueryLog;
import queryprovenance.problemsolution.SingleComplaint;
import queryprovenance.problemsolution.Solution;
import queryprovenance.query.Query;
import queryprovenance.solve.FixQueryLog;
import queryprovenance.solve.FixQueryLogParams;

public class Harness {
	QueryLog qlog = null;
	QueryLog badqlog = null;
	DatabaseStates ds = null;
	DatabaseStates badds = null;
	Complaint complaint = null;
	Table table = null;

	int run = 0;
	int domian_max = 50;

	public static void main(String[] args) throws Exception {
		String dir = "/Users/xlwang/2015/projects/queryprov/code/queryprovenance/queryprovenance/";
		// int[] clause_count = {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		// 1,1,1,1,1};// 1, 1, 1, 1, 1, 1, 1, 1, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5,
		// 2, 3, 4, 2, 3, 4, 1, 1, 1, 5, 5, 5};
		// int[] qlog_count = {1,1,1,1,1,5,5,5,5,5,
		// 10,10,10,10,10,15,15,15,15,15,20,20,20,20,20};//5, 5, 5, 20, 20, 20,
		// 20, 20, 5, 5, 5, 5, 5, 20, 20, 20, 20, 20, 5, 5, 5, 20, 20, 20, 1,
		// 10, 15, 1, 10, 15};
		// int[] tuple_count = {500, 1000, 5000, 10000, 30000,500, 1000, 5000,
		// 10000, 30000,500, 1000, 5000, 10000, 30000,500, 1000, 5000, 10000,
		// 30000,500, 1000, 5000, 10000, 30000};//1000, 5000, 10000, 100, 500,
		// 1000, 5000, 10000,100, 500, 1000, 5000, 10000, 100, 500, 1000, 5000,
		// 10000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000};
		int[] clause_count = { 1, 1, 1, 1, 1, 1 };
		int[] qlog_count = { 1000, 50, 100, 500, 1000 };
		int[] tuple_count = { 500, 500, 500, 500, 500, 500 };
		IloCplex cplex = new IloCplex();
		// cplex.setParam(IloCplex.IntParam.PrePass, 0);
		int run_count = 10;
		int totalcount = 0;
		double percentage = 1;
		double[] complaintpercentage = { 1 };
		double[] complaintpercentage2 = { 1 };

		DatabaseHandler handler = new DatabaseHandler();
		handler.getConnected(dir + "/dbconn.config");
		handler.executePrepFile(dir + "/data/setup.sql");
		// handler.executePrepFile(dir + "/data/inserts.sql");
		handler.executePrepFile(dir + "/data/result.sql");

		Harness harness = new Harness();

		for (int i = 0; i < 5; ++i) {
			// prepare data files
			String filename = dir + "/result/harnessresult(" + tuple_count[i]
					+ "_" + qlog_count[i] + "_" + clause_count[i] + ").csv";
			String logpath = dir + "/result/harnessDT" + tuple_count[i] + "_"
					+ qlog_count[i] + "_" + clause_count[i];
			File filepath = new File(logpath);
			// create directory if not exist
			if (!filepath.exists()) {
				try {
					filepath.mkdir();
				} catch (Exception e) {
					System.out.print(e);
					return;
				}
			}
			File file = new File(filename);
			if (!file.exists())
				file.createNewFile();
			// for each random run

			for (int runs = 0; runs < run_count; runs++) {
				// vary the complaint percentage
				int qidx = harness.randomInstance(dir, handler, tuple_count[i],
						qlog_count[i], clause_count[i], percentage);

				for (int solverind = 0; solverind >= 0; --solverind) {

					// vary the solver
					harness.singleRun(handler, cplex, qlog_count[i],
							clause_count[i], tuple_count[i], logpath,
							solverind, 1, 1, qidx);

				}
			}
			// out.close();
		}
	}

	public int randomInstance(String dir, DatabaseHandler handler,
			int tuple_count, int qlog_count, int clause_count, double percentage)
			throws Exception {
		// generate data
		DataGenerator.generatorData(tuple_count);

		// TODO: somehow generate initial dataset
		ExpParams params = ExpParams.instance();
		String[] cols = new String[] { "employeeId", "level", "age",
				"employmentyear", "tax", "salary" };
		Table.Type[] types = new Table.Type[] { Table.Type.NUM, Table.Type.NUM,
				Table.Type.NUM, Table.Type.NUM, Table.Type.NUM, Table.Type.NUM };
		Object[] domains = new Object[] { new int[] { 0, domian_max },
				new int[] { 0, domian_max }, new int[] { 0, domian_max },
				new int[] { 0, domian_max }, new int[] { 0, domian_max },
				new int[] { 0, domian_max } };
		ArrayList<Integer> keylist = new ArrayList<Integer>();
		keylist.add(0);
		table = new Table("Employee", cols, types, domains, keylist);
		params.table = table;
		params.ql_nqueries = qlog_count;
		params.ql_nclauses = clause_count;


		// correct query log
		qlog = QueryLog.generate(params);
		ds = qlog.execute(table.getName(), "clean", handler, true);
		params.qlog = qlog;
		params.ql_qtypes = new Query.Type[qlog.size()];
		for(int qidx = 0; qidx < qlog.size(); ++qidx) {
			params.ql_qtypes[qidx] = qlog.get(qidx).getType();
		} 

		// System.out.println("Transformation: ");
		Transform trans = new Transform(qlog.size());
		trans.generate(params, 1);
		badqlog = trans.apply(qlog);
		// System.out.println("Wrong Query Log: ");
		badds = badqlog.execute(table.getName(), "dirty", handler, true);

		// get complaint set: good ds vs. bad ds
		complaint = new Complaint(ds.get(ds.size() - 1),
				badds.get(badds.size() - 1));

		while (complaint.size() < 1) {
			handler.executePrepFile(dir + "/data/setup.sql");
			handler.executePrepFile(dir + "/data/inserts.sql");

			qlog = QueryLog.generate(params);
			ds = qlog.execute(table.getName(), "clean", handler, true);

			params.qlog = qlog;
			trans.generate(params, 1);

			badqlog = trans.apply(qlog);
			badds = badqlog.execute(table.getName(), "dirty", handler, true);
			complaint = new Complaint(ds.get(ds.size() - 1), badds.get(badds
					.size() - 1));

			System.out.print(complaint.size() + " ");
		}

		return trans.qidx;
	}

	public void singleRun(DatabaseHandler handler, IloCplex cplex,
			int qlog_count, int clause_count, int tuple_count, String logpath,
			int solverind, double percentage, double complaintpercentage,
			int qidx) throws Exception {
		// prepare log data files
		File datapath = new File(logpath + "/" + run);
		if (!datapath.exists())
			datapath.createNewFile();
		BufferedWriter dataout = new BufferedWriter(new FileWriter(
				datapath.getAbsoluteFile()));

		System.out.println(run);
		// set parameters for solver
		String[] options = new String[] { "-M", String.valueOf(solverind),
				"-E", "0.1", "-O", "abs" };

		// solve bad query log
		// QueryLog fixedqlog = instance.solve(cplex, badqlog, ds, badds,
		// complaint);
		//

		// solve bad query log with incomplete complaint set
		// Complaint incomplete = complaint.getPart(complaintpercentage);
		Complaint cp = new Complaint(ds.get(ds.size() - 1), badds.get(badds
				.size() - 1));
		Complaint smcp = Complaint.getPartial(cp, 20);
		// QueryLog fixedqlog = solver2.onePassSolution(cplex, handler, badds,
		// badqlog, complaint, 0.1, 300000, true, options);
		QueryLog fixedqlog = badqlog;

		DatabaseStates fixedds;// = fixedqlog.execute(table.getName(), "fixed",
								// handler);
		HashSet<Integer> updated = new HashSet<Integer>();
		int[] temp = new int[] { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14,
				15, 16, 17, 18, 19 };
		double[] tttt = new double[temp.length];
		FixQueryLogParams params = new FixQueryLogParams();

		for (int i = 0; i < 1; ++i) {

			Solution solver2 = new Solution(handler, badds, badqlog, smcp);
			solver2.setPrint(false);
			FixQueryLog solution = new FixQueryLog();
			solution.initialize(cplex, handler, badds, badqlog, smcp);
			boolean fpchoice = i == 1;
			String solver = "";
			String modifiedlist = "";
			int avgconstraint = 0, avgvariable = 0;
			switch (solverind) {
			case 0:
				fixedqlog = solution.fixQueries(cplex, params);
				solver = "newalg1_1";
				modifiedlist = Util.join(solution.modifiedList, ",");
				avgconstraint = solution.avgconstraint;
				avgvariable = solution.avgvariable;
				break;
			case 1:
				fixedqlog = solver2.onePassSolution(cplex, params.epsilon, params.M,
						false, false, 1, options);
				solver = "onepass";
				modifiedlist = Util.join(solver2.modifiedList, ",");
				avgconstraint = solver2.avgconstraint;
				avgvariable = solver2.avgvariable;
				break;
			case 2:
				fixedqlog = solution.fixQueries(cplex, params);
				solver = "newalg1_3";
				modifiedlist = Util.join(solution.modifiedList, ",");
				avgconstraint = solution.avgconstraint;
				avgvariable = solution.avgvariable;
				break;
			case 3:
				fixedqlog = solution.fixQueries(cplex, params);
				solver = "newalg1_4";
				modifiedlist = Util.join(solution.modifiedList, ",");
				avgconstraint = solution.avgconstraint;
				avgvariable = solution.avgvariable;
				break;
			// case 1: fixedqlog = solution.fixQueries(cplex, 0.001, 1000000, 1,
			// 1, true, solverind); solver = "newalg1_2"; modifiedlist =
			// Util.join(solution.modifiedList, ","); avgconstraint =
			// solution.avgconstraint; avgvariable = solution.avgvariable;
			// break;
			// case 2: fixedqlog = solution.fixQueries(cplex, 0.001, 1000000, 1,
			// 1, true, solverind); solver = "newalg1_3"; modifiedlist =
			// Util.join(solution.modifiedList, ","); avgconstraint =
			// solution.avgconstraint; avgvariable = solution.avgvariable;
			// break;
			// case 3: fixedqlog = solution.fixQueries(cplex, 0.001, 1000000, 1,
			// 1, true, solverind); solver = "newalg1_4"; modifiedlist =
			// Util.join(solution.modifiedList, ","); avgconstraint =
			// solution.avgconstraint; avgvariable = solution.avgvariable;
			// break;
			// case 4: fixedqlog = solution.fixQueries(cplex, 0.001, 1000000, 2,
			// 1, true, 2); solver = "newalg2"; modifiedlist =
			// Util.join(solution.modifiedList, ","); avgconstraint =
			// solution.avgconstraint; avgvariable = solution.avgvariable;
			// break;
			// case 5: fixedqlog = solution.fixQueries(cplex, 0.001, 1000000, 3,
			// 1, true, 2); solver = "newalg3"; modifiedlist =
			// Util.join(solution.modifiedList, ","); avgconstraint =
			// solution.avgconstraint; avgvariable = solution.avgvariable;
			// break;
			// case 6: fixedqlog = solver2.onePassSolution(cplex, 0.001,
			// 1000000, true, false, false, 1, options); solver = "onepass";
			// modifiedlist = Util.join(solver2.modifiedList, ",");
			// avgconstraint = solver2.avgconstraint; avgvariable =
			// solver2.avgvariable; break;

			// case 2: fixedqlog = solver2.twoPassSolution(cplex, 0.001,
			// 10000000, true, false, true, 5, options); break;
			// case 3: fixedqlog = solver2.twoPassSolution(cplex, 0.001,
			// 10000000, false, false, true, 5, options); break;
			// case 4: solver2.rollback(cplex, 0.001, 10000000, true,
			// badqlog.size(), temp[i], badqlog.size(), options);
			}
			// fixedqlog = solver2.onePassSolution(cplex, handler, fixedds,
			// fixedqlog, complaint, 0.000001, 10000000, updated, true, false,
			// false, options);
			fixedds = fixedqlog.execute(table.getName(), "fixed", handler, true);
			Metrics.Index diff = Metrics.compare(badqlog, fixedqlog, 0.1);
			updated.clear();
			updated.addAll(diff);
			HashMap<Metrics.Type, Double> metrics = Metrics.evaluateAll2(qlog,
					ds, badqlog, badds, fixedqlog, fixedds);

			String metric_value = Metrics.toString(metrics);
			long[] time;
			if (solverind == 6)
				time = solver2.getTime();
			else
				time = solution.getTime();
			double[] computetime = new double[time.length];
			for (int j = 0; j < computetime.length; ++j) {
				computetime[j] = time[j] / 1000000000.0;
				if (computetime[j] == 0)
					System.out.print(" ");
			}

			float falsepositivepercentage = (float) 0.1;
			// insert data into result table

			String preprocess = "1";
			String fp = String.valueOf(smcp.size() / cp.size());
			String resultqurey = "INSERT INTO RESULT VALUES (" + run++ + ",6,"
					+ fp + ",'" + solver + "'" + "," + "" + clause_count + ","
					+ qlog_count + "," + tuple_count + ",'" + preprocess + "',"
					+ cp.size() + "," + metric_value + "'" + qidx + "','"
					+ modifiedlist + "'," + "" + computetime[0] + ","
					+ computetime[1] + "," + computetime[2] + ","
					+ computetime[3] + "," + avgconstraint + "," + avgvariable
					+ ")";
			// System.out.println(resultqurey);
			handler.queryExecution(resultqurey);
			// System.out.println(badqlog.size() + ":" + fixedqlog.size() + ":"
			// + ds.size() + ":" + fixedds.size());

			// cp = Complaint.addNoise(cp, badds.get(badds.size()-1),
			// (float)(0.1), (float)(0.0));
		}
		/*
		 * if(solverind != 1) { fixedqlog = solver2.onePassSolution(cplex,
		 * handler, badds, badqlog, complaint, 0.1, 300000, false, options); }
		 * else { fixedqlog = solver2.twoPassSolution(cplex, handler, badds,
		 * badqlog, complaint, 0.1, 300000, false, 1, options); }
		 */

		// Linearization linearizesolver = new Linearization(0);
		// Complaint rollback = new Complaint();
		// linearizesolver.solve(cplex, table, badqlog, badds, complaint,
		// fixedqlog, rollback);
		/*
		 * if(percentage < 1){ complaint =
		 * complaint.getPart(complaintpercentage); fixedqlog =
		 * instance.solveIncomplete(cplex, badqlog, ds, badds, complaint); }
		 * else fixedqlog = instance.solve(cplex, badqlog, ds, badds,
		 * complaint);
		 */

		// get metrics
		// long[] computetime = instance.computeTime();

		// get metrics

		dataout.write("query log, bad query log, fixed query log ");
		dataout.newLine();
		for (int i = 0; i < qlog.size(); ++i) {
			dataout.write(qlog.get(i) + "," + badqlog.get(i) + ","
					+ fixedqlog.get(i));
			dataout.newLine();
		}
		dataout.close();

	}
}
