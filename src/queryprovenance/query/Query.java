package queryprovenance.query;

import ilog.concert.IloNumVar;
import ilog.cplex.IloCplex;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Random;
import java.util.Set;

import queryprovenance.database.DatabaseState;
import queryprovenance.database.Table;
import queryprovenance.expression.Expression;
import queryprovenance.expression.VariableExpression;
import queryprovenance.harness.QueryParams;
import queryprovenance.harness.Util;
import queryprovenance.problemsolution.Complaint;
import queryprovenance.problemsolution.QueryLog;
import queryprovenance.problemsolution.SingleComplaint;
import queryprovenance.query.WhereClause.Op;
import queryprovenance.solve.varQuery;
import queryprovenance.solve.varX;

public class Query {
	public static enum Type {
		INSERT("insert"), DELETE("delete"), UPDATE("update"), SELECT("select"), EMPTY(
				"empty");
		private final String type;

		private Type(String type_) {
			type = type_;
		}

		public String toString() {
			return this.type;
		}
	};

	// protected String query; // query content
	protected int id; // need ID to equate the same query in different qlogs
	protected Query.Type type;
	protected Select select;
	protected SetClause set;
	protected Table from;
	protected WhereClause where;
	protected List<VariableExpression> values; // values for INSERT query
	public List<String> insert_vals; // values for INSERT query
	public List<String> attr_names; // attribute names for INSERT query

	public List<VariableExpression> variables = new ArrayList<VariableExpression>();

	protected Set<Integer> impact; // get impact of the query; should depend on
									// query log

	// transform insert values
	public List<String> generate(List<String> values, List<String> attrs,
			QueryParams params) {
		Table t = params.from;
		Random rand = new Random();
		List<String> transvalue = new ArrayList<String>();

		for (String attr : attrs) {
			int col = t.getColumnIdx(attr);
			long[] dom = t.getNumDomain(col);
			long v;
			if (dom[0] == dom[1]) {
				v = dom[0];
			} else {
				v = rand.nextInt((int) (dom[1] - dom[0])) + dom[0];
				v = v == 0 ? v + 1 : v;
			}
			transvalue.add(String.valueOf(v));
		}
		return transvalue;
	}

	public List<String> getModifiedAttr() {
		List<String> attrs = new ArrayList<String>();
		if (type == Type.INSERT || type == Type.DELETE) {
			attrs.addAll(attr_names);
		} else if (type == Type.UPDATE) {
			attrs = set.getModifiedAttr();
		}
		return attrs;
	}

	/**
	 * Function querySAT: return query satisfactory information for a given
	 * tuple Update & Delete query: whether each expression in the where clause
	 * is satisfied or not Insert query: whether insert query is conducted,
	 * always true
	 * 
	 * @throws Exception
	 */
	public HashMap<String, varX> querySAT(IloCplex cplex, SingleComplaint scp,
			String[] values_) throws Exception {
		HashMap<String, varX> varXList = new HashMap<String, varX>();
		if (where != null) {
			for (WhereExpr whereexpr : where.getWhereExprs()) {
				// for each where expression
				// set value for each attribute
				Expression leftexpr = whereexpr.getAttrExpr();
				Expression rightexpr = whereexpr.getVarExpr();
				for (int i = 0; i < from.getColumns().length; ++i) {
					String attr = from.getColumnName(i);
					double value;
					if (values_[i] == null) {
						value = Double.MIN_VALUE;
					} else {
						value = Double.valueOf(values_[i]);
					}
					leftexpr.setVariable(attr, value);
					rightexpr.setVariable(attr, value);
				}
				double left = leftexpr.Evaluate();
				double right = rightexpr.Evaluate();
				boolean sat = true;
				switch (whereexpr.getOperator()) {
				case g:
					sat = left > right;
					break;
				case l:
					sat = left < right;
				case ge:
					sat = left >= right;
					break;
				case le:
					sat = left <= right;
					break;
				case eq:
					sat = left == right;
					break;
				case ne:
					sat = left != right;
					break;
				}
				varX x = new varX(cplex, scp, whereexpr.toString(),
						sat == true ? 1 : 0);
				varXList.put(whereexpr.toString(), x);
			}
		} else if (values != null && values.size() > 0) {
			// for insert query
			varX x = new varX(cplex, scp, this.toString(), 1);
			varXList.put(this.toString(), x);
		}
		return varXList;
	}

