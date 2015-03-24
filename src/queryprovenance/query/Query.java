package queryprovenance.query;

import ilog.concert.IloNumVar;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import queryprovenance.database.DatabaseState;
import queryprovenance.database.Table;
import queryprovenance.expression.Expression;
import queryprovenance.harness.QueryParams;
import queryprovenance.harness.Util;
import queryprovenance.problemsolution.Complaint;
import queryprovenance.problemsolution.QueryLog;


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
	
	protected Set<Integer> impact; // get impact of the query; should depend on query log
	
	
	public boolean compare(Query query, double epsilon) {
		boolean isSame = true;
		if(type == Query.Type.INSERT) {
			// compare list of values
			isSame &= values.size() == query.values.size();
			for(int i = 0; isSame && i < values.size(); ++i) {
				Double cur = Double.valueOf(values.get(i));
				Double qval = Double.valueOf(query.values.get(i));
				isSame &= Math.abs(cur - qval) < epsilon;
			}
		} else {
			int cursize = set == null ? 0 : set.getSetExprs().size();
			int qsize = query.set == null ? 0 : query.set.getSetExprs().size();
			isSame &= cursize == qsize;
			List<SetExpr> setexprs = set != null ? set.getSetExprs() : null;
			for(int i = 0; isSame && cursize > 0 && i < setexprs.size(); ++i) {
				isSame &= setexprs.get(i).attr.compare(query.set.getSetExprs().get(i).attr) && setexprs.get(i).expr.compare(query.set.getSetExprs().get(i).expr); 
			}
			cursize = where == null ? 0 : where.getWhereExprs().size();
			qsize = query.where == null ? 0 : query.where.getWhereExprs().size();
			List<WhereExpr> whereexprs = where != null ?where.getWhereExprs() : null;
			isSame &= cursize == qsize;
			for(int i = 0; isSame && cursize > 0 && i < whereexprs.size(); ++i) {
				isSame &= whereexprs.get(i).attr_expr.compare(query.where.getWhereExprs().get(i).attr_expr) && whereexprs.get(i).var.compare(query.where.getWhereExprs().get(i).var);
			}
		}
		return isSame;
	}
	//computation time
	protected long[] times = new long[3];
	
	/* initialization */
	public Query(int id){
		this.id = id;
	}
	
	/* initialization */
	public Query(int id, Query.Type type){
		this.id = id;
		this.type = type;
	}
	
	/* initialization */
	public Query(int id, Select select, Table from, WhereClause where) {
		this.id = id;
		this.select = select;
		this.from = from;
		this.where = where;
		this.type = Type.SELECT;
	}
	
	/* replace fixed paramters */
	public void fix(HashMap<IloNumVar, Double> fixedmap, HashMap<Expression, IloNumVar> expressionmap) throws Exception {
		if(set != null)
			set.fix(fixedmap, expressionmap);
		if(where != null)
			where.fix(fixedmap, expressionmap);
	}
	
	public void fixInsert(HashMap<IloNumVar, Double> fixedmap, HashMap<List<String>, IloNumVar[]> insrtmap) throws Exception {
		if(insrtmap.containsKey(this.values)) {
			IloNumVar[] vars = insrtmap.get(this.values);
			List<String> temp = new ArrayList<String>();
			for(int i = 0; i < vars.length; ++i) {
				IloNumVar var = vars[i];
				Double corval = fixedmap.get(var);
				temp.add(String.valueOf(corval));
			}
			this.values = temp;
		}
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
	
	/* initialization */
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
			l.add("VALUES(" + Util.join(values, ",") + ")"); // XXX: assumes numeric vals 
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
	/* sove single query: imcomplete complaint set */
	public Query solve(CplexHandler cples, DatabaseState pre, DatabaseState bad, Complaint complaint, String[] options) throws Exception{
		return null;
	}
	
	/* compare */
	public boolean equals(Object o) {
		if (o == null) return false;
		if (o instanceof Query) {
			return this.toString() == o.toString();
		}
		return super.equals(o);
	}
	
	/* compare */
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
	
	/* set where clause */
	public void setWhere(WhereClause where) {
		this.where = where;
	}
	
	/* return where clause */
	public WhereClause getWhere(){
		return this.where;
	}
	
	/* set select attributes */
	public Select getSelect() {
		return select;
	}

	/* return select attributes */
	public void setSelect(Select select) {
		this.select = select;
	}

	/* get query type */
	public void setType(Query.Type type) {
		this.type = type;
	}

	/* set set clause */
	public void setSet(SetClause set) {
		this.set = set;
	}
	
	/* return set clause */
	public SetClause getSet(){
		return this.set;
	}

	/* return query type */
	public Query.Type getType(){
		return type;
	}
	
	/* get query id */
	public int getId() {
		return id;
	}
	
	/* set table */
	public Table setTable(Table t) { 
		from = t;
		return from;
	}
	
	/* get table */
	public Table getTable(){
		return from;
	}
	
	/* set values for insert query */
	public void setValue(List<String> values) {
		this.values = values;
	}
	
	/* get values for insert query */
	public List<String> getValue(){
		return this.values;
	}
	
	/* clone query */
	public Query clone() {
	    SetClause newset = null;
	    WhereClause newwhere = null;
	    if (set != null) newset = set.clone();
	    if (where != null) newwhere = where.clone();
	    Query  q = new Query(id, select, newset, from, newwhere, type);
	    q.values = values;
			return q;
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
	
	/* get execution time */
	public long[] getTime(){
		return times;
	}
	
	/* get modified attribute */
	public Set<Integer> calculatImpact(QueryLog qlog, int current, HashMap<Integer, List<Query>> provmap) {
		impact = new HashSet<Integer>();
		HashSet<Integer> partialimpact = new HashSet<Integer>();
		HashSet<Integer> partialdependency = new HashSet<Integer>();
		switch(this.type) {
		case INSERT: 
			for(int i = 0; i < from.getColumns().length; ++i)
				partialimpact.add(i);
			break;
		default:
			// find immediate query impact
			for(int i = 0; i < this.set.getSetExprs().size(); ++i) {
				partialimpact.add(from.getColumnIdx(set.getSetExprs().get(i).getAttr().toString()));
			}
			// find dependencies
			for(int i = 0; i < this.where.getWhereExprs().size(); ++i) {
				List<Expression> variables = this.where.getWhereExprs().get(i).getAttrExpr().getVariable();
				variables.addAll(this.where.getWhereExprs().get(i).getVarExpr().getVariable());
				for(int j = 0; j < variables.size(); ++j) {
					if(from.getColumnIdx(variables.get(j).toString()) >= 0)
						partialdependency.add(from.getColumnIdx(variables.get(j).toString()));
				}
			}
			break;	
		}
		// update impact list
		for(int im : partialimpact) {
			if(provmap.containsKey(im)) {
				List<Query> prov = provmap.get(im);
				for(Query q : prov) {
					impact.addAll(q.getImpact());
				}
			}
		}
		impact.addAll(partialimpact);
		// update provmap
		for(int dep : partialdependency) {
			if(provmap.containsKey(dep)) {
				provmap.get(dep).add(this);
			} else {
				List<Query> templist = new ArrayList<Query>();
				templist.add(this);
				provmap.put(dep, templist);
			}
		}
		return this.impact;
	}
	
	public Set<Integer> getImpact() {
		return this.impact;
	}
}