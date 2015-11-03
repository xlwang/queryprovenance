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

public class Harness extends HarnessBase {

	Table table = null;

	public class HarnessParams {
		HarnessParams() {
		}

		HarnessParams(int max_, int n_a_, int n_q_, int n_t_, double p_,
				int n_c_) {
			domain_max = max_;
			num_attr = n_a_;
			num_queries = n_q_;
			num_tuple = n_t_;
			percentage = p_;
			num_clause = n_c_;
		}

		int domain_max = 50;
		int num_attr = 10;
		int num_queries = 10;
		int num_tuple = 100;
		double percentage = 1;
		int num_clause = 1;

	}

	HarnessParams harness_params = new HarnessParams();

	public static void main(String[] args) throws Exception {
		String dir = "/Users/xlwang/2015/projects/queryprov/code/queryprovenance/queryprovenance/";
		IloCplex cplex = new IloCplex();
		// cplex.setParam(IloCplex.IntParam.PrePass, 0);
		

		DatabaseHandler handler = new DatabaseHandler();
		handler.getConnected(dir + "/dbconn.config");
		// handler.executePrepFile(dir + "/data/inserts.sql");
		handler.executePrepFile(dir + "/data/result.sql");
		
		// problem def. 
		int[] clause_count = { 1 };
		int[] qlog_count = {10, 50, 100, 500, 1000};
		int[] tuple_count = {500};
		int[] attr_count = {10};
		
		double[] num_solve_attr = {0, 0.5, 1};
		String[] num_solve_attr_name = {"single_attr", "half_attr", "full_attr"};
		int[] preproc = {0, 1};
		
		int num_run = 10;
		for (int n_q : qlog_count) {
			for (int n_t : tuple_count) {
				for(int n_c : clause_count) {
					for (int n_a : attr_count) {
						// Construct problem
						Harness harness = new Harness();
						harness.harness_params.num_queries = n_q;
						harness.harness_params.num_tuple = n_t;
						harness.harness_params.num_clause = n_c;
						harness.harness_params.num_attr = n_a;
						
						for(int run = 0; run < num_run; ++run) {
							harness.randomInstance(dir, handler);
							
							// define solution
							for(int i = 0; i < num_solve_attr.length; ++i) {
								double n_s_a = num_solve_attr[i];
								String n_s_a_n = num_solve_attr_name[i];
								for(int p_p : preproc) {
									harness.prob_params.niterations = 2;
									harness.fix_params.attr_per_iteration = (int) (harness.harness_params.num_attr*n_s_a);
									harness.fix_params.attr_per_iteration = harness.fix_params.attr_per_iteration > 0 ? harness.fix_params.attr_per_iteration : 1;
									
									harness.fix_params.pre_proc = p_p == 1;
									String solver_name = "new_alg_" + n_s_a_n;
									harness.singleRun(handler, cplex, solver_name);
								}
							}
						}
					}
				}
			}			
		}
	}