	/**
	 * Function getSetAttr: return attributes that are changed by the current
	 * query
	 */
	public HashSet<String> getSetAttr() {
		HashSet<String> setattrs = new HashSet<String>();
		if (set != null) {
			for (SetExpr setexpr : set.getSetExprs()) {
				setattrs.addAll(setexpr.attrs);
			}
		}
		if (values != null && values.size() > 0) {
			for (String attr : from.getColumns()) {
				setattrs.add(attr);
			}
		}
		return setattrs;
	}

	/**
	 * Function getWhereAttr: return attributes that are included in the current
	 * query where clause
	 */
	public HashSet<String> getWhereAttr() {
		HashSet<String> whereattrs = new HashSet<String>();
		if (where != null) {
			for (WhereExpr whereexpr : where.getWhereExprs()) {
				whereattrs.addAll(whereexpr.attrs);
			}
		}
		return whereattrs;
	}

	public List<VariableExpression> getVariable() {
		return variables;
	}

	public boolean compare(Query query, double epsilon) {
		boolean isSame = true;
		if (type == Query.Type.INSERT) {
			// compare list of values
			isSame &= values.size() == query.values.size();
			for (int i = 0; isSame && i < values.size(); ++i) {
				Double cur = Double.valueOf(values.get(i).getValue());
				Double qval = Double.valueOf(query.values.get(i).getValue());
				isSame &= Math.abs(cur - qval) < epsilon;
			}
		} else {
			int cursize = set == null ? 0 : set.getSetExprs().size();
			int qsize = query.set == null ? 0 : query.set.getSetExprs().size();
			isSame &= cursize == qsize;
			List<SetExpr> setexprs = set != null ? set.getSetExprs() : null;
			for (int i = 0; isSame && cursize > 0 && i < setexprs.size(); ++i) {
				isSame &= setexprs.get(i).attr.compare(query.set.getSetExprs()
						.get(i).attr)
						&& setexprs.get(i).expr.compare(query.set.getSetExprs()
								.get(i).expr);
			}
			cursize = where == null ? 0 : where.getWhereExprs().size();
			qsize = query.where == null ? 0 : query.where.getWhereExprs()
					.size();
			List<WhereExpr> whereexprs = where != null ? where.getWhereExprs()
					: null;
			isSame &= cursize == qsize;
			for (int i = 0; isSame && cursize > 0 && i < whereexprs.size(); ++i) {
				isSame &= whereexprs.get(i).attr_expr.compare(query.where
						.getWhereExprs().get(i).attr_expr)
						&& whereexprs.get(i).var.compare(query.where
								.getWhereExprs().get(i).var);
			}
		}
		return isSame;
	}

	// computation time
	protected long[] times = new long[3];

	/* initialization */
	public Query(int id) {
		this.id = id;
	}

