package queryprovenance.problemsolution;

import java.util.ArrayList;

import queryprovenance.database.Table;
import queryprovenance.harness.Util;

// define single complaint
public class SingleComplaint {
	public String key;
	public String[] values;
	
	/* initialization */
	public SingleComplaint(String key_, String[] values_){
		key = key_;
		values = values_;
	}
	
	/* to String*/
	public String toString() {
		String str = "";
		for(int i = 0; values != null && i < values.length; ++i) {
			str += values[i] + ",";
		}
		return str;
	}
	
	public SingleComplaint clone() {
		String[] vals = null;
    if (values != null) 
      vals = values.clone();
		return new SingleComplaint(key, vals);
	}
	
	public String getConstraint(Table table) {
		ArrayList<String> attrs = table.getPrimaryKey();
		String[] conditions = new String[attrs.size()];
		for(int i = 0; i < attrs.size(); ++i) {
			conditions[i] = attrs.get(i) + " = " + values[table.getColumnIdx(attrs.get(i))];
		}
		return " (" + Util.join(conditions, " and ") + ") ";
	}
}
