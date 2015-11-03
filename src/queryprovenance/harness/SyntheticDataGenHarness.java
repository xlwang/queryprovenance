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
public class SyntheticDataGenHarness {

	public static String qlog_insert_sql = "INSERT INTO qlogs VALUES (DEFAULT, %d, %d, %d, '%s', '%s', '%s', '%s', '%s', '%s', '%s')";

	public DatabaseHandler handler;
	public int max_query;
	public int[] test_size; // test size in each test case
	public double percentage;
	public int attr_count, tuple_count, domain_max;
	public int n_clauses;

	public int test_cases;
	
	public int range;
	
	public double query_skewness = 1;

	// Initialization
	public SyntheticDataGenHarness(DatabaseHandler handler_, int max_query_,
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
		range = domain_max / 20;
	}
	
	// Generating all
	public void SyntheticGen() throws Exception {
		// Generating base table
		DataGenerator.generatorData(handler, attr_count, tuple_count,
				domain_max);

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

		// get selected attributes
		int impact_attr_size = (int) (table.getColumns().length * this.query_skewness);
		impact_attr_size = impact_attr_size > 0 ? impact_attr_size : 1;
		String[] impact_attr = new String[impact_attr_size];
		for (int i = 0; i < impact_attr_size; i++) {
			impact_attr[i] = table.getColumns()[i];
		}
		QueryLog cleanQueries = QueryLog.generate(params, impact_attr, range);
		
		// Insert clean Query logs into qlogs
		SaveQueries(handler, "clean", cleanQueries, pid, max_query);
		DatabaseStates cleanDss = cleanQueries.execute(table.getName(), "clean", handler,
				false);
		
		// Generate dirty queries
		for (int i = 0; i < test_size.length; ++i) {
			int test = test_size[i];
			Transform trans = new Transform(test);
			QueryLog dirtyQueries = null;
			Complaint complaints = null;
			DatabaseStates dirtyDss = null;
			
			while (dirtyQueries == null || complaints.size() < 1 || complaints.size() > 10) {
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
		double percentage = 0.8;
		int attr_count = 10, tuple_count = 500, domain_max = 100;
		int n_clauses = 1;

		int test_cases = 10;
		
		DatabaseHandler handler = new DatabaseHandler();
		handler.getConnected(argv[0]);
		handler.executePrepFile(argv[1]);
		
		SyntheticDataGenHarness harness = new SyntheticDataGenHarness(handler, max_query,
				test_size, percentage, attr_count, tuple_count, domain_max, n_clauses, test_cases);
		harness.query_skewness = 0.5;
		harness.SyntheticGen();	
	}

}
