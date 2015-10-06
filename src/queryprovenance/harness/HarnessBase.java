package queryprovenance.harness;

import queryprovenance.database.DatabaseHandler;
import queryprovenance.database.DatabaseStates;
import queryprovenance.problemsolution.Complaint;
import queryprovenance.problemsolution.QueryLog;
import queryprovenance.solve.FixQueryLogParams;

public abstract class HarnessBase {
	// Define parameter class for the current problem.
	public class ProbParams {
		public ProbParams() {
		}

		public ProbParams(double p_fp_, double p_fn_, int solvertype_,
				int niterations_) {
			p_fp = p_fp_;
			p_fn = p_fn_;
			solvertype = solvertype_;
			niterations = niterations_;
		}

		public double p_fp;
		public double p_fn;
		public int solvertype = 0;
		public int niterations = 1;
		public int n_compl = 10;
		public int n_compl_iter = 10;
	}
	DatabaseHandler handler = null;
	
	QueryLog cleanQueries = null;
	queryprovenance.problemsolution.QueryLog dirtyQueries = null;
	DatabaseStates cleanDss = null;
	DatabaseStates dirtyDss = null;
	Complaint complaints = null;

	// Define solver parameters.
	public FixQueryLogParams fix_params = new FixQueryLogParams();
	public ProbParams prob_params = new ProbParams();
	
}
