package queryprovenance.problemsolution;

// define single complaint
public class SingleComplaint {
	public Integer key;
	public String[] values;
	
	/* initialization */
	SingleComplaint(Integer key_, String[] values_){
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
		String[] vals = values.clone();
		return new SingleComplaint(key, vals);
	}
}
