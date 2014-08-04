package queryprovenance.query;

import java.util.ArrayList;
import java.util.List;

import queryprovenance.database.DatabaseState;
import queryprovenance.harness.QueryParams;
import queryprovenance.harness.Util;


public class Query {
	public static enum Type {
		INSERT, DELETE, UPDATE, SELECT
	};
	
	//protected String query; // query content
	protected Query.Type type; 
	protected SetClause select;
	protected Table from;
	protected WhereClause where;
	protected List<String> values; // values for INSERT query
	
	public Query(){
	}
	
	/* initialize query with query string and query type*/
	public Query(SetClause select, Table from, WhereClause where, Query.Type type_){
		// preprocess the query
		this.select = select;
		this.from = from;
		this.where = where;
		this.type = type_;
	}
	
	// insert query constructor
	public Query(Table from, List<String> values) {
		this.type = Type.INSERT;
		this.from = from;
		this.values = values;
	}
	
	/* construct query groups*/
	public void construct(){
		// XXX: do we support subqueries?
		/*
		String subquery = query; // current subquery
		for(Partition part:groups){
			if(subquery!=null&&subquery.length()>0)
				subquery = part.getContentSplit(subquery); // process partition into partition name and content sets
			else
				break;
		}
		*/
	}
	/* get query initialized */
	public void queryInitialize(){
		System.out.println("type not supported");
	}

	/* return query type */
	public Query.Type getType(){
		return type;
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
			l.add(select.toString());
			l.add("FROM");
			l.add(from.toString());
			l.add("WHERE");
			l.add(where.toString());
		} else {
			l.add("SELECT");
			l.add(select.toString());
			l.add("FROM");
			l.add(from.toString());
			if (where.toString() != "") {
				l.add("WHERE");
				l.add(where.toString());
			};
		}
		return Util.join(l,  " ");
	}
	
	/* solve query by previous database state and next database state*/
	public Query solve(DatabaseState pre, DatabaseState next, String[] options) throws Exception{
		return null;
	}
	
	public Table setTable(Table t) { 
		from = t;
		return from;
	}
	/* return table names involved in this query*/
	public Table getTable(){
		return from;
		/*
		if(type.equals("insert"))
			for(Partition part:groups)
				if(part.getPartitionName().equals("insert into"))
					return part.getSplitedContent();
		if(type.equals("update"))
			for(Partition part:groups)
				if(part.getPartitionName().equals("update"))
					return part.getSplitedContent();
		if(type.equals("delete"))
			for(Partition part:groups)
				if(part.getPartitionName().equals("delete from"))
					return part.getSplitedContent();
		return null;
		*/
	}
	
	public Query clone() {
		Query q = new Query(select, from, where, type);
		q.values = values;
		return q;
	}
	
	public static Query generate(QueryParams params) {
		Query q = null;
		WhereClause clause = WhereClause.generate(params);
		SetClause set = SetClause.generate(params);
		switch(params.queryType) {
		case INSERT:
			// generate values
			q = new Query(params.from, null);
		case UPDATE:
			q = new Query(set, params.from, clause, Type.UPDATE);
		case DELETE:
			q = new Query(null, params.from, clause, Type.DELETE);
		}
		return q;
	}
}