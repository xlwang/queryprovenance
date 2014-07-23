package queryprovenance.problemsolution;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashSet;

import queryprovenance.query.Partition;
import queryprovenance.query.Query;

public class DatabaseState {
	public ResultSet state;
	String[] columnNames;	
	//boolean[] columnKey;
	String statequery;
	HashSet<String> primaryKey;
	ArrayList<String> tablenames;
	public DatabaseState(DatabaseHandler database, Query query) throws Exception{
		tablenames = query.getTables();
		primaryKey = new HashSet<String>();
		
		DatabaseMetaData dbmd = database.getMetaData();
		if(tablenames!=null&&tablenames.size()>0){
			statequery = "select * from ";
			for(String tabname:tablenames){
				statequery = statequery + tabname +",";
				ResultSet tabkeys = dbmd.getPrimaryKeys(
					    null, null, tabname);
				while(tabkeys.next())
					primaryKey.add(tabkeys.getString(4));
			}
			statequery = (String) statequery.subSequence(0, statequery.length()-1);
			statequery = statequery+";";
			state = database.queryExecution(statequery);
		}

		ResultSetMetaData rsmd = (ResultSetMetaData) state.getMetaData();
		int columncount = rsmd.getColumnCount();
		columnNames = new String[columncount];
		//columnKey = new boolean[columncount];
		for(int i=1; i<=columncount; ++i){
			columnNames[i-1] = rsmd.getColumnLabel(i);
			//columnKey[i-1] = rsmd.isAutoIncrement(i);
		}

	}
	public String getCheckQuery(String[] data){
		if(data.length!=columnNames.length)
			return null;
		String checkquery = statequery.substring(0,statequery.length()-1) + getCheckCondition(data);
		return checkquery;
	}
	
	public String getCheckCondition(String[] data){
		String checkcondition = " where ";
		for(int i=0;i<columnNames.length;++i){
			if(primaryKey.contains(columnNames[i]))
				checkcondition = checkcondition+columnNames[i]+"="+data[i]+" and ";
		}
		checkcondition = checkcondition.substring(0, checkcondition.length()-4)+";";
		return checkcondition;
	}
	public ResultSet getState(){
		return state;
	}
	
	public String[] getColumnNames(){
		return columnNames;
	}
	
	public boolean next() throws SQLException{
		return state.next();
	}
	
	public int getRow() throws SQLException{
		return state.getRow();
	}
	public Object getObject(int i) throws SQLException{
		return state.getObject(i);
	}
	public String[] getColumns() throws SQLException{
		String[] values = new String[columnNames.length];
		for(int i=1; i<=columnNames.length; ++i)
			values[i-1] = state.getString(i);
		return values;
	}
}
