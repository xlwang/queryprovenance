package queryprovenance.solve;

import ilog.cplex.IloCplex;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import queryprovenance.database.DatabaseHandler;
import queryprovenance.database.DatabaseState;
import queryprovenance.database.DatabaseStates;
import queryprovenance.expression.VariableExpression;
import queryprovenance.harness.Metrics;
import queryprovenance.problemsolution.Complaint;
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

	private boolean print = false; // print flag

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
	public FixQueryLog(IloCplex cplex, DatabaseHandler handler_,
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
		for (Query query : fixedQueries) {
			List<VariableExpression> variables = query.getVariable();
			for (VariableExpression variable : variables) {
				varQMap.put(variable, new varQuery(cplex, variable));
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
	public QueryLog fixQueries(IloCplex cplex, double epsilon, double M,
			int attrcount, int batchsize, boolean falsepositive)
			throws Exception {
		times = new long[4];
		// define initial database state
		DatabaseState badInitialDs = badDss.get(0);
		// define linearization solver
		Linearization linearization = new Linearization(epsilon, M, badDss,
				fixedQueries, complaints, varQMap, varXMap);
		linearization.setPrint(print);
		// define attribute provenance
		long starttime = System.nanoTime();
		AttributeProvenance attrprov = new AttributeProvenance(fixedQueries);
		long endtime = System.nanoTime();
		// record time
		times[0] += endtime - starttime;
		int processed = 0;
		while (processed < attrprov.sortedAttributes.size()) {
			// solve for current attributes
			linearization.fixParameters(cplex, attrprov.sortedAttributes
					.subList(processed,
							processed + attrcount < attrprov.sortedAttributes
									.size() ? processed + attrcount
									: attrprov.sortedAttributes.size()),
					batchsize, times);
			// add processed
			processed += attrcount;
		}
		// finish all the attributes, solve remaining unsolved variables
		// linearization.fixParameters(cplex, attrprov.sortedAttributes,
		// batchsize, times);
		// final process
		varQMap = linearization.varQMap;
		starttime = System.nanoTime();
		updateFix();
		endtime = System.nanoTime();
		times[3] += endtime - starttime;
		return fixedQueries;
	}

	/** Function updateFix : update fixed query log */
	public void updateFix() {
		for (VariableExpression variable : varQMap.keySet()) {
			variable.setVariable(variable, varQMap.get(variable).fixedval);
		}
	}

}
