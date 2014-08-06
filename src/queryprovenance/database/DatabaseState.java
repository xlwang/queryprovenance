package queryprovenance.database;

import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Set;

import javax.script.ScriptEngine;
import javax.script.ScriptEngineManager;

import queryprovenance.problemsolution.Complaint;
import queryprovenance.query.Table;

public class DatabaseState {
	//private ResultSet state; // tuple values in this state
	private HashMap<String, String[]> state; 
	private String[] column_names;	// column/attribute names in the state
	private String state_query; // query to retrieve state from database
	private String primary_key; // primary keys of tuples in this state
	private String table_name; // tables involved in this state
	
	/* initialize database state*/
	public DatabaseState(DatabaseHandler database, Table table) throws Exception{
		
		state = new HashMap<String, String[]>(); // initialize state information
		this.table_name = table.getName();
		primary_key = table.getPrimaryKey(); // get primaryKey from the data
		
		DatabaseMetaData dbmd = database.getMetaData(); // get meta data from the database, initialize primary key, involved column information
		ResultSet result;
		if(table_name !=null) {
			state_query = "select * from "; // initialize state query
			state_query = state_query + table_name +",";

			// get state query prepared
			state_query = "select * from "+table_name+";";
			
			// execute the state query and get returned result set
			result = database.queryExecution(state_query);
			
			// get meta data
			ResultSetMetaData rsmd = (ResultSetMetaData) result.getMetaData();
			int columncount = rsmd.getColumnCount();
			column_names = new String[columncount];
			for(int i=1; i<=columncount; ++i){
				column_names[i-1] = rsmd.getColumnLabel(i);
			}
			// prepare state information
			while(result.next()){
				String[] tuple = new String[columncount];
				String tuplekey = "";
				for(int i = 1; i<=columncount; ++i){
					tuple[i-1] = result.getString(i);
					if(primary_key.equals(column_names[i-1]))
						tuplekey = result.getString(i);
				}
				state.put(tuplekey, tuple);
			}			
		}
	}
	
	public DatabaseState(DatabaseHandler database, String table_name) throws Exception{
		
		state = new HashMap<String, String[]>(); // initialize state information
		this.table_name = table_name;
		HashSet<String> primary_key = new HashSet<String>(); // get primaryKey from the data
		
		DatabaseMetaData dbmd = database.getMetaData(); // get meta data from the database, initialize primary key, involved column information
		ResultSet result;
		if(table_name !=null) {
			state_query = "select * from "; // initialize state query
			state_query = state_query + table_name +",";
			
			// retrieve primary key in this table
			ResultSet tabkeys = dbmd.getPrimaryKeys(null, null, table_name);  
			boolean keyISFound = false;
			while(tabkeys.next()){
				primary_key.add(tabkeys.getString(4));
				keyISFound = true;
			}
			if(!keyISFound){ //if primary key not set for this table, add every column
				ResultSet tabcol = dbmd.getColumns(null, null, table_name, null);
				while(tabcol.next())
					primary_key.add(tabcol.getString("COLUMN_NAME"));
			}

			// get state query prepared
			state_query = (String) state_query.subSequence(0, state_query.length()-1);
			state_query = state_query+";";
			
			// execute the state query and get returned result set
			System.out.println(state_query);
			result = database.queryExecution(state_query);
			
			// get meta data
			ResultSetMetaData rsmd = (ResultSetMetaData) result.getMetaData();
			int columncount = rsmd.getColumnCount();
			column_names = new String[columncount];
			for(int i=1; i<=columncount; ++i){
				column_names[i-1] = rsmd.getColumnLabel(i);
			}
			// prepare state information
			while(result.next()){
				String[] tuple = new String[columncount];
				String tuplekey = "";
				for(int i = 1; i<=columncount; ++i){
					tuple[i-1] = result.getString(i);
					if(primary_key.contains(column_names[i-1]))
						tuplekey = tuplekey +","+result.getString(i);
				}
				state.put(tuplekey, tuple);
			}			
		}
	}


