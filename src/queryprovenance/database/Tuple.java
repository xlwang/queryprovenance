package queryprovenance.database;

public class Tuple {
	
	public String[] values;
	
	public Tuple(String[] v_) {
		values = v_;
	}
	public Tuple(int count) {
		values = new String[count];
	}
	
	public Tuple(int count, String[] v_) {
		if(v_ == null) {
			values = new String[count];
			for(int i = 0; i < count; ++i) {
				values[i] = String.valueOf(Double.MIN_VALUE);
			}
		} else {
			values = v_;
		}
	}
	
	public void setValue(int idx, String value) {
		values[idx] = value;
	}
	
	public String getValue(int idx) {
		return values[idx];
	}
	
	public String toString() {
		StringBuffer sb = new StringBuffer();
		for(String value : values)
			sb.append(value + ",");
		return sb.toString();
	}
	
	public int size() {
		return values.length;
	}
	
	public String getKey(Table table) {
		return values[table.getKeyIdx()];
	}
} 
