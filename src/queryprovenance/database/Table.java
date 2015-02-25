package queryprovenance.database;


public class Table {
	public static enum Type {
		STR, NUM  // column types
	}

	private int keyidx = -1;
	private String name;
	private String[] columns;
	private Type[] types;

	// each element stores the corresponding column's domain
	// NUM: [minint, maxint]
	// STR: String[] of all possible string values
	private Object[] domains;  

	// should only be used when sure that name is only attribute that is needed
	public Table(String name) {
		this(name, null, null, null, -1);
	}
	
	public Table(String name, String[] columns, Type[] types, Object[] domains, int primaryKeyIdx) {
		this.name = name;
		this.keyidx = primaryKeyIdx;
		this.columns = columns;
		this.types = types;
		this.domains = domains;
	}
	
	public Type getType(int colidx) {
		return this.types[colidx];
	}
	
	public String[] getStrDomain(int colidx) {
		if (getType(colidx) != Type.STR) 
			throw new RuntimeException();
		return (String[])domains[colidx];
	}
	
	public int[] getNumDomain(int colidx) {
		return (int[]) domains[colidx];
	}
	
	public String toString() {
		return name;
	}
	
	public String getName() {
		return name;
	}
	
	public String[] getColumns() {
		return columns;
	}
	
	public String getPrimaryKey() {
		return columns[keyidx];
	}
	
	public void setName(String n_) {
		this.name = n_;
	}
	
	public void setColumns(String[] c_) {
		this.columns = c_;
	}
	public int getKeyIdx() {
		return this.keyidx;
	}
	
	public int getColumnIdx(String column_name) {
		for(int i = 0; i < columns.length; ++i) {
			if (column_name.toLowerCase().equals(columns[i].toLowerCase()))
				return i;
		}
		return -1;
	}

	public String getColumnName(int idx) {
		return this.columns[idx];
	}
	
}