	/* return D*, a correct database state by given a set of complaints*/
	public DatabaseState getTrueState(Complaint complaint_set){
		// to be implemented
		return null;
	}
	
	/* compose check query of one tuple */
	public String getCheckQuery(String[] data){
		if(data.length!=column_names.length)
			return null;
		String checkquery = state_query.substring(0,state_query.length()-1) + getCheckCondition(data);
		return checkquery;
	}
	
	/* compose check conditions given one tuple*/
	public String getCheckCondition(String[] data){
		String checkcondition = " where ";
		for(int i=0;i<column_names.length;++i){
			if(primary_key.contains(column_names[i]))
				checkcondition = checkcondition+column_names[i]+"="+data[i]+" and ";
		}
		checkcondition = checkcondition.substring(0, checkcondition.length()-4)+";";
		return checkcondition;
	}
	
	/* compare two database state */
	public String[] compare(DatabaseState compare_to_state){
		String[] check_list = new String[this.state.size()];
		int count = 0;
		for(String key:this.state.keySet()){
			String[] compare_to_value, value;
			if(compare_to_state.containTuple(key)){
				compare_to_value = compare_to_state.getTuple(key);
				value = state.get(key);
				if(compare_to_value.length == value.length){
					check_list[count] = "g";
					for(int i=0; i< value.length; ++i){
						if(!compare_to_value[i].equals(value[i])){
							check_list[count] = "b";
							break;
						}
					}
				}
				else
					check_list[count] = "g";
			}
			else
				check_list[count] = "b";
			count++;
		}
		return check_list;
	}
	
	/* get values for selected column*/
	public String[] getColumn(String colname){
		String[] result = new String[state.size()];
		int colindex = -1;
		for(int i=0; i<column_names.length; ++i){
			if(colname.equals(column_names[i])){
				colindex = i;
				break;
			}
		}
		if(colindex<0)
			return null;
		int count = 0;
		for(String[] values:state.values()){
			result[count++] = values[colindex];
		}
		return result;
	}
	/* get value for selected feature which is composed by columns */
	public String[] getFeature(String feature_name) throws Exception{
		String[] result = new String[state.size()];
		int count = 0;
		ScriptEngineManager mgr = new ScriptEngineManager();
	    ScriptEngine engine = mgr.getEngineByName("JavaScript");
		for(String key:state.keySet()){
			String[] values = state.get(key);
			String current_feature = feature_name;
			for(int i=0; i< values.length; ++i){
				current_feature = current_feature.replaceAll(column_names[i], values[i]);
			}
			result[count++] = engine.eval(current_feature).toString();
		}
		return result;
	}
	public String[] getFeature(String feature_name, Set<String> key_list) throws Exception{
		String[] result = new String[state.size()];
		int count = 0;
		ScriptEngineManager mgr = new ScriptEngineManager();
	    ScriptEngine engine = mgr.getEngineByName("JavaScript");
		for(String key:key_list){
			String[] values = state.get(key);
			String current_feature = feature_name;
			for(int i=0; i< values.length; ++i){
				current_feature = current_feature.replaceAll(column_names[i], values[i]);
			}
			result[count++] = engine.eval(current_feature).toString();
		}
		return result;
	}
	/* get key set*/
	public Set<String> getKeySet(){
		return this.state.keySet();
	}
 	/* check whether a tuple exists in the state based on its key*/
	public boolean containTuple(String key){
		return this.state.containsKey(key);
	}
	
	/* get tuple values*/
	public String[] getTuple(String key){
		return this.state.get(key);
	}
	
	/* get column/attribute names */
	public String[] getColumnNames(){
		return column_names;
	}
	
	/* get state size*/
	public int size(){
		return state.size();
	}
	
	/* get primary key set */
	public String getPrimaryKey(){
		return this.primary_key;
	}
}
