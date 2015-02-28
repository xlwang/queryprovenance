package queryprovenance.database;

import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;


public class Table {
	public static enum Type {
		STR, NUM  // column types
	}

	private int keyidx = -1;
	private String name;
	private String[] columns;
	public Type[] types;

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
	
	public Table clone() {
    String[] cols = null;
    if (columns != null) cols = columns.clone();
    Type[] typs = null;
    if (types != null) typs = types.clone();
    Object[] dmns = null;
    if (domains != null) dmns = domains.clone();
		return new Table(name, cols, typs, dmns, keyidx);
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
	
	public int size() {
		return columns.length;
	}
	
	public static Table tableFromDB(DatabaseHandler handler, String tname) throws Exception	{
		Table ret = new Table(tname);
		ResultSet rset = handler.queryExecution("SELECT * FROM " + tname + " LIMIT 0");
		ResultSetMetaData rmd = rset.getMetaData();
		int ncols = rmd.getColumnCount();
		int pkIdx = -1;
		String[] cols = new String[ncols];
		Type[] types = new Type[ncols];
		Object[] domains = new Object[ncols];

		
		for (int i = 0; i < ncols; i++) {
			String col = rmd.getColumnName(i+1);
			cols[i] = col;
			if ("id".equalsIgnoreCase(col)) {
				pkIdx = i;
			}
			int type = rmd.getColumnType(i+1);
			Table.Type realtype = null;
			switch(type) {
			case Types.BIGINT:
			case Types.DECIMAL:
			case Types.INTEGER:
			case Types.DOUBLE:
			case Types.NUMERIC:
			case Types.REAL:
				realtype = Table.Type.NUM;
				break;
			case Types.CHAR:
			case Types.LONGNVARCHAR:
			case Types.LONGVARCHAR:
			case Types.NCHAR:
			case Types.VARCHAR:
				realtype = Table.Type.STR;
				break;
			default:
				throw new RuntimeException(col + " has unknown type: " + type);
			}
			types[i] = realtype;
			
			// get domain information
			if (realtype == Table.Type.NUM) {
				String q = "SELECT min(%s) as min, max(%s) as max FROM %s";
				q = String.format(q, col, col, tname);
				ResultSet rset2 = handler.queryExecution(q);
				rset2.next();
				int[] domain = new int[]{(int)rset2.getFloat(1), (int)rset2.getFloat(2)};
				domains[i] = domain;
			} else {
				String q = "SELECT distinct %s FROM %s";
				q = String.format(q, col, tname);
				ResultSet rset2 = handler.queryExecution(q);
				List<String> strs = new ArrayList<String>();
				while (rset2.next()) {
					strs.add(rset2.getString(1));
				}
				domains[i] = strs.toArray(new String[strs.size()]);
			}
			
		}
		return new Table(tname, cols, types, domains, pkIdx);
	}
	
	
	
	public static void main(String[] args) throws Exception {
		DatabaseHandler handler = new DatabaseHandler();
		handler.getConnected("dbconn.config");
		Table t = tableFromDB(handler, "test");
	}
}
