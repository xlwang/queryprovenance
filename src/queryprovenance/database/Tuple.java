package queryprovenance.database;

public class Tuple {
	
	public String[] values;
	
	// for dealing with SET clauses
	// this tracks the value ranges that each attribute needs to be within
	public String[][] valueRanges;
	
	public Tuple(String[] v_) {
		values = v_;
		valueRanges = new String[v_.length][2];
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
	
	public Tuple clone() {
		Tuple t = new Tuple(values.clone());
		if (valueRanges != null) {
			for (int i = 0; i < valueRanges.length; i++) {
				t.valueRanges[i] = valueRanges[i].clone();
			}
		}
		return t;
	}
	
	public String getKey(Table table) {
		return values[table.getKeyIdx()];
	}
	
	public boolean compare(String[] v) {
		boolean isSame = true;
		for(int i = 0; i < values.length; ++i) {
			isSame &= values[i].equals(v[i]);
			if(!isSame)
				return false;
		}
		return true;
	}
} 
