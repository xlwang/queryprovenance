package queryprovenance.harness;

import queryprovenance.database.DataGenerator;
import queryprovenance.database.DatabaseHandler;
import queryprovenance.database.DatabaseStates;
import queryprovenance.database.Table;
import queryprovenance.problemsolution.Complaint;
import queryprovenance.problemsolution.QueryLog;
import queryprovenance.query.Query;

// Generate synthetic data
// One base table
// k query logs, each of which with 1000 queries
// Generate dirty queries for each test size
public class WorkloadDataGenHarness {

	public static String qlog_insert_sql = "INSERT INTO qlogs VALUES (DEFAULT, %d, %d, %d, '%s', '%s', '%s', '%s', '%s', '%s', '%s')";
	
	public static String clean_qlog_sql = "SELECT qidx, type, vals, attrs, setc, wherec FROM qlogs where pid = %d and "
			+ "mode = 'clean' ORDER BY qidx LIMIT %d;";

	public DatabaseHandler handler;
	public int max_query;
	public int[] test_size; // test size in each test case
	public double percentage;
	public int attr_count, tuple_count, domain_max;
	public int n_clauses;

	public int test_cases;
	
	public int range;
	
	public int max_size = 1000;

	// Initialization
	public WorkloadDataGenHarness(DatabaseHandler handler_, int max_query_,
			int[] test_size_, double percentage_, int attr_count_, int tuple_count_, int domain_max_, int n_clauses_, int test_cases_) {
		handler = handler_;
		max_query = max_query_;
		test_size = test_size_;
		attr_count = attr_count_;
		tuple_count = tuple_count_;
		domain_max = domain_max_;
		percentage = percentage_;
		n_clauses = n_clauses_;
		test_cases = test_cases_;
		range = domain_max / 10;
	}
	
	// Generating all
	public void SyntheticGen() throws Exception {

		for (int test = 0; test < test_cases; test++) {
			SyntheticGen(test);
		}
	}

	// Generating data
	public void SyntheticGen(int pid) throws Exception {
		// Generating queries
		Table table = Table.tableFromDB(handler, "synth");
		ExpParams params = ExpParams.instance();
		params.table = table;

		params.ql_nqueries = max_query;
		params.ql_nclauses = n_clauses;

		String c_qlog_sql = String.format(clean_qlog_sql, pid, max_size);
		
		QueryLog cleanQueries = SyntheticHarness2.loadQueries(handler,
				c_qlog_sql);
		// Insert clean Query logs into qlogs
		DatabaseStates cleanDss = cleanQueries.execute(table.getName(), "clean", handler,
				false);
		
		// Generate dirty queries
		for (int i = 0; i < test_size.length; ++i) {
			int test = test_size[i];
			Transform trans = new Transform(test);
			QueryLog dirtyQueries = null;
			Complaint complaints = null;
			DatabaseStates dirtyDss = null;
			
			while (dirtyQueries == null || complaints.size() < 1 || complaints.size() > 15) {
				trans.generate(params, cleanQueries, percentage);

				dirtyQueries = trans.apply(cleanQueries);
				dirtyDss = dirtyQueries.execute(table.getName(), "dirty", handler,
						false);
				
				// handler.commit();
				
				complaints = new Complaint(cleanDss.get(test),
						dirtyDss.get(test));

				// TODO: remove later
				System.out.print(complaints.size() + " ");
			}
			SaveQueries(handler, "dirty", dirtyQueries, pid, test);
		}
	}
	
	public static void SaveQueries(DatabaseHandler handler, String type, QueryLog queries, int pid, int testsize) throws Exception {
		int qidx = 0;
		for (Query query : queries) {
			String[] components = new String[4];
			query.queryToJSON(components);
			// Prepare insert
			String sql = String.format(qlog_insert_sql, pid, testsize, qidx, type,
					query.getType(), components[0], components[1],
					components[2], components[3], query.toString());
			handler.updateExecution(sql);
			qidx++;
		}
	}
	
	public static void main(String[] argv) throws Exception {
		int max_query = 1000;
		int[] test_size = {10, 50, 100, 500, 1000};
		double percentage = 0.9;
		int attr_count = 10, tuple_count = 500, domain_max = 100;
		int n_clauses = 1;

		int test_cases = 10;
		
		DatabaseHandler handler = new DatabaseHandler();
		handler.getConnected(argv[0]);
		for (int i = 10; i <= 10000; ++i) {
			handler.updateExecution("INSERT INTO qlogs VALUES (DEFAULT, 1,1,1, '1', '1', '1', '1', '1', '1', '1')");
		}
		
		// handler.executePrepFile(argv[1]);
		WorkloadDataGenHarness harness = new WorkloadDataGenHarness(handler, max_query,
				test_size, percentage, attr_count, tuple_count, domain_max, n_clauses, test_cases);
		harness.SyntheticGen();	
	}

}
