package queryprovenance.problemsolution;

public class SingleComplaintRange {
	public Integer key;
	public Range[] values;
	
	/* initialization */
	public SingleComplaintRange(Integer key_, Range[] values_){
		key = key_;
		values = values_;
	}
	
	public SingleComplaintRange(SingleComplaint comp) {
		key = comp.key;
		values = new Range[comp.values.length];
		for(int i = 0; i < comp.values.length; ++i) {
			double value = Double.valueOf(comp.values[i]);
			values[i] = new Range(value, value);
		}
	}
	/* to String*/
	public String toString() {
		String str = "";
		for(int i = 0; values != null && i < values.length; ++i) {
			str += values[i] + ",";
		}
		return str;
	}
	
	public SingleComplaintRange clone() {
		Range[] vals = values.clone();
		return new SingleComplaintRange(key, vals);
	}
}
