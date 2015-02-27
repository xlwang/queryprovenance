package queryprovenance.database;

import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Set;

import queryprovenance.harness.Util;
import queryprovenance.problemsolution.Complaint;
import queryprovenance.problemsolution.SingleComplaint;

public class DatabaseState {

		//private ResultSet state; // tuple values in this state
		private HashMap<Integer, Tuple> state; 
		private Table table;
		
		public DatabaseState(DatabaseState ds) throws Exception {
			state = new HashMap<Integer, Tuple>();
			for (Integer pk : ds.state.keySet()) {
				ds.state.put(pk, ds.state.get(pk).clone());
			}
			
			table = ds.table.clone();
		}
		
		/* initialize database state*/
		public DatabaseState(DatabaseHandler database, Table table) throws Exception{
			
			state = new HashMap<Integer, Tuple>(); // initialize state information
			this.table = table;
			
			ResultSet result;
			if(table.getName() !=null) {

				// get state query prepared
				String state_query = "select * from "+table.getName()+";";
				
				// execute the state query and get returned result set
				result = database.queryExecution(state_query);
				
				// get table information
				ResultSetMetaData rsmd = (ResultSetMetaData) result.getMetaData();
				int columncount = rsmd.getColumnCount();
				HashMap<String, Integer> column_map = new HashMap<String, Integer>();
				for(int i=1; i<=columncount; ++i){
					column_map.put(rsmd.getColumnLabel(i), i);
				}
				
				// prepare state information
				while(result.next()){
					Tuple tuple = new Tuple(columncount);
					for(int i = 0; i < table.getColumns().length; ++i) {
						tuple.setValue(i, result.getString(column_map.get(table.getColumns()[i])));
					}
					state.put(Integer.valueOf(tuple.getValue(table.getKeyIdx())), tuple);
				}			
			}
		}
		
		/* initialize database state given table name */ 
		/* initialize database state*/
		public DatabaseState(DatabaseHandler database, String tablename) throws Exception{
			
			state = new HashMap<Integer, Tuple>(); // initialize state information
			
			ResultSet result;
			if(tablename!=null) {

				// get state query prepared
				String state_query = "select * from " + tablename;
				
				// retrieve primary key in this table
				DatabaseMetaData dbmd = database.getMetaData(); 
				ResultSet tabkeys = dbmd.getPrimaryKeys(null, null, tablename.toLowerCase());  
				String tablekey = "";
				while(tabkeys.next()){
					tablekey = tabkeys.getString(4);
				}
				
				// execute the state query and get returned result set
				result = database.queryExecution(state_query);
				
				// get table information
				ResultSetMetaData rsmd = (ResultSetMetaData) result.getMetaData();
				int columncount = rsmd.getColumnCount();
				HashMap<String, Integer> column_map = new HashMap<String, Integer>();
				String[] columnnames = new String[columncount];
				int tablekeyidx = -1;
				for(int i=1; i<=columncount; ++i){
					column_map.put(rsmd.getColumnLabel(i), i);
					columnnames[i-1] = rsmd.getColumnLabel(i);
					if(tablekey.equals(columnnames[i-1]))
						tablekeyidx = i-1;
				}
				this.table = new Table(tablename, columnnames, null, null, tablekeyidx);
			
				// prepare state information
				while(result.next()){
					Tuple tuple = new Tuple(columncount);
					for(int i = 0; i < table.getColumns().length; ++i) {
						tuple.setValue(i, result.getString(column_map.get(table.getColumns()[i])));
					}
					state.put(Integer.valueOf(tuple.getValue(table.getKeyIdx())), tuple);
				}			
			}
		}
		
		public void saveToDatabase(DatabaseHandler handler, String tablename) throws Exception {
			StringBuffer fmtsb = new StringBuffer();
			StringBuffer sb = new StringBuffer();
			sb.append(String.format("CREATE SEQUENCE %s_seq MINVALUE %d;", tablename, this.size()+1));
			sb.append(String.format("CREATE TABLE %s (", tablename));
			for (int colidx = 0; colidx < table.size(); colidx++) {
				String col = table.getColumnName(colidx);
				Table.Type type = table.getType(colidx);
				sb.append(col);
				if (type == Table.Type.NUM) {
					if ("id".equals(col)) {
						fmtsb.append("default");
						sb.append(String.format("%s int DEFAULT nextval('%s_seq') NOT NULL", col, tablename));
					}
					else {
						fmtsb.append("%s");
						sb.append(String.format("%s %s ", col, "numeric"));
					}
				} else {
					fmtsb.append("'%s'");
					sb.append(String.format("%s text", col));
				}
				
				if (colidx < table.size()-1) {
					fmtsb.append(", ");
					sb.append(", ");
				}
					
			}
			sb.append(");");
			handler.queryExecution(sb.toString());
			
			List<String>valslist = new ArrayList<String>();
			String valstmpl = String.format("(%s)", fmtsb.toString());
			for (Tuple t : state.values()) {
				valslist.add(String.format(valstmpl, (Object[])t.values));
			}
			String sql = String.format("INSERT INTO %s VALUES %s", tablename, Util.join(valslist, ","));
			handler.queryExecution(sql);
		}
		
