package queryprovenance.problemsolution;

import ilog.cplex.IloCplex;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;

import queryprovenance.database.DatabaseHandler;
import queryprovenance.database.DatabaseState;
import queryprovenance.database.DatabaseStates;
import queryprovenance.database.Table;
import queryprovenance.falsepositive.FalsePositiveAll;
import queryprovenance.harness.Metrics;

/** @deprecated*/
public class Solution {
	static final String gqlogname = "gqlog"; // filename for good query log
	static final String bqlogname = "bqlog"; // filename for bad query log
	static final String fqlogname = "fqlog"; // filename for fixed query log
	static final String bcompset = "bcomp"; // filename for bad complaint set
	static final String fcompset = "fcomp"; // filename for fixed complaint set
	static final String dataparaname = "datapara"; // filename for the experiment: #tuple, # cardinality, etc.  
	
	long[] times; 
	HashMap<Metrics.Type, Double> metrics;
	String[] datapara;
	
	DatabaseHandler handler;
	DatabaseStates badDss;
	QueryLog badQueries;
	Complaint complaints;
	
	
	public List<Integer> modifiedList = new ArrayList<Integer>();
	public int avgconstraint = 0;
	public int avgvariable = 0;
	
	private boolean print = false;
	
	public Solution(DatabaseHandler dbhandler,DatabaseStates badds, QueryLog badqlog, Complaint compset) {
		this.handler = dbhandler;
		this.badDss = badds;
		this.badQueries = badqlog;
		this.complaints = compset;
	}
			
	
	/* read data generator parameters */
	public void readDataPara(String dir) {
		// to be completed
	}
	/* read query log from file */
	public QueryLog readQueryLog(String path) {
		// to be completed
		return null;
	}
	
	public void writeResult(DatabaseHandler dbhandler, QueryLog badqlog, QueryLog qlog, QueryLog fixedqlog, String dir) {
		// save everything
		// to be completed
		// write metrics, times, dataparas into result table
	}
	
	public HashSet<Integer> preprocess(boolean preproc) throws Exception {
		HashSet<Integer> candidate = new HashSet<Integer>();
		//preprocess queries
		if(preproc) {
			PreProcess pre = new PreProcess();
			candidate.addAll(pre.findCandidate(badDss, badQueries, complaints));
		} 
		if(!preproc || candidate.size() == 0) {
			for(int i = 0; i < badQueries.size(); ++i)
				candidate.add(i);
		}
		return candidate;
	}
	
