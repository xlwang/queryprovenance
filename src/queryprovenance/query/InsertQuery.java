package queryprovenance.query;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;

import queryprovenance.database.DatabaseState;

public class InsertQuery extends Query {
	String table_name;
	String[] column_names;
	boolean[] primary_key;
	HashMap<String, String[]> prevalues;
	HashMap<String, String[]> nextvalues;
	
	public InsertQuery(Table from, List<String>values) {
		super(from, values);
	}
	
	
	
	
	/* prepare data for insert query*/
	public HashMap<String, String[]> prepareData(DatabaseState stat){
		HashMap<String, String[]> values = new HashMap<String, String[]>();
		// get primary keys
		HashSet<String> keys = stat.getPrimaryKey();
		// get insert column names
		if(column_names == null)
			column_names = stat.getColumnNames();
		for(Partition part: groups){
			if(part.getPartitionName().equals("values")){
				ArrayList<String> splited_content = part.getSplitedContent();
				for(String value:splited_content){
					value = value.replaceAll("\\(","");
					value = value.replaceAll("\\)","");
					String key_value = "";
					String[] splited_value = value.split(",");
					for(int i=0; i < splited_value.length; ++i)
						splited_value[i] = splited_value[i].trim();
					if(splited_value.length != column_names.length){
						System.out.println("Insert Query Error: column/value not match");
						return null;
					}
					else{
						for(int i = 0; i < column_names.length; ++i)
							if(keys.contains(column_names[i]))
								key_value = key_value + ","+splited_value[i];
						if(stat.containTuple(key_value))
							values.put(key_value, stat.getTuple(key_value));
						else
							values.put(key_value, null);
					}
				}
			}
		}
		return values;
		
	}
	
	/* fix the value content for the insert query */
	public String fixValues(DatabaseState pre, DatabaseState next){
		String fixed_values = "";
		// try to fix insert query
		prevalues = this.prepareData(pre);
		nextvalues = this.prepareData(next);
		if(prevalues.size() == nextvalues.size()){
			for(String key:prevalues.keySet()){
				if(!nextvalues.containsKey(key))
					return null;
				fixed_values = fixed_values + getValueStr(nextvalues.get(key)) + ",";
			}
		}
		fixed_values = fixed_values.substring(0, fixed_values.length()-1);
		
		return fixed_values;
	}
	
	/* convert string array of values into single string*/
	public String getValueStr(String[] value){
		String valuestr = "(";
		for(String val: value)
			valuestr = valuestr + val + ",";
		valuestr = valuestr.substring(0, valuestr.length()-1) + ")";
		return valuestr;
	}
	
	/* solve insert query by previous correct db state and next correct db state, return fixed query or null if not solvable*/
	public Query solve(DatabaseState pre, DatabaseState next, String[] options) throws Exception{
		// check whether this query should be deleted or not
		if(pre.size() == next.size())
			return "DELETE:"+super.query;
		else{
			String fixed_values = fixValues(pre, next);
			String fixed_query = super.query;
			if(fixed_values != null){
				fixed_query = fixed_query.replaceAll("(values.*;)", "values " + fixed_values + ";");
				return fixed_query;
			}
			else
				return null;
		}
	}
}
