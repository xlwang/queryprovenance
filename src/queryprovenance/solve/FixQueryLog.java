package queryprovenance.solve;

import ilog.cplex.IloCplex;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;

import queryprovenance.database.DatabaseHandler;
import queryprovenance.database.DatabaseState;
import queryprovenance.database.DatabaseStates;
import queryprovenance.database.Tuple;
import queryprovenance.expression.VariableExpression;
import queryprovenance.harness.Metrics;
import queryprovenance.problemsolution.Complaint;
import queryprovenance.problemsolution.PreProcess;
import queryprovenance.problemsolution.QueryLog;
import queryprovenance.problemsolution.SingleComplaint;
import queryprovenance.query.Query;

public class FixQueryLog {
	public static final double TIMERATIO = 1000000000.0;
	long[] times;
	HashMap<Metrics.Type, Double> metrics; // evaluation metrics

	DatabaseHandler handler; // database handler
	DatabaseStates badDss; // bad database states
	QueryLog fixedQueries; // bad queries
	Complaint complaints; // complaints

	private HashMap<VariableExpression, varQuery> varQMap = new HashMap<VariableExpression, varQuery>();
	private HashMap<SingleComplaint, ArrayList<HashMap<String, varX>>> varXMap = new HashMap<SingleComplaint, ArrayList<HashMap<String, varX>>>();

	private HashMap<VariableExpression, Integer> varMap = new HashMap<VariableExpression, Integer>();

	private boolean print = false; // print flag

	public HashSet<Integer> modifiedList = new HashSet<Integer>();
	public int avgconstraint = 0;
	public int avgvariable = 0;

	public int num_relv_attr = 0;
	public int num_relv_query = 0;

	public HashSet<String> dirty_attr = new HashSet<String>();

	public static String exps_detail_inset = "INSERT INTO exps_detail VALUES (DEFAULT, %d, %d, %d, %d, %d, %f, %f, %f, '%s')";

	/**
	 * Initialize
	 * 
	 * @param cplex
	 *            IloCplex
	 * @param handler_
	 *            DatabaseHandler
	 * @param badDss_
	 *            Bad database states
	 * @param badQueries_
	 *            Bad query log to fix
	 * @param complaints_
	 *            Complaints
	 * @throws Exception
	 */
	public FixQueryLog() throws Exception {
	}

	public void initialize(IloCplex cplex, DatabaseHandler handler_,
			DatabaseStates badDss_, QueryLog badQueries_, Complaint complaints_)
			throws Exception {
		this.handler = handler_;
		this.badDss = badDss_;
		this.fixedQueries = badQueries_.clone();
		this.complaints = complaints_;

		// initialize varXMap
		for (SingleComplaint scp : complaints.compmap.values()) {
			ArrayList<HashMap<String, varX>> complVarXList = new ArrayList<HashMap<String, varX>>();
			for (int i = 0; i < fixedQueries.size(); ++i) {
				Query query = fixedQueries.get(i);
				HashMap<String, varX> varXList = query.querySAT(cplex, scp,
						badDss.get(i).getTuple(scp.key).values);
				complVarXList.add(varXList);
			}
			varXMap.put(scp, complVarXList);
		}

		// initial varQMap
		for (int i = 0; i < fixedQueries.size(); ++i) {
			Query query = fixedQueries.get(i);
			List<VariableExpression> variables = query.getVariable();
			for (VariableExpression variable : variables) {
				varQMap.put(variable, new varQuery(cplex, variable));
				varMap.put(variable, i);
			}
		}
		// initialize incorrect attributes
		for (SingleComplaint scp : complaints.compmap.values()) {
			Tuple dirty_tuple = badDss.get(badDss.size() - 1).getTuple(scp.key);
			for (String attr : badDss.get(badDss.size() - 1).getTable()
					.getColumns()) {
				Object dirtyobj = dirty_tuple.getValue(badDss
						.get(badDss.size() - 1).getTable().getColumnIdx(attr));
				Object scpobj = scp.values[badDss.get(badDss.size() - 1)
						.getTable().getColumnIdx(attr)];
				if ((dirtyobj == null && scpobj != null)
						|| (dirtyobj != null && scpobj == null)
						|| !dirtyobj.toString().equals(scpobj.toString())) {
					dirty_attr.add(attr);
				}
			}
		}
	}