		public void clear(){
			this.state.clear();
		}
		
		/* return D*, a correct database state by given a set of complaints*/
		public DatabaseState getTrueState(Complaint complaint_set) throws Exception {
			DatabaseState ds = new DatabaseState(this);
			for (Integer pk : complaint_set.keySet()) {
				SingleComplaint sc = complaint_set.get(pk);
				ds.getTuple(pk).values = sc.values;
			}
			return ds;
		}
		
		/* compose check query of one tuple */
		public String getCheckQuery(String[] data){
			String state_query = "select * from " + table.getName();
			if(data.length != table.getColumns().length) {
				return null;
			}
			// add conditions (key) for current data
			String checkquery = "select * from " + table.getName() + " where " + table.getPrimaryKey() + " = " + data[table.getKeyIdx()];
			return checkquery;
		}
		
		/* compare two database state */
		public HashMap<Integer, String> compare(DatabaseState compare_to_state){
			HashMap<Integer, String> check_list = new HashMap<Integer, String>();
			// for each tuple
			for(Integer key:this.state.keySet()){
				String state_tuple = state.get(key).toString();
				String compare_tuple = state.get(key).toString();
				// check if the tuple values are the same
				if(state_tuple.equals(compare_tuple))
					check_list.put(key, "g");
				else
					check_list.put(key, "b");
			}
			return check_list;
		}
		
		/* compare two database state */
		public boolean isSame(DatabaseState compare_to_state){
			// for each tuple
			for(Integer key:this.state.keySet()){
				String state_tuple = state.get(key).toString();
				String compare_tuple = state.get(key).toString();
				// check if the tuple values are the same
				if(!state_tuple.equals(compare_tuple))
					return false;
			}
			return true;
		}
		
		/* get values for selected column*/
		public String[] getColumn(String column_name){
			String[] result = new String[state.size()];
			int colindex = table.getColumnIdx(column_name);
			if(colindex < 0)
				return null;
			int count = 0;
			for(Tuple tuple : state.values()){
				result[count++] = tuple.getValue(colindex);
			}
			return result;
		}
		
		/* get value for selected feature which is composed by columns */
		public String[] getFeature(String column_name) throws Exception{
			String[] result = new String[state.size()];
			int count = 0;
		    int idx = table.getColumnIdx(column_name);
		    if(idx != -1) {
				for(Integer key : state.keySet()){
					Tuple tuple = state.get(key);
					result[count++] = String.valueOf(tuple.getValue(idx));
				}
		    }
			return result;
		}
		
		/* get value for selected feature which is composed by columns with given key list */
		public String[] getFeature(String column_name, Set<String> tuple_list) throws Exception{
			String[] result = new String[state.size()];
			int count = 0;
			int idx = table.getColumnIdx(column_name);
			if(idx != -1) {
				for(String key : tuple_list){
					Tuple tuple = state.get(key);
					result[count++] = String.valueOf(tuple.getValue(idx));
				}
			}
			return result;
		}
		/* get key set*/
		public Set<Integer> getKeySet(){
			return this.state.keySet();
		}
	 	/* check whether a tuple exists in the state based on its key*/
		public boolean containTuple(Integer key){
			return this.state.containsKey(key);
		}
		
		/* get tuple values*/
		public Tuple getTuple(Integer key){
			if(state.containsKey(key)) {
				return this.state.get(key);
			} else {
				String[] emptyvalue = new String[table.getColumns().length];
				for(int i = 0; i < emptyvalue.length; ++i)
					emptyvalue[i] = String.valueOf(Double.MIN_VALUE);
				Tuple empty = new Tuple(emptyvalue);
				return empty;
			}
		}
		
		/* get tuple values*/
		public String getValue(String key, String column_name){
			Tuple tuple = state.get(key);
			int idx = table.getColumnIdx(column_name);
			if(idx != -1)
				return tuple.getValue(idx);
			return null;
		}
		
		/* get state size*/
		public int size(){
			return state.size();
		}
		
		public boolean equals(DatabaseState o) {
			if (o == null) return false;
			return (new Complaint(this, o)).size() == 0;
		}
		
		/* get primary key set */
		public String getPrimaryKey(){
			return table.getPrimaryKey();
		}
		
		public String[] getColumnNames() {
			return table.getColumns();
		}
		
		/* return table*/
		public Table getTable() {
			return this.table;
		}
	
}


