package queryprovenance.solve;
// Define parameters for FixQueryLog function
public class FixQueryLogParams {
	public FixQueryLogParams(double epsilon_, double M_, int attr_per_iteration_,
			int batch_per_iteration_, boolean flag_falsepositive_,
			boolean print_, boolean objective_full_, int objective_varconstr_ratio_,
			boolean fix_all_query_,
			boolean fix_all_attr_) {
		epsilon = epsilon_;
		M = M_;
		attr_per_iteration = attr_per_iteration_;
		batch_per_iteration = batch_per_iteration_;
		flag_falsepositive = flag_falsepositive_;
		print = print_;
		objective_full = objective_full_;
		fix_all_query = fix_all_query_;
		objective_varconstr_ratio = objective_varconstr_ratio_;
		fix_all_attr = fix_all_attr_;
	}
	// parameters for cplex
	public double epsilon = 0.001;
	public double M = 100000;
	public int precision = (int) Math.pow(10, (double) (String.valueOf(epsilon).length()
			- String.valueOf(epsilon).lastIndexOf(".") - 1));
	// parameters for fix process
	public int attr_per_iteration = 1;
	public int batch_per_iteration = 1;
	public boolean flag_falsepositive = false;	
	// parameters for print option
	public boolean print = false;
	// parameters for fix options
	public boolean objective_full = false;
	public int objective_varconstr_ratio = 10;
	public boolean fix_all_query = false;
	public boolean fix_all_attr = false;
	
}