	/**
	 * Function: fixQueries : fix the query log
	 * 
	 * @param cplex
	 *            IloCplex
	 * @param epsilon
	 *            precision parameter, in [0, 1]
	 * @param M
	 *            precision parameter, greater than domain max
	 * @param attrcount
	 *            control size of sub-problem: number of attributes to consider
	 *            at one time
	 * @param batchsize
	 *            control size of sub-problem: number of queries to solve at one
	 *            time
	 * @param falsepositive
	 *            flag for false positive complaints pruning
	 * @throws Exception
	 */
	public QueryLog fixQueries(IloCplex cplex, FixQueryLogParams params)
			throws Exception {
		times = new long[5];
		// define initial database state
		DatabaseState badInitialDs = badDss.get(0);
		// define attribute provenance
		long starttime = System.nanoTime();
		// preprocess the querylog
		HashSet<Integer> candidate = preprocess(params.pre_proc);

		Integer[] sortedcandidate = new Integer[candidate.size()];
		sortedcandidate = candidate.toArray(sortedcandidate);
		Arrays.sort(sortedcandidate);

		long endtime = System.nanoTime();
		// record time
		times[0] += endtime - starttime;

		HashSet<varQuery> bestfix = null;
		HashMap<Query, varX> bestrm = null;
		double bestobj = Double.MAX_VALUE;

		// divide the problem by batches
		// count number of times call linearization solver
		int num_cplex_prob = 0;
		for (int i = sortedcandidate.length - 1; i >= 0; i = i
				- params.batch_per_iteration) { // batch
												// of
												// 2
			// add candidate set, only include the current query
			int startidx = sortedcandidate[i];
			System.out.println("Index: " + String.valueOf(startidx));
			HashSet<Integer> queryToFix = new HashSet<Integer>();
			for (int j = 0; j < params.batch_per_iteration && i - j >= 0; ++j) {
				queryToFix.add(sortedcandidate[i - j]);
				startidx = sortedcandidate[i - j];
			}
			// get relevant attributes
			AttributeProvenance attrprov = new AttributeProvenance(
					fixedQueries, queryToFix, params.attr_per_iteration,
					params.fix_relv_attr, this.dirty_attr, params.random_num,
					params.objective_attr_impact);

			// define linearization solver
			Linearization linearization = new Linearization(badDss,
					fixedQueries, complaints, varQMap, varXMap, queryToFix,
					params);

			// divide problem by attribute
			int processed = 0;
			HashMap<VariableExpression, varQuery> current = null;

			// record stats
			long[] curtimes = new long[5];
			int curconstraint = 0, curvariable = 0;

			while (processed < attrprov.sortedAttributes.size()) {
				// solve for current attributes

				List<String> cur_attr = null;
				cur_attr = attrprov.getCurIterAttr(queryToFix,
						params.fix_relv_attr, processed,
						params.attr_per_iteration);

				// solve current cplex prob.
				current = linearization.fixParameters(cplex, cur_attr,
						curtimes, startidx);

				// add processed
				processed += cur_attr.size();

				// record constraint and variable amount
				curconstraint += linearization.cplexConstraints.size();
				curvariable += linearization.linearization_procs.num_cplex_var;
				// record relv_attr amount
				this.num_relv_attr += cur_attr.size();
				num_cplex_prob++;

				if ((current == null || (!params.fix_all_attr && linearization.linearization_procs.stop_procs))) {
					break;
				}

			}
			// update stats
			avgconstraint += curconstraint;
			avgvariable += curvariable;
			for (int timeidx = 1; timeidx < 4; ++timeidx) {
				times[timeidx] += curtimes[timeidx];
			}

			// check if current fix is valid
			double objective = linearization.getObjective()
					+ params.objective_attr_impact
					* attrprov.sortedAttributes.size()
					* (this.fixedQueries.size() - startidx);
			if (current != null && objective < bestobj
					&& linearization.getObjective() > 0) {
				bestfix = linearization.querySolvedVar;
				bestrm = linearization.queryRemoveList;
				bestobj = objective;
				//
				if (i < sortedcandidate.length) {
					// print the objective
					System.out.println(String.valueOf(bestobj) + "  ");
				}
			}
			// Record exps details
			int feasible = current != null ? 1 : 0;
			String exps_insert = String.format(exps_detail_inset,
					0 , this.fixedQueries.size(), startidx, feasible,
					curconstraint, (double) (curtimes[1] / TIMERATIO),
					(double) (curtimes[2] / TIMERATIO),
					(double) (curtimes[3] / TIMERATIO), String.valueOf(bestobj));
			handler.updateExecution(exps_insert);
		}
		starttime = System.nanoTime();
		if (bestfix != null)
			fixedQueries = updateFix(bestfix, bestrm);
		endtime = System.nanoTime();
		times[4] += endtime - starttime;
		// finish all the attributes, solve remaining unsolved variables
		// update average number of constraints and variables
		avgconstraint = avgconstraint / num_cplex_prob;
		avgvariable = avgvariable / num_cplex_prob;
		num_relv_attr = num_relv_attr / num_cplex_prob;
		num_relv_query = candidate.size();

		// return result
		return fixedQueries;
	}

	// preprocess the problem
	public HashSet<Integer> preprocess(boolean preproc) throws Exception {
		HashSet<Integer> candidate = new HashSet<Integer>();
		// preprocess queries
		if (preproc) {
			PreProcess pre = new PreProcess();
			candidate.addAll(pre
					.findCandidate(badDss, fixedQueries, complaints));
		}
		if (!preproc || candidate.size() == 0) {
			for (int i = 0; i < fixedQueries.size(); ++i)
				candidate.add(i);
		}
		return candidate;
	}

	// Update fixed query
	public QueryLog updateFix(HashSet<varQuery> bestfix,
			HashMap<Query, varX> bestrm) {
		QueryLog fixed = new QueryLog();
		for (varQuery var : bestfix) {
			if (var.fixedval != Double.MAX_VALUE) {
				if (var.expr.getValue() != var.fixedval) {
					modifiedList.add(varMap.get(var.expr));
					// System.out.println(varMap.get(var.expr).toString()
					// + " modificedvalue:" + var.expr.getValue() + "->"
					// + var.fixedval);
					var.expr.setVariable(var.expr, var.fixedval);
				}
			}
		}
		for (int i = 0; i < fixedQueries.size(); ++i) {
			Query query = fixedQueries.get(i);
			if (bestrm.containsKey(query) && bestrm.get(query).solvedval == 0) {
				modifiedList.add(i);
				continue;
			}
			fixed.add(query);
		}
		return fixed;
	}

	public long[] getTime() {
		return this.times;
	}
}
