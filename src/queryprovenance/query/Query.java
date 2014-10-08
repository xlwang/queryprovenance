package queryprovenance.query;

import java.util.ArrayList;
import java.util.List;

import queryprovenance.database.DatabaseState;
import queryprovenance.harness.QueryParams;
import queryprovenance.harness.Util;


public class Query {
	public static enum Type {
		INSERT, DELETE, UPDATE, SELECT, EMPTY
	};
	
	//protected String query; // query content
	protected int id;  // need ID to equate the same query in different qlogs
	protected Query.Type type;
	protected Select select;
	protected SetClause set;
	protected Table from;
	protected WhereClause where;
	protected List<String> values; // values for INSERT query
	protected List<String> attr_names; // attribute names for INSERT query
	
	//computation time
	protected long[] timestamps = new long[4];
	
	
	public Query(int id){
		this.id = id;
	}
	public Query(int id, Query.Type type){
		this.id = id;
		this.type = type;
	}
	public Query(int id, Select select, Table from, WhereClause where) {
		this.id = id;
		this.select = select;
		this.from = from;
		this.where = where;
		this.type = Type.SELECT;
	}
	
	// For UPDATE queries
	public Query(int id, SetClause set, Table from, WhereClause where, Query.Type type_){
		this.id = id;
		// preprocess the query
		this.set = set;
		this.from = from;
		this.where = where;
		this.type = type_;
	}
	// For DELETE query
	public Query(int id, Table from, WhereClause where, Query.Type type_){
		this.id = id;
		// preprocess the query
		this.from = from;
		this.where = where;
		this.type = type_;
	}
	
	// insert query constructor
	public Query(int id, Table from, List<String> values) {
		this.id = id;
		this.type = Type.INSERT;
		this.from = from;
		this.values = values;
	}
	
	public Query(int id, Select select, SetClause set, Table from, WhereClause where, Query.Type type){
		this.id = id;
		this.select = select;
		this.set = set;
		this.from = from;
		this.where = where;
		this.type = type;
	}
	
	
	/* get query initialized */
	public void queryInitialize(){
		System.out.println("type not supported");
	}

	
	/* return original query */
	public String toString(){
		List<String> l = new ArrayList<String>();
		if (type == Type.INSERT) {
			l.add("INSERT INTO");
			l.add(from.toString());
			l.add("VALUES(");
			l.add(Util.join(values, ", "));  //XXX: not exactly right...
			l.add(")");
		} else if (type == Type.DELETE) {
			l.add("DELETE FROM");
			l.add(from.toString());
			l.add("WHERE");
			l.add(where.toString());
		} else if (type == Type.UPDATE) {		
			l.add("UPDATE");
			l.add(from.toString());
			l.add("SET");
			l.add(set.toString());
			l.add("WHERE");
			l.add(where.toString());
		} else  if(type == Type.SELECT) {
			l.add("SELECT");
			l.add(select.toString());
			l.add("FROM");
			l.add(from.toString());
			if (where.toString() != "") {
				l.add("WHERE");
				l.add(where.toString());
			};
		} else
			return "EMPTY";
		return Util.join(l,  " ");
	}
	
	/* solve query by previous database state and next database state*/
	public Query solve(CplexHandler cplex, DatabaseState pre, DatabaseState next, DatabaseState bad, String[] options) throws Exception{
		return null;
	}
	
	public boolean equals(Object o) {
		if (o == null) return false;
		if (o instanceof Query) {
			return this.toString() == o.toString();
		}
		return super.equals(o);
	}
	
	public List<String> difference(Query q) {
		List<String> diffs = new ArrayList<String>();
		if (this.equals(q)) return diffs;
		if (this.type != q.type) {
			diffs.add(this.type.toString());
		}
		
		
		if (this.select != null && q.select != null) {
			diffs.addAll(this.select.difference(q.select));			
		} else if (this.select != null) {
			diffs.addAll(this.select.difference(null));
		} else if (q.select != null) {
			diffs.addAll(q.select.difference(null));
		}

		return diffs;
	}
	
	
	public void setWhere(WhereClause where) {
		this.where = where;
	}
	public Select getSelect() {
		return select;
	}

	public void setSelect(Select select) {
		this.select = select;
	}

	public void setType(Query.Type type) {
		this.type = type;
	}

	public void setSet(SetClause set) {
		this.set = set;
	}

	/* return query type */
	public Query.Type getType(){
		return type;
	}
	
	public int getId() {
		return id;
	}
	
	
	public Table setTable(Table t) { 
		from = t;
		return from;
	}
	
	public Table getTable(){
		return from;
	}
	
	public void setValue(List<String> values) {
		this.values = values;
	}
	
	public List<String> getValue(){
		return this.values;
	}
	public Query clone() {
		Query q = new Query(id, select, set, from, where, type);
		q.values = values;
		return q;
	}
	
	public SetClause getSet(){
		return this.set;
	}
	
	public WhereClause getWhere(){
		return this.where;
	}
	
	/*
	 * Genereate a random Query object.
	 * NOTE: if params doesn't set an id field, the query's 
	 *       id field is initialized to -1
	 */
	public static Query generate(QueryParams params) {
		Query q = null;
		WhereClause clause = WhereClause.generate(params);
		SetClause set = SetClause.generate(params);
		switch(params.queryType) {
		case INSERT:
			// generate values
			q = new Query(-1, params.from, null);
			break;
		case UPDATE:
			q = new Query(-1, set, params.from, clause, Type.UPDATE);
			break;
		case DELETE:
			q = new Query(-1, null, params.from, clause, Type.DELETE);
			break;
		}
		return q;
	}
	
	public long[] getTimeStamps(){
		return timestamps;
	}
}