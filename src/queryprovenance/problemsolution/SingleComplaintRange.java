package queryprovenance.problemsolution;

public class SingleComplaintRange {
	public class Range {
		double min, max;
		
		public Range() {
			min = Double.MIN_VALUE;
			max = Double.MAX_VALUE;
		}
		public Range(double min_, double max_) {
			min = min_;
			max = max_;
		}
		public Range clone() {
			return new Range(min, max);
		}
	}
	
	public Integer key;
	public Range[] values;
	
	/* initialization */
	public SingleComplaintRange(Integer key_, Range[] values_){
		key = key_;
		values = values_;
	}
	
	public SingleComplaintRange(SingleComplaint comp) {
		key = comp.key;
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
