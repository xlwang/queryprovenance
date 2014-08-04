package queryprovenance.query;


public class Table {
	
	String name;
	String[] columns;
	int keyidx = -1;
	
	public Table(String name, String[] columns, int primaryKeyIdx) {
		this.name = name;
		this.keyidx = primaryKeyIdx;
		this.columns = columns;
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