	public int randomInstance(String dir, DatabaseHandler handler)
			throws Exception {

		// TODO: somehow generate initial dataset
		ExpParams params = ExpParams.instance();
		// Add table def.
		String[] attr_def = new String[harness_params.num_attr];
		Table.Type[] types = new Table.Type[harness_params.num_attr];
		Object[] domains = new Object[harness_params.num_attr];
		String[] cols = new String[harness_params.num_attr];
		for (int i = 0; i < harness_params.num_attr; ++i) {
			attr_def[i] = "a" + String.valueOf(i) + "\t INT ";
			cols[i] = "a" + String.valueOf(i);
			types[i] = Table.Type.NUM;
			domains[i] = new long[] { 0, harness_params.domain_max };
		}
		// generate data
		DataGenerator.generatorData(harness_params.num_tuple, attr_def,
				harness_params.domain_max);
		handler.executePrepFile(dir + "/data/inserts.sql");

		table = Table.tableFromDB(handler, "synth");
		params.table = table;
		params.ql_nqueries = harness_params.num_queries;
		params.ql_nclauses = harness_params.num_clause;

		// correct query log
		cleanQueries = QueryLog.generate(params, table.getColumns(), 10);
		cleanDss = cleanQueries.execute(table.getName(), "clean", handler,
				false);
		params.qlog = cleanQueries;
		params.ql_qtypes = new Query.Type[cleanQueries.size()];
		for (int qidx = 0; qidx < cleanQueries.size(); ++qidx) {
			params.ql_qtypes[qidx] = cleanQueries.get(qidx).getType();
		}

		// System.out.println("Transformation: ");
		Transform trans = new Transform(cleanQueries.size());
		trans.generate(params, cleanQueries, harness_params.percentage);
		dirtyQueries = trans.apply(cleanQueries);
		// System.out.println("Wrong Query Log: ");
		dirtyDss = dirtyQueries.execute(table.getName(), "dirty", handler,
				false);

		// get complaint set: good ds vs. bad ds
		complaints = new Complaint(cleanDss.get(cleanDss.size() - 1),
				dirtyDss.get(dirtyDss.size() - 1));

		while (complaints.size() < 1) {
			trans.generate(params, cleanQueries, harness_params.percentage);

			dirtyQueries = trans.apply(cleanQueries);
			dirtyDss = dirtyQueries.execute(table.getName(), "dirty", handler,
					false);

			complaints = new Complaint(cleanDss.get(cleanDss.size() - 1),
					dirtyDss.get(dirtyDss.size() - 1));

			System.out.print(complaints.size() + " ");
		}
		cleanDss.loadPartial(complaints);
		dirtyDss.loadPartial(complaints);

		if (trans.qidx >= 0) {
			String cleanqparam = String.format(
					"DEFAULT, %d, %d, '%s', '%s', 'clean', "
							+ "'%s', '%s', '%s', '%s', '%s'",
					harness_params.num_queries, trans.qidx, table.getName()
							+ "_clean_" + trans.qidx, table.getName()
							+ "_clean_" + String.valueOf(trans.qidx + 1),
					trans.type, "", "", "", cleanQueries.get(trans.qidx));
			String dirtyqparam = String.format(
					"DEFAULT, %d, %d, '%s', '%s', 'dirty', "
							+ "'%s', '%s', '%s', '%s', '%s'",
					harness_params.num_queries, trans.qidx, table.getName()
							+ "_dirty_" + trans.qidx, table.getName()
							+ "_dirty_" + String.valueOf(trans.qidx + 1),
					trans.type, "", "", "", dirtyQueries.get(trans.qidx));
			String cleanq = String.format("INSERT INTO qlogs VALUES(%s)",
					cleanqparam);
			String dirtyq = String.format("INSERT INTO qlogs VALUES(%s)",
					dirtyqparam);
			handler.updateExecution(cleanq);
			handler.updateExecution(dirtyq);
		}
		return trans.qidx;
	}

	public void computeMetrics(DatabaseHandler handler, String solver_name, QueryLog fixedqlog,
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
		
		// insert data into result table
		String params = String
				.format("DEFAULT, %d, %f, '%s', %d, %d, %d, %d, %d, %d, %f, %f,'%s', '%s', %f, %f, %f, %f, %f, %d, %d",
						harness_params.num_attr, prob_params.p_fp, solver_name,
						harness_params.num_clause, harness_params.num_queries,
						harness_params.num_tuple,
						(int) (fix_params.pre_proc == true ? 1 : 0), complaints.size(),
						metrics.get(Metrics.Type.FIXEDCOMPLAINT).intValue(),
						metrics.get(Metrics.Type.REMOVEDRATE), metrics
								.get(Metrics.Type.NOISERATE), "", "",
						computetime[0], computetime[1], computetime[2],
						computetime[3], computetime[4], solver2.avgconstraint,
						solver2.avgvariable);

		String q = String.format("INSERT INTO result VALUES(%s)", params);
		handler.updateExecution(q);
	}

