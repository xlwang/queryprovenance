package queryprovenance.query;


public class Table {
	public static enum Type {
		STR, NUM  // column types
	}

	int keyidx = -1;
	String name;
	String[] columns;
	Type[] types;

	// each element stores the corresponding column's domain
	// NUM: [minint, maxint]
	// STR: String[] of all possible string values
	Object[] domains;  

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

}