	/* solve by one pass */
	public QueryLog onePassSolution(IloCplex cplex, 
			double epsilon, double M, boolean feasible, 
			boolean falsepositive, int batch, String[] args) throws Exception {
		// define linear solver
		times = new long[]{0,0,0,0};
		Linearization linearsolver = new Linearization(epsilon, M);
		linearsolver.setPrint(print);
		
		long starttime = System.nanoTime();
		HashSet<Integer> candidate = preprocess(true); 
		times[0] = System.nanoTime() - starttime;
		// record original number of complaints
		int complaintsize = complaints.size();
		Complaint pruned = new Complaint();
		// solve the problem
		QueryLog qlogfix = new QueryLog();
		DatabaseState badInitialDs = badDss.get(0);
		
		
		Integer[] candarray = new Integer[candidate.size()];
		candarray = candidate.toArray(candarray);
		Arrays.sort(candarray); // sort the candidates, start from last one
		QueryLog bestfix = null;
		double bestobjvalue = Double.MAX_VALUE;
		int bestcoverage = 0;
		List<Integer> bestmodified = new ArrayList<Integer>();
		
		// prune false positive at a time
		//if(falsepositive) {
		//	pruned = FalsePositiveAll.densityFilter(cplex, handler, badDss, badQueries, new HashSet<Integer>(Arrays.asList(candarray)), 0, badQueries.size(), complaints, epsilon, M, -1);
		//}
		int counttime = 0;
		for(int i = candarray.length - 1; i >= 0; i = i - batch) { // batch of 2
			// add candidate set, only include the current query
			int cand = candarray[i];
			HashSet<Integer> curcand = new HashSet<Integer>();
			for(int b = 0; b < batch && i - b >= 0; ++b) {
				curcand.add(candarray[i-b]);
				cand = candarray[i - b];
			}
			// prune false positive
			
			if(falsepositive) {
				//starttime = System.nanoTime();
				pruned = FalsePositiveAll.densityFilter(cplex, handler, badDss, badQueries, curcand, cand, candarray[i] + 1, complaints, epsilon, M, -1, times);
				// times[0] += fptime[1]; // add false positive pruning time into pre-process time
				qlogfix = linearsolver.fixParameters(cplex, badInitialDs.getTable(), badQueries, badDss, pruned, curcand, cand, badQueries.size()); // start from current candidate state
			} else {
				qlogfix = linearsolver.fixParameters(cplex, badInitialDs.getTable(), badQueries, badDss, complaints, curcand, cand, badQueries.size()); // start from current candidate state
			}
			
			avgconstraint += linearsolver.avgconstraint;
			avgvariable += linearsolver.avgvariable;
			counttime ++;
			
			for(int j = 1; j < linearsolver.getTime().length + 1; ++j) {
				times[j] += linearsolver.getTime()[j-1];
			}
			if(qlogfix != null) {
				if(falsepositive) { // pick the fix maintain maximum number of complaints; if the same, consider objective value
					//System.out.println("query index: " + i + " complaintcount: " + pruned.size() + " objective value: " + linearsolver.getObjValue());
					if(linearsolver.getObjValue() > 0 && pruned.size() > bestcoverage) {
						bestfix = qlogfix;
						bestcoverage = pruned.size();
						bestobjvalue = linearsolver.getObjValue();
						bestmodified = linearsolver.modifiedList;
					} else if (linearsolver.getObjValue() > 0 && pruned.size() == bestcoverage && (linearsolver.getObjValue() < bestobjvalue)) {
						bestfix = qlogfix;
						bestobjvalue = linearsolver.getObjValue();
						bestmodified = linearsolver.modifiedList;
					}
				} else { // pick the fix with minimum objective value
					if(linearsolver.getObjValue() > 0 && (linearsolver.getObjValue() < bestobjvalue)) {
						//System.out.println("query index: " + i + "  complaintcount: " + complaints.size() + " objective value: " + linearsolver.getObjValue());
						bestfix = qlogfix;
						bestobjvalue = linearsolver.getObjValue();
						bestmodified = linearsolver.modifiedList;
					}
				}
			}
			System.out.print(i + " ");
		}
		System.out.println();
		qlogfix = bestfix;
		this.modifiedList = bestmodified;
		avgconstraint = avgconstraint / counttime;
		avgvariable = avgvariable / counttime;
		
		if(qlogfix != null) {
			return qlogfix;
		} else {
			System.out.print("infeasible");
			return badQueries;
		}
	}
	
	/*
	 * given the true database state (assuming rollback is perfect), 
	 * and that there is only a single query in the query log,
	 * run the fixer algorithm.
	 */
	public QueryLog qfixOnlySolution(IloCplex cplex, DatabaseStates goodDss,
			double epsilon, double M,
			boolean prepos, boolean feasible, boolean fasepositive,
			int steps, String[] args) throws Exception {
		
		times = new long[]{0,0,0,0};
		// define linear solver
		Linearization linearsolver = new Linearization(epsilon, M);
		linearsolver.setPrint(print);
		
		// preprocess
		long starttime = System.nanoTime();
		HashSet<Integer> candidate = preprocess(prepos);
		times[0] = System.nanoTime() - starttime;
		int idx = badQueries.size()-1;
		Table badInitialTable = badDss.get(idx).getTable();
		QueryLog curfix = linearsolver.fixParameters(cplex, badInitialTable, badQueries, badDss, complaints, candidate, idx-1, idx);

		if(curfix != null) 
			return curfix;
					
		return badQueries;
	}
	
	public long[] getTime() {
		return times;
	}
	
	public void setPrint(boolean p_) {
		print = p_;
	}
 }
