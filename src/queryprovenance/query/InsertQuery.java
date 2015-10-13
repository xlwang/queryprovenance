package queryprovenance.query;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;

import queryprovenance.database.DatabaseState;
import queryprovenance.database.Table;
import queryprovenance.database.Tuple;
import queryprovenance.expression.VariableExpression;

public class InsertQuery extends Query {
	
	long[] timestamps = new long[4];
	public InsertQuery(int id, Table from, List<String>values) {
		super(id, from, values);
	}
	
	public InsertQuery(int id, Table from, List<String> values, List<String> attrs) {
		super(id, from, values, attrs);
	}
	
	
	/* prepare data for insert query*/
	public HashMap<String, Tuple> prepareData(DatabaseState stat){
		HashMap<String, Tuple> datavalues = new HashMap<String, Tuple>();
		
		// get primary keys
		HashSet<String> keys = new HashSet<String>();
		keys.addAll(super.from.getPrimaryKey());
		String[] column_names;
		
		// get insert column names
		if(super.attr_names == null)
			column_names = super.from.getColumns();
		else{
			column_names = new String[super.attr_names.size()];
			super.attr_names.toArray(column_names);
		}
		
		for(VariableExpression val:values){
			String key_value = "";
			String value = String.valueOf(val.getValue());
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
						key_value = splited_value[i] + "\t";
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
		timestamps[0] = System.nanoTime();
		List<String> fixed_values = new ArrayList<String>();
		// try to fix insert query
		HashMap<String, Tuple> prevalues = this.prepareData(pre);
		HashMap<String, Tuple> nextvalues = this.prepareData(next);
		timestamps[1] = System.nanoTime();
		// update insert query
		if(prevalues.size() == nextvalues.size()){
			for(String key:prevalues.keySet()){
				if(!nextvalues.containsKey(key))
					return null;
				fixed_values.add(getValueStr(nextvalues.get(key)));
			}
		}
		timestamps[2] = System.nanoTime();
		timestamps[3] = timestamps[2];
		return fixed_values;
	}
	
	/* convert string array of values into single string*/
	public String getValueStr(Tuple tuple){
		String valuestr = "";
		for(String val: tuple.values)
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
				q.setValue(fixed_values);
				return q;
			}
			else
				return null;
		}
	}
	
	public long[] getTimeStamps(){
		return timestamps;
	}
}
