package queryprovenance.query;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import queryprovenance.database.DatabaseState;

public class InsertQuery extends Query {
	
	public InsertQuery(int id, Table from, List<String>values) {
		super(id, from, values);
	}
	
	
	/* prepare data for insert query*/
	public HashMap<String, String[]> prepareData(DatabaseState stat){
		HashMap<String, String[]> datavalues = new HashMap<String, String[]>();
		
		// get primary keys
		String keys = super.from.getPrimaryKey();
		String[] column_names;
		
		// get insert column names
		if(super.attr_names == null)
			column_names = super.from.getColumns();
		else{
			column_names = new String[super.attr_names.size()];
			super.attr_names.toArray(column_names);
		}
		
		for(String value:values){
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
					if(keys.equals(column_names[i]))
						key_value = splited_value[i];
				if(stat.containTuple(key_value))
					datavalues.put(key_value, stat.getTuple(key_value));
				else
					datavalues.put(key_value, null);
			}
		}
		return datavalues;
		
	}
	
	/* fix the value content for the insert query */
	public List<String> fixValues(DatabaseState pre, DatabaseState next){
		List<String> fixed_values = new ArrayList<String>();
		// try to fix insert query
		HashMap<String, String[]> prevalues = this.prepareData(pre);
		HashMap<String, String[]> nextvalues = this.prepareData(next);
		
		// update insert query
		if(prevalues.size() == nextvalues.size()){
			for(String key:prevalues.keySet()){
				if(!nextvalues.containsKey(key))
					return null;
				fixed_values.add(getValueStr(nextvalues.get(key)));
			}
		}

		return fixed_values;
	}
	
	/* convert string array of values into single string*/
	public String getValueStr(String[] value){
		String valuestr = "";
		for(String val: value)
			valuestr = valuestr + val + ",";
		valuestr = valuestr.substring(0, valuestr.length()-1);
		return valuestr;
	}
	
	/* solve insert query by previous correct db state and next correct db state, return fixed query or null if not solvable*/
	public Query solve(DatabaseState pre, DatabaseState next, DatabaseState bad, String[] options) throws Exception{
		// check whether this query should be deleted or not
		Query q = clone();
		if(pre.size() == next.size())
			return new Query(q.id);
		else{
			
			List<String> fixed_values = fixValues(pre, next);
			if(fixed_values!= null){
				q.values = fixed_values;
				return q;
			}
			else
				return null;
		}
	}
}
