package queryprovenance.problemsolution;

import ilog.cplex.IloCplex;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;

import queryprovenance.database.DatabaseHandler;
import queryprovenance.database.DatabaseState;
import queryprovenance.database.DatabaseStates;
import queryprovenance.query.CplexHandler;
import queryprovenance.query.Query;
import queryprovenance.query.UpdateQuery;

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
	
	/* solve by one pass */
	public QueryLog onePassSolution(IloCplex cplex, DatabaseHandler dbhandler, DatabaseStates badds, QueryLog badqlog, Complaint compset, double epsilon, double M, boolean prepos, boolean feasible, boolean falsepositive, String[] args) throws Exception {
		// define linear solver
		times = new long[]{0,0,0,0};
		Linearization linearsolver = new Linearization(epsilon, M);
		long starttime = System.nanoTime();
		HashSet<Integer> candidate = new HashSet<Integer>();
		//preprocess queries
		if(prepos) {
			PreProcess pre = new PreProcess();
			candidate.addAll(pre.findCandidate(badds, badqlog, compset));
		} else {
			for(int i = 0; i < badqlog.size(); ++i)
				candidate.add(i);
		}
		long endtime = System.nanoTime();
		times[0] = endtime - starttime;
		
		// solve the problem
		QueryLog qlogfix = new QueryLog();
		qlogfix = linearsolver.fixParameters(cplex, badds.get(0).getTable(), badqlog, badds, compset, candidate, 0, badqlog.size());
		
		// copy time
		for(int i = 1; i < linearsolver.getTime().length + 1; ++i) {
			times[i] = linearsolver.getTime()[i-1];
		}
		if(qlogfix != null)
			return qlogfix;
		else
			return badqlog;
	}
	
	/* solve by two passes: cplex or decision tree */
	public QueryLog twoPassSolution(IloCplex cplex, DatabaseHandler dbhandler, DatabaseStates badds, QueryLog badqlog, Complaint compset, double epsilon, double M, boolean prepos, boolean feasible, boolean falsepositive, int steps, String[] args) throws Exception {
		times = new long[]{0,0,0,0};
		// define linear solver
		Linearization linearsolver = new Linearization(epsilon, M);
		// check inputs
		if(badqlog.size() != badds.size()-1)
			return null;
		// preprocess
		HashSet<Integer> candidate = new HashSet<Integer>();
		//preprocess queries
		long starttime = System.nanoTime();
		if(prepos) {
			PreProcess pre = new PreProcess();
			candidate.addAll(pre.findCandidate(badds, badqlog, compset));
		} else {
			for(int i = 0; i < badqlog.size(); ++i)
				candidate.add(i);
		}
		long endtime = System.nanoTime();
		times[0] = endtime - starttime;
		
		// sort the candidate queries. start from last one
		Integer[] candlist = new Integer[candidate.size()];
		candlist = candidate.toArray(candlist);
		Arrays.sort(candlist);
		boolean fixed = false;
		ArrayList<QueryLog> fixes = new ArrayList<QueryLog>();
		// start the fix
		Complaint precompset = compset;
		int last = badqlog.size();
		for(int i = candlist.length - 1; i >= 0 && !fixed; --i) {
			// for each candidate query
			int idx = candlist[i];
			// rollback
			Complaint rolledback = linearsolver.rollBack(cplex, badds.get(0).getTable(), badqlog, badds, precompset, steps, idx + 1, last);
			last = idx;
			// solve the problem
			QueryLog curfix = linearsolver.fixParameters(cplex, badds.get(0).getTable(), badqlog, badds, rolledback, candidate, idx, idx + 1);
			
			if(curfix != null) {
				QueryLog fix = (QueryLog) badqlog.subList(0, idx);
				fix.addAll(curfix);
				fix.addAll(badqlog.subList(idx + 1, badqlog.size()));
				fixes.add(fix);
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
			qlogfix = badqlog;
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
		
		String configfile = null, tablename = null, dir = null;
		int solution = 1; // default, one pass solution,
		int steps = 1; // default, steps for two passes solution
		double epsilon = 0.0001, M = 1000000.0;
		boolean preprocess = true; // true: do preprocess; false no preprocess
		boolean feasible = false; // do not relax constraints
		boolean falsepositive = false; // do not prune false positives
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
						+ "-AP: use approximation if cplex is infeasible");
			}
			i++;
		}
		if(configfile == null || tablename == null || dir == null)
			throw new IllegalArgumentException("Not enough input parameters. ");
		// start the work
		// prepare the problem: 
		Solution solver = new Solution();
		
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
		
		// solve 
		if(solution == 1) {
			fixedqlog = solver.onePassSolution(cplex, dbhandler, badds, badqlog, compset, epsilon, M, preprocess, feasible, falsepositive, args);
		} else {
			fixedqlog = solver.twoPassSolution(cplex, dbhandler, badds, badqlog, compset, epsilon, M, preprocess, feasible, falsepositive, steps, args);
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
 }
