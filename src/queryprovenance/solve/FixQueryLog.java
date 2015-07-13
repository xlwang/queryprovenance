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
import queryprovenance.expression.VariableExpression;
import queryprovenance.harness.Metrics;
import queryprovenance.problemsolution.Complaint;
import queryprovenance.problemsolution.PreProcess;
import queryprovenance.problemsolution.QueryLog;
import queryprovenance.problemsolution.SingleComplaint;
import queryprovenance.query.Query;

public class FixQueryLog {

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

	public List<Integer> modifiedList = new ArrayList<Integer>();
	public int avgconstraint = 0;
	public int avgvariable = 0;

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
				HashMap<String, varX> varXList = query.querySAT(cplex, badDss
						.get(i).getTuple(scp.key).values);
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
	 * */
	public QueryLog fixQueries(IloCplex cplex, FixQueryLogParams params)
			throws Exception {
		times = new long[4];
		// define initial database state
		DatabaseState badInitialDs = badDss.get(0);
		// define attribute provenance
		long starttime = System.nanoTime();
		// preprocess the querylog
		HashSet<Integer> candidate = preprocess(true);
		Integer[] sortedcandidate = new Integer[candidate.size()];
		sortedcandidate = candidate.toArray(sortedcandidate);
		Arrays.sort(sortedcandidate);

		AttributeProvenance attrprov = new AttributeProvenance(fixedQueries,
				candidate);
		long endtime = System.nanoTime();
		// record time
		times[0] += endtime - starttime;

		HashSet<varQuery> bestfix = null;
		HashMap<Query, varX> bestrm = null;
		double bestobj = Double.MAX_VALUE;

		// divide the problem by batches
		// count number of times call linearization solver
		int counttime = 0;
		for (int i = sortedcandidate.length - 1; i >= 0; i = i
				- params.batch_per_iteration) { // batch of 2
			// add candidate set, only include the current query
			int startidx = sortedcandidate[i];
			HashSet<Integer> queryToFix = new HashSet<Integer>();
			for (int j = 0; j < params.batch_per_iteration && i - j >= 0; ++j) {
				queryToFix.add(sortedcandidate[i - j]);
				startidx = sortedcandidate[i - j];
			}
			// define linearization solver
			Linearization linearization = new Linearization(badDss,
					fixedQueries, complaints, varQMap, varXMap, queryToFix,
					params);

			// divide problem by attribute
			int processed = 0;
			HashMap<VariableExpression, varQuery> current = null;

			while (processed < attrprov.sortedAttributes.size()) {
				// solve for current attributes
				int attrsnum = processed + params.attr_per_iteration < attrprov.sortedAttributes
						.size() ? processed + params.attr_per_iteration
						: attrprov.sortedAttributes.size();

				current = linearization.fixParameters(cplex,
						attrprov.sortedAttributes.subList(processed, attrsnum),
						times, startidx);

				// add processed
				processed += params.attr_per_iteration;
				// record constraint and variable amount
				avgconstraint += linearization.cplexConstraints.size();
				avgvariable += linearization.linearization_procs.num_cplex_var;
				counttime++;

				if (current == null
						|| (!params.fix_all_attr && linearization.linearization_procs.stop_procs)) {
					break;
				}

			}
			// check if current fix is valid
			if (current != null && linearization.getObjective() < bestobj
					&& linearization.getObjective() > 0) {
				bestfix = linearization.querySolvedVar;
				bestrm = linearization.queryRemoveList;
				bestobj = linearization.getObjective();
			}
		}
		starttime = System.nanoTime();
		if (bestfix != null)
			fixedQueries = updateFix(bestfix, bestrm);
		endtime = System.nanoTime();
		times[3] += endtime - starttime;
		// finish all the attributes, solve remaining unsolved variables
		// update average number of constraints and variables
		avgconstraint = avgconstraint / counttime;
		avgvariable = avgvariable / counttime;
		return fixedQueries;
	}

	// preprocess the problem
	public HashSet<Integer> preprocess(boolean preproc) {
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
					//		+ " modificedvalue:" + var.expr.getValue() + "->"
					//		+ var.fixedval);
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
