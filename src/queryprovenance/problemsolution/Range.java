package queryprovenance.problemsolution;


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
	public String toString() {
		return String.valueOf(min) + "_" + String.valueOf(max);
	}
}
