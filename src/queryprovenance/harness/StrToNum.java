package queryprovenance.harness;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;

import queryprovenance.database.DatabaseHandler;
import queryprovenance.database.DatabaseState;
import queryprovenance.database.Tuple;
import queryprovenance.problemsolution.QueryLog;
import queryprovenance.query.Query;

// Convert data from string to numeric value
public class StrToNum {
	public enum AttrType {
		INT, DOUBLE
	};

	// Define conversion table to save converted value
	public static String drop_tables = "DROP TABLE IF EXISTS str_to_num, num_cleanqlogs, %s CASCADE;";
	public static final String table_map = "CREATE TABLE str_to_num (attr_name text, str text, num real);";
	public static final String table_cleanqlogs = "CREATE TABLE num_cleanqlogs ( "
			+ "id            SERIAL, "
			+ "table_names   VARCHAR(400),"
			+ "type           VARCHAR(10), "
			+ "query           TEXT, "
			+ "setc             VARCHAR(250), "
			+ "wherec          VARCHAR(250), "
			+ "vals             VARCHAR(500), "
			+ "attrs             VARCHAR(500));";
	public static String table_basetable = "CREATE TABLE %s (%s);";
	public static String table_basetable_keys= "ALTER table %s ADD primary key (%s)";
	public static String insert_str_to_num = "INSERT INTO str_to_num VALUES (%s, %s, %d)";
	public static String insert_cleanqlogs = "INSERT INTO num_cleanqlogs VALUES (%s, %s, %s, %s, %s, %s, %s, %s)";
	public static String insert_basetable = "INSERT INTO %s VALUES (%s)";

	public static final double RATIO_BOUND = 100;

	protected DatabaseHandler handler;
	// Define output table and querylog
	protected String num_tablename;
	protected QueryLog num_qlog;
	protected DatabaseState numDs;

	// Define functions
	public StrToNum(DatabaseHandler handler_, QueryLog str_qlog_,
			String str_tablename_) throws Exception {
		handler = handler_;
		num_qlog = str_qlog_.clone();
		num_tablename = "num_" + str_tablename_;
		numDs = new DatabaseState(handler, str_tablename_, null);
		// Initialize tables
		drop_tables = String.format(drop_tables, num_tablename);
		handler.updateExecution(drop_tables);
		handler.updateExecution(table_map);
		handler.updateExecution(table_cleanqlogs);
	}

	// Linearize the base table
	public void strToNumPerDbState() throws Exception {
		// convert into integer
		String[] table_attrs = new String[numDs.getTable().getColumns().length];
		String[] keylist = numDs.getTupleKeys();
		for (int i = 0; i < numDs.getTable().getColumns().length; ++i) {
			double ratio = (numDs.getTable().getNumDomain(i)[1] - numDs
					.getTable().getNumDomain(i)[0]) / (numDs.size() + 0.0);
			// Check domain
			strToNumPerAttr(keylist, numDs.getTable().getColumnName(i));
			// Update table def.
			if (numDs.getTable().getKeyIdx().contains(i) || ratio > RATIO_BOUND) {
				table_attrs[i] = numDs.getTable().getColumnName(i) + "\t int";
			} else {
				table_attrs[i] = numDs.getTable().getColumnName(i) + "\t real";
			}
		}
		// Create updated table
		table_basetable = String.format(table_basetable, num_tablename,
				Util.join(table_attrs, ","));
		handler.updateExecution(table_basetable);
		// Update table primary keys
		table_basetable_keys = String.format(table_basetable_keys, num_tablename, Util.join(numDs.getPrimaryKey(), ","));
		handler.updateExecution(table_basetable_keys);
		// Update querylog
		strToNumQlog();
		// Update table
		strToNumTable(keylist);
	}

	// Linearize by attribute name
	public void strToNumPerAttr(String[] keylist, String attr) throws Exception {
		HashMap<String, Integer> attr_value_map = new HashMap<String, Integer>();
		int attr_idx = numDs.getTable().getColumnIdx(attr);
		// Convert attribute from str/long into numeric value
		for (String key : keylist) {
			// Get str tuple
			Tuple num_tuple = numDs.getTuple(key);
			String str_attr_value = num_tuple.getValue(attr_idx);
			if(attr.equals("ui_i_id") && Double.valueOf(str_attr_value) == 178120948056065L) {
				System.out.println(str_attr_value);
			}
			int num_attr_value = -1;
			if (!attr_value_map.containsKey(str_attr_value)) {
				num_attr_value = attr_value_map.size();
				attr_value_map.put(str_attr_value, num_attr_value);
			} else {
				num_attr_value = attr_value_map.get(str_attr_value);
			}
			// Update num tuple
			num_tuple.setValue(attr_idx, String.valueOf(num_attr_value));
		}
		// Update querylog
		for (int i = 0; i < num_qlog.size(); ++i) {
			Query query = num_qlog.get(i);
			query.strToNum(attr_value_map, attr);
		}
		// Insert str-num mapping into mapping table
		for (String str : attr_value_map.keySet()) {
			String mapping = String.format(insert_str_to_num, "'" + attr + "'",
					str, attr_value_map.get(str));
			handler.updateExecution(mapping);
		}
	}

	// Update querylogs in database
	public void strToNumQlog() throws Exception {
		for (Query query : num_qlog) {
			String[] components = new String[4];
			query.queryToJSON(components);
			// update insert querylog
			String insert_cleanqlog = String.format(insert_cleanqlogs,
					"DEFAULT", "'" + num_tablename + "'", "'" + query.getType() + "'",
					"'" + query.toString() + "'", "'" + components[2] + "'",
					"'" + components[3] + "'", "'" + components[0] + "'", "'"
							+ components[1] + "'");
			handler.updateExecution(insert_cleanqlog);
		}
	}

	// Update base table in database
	public void strToNumTable(String[] keylist) throws Exception {
		for (String key : keylist) {
			Tuple num_tuple = numDs.getTuple(key);
			String[] values = new String[numDs.getTable().getColumns().length];
			for (int i = 0; i < numDs.getTable().getColumns().length; ++i) {
				values[i] = num_tuple.getValue(i);
			}
			String insert_tuple = String.format(insert_basetable,
					num_tablename, Util.join(values, ","));
			handler.updateExecution(insert_tuple);
		}
	}

	public static void main(String[] args) throws Exception {
		String dbconfigname = args[0];
		DatabaseHandler handler = new DatabaseHandler();
		handler.getConnected(dbconfigname);

		WorkloadHarness harness = new WorkloadHarness(handler);
		harness.loadQueries(750);
		StrToNum instance = new StrToNum(handler, harness.cleanQueries,
				harness.tablebase);
		instance.strToNumPerDbState();
	}
}