	public void singleRun(DatabaseHandler handler, IloCplex cplex,
			String solver_name) throws Exception {
		QueryLog fixedQueries = new QueryLog();

		Complaint _complaints = complaints.clone();
		// sample 10 complaint
		Complaint _complaints_sub = Complaint.getPartial(_complaints,
				prob_params.n_compl);
		// _complaints = Complaint.addNoise(_complaints, handler, fp, fn);

		// define new algorithm
		FixQueryLog solver2 = new FixQueryLog();

		prob_params.p_fn = (double) (_complaints_sub.size() == 0 ? 1.0
				: _complaints_sub.size() / (_complaints.size()+0.0));
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
			computeMetrics(handler, solver_name, fixedQueries, fixedds, solver2,
					complaints, 0);
			// update complaint set
			Complaint newcmp = new Complaint(cleanDss.get(cleanDss.size() - 1),
					fixedds.get(fixedds.size() - 1));
			newcmp = Complaint.getPartial(newcmp, prob_params.n_compl_iter);
			_complaints.addAll(newcmp);

			for (int modified : solver2.modifiedList) {
				String fixedqparam = String.format(
						"DEFAULT, %d, %d, '%s','%s', 'fixed', "
								+ "'%s', '%s', '%s', '%s', '%s'",
						dirtyQueries.size(), modified, table.getName()
								+ "_fixed_" + modified, table.getName()
								+ "_fixed_" + String.valueOf(modified + 1), "",
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
/*
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
		Complaint smcp = Complaint.getPartial(complaint, 20);
		// QueryLog fixedqlog = solver2.onePassSolution(cplex, handler, badds,
		// badqlog, complaint, 0.1, 300000, true, options);
		QueryLog fixedQueries = dirtyQueries;

		DatabaseStates fixedDss;// = fixedqlog.execute(table.getName(), "fixed",
								// handler);
		HashSet<Integer> updated = new HashSet<Integer>();

		FixQueryLogParams params = new FixQueryLogParams();

		for (int i = 0; i < 1; ++i) {

			Solution solver2 = new Solution(handler, dirtyDss, dirtyQueries,
					smcp);
			solver2.setPrint(false);
			FixQueryLog solution = new FixQueryLog();
			solution.initialize(cplex, handler, dirtyDss, dirtyQueries, smcp);
			boolean fpchoice = i == 1;
			String solver = "";
			String modifiedlist = "";
			int avgconstraint = 0, avgvariable = 0;
			switch (solverind) {
			case 0:
				params.attr_per_iteration = 1;
				fixedQueries = solution.fixQueries(cplex, params);
				solver = "newalg1_1";
				modifiedlist = Util.join(solution.modifiedList, ",");
				avgconstraint = solution.avgconstraint;
				avgvariable = solution.avgvariable;
				break;
			case 1:
				fixedQueries = solver2.onePassSolution(cplex, params.epsilon,
						params.M, false, false, 1, options);
				solver = "onepass";
				modifiedlist = Util.join(solver2.modifiedList, ",");
				avgconstraint = solver2.avgconstraint;
				avgvariable = solver2.avgvariable;
				break;
			case 2:
				params.attr_per_iteration = num_attr / 2;
				fixedQueries = solution.fixQueries(cplex, params);
				solver = "newalg1_half";
				modifiedlist = Util.join(solution.modifiedList, ",");
				avgconstraint = solution.avgconstraint;
				avgvariable = solution.avgvariable;
				break;
			case 3:
				params.attr_per_iteration = num_attr;
				fixedQueries = solution.fixQueries(cplex, params);
				solver = "newalg1_full";
				modifiedlist = Util.join(solution.modifiedList, ",");
				avgconstraint = solution.avgconstraint;
				avgvariable = solution.avgvariable;
				break;
			}
			fixedDss = fixedQueries.execute(table.getName(), "fixed", handler,
					false);
			fixedDss.loadPartial(complaint);

			Metrics.Index diff = Metrics.compare(dirtyQueries, fixedQueries,
					0.1);
			updated.clear();
			updated.addAll(diff);
			HashMap<Metrics.Type, Double> metrics = Metrics.evaluateAll2(
					cleanQueries, cleanDss, dirtyQueries, dirtyDss,
					fixedQueries, fixedDss);

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
			String fp = String.valueOf(smcp.size() / complaints.size());
			String resultqurey = "INSERT INTO RESULT VALUES (" + run++ + ","
					+ num_attr + "," + fp + ",'" + solver + "'" + "," + ""
					+ clause_count + "," + qlog_count + "," + tuple_count
					+ ",'" + preprocess + "'," + complaints.size() + ","
					+ metric_value + "'" + qidx + "','" + modifiedlist + "',"
					+ "" + computetime[0] + "," + computetime[1] + ","
					+ computetime[2] + "," + computetime[3] + ","
					+ computetime[3] + "," + avgconstraint + "," + avgvariable
					+ ")";
			// System.out.println(resultqurey);
			handler.queryExecution(resultqurey);
			// System.out.println(badqlog.size() + ":" + fixedqlog.size() +
			// ":"
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
		

		// get metrics
		// long[] computetime = instance.computeTime();

		// get metrics
		dataout.write("query log, bad query log, fixed query log ");
		dataout.newLine();
		for (int i = 0; i < cleanQueries.size(); ++i) {
			dataout.write(cleanQueries.get(i) + "," + dirtyQueries.get(i) + ","
					+ fixedQueries.get(i));
			dataout.newLine();
		}
		dataout.close();

	}
*/
}