	/* initialization */
	public Query(int id, Query.Type type) {
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
	public void fix(HashMap<IloNumVar, Double> fixedmap,
			HashMap<Expression, IloNumVar> expressionmap) throws Exception {
		if (set != null)
			set.fix(fixedmap, expressionmap);
		if (where != null)
			where.fix(fixedmap, expressionmap);
	}

	public void fixInsert(HashMap<IloNumVar, Double> fixedmap,
			HashMap<List<VariableExpression>, IloNumVar[]> insrtmap)
			throws Exception {
		if (insrtmap.containsKey(this.values)) {
			IloNumVar[] vars = insrtmap.get(this.values);
			List<VariableExpression> temp = new ArrayList<VariableExpression>();
			for (int i = 0; i < vars.length; ++i) {
				IloNumVar var = vars[i];
				Double corval = fixedmap.get(var);
				temp.add(new VariableExpression(String.valueOf(corval), false));
			}
			this.values = temp;
		}
	}

	// For UPDATE queries
	public Query(int id, SetClause set, Table from, WhereClause where,
			Query.Type type_) {
		this.id = id;
		// preprocess the query
		this.set = set;
		this.from = from;
		this.where = where;
		this.type = type_;
		// update variable expressions
		if (set != null) {
			for (SetExpr setexpr : set.getSetExprs()) {
				variables.addAll(setexpr.getExpr().getUnassignedVariable());
			}
		}
		if (where != null) {
			for (WhereExpr wherexpr : where.getWhereExprs()) {
				variables.addAll(wherexpr.getVarExpr().getUnassignedVariable());
			}
		}
	}

	// For DELETE query
	public Query(int id, Table from, WhereClause where, Query.Type type_) {
		this.id = id;
		// preprocess the query
		this.from = from;
		this.where = where;
		this.type = type_;

		for (WhereExpr wherexpr : where.getWhereExprs()) {
			variables.addAll(wherexpr.getVarExpr().getUnassignedVariable());
		}
	}

	// insert query constructor
	public Query(int id, Table from, List<String> values) {
		this.id = id;
		this.type = Type.INSERT;
		this.from = from;
		this.insert_vals = values;
		variableInit();
	}

	public Query(int id, Table from, List<String> values, List<String> attrs) {
		this(id, from, values);
		this.attr_names = attrs;
	}

	/* initialization */
	public Query(int id, Select select, SetClause set, Table from,
			WhereClause where, Query.Type type) {
		this.id = id;
		this.select = select;
		this.set = set;
		this.from = from;
		this.where = where;
		this.type = type;
		variableInit();
	}

	public void variableInit() {
		variables.clear();
		// update set/where clause
		if (set != null) {
			for (SetExpr setexpr : set.getSetExprs()) {
				variables.addAll(setexpr.getExpr().getUnassignedVariable());
			}
		}
		if (where != null) {
			for (WhereExpr wherexpr : where.getWhereExprs()) {
				variables.addAll(wherexpr.getVarExpr().getUnassignedVariable());
			}
		}
		// update insert
		if (this.insert_vals != null) {
			for (String value : this.insert_vals) {
				VariableExpression variable = new VariableExpression(
						Double.valueOf(value), false);
				variables.add(variable);
			}
		}
	}

	/* get query initialized */
	public void queryInitialize() {
		System.out.println("type not supported");
	}

	/* return original query */
	public String toString() {
		List<String> l = new ArrayList<String>();
		if (type == Type.INSERT) {
			l.add("INSERT INTO");
			l.add(from.toString());
			if (this.attr_names != null && attr_names.size() > 0)
				l.add(" (" + Util.join(this.attr_names, ", ") + " ) ");
			l.add("VALUES(");
			l.add(Util.join(variables, ", ")); // XXX: not exactly right...
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
		} else if (type == Type.SELECT) {
			l.add("SELECT");
			l.add(select.toString());
			l.add("FROM");
			l.add(from.toString());
			if (where.toString() != "") {
				l.add("WHERE");
				l.add(where.toString());
			}
			;
		} else
			return "EMPTY";
		return Util.join(l, " ");
	}

	/* solve query by previous database state and next database state */
	public Query solve(CplexHandler cplex, DatabaseState pre,
			DatabaseState next, DatabaseState bad, String[] options)
			throws Exception {
		return null;
	}

	/* sove single query: imcomplete complaint set */
	public Query solve(CplexHandler cples, DatabaseState pre,
			DatabaseState bad, Complaint complaint, String[] options)
			throws Exception {
		return null;
	}

	/* compare */
	public boolean equals(Object o) {
		if (o == null)
			return false;
		if (o instanceof Query) {
			return this.toString() == o.toString();
		}
		return super.equals(o);
	}

	/* compare */
	public List<String> difference(Query q) {
		List<String> diffs = new ArrayList<String>();
		if (this.equals(q))
			return diffs;
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
	public WhereClause getWhere() {
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
	public SetClause getSet() {
		return this.set;
	}

	/* return query type */
	public Query.Type getType() {
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
	public Table getTable() {
		return from;
	}

	/* set values for insert query */
	public void setValue(List<String> values) {
		variables.clear();
		for (String value : values) {
			variables.add(new VariableExpression(Double.valueOf(value), false));
		}
	}

	/* get values for insert query */
	public List<VariableExpression> getValue() {
		return this.values;
	}

	/* clone query */
	public Query clone() {
		Query q;
		if (this.type == Type.UPDATE) {
			SetClause newset = null;
			WhereClause newwhere = null;
			if (set != null)
				newset = set.clone();
			if (where != null)
				newwhere = where.clone();
			q = new Query(id, select, newset, from, newwhere, type);
		} else {
			q = new Query(id, from, this.insert_vals, this.attr_names);
		}
		// q.variables = this.variables;
		return q;
	}

	/*
	 * Genereate a random Query object. NOTE: if params doesn't set an id field,
	 * the query's id field is initialized to -1
	 */
	public static Query generate(QueryParams params) {
		Query q = null;
		WhereClause clause = WhereClause.generate(params);
		SetClause set = SetClause.generate(params);
		switch (params.queryType) {
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
	public long[] getTime() {
		return times;
	}

	/* get modified attribute */
	public Set<Integer> calculatImpact(QueryLog qlog, int current,
			HashMap<Integer, List<Query>> provmap) {
		impact = new HashSet<Integer>();
		HashSet<Integer> partialimpact = new HashSet<Integer>();
		HashSet<Integer> partialdependency = new HashSet<Integer>();
		switch (this.type) {
		case INSERT:
			for (int i = 0; i < from.getColumns().length; ++i)
				partialimpact.add(i);
			break;
		default:
			// find immediate query impact
			for (int i = 0; i < this.set.getSetExprs().size(); ++i) {
				partialimpact.add(from.getColumnIdx(set.getSetExprs().get(i)
						.getAttr().toString()));
			}
			// find dependencies
			for (int i = 0; i < this.where.getWhereExprs().size(); ++i) {
				List<Expression> variables = this.where.getWhereExprs().get(i)
						.getAttrExpr().getVariable();
				variables.addAll(this.where.getWhereExprs().get(i).getVarExpr()
						.getVariable());
				for (int j = 0; j < variables.size(); ++j) {
					if (from.getColumnIdx(variables.get(j).toString()) >= 0)
						partialdependency.add(from.getColumnIdx(variables
								.get(j).toString()));
				}
			}
			break;
		}
		// update impact list
		for (int im : partialimpact) {
			if (provmap.containsKey(im)) {
				List<Query> prov = provmap.get(im);
				for (Query q : prov) {
					impact.addAll(q.getImpact());
				}
			}
		}
		impact.addAll(partialimpact);
		// update provmap
		for (int dep : partialdependency) {
			if (provmap.containsKey(dep)) {
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

	// Update the querylog based on attr_value_map
	public void StrToNum(HashMap<String, Integer> attr_value_map, String attr) {
		switch (type) {
		case INSERT:
			int attr_idx = -1;
			if (attr_names != null && attr_names.size() > 0) {
				for (int i = 0; i < attr_names.size(); ++i) {
					if (attr_names.get(i).equals(attr)) {
						attr_idx = i;
						break;
					}
				}
			} else {
				attr_idx = this.from.getColumnIdx(attr);
			}
			// Get original value
			int num_attr_value = -1;
			if(attr_value_map.containsKey(insert_vals.get(attr_idx))) {
				num_attr_value = attr_value_map.get(insert_vals.get(attr_idx));
			} else if (attr_value_map.containsKey(String.valueOf(Double.valueOf(insert_vals.get(attr_idx))))) {
				num_attr_value = attr_value_map.get(String.valueOf(Double.valueOf(insert_vals.get(attr_idx))));
			} else {
				num_attr_value = attr_value_map.size();
				attr_value_map.put(String.valueOf(insert_vals.get(attr_idx)), num_attr_value);
			}
			this.insert_vals.set(attr_idx, String.valueOf(num_attr_value));
			break;
		case UPDATE:
			this.set.StrToNum(attr_value_map, attr);
			this.where.StrToNum(attr_value_map, attr);
			break;
		case DELETE:
			this.where.StrToNum(attr_value_map, attr);
			break;
		}
	}

	public void QueryToJSON(String[] components) {
		// process value
		if (this.insert_vals != null) {
			components[0] = "[" + Util.join(this.insert_vals, ",") + "]";
		}
		if (this.attr_names != null) {
			components[1] = "[" + Util.join(this.attr_names, ",") + "]";
		}
		// process set clause
		if (this.set != null) {
			components[2] = "[[" + Util.join(this.set.QueryToJSON(), "],[") + "]]";
		}
		// process where clause
		if (this.where != null) {
			components[3] = "[[" + Util.join(this.where.QueryToJSON(), "],[") + "]]";
		}
	}
}