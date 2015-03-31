package queryprovenance.problemsolution;

import ilog.cplex.IloCplex;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;

import queryprovenance.database.DatabaseHandler;
import queryprovenance.database.DatabaseState;
import queryprovenance.database.DatabaseStates;
import queryprovenance.database.Table;
import queryprovenance.harness.Metrics;

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
	
	public HashSet<Integer> preprocess(boolean preproc) {
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
			double epsilon, double M, 
			boolean prepos, boolean feasible, 
			boolean falsepositive, boolean oneerror, String[] args) throws Exception {
		// define linear solver
		times = new long[]{0,0,0,0};
		Linearization linearsolver = new Linearization(epsilon, M);
		linearsolver.setPrint(print);
		
		long starttime = System.nanoTime();
		HashSet<Integer> candidate = preprocess(prepos); 
		times[0] = System.nanoTime() - starttime;
		
		// solve the problem
		QueryLog qlogfix = new QueryLog();
		DatabaseState badInitialDs = badDss.get(0);
		if(oneerror) {
			Integer[] candarray = new Integer[candidate.size()];
			candarray = candidate.toArray(candarray);
			Arrays.sort(candarray); // sort the candidates, start from last one
			QueryLog bestfix = null;
			double bestobjvalue = Double.MAX_VALUE;
			for(int i = candarray.length - 1; i >= 0; --i) {
				// prune false positive
				starttime = System.nanoTime();
				if(falsepositive) {
					complaints = FalsePositiveAll.densityFilter(cplex, handler, badDss, badQueries, i, complaints, epsilon, M);
				}
				times[0] += System.nanoTime() - starttime; // add false positive pruning time into pre-process time
				// add candidate set, only include the current query
				int cand = candarray[i];
				HashSet<Integer> curcand = new HashSet<Integer>();
				curcand.add(cand);
				qlogfix = linearsolver.fixParameters(cplex, badInitialDs.getTable(), badQueries, badDss, complaints, curcand, cand, badQueries.size()); // start from current candidate state
				for(int j = 1; j < linearsolver.getTime().length + 1; ++j) {
					times[j] += linearsolver.getTime()[j-1];
				}
				if(qlogfix != null) {
					if(linearsolver.getObjValue() > 0 && (linearsolver.getObjValue() < bestobjvalue)) {
						bestfix = qlogfix;
						bestobjvalue = linearsolver.getObjValue();
					}
				}
			}
			qlogfix = bestfix;
		} else {
			qlogfix = linearsolver.fixParameters(cplex, badInitialDs.getTable(), badQueries, badDss, complaints, candidate, 0, badQueries.size());
			// copy time
			for(int i = 1; i < linearsolver.getTime().length + 1; ++i) {
				times[i] = linearsolver.getTime()[i-1];
			}
		}

		if(qlogfix != null)
			return qlogfix;
		else
			return badQueries;
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
	
	

	
	/* solve by two passes: cplex or decision tree */
	public DatabaseStates rollback(IloCplex cplex, 
			double epsilon, double M, 
			boolean prepos,
			int steps, String[] args) throws Exception {
		
		
		times = new long[]{0,0,0,0};
		// define linear solver
		Linearization linearsolver = new Linearization(epsilon, M);
		
		// preprocess
		long starttime = System.nanoTime();
		HashSet<Integer> candidate = preprocess(prepos);
		times[0] = System.nanoTime() - starttime;
				
		// sort the candidate queries. start from last one
		Integer[] candlist = new Integer[candidate.size()];
		candlist = candidate.toArray(candlist);
		Arrays.sort(candlist);
		
		
		DatabaseState badInitialDs = badDss.get(0);
		Table badInitialTable = badInitialDs.getTable();
		
		if(print) {
		    for(DatabaseState x:badDss) { 
		        System.out.println(x.getTable().getName());
		      }
		  		
		      for (int cand: candlist) {
		        System.out.println(" candlist: " + cand);
		      }
		}
		
		// start the fix
		DatabaseState[] dss = new DatabaseState[badDss.size()];
		if(print) System.out.println("dss states: " + badDss.size());
	    if(print) System.out.println("badq list:  " + badQueries.size());
		Complaint precompset = complaints;
		int last = badQueries.size();
		for(int i = candlist.length - 1; i >= 0; --i) {
			// for each candidate query
			int idx = candlist[i];
			if(print) System.out.println("idx: " + idx + " to " + last);

			Complaint rolledback = linearsolver.rollBack(cplex, badInitialTable, badQueries, badDss, precompset, steps, idx + 0, last);
			DatabaseState fixedDs = badDss.get(idx).getTrueState(rolledback);
			if(print) System.out.println(fixedDs.getTable());
			dss[idx] = fixedDs;
			
			// roll forward the database state to recover the rest of the database states
			QueryLog badQueriesSublist = badQueries.subList(idx, last);
			String tmptablename = String.format("%s_rollback_%d", badInitialTable.getName(), idx);
			fixedDs.saveToDatabase(handler, tmptablename);
			int h = idx+1;
			if(print)  System.out.println("tmptablename " + tmptablename);
			for (DatabaseState ds : badQueriesSublist.execute(tmptablename, handler)) {
				if(print)  System.out.println(" " + h);
				dss[h-1] = ds;
				h++;
			}

			// copy time
			for(int j = 1; j < linearsolver.getTime().length + 1; ++j) 
				times[j] += linearsolver.getTime()[j-1];
			
			last = idx;
			precompset = rolledback;
		}
		
		DatabaseStates fixedDss = new DatabaseStates();
		for (DatabaseState ds : dss) fixedDss.add(ds);

		return fixedDss;
	}
	
	
	/* solve by two passes: cplex or decision tree */
	public QueryLog twoPassSolution(IloCplex cplex, 
			double epsilon, double M, 
			boolean prepos, boolean feasible, boolean falsepositive, 
			int steps, String[] args) throws Exception {
		
		// check inputs
		if(badQueries.size() != badDss.size()-1) {
			return null;
    }

		
		times = new long[]{0,0,0,0};
		// define linear solver
		Linearization linearsolver = new Linearization(epsilon, M);
		
		// preprocess
		long starttime = System.nanoTime();
		HashSet<Integer> candidate = preprocess(prepos);
		times[0] = System.nanoTime() - starttime;
				
		// sort the candidate queries. start from last one
		Integer[] candlist = new Integer[candidate.size()];
		candlist = candidate.toArray(candlist);
		Arrays.sort(candlist);
		DatabaseState badInitialDs = badDss.get(0);
		Table badInitialTable = badInitialDs.getTable();
		
		boolean fixed = false;
		ArrayList<QueryLog> fixes = new ArrayList<QueryLog>();
		
		// start the fix
		Complaint precompset = complaints;
		int last = badQueries.size();
		for(int i = candlist.length - 1; i >= 0 && !fixed; --i) {
			// for each candidate query
			int idx = candlist[i];
			// rollback
			Complaint rolledback = linearsolver.rollBack(cplex, badInitialTable, badQueries, badDss, precompset, steps, idx + 1, last);
			last = idx;
			// solve the problem
			QueryLog curfix = linearsolver.fixParameters(cplex, badInitialTable, badQueries, badDss, rolledback, candidate, idx, idx + 1);
			
			if(curfix != null) {
				fixes.add(curfix);
				break;
			}
			// copy time
			for(int j = 1; j < linearsolver.getTime().length + 1; ++j) {
				times[j] += linearsolver.getTime()[j-1];
			}
			precompset = rolledback;
		}
		
		// find the best fix
		QueryLog qlogfix = new QueryLog();
		if(fixes.size() > 0)
			qlogfix = fixes.get(0);
		else
			qlogfix = badQueries;
		return qlogfix;
	}
	
	public void solve(IloCplex cplex, String[] args) throws Exception {
		// process parameters
		// -F: (mandatory) database configuration file
		// -T: (mandatory) specify table name
		// -PATH: (mandatory) specify the path for querylogs, under the path, there should have two files: "gqlog", bqlog"
		// -S: 1: one pass solution; 2: two passes solution. Default: one pass solution
		// -OP: optimization choice: 0: no preprocess; 1: with preprocess
		// -STEP: for two passes solution only, batch rollback
		// -M: for two passes solution only, 0: cplex; 1: decision tree
		// -E: epsilon, default: 0.0001 
		// -MV: linearize parameter, default 1000000.0
		// -AP: use approximation if cplex is infeasible
		// -PRUNE: prone false positives
		// -ONE: single query error
		// -PRINT: print status
		
		String configfile = null, tablename = null, dir = null;
		int solution = 1; // default, one pass solution,
		int steps = 1; // default, steps for two passes solution
		double epsilon = 0.0001, M = 1000000.0;
		boolean preprocess = true; // true: do preprocess; false no preprocess
		boolean feasible = false; // do not relax constraints
		boolean falsepositive = false; // do not prune false positives
		boolean oneerror = false;
		boolean print = false;
		int i = 0;
		while(i < args.length){
			String op = args[i];
			switch(op){
			case "-F":
				configfile = args[++i];
				break;
			case "-PATH":
				dir = args[++i];
				break;
			case "-AP":
				feasible = true; i++;
				break;
			case "-PRUNE":
				falsepositive = true; i++;
				break;
			case "-S": 
				solution = Integer.valueOf(args[++i]);
				break;
			case "-STEP": 
				steps = Integer.valueOf(args[++i]);
				break;
			case "-OP": 
				preprocess = Integer.valueOf(args[++i]) == 1;
				break;
			case "-T": 
				tablename = args[++i];
				break;
			case "-ONE": 
				oneerror = true; i++;
				break;
			case "-PRINT": 
				print = true; i++;
				break;
			case "-E": 
				try{
					epsilon = Double.parseDouble(args[++i]);
				} catch (Exception e){
					throw new IllegalArgumentException("MILP parameter error: epsilon must be a number. ");
				}
				break;
			case "-MV":
				try{
					M = Double.parseDouble(args[++i]);
				} catch (Exception e){
					throw new IllegalArgumentException("MILP parameter error: M must be a number. ");
				}
				break;
			default: 
				System.out.print("\n Help \n "
						+ "-F: (mandatory) database configuration file \n "
						+ "-PATH: (mandatory) specify the path for querylogs, under the path, there should have two files: goodquerylog, badquerylog \n "
						+ "-T: (mandatory) specify table name"
						+ "-S: 1: one pass solution; 2: two pass solution Default: 1 \n "
						+ "-OP: optimization choice: 0: no preprocess; 1: with preprocess & prunning \n"
						+ "-M: for two pass solution only, 0: cplex; 1: decision tree \n "
						+ "-EP: epsilon, default: 0.0001 \n "
						+ "-MV: linearize parameter, default 1000000.0 \n"
						+ "-AP: use approximation if cplex is infeasible \n"
						+ "-PRUNE: prone false positives \n"
						+ " -ONE: single query error");
			}
			i++;
		}
		if(configfile == null || tablename == null || dir == null)
			throw new IllegalArgumentException("Not enough input parameters. ");
		// start the work
		// prepare the problem: 

		
		// connect to database
		DatabaseHandler dbhandler = new DatabaseHandler();
		dbhandler.getConnected(configfile);
		
		// get query log
		QueryLog badqlog = this.readQueryLog(dir + "/" + bqlogname);
		QueryLog qlog = this.readQueryLog(dir + "/" + gqlogname);
		QueryLog fixedqlog = null; // get a bad querylog and good querylog
		DatabaseStates ds, badds;
		badds = badqlog.execute(tablename, dbhandler); // get bad querylog
		ds = qlog.execute(tablename, dbhandler); // get correct querylog
		
		// get complaint set
		Complaint compset = new Complaint(ds.get(ds.size()-1), badds.get(badds.size()-1)); // get complaint set
		
		Solution solver = new Solution(dbhandler, badds, badqlog, compset);
		solver.setPrint(print);
		
		// solve 
		if(solution == 1) {
			fixedqlog = solver.onePassSolution(cplex, epsilon, M, preprocess, feasible, falsepositive, oneerror, args);
		} else {
			fixedqlog = solver.twoPassSolution(cplex, epsilon, M, preprocess, feasible, falsepositive, steps, args);
		}
		
		// evaluate 
		DatabaseStates fixedds = fixedqlog.execute(tablename, dbhandler);
		metrics = Metrics.evaluateAll2(qlog, ds, badqlog, badds, fixedqlog, fixedds); // get evaluation 
		
		// save result
		this.writeResult(dbhandler, badqlog, qlog, fixedqlog, dir);
	}
	
	public long[] getTime() {
		return times;
	}
	
	public void setPrint(boolean p_) {
		print = p_;
	}
 }
