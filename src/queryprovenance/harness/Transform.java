package queryprovenance.harness;

import java.util.HashSet;
import java.util.List;

import queryprovenance.problemsolution.QueryLog;
import queryprovenance.query.Query;
import queryprovenance.query.SetClause;
import queryprovenance.query.WhereClause;
import weka.core.Debug.Random;

public class Transform {
	public enum Type {
		DELETE, VALUES, SET, WHERE
	}

	protected int qidx;
	protected Type type;
	protected WhereClause where;
	protected SetClause set;
	protected QueryParams params;
	protected int pre;
	
	public Transform(int qlogsize) {pre = qlogsize;}

	public Transform(int qidx, Type type, WhereClause where, SetClause set,
			QueryParams params) {
		// delete query
		// change insert value
		// change values at indexes idxs
		// change set clause
		// change projected column i
		// change function/udf
		// change where clause
		// change predicate
		// set constant value
		this.qidx = qidx;
		this.type = type;

		this.where = where;
		this.set = set;
		this.params = params;
	}

	/*
	 * Apply this transformation to a query log
	 */
	public QueryLog apply(QueryLog ql) {
		ql = (QueryLog) ql.clone();
		Query q;
		switch (this.type) {
		case DELETE:
			ql.remove(qidx);
			break;
		case VALUES:
			if (ql.get(qidx).getType() != Query.Type.INSERT)
				throw new RuntimeException();
			q = ql.get(qidx);
			List<String> insertvalue = q.generate(ql.get(qidx).insert_vals,
					ql.get(qidx).attr_names, params);
			q.setValue(insertvalue);
			break;
		// XXX: change query structure
		case SET:
			// XXX: change set clause
			set = SetClause.generate(ql.get(qidx).getSet(), params);
			while (ql.get(qidx).getSet().toString().equals(set.toString())) {
				System.out.println("set : " + ql.get(qidx).getSet().toString());
				set = SetClause.generate(ql.get(qidx).getSet(), params);
			}
			q = ql.get(qidx);
			q = q.clone();
			System.out.println(q);
			q.setSet(set);
			System.out.println(q);
			ql.set(qidx, q);
			break;
		case WHERE:
			// XXX: replace where clause completely with new clause
			where = WhereClause.generate(ql.get(qidx).getWhere(), params);
			while (ql.get(qidx).getWhere().toString().equals(where.toString())) {
				System.out.println("where : "
						+ ql.get(qidx).getWhere().toString());
				where = WhereClause.generate(ql.get(qidx).getWhere(), params);
			}
			q = ql.get(qidx);
			q = q.clone();
			// System.out.println(q);
			q.setWhere(where);
			// System.out.println(q);
			ql.set(qidx, q);
			break;
		}
		return ql;
	}

	/*
	 * Create a transformation for our experiments
	 */
	public void generate(ExpParams params, double percentage) {
		Random rand = new Random();
		int lowerbd = (int) (params.ql_nqueries * ((double) (percentage - 0.2) > 0 ? percentage - 0.2
				: 0));
		int upperbd = (int) (params.ql_nqueries * ((double) (percentage + 0.2) < 1 ? percentage + 0.2
				: 1));
		upperbd = upperbd == 0 ? 1 : upperbd;
		for(int tmp = pre - 1; tmp >= 0; --tmp) {
			if(params.ql_qtypes[tmp] == Query.Type.UPDATE) {
				this.qidx = tmp;
				this.pre = qidx;
				System.out.println(String.valueOf(qidx));
				break;
			}
		}
		if(qidx == -1) {
			return;
		}
		this.params = new QueryParams();
		this.params.from = params.table;
		this.params.nclauses = 1;
		this.params.queryType = params.ql_qtypes[qidx];
		
		Transform.Type transtype = null;
		switch (this.params.queryType) {
		case UPDATE: 
			this.type = Transform.Type.WHERE;
			break;
		case DELETE: 
			this.type = Transform.Type.DELETE;
			break;
		case INSERT: 
			this.type = Transform.Type.VALUES;
			break;
		}
		// WhereClause newWhere = WhereClause.generate(qparams);
		// Transformation.Type transtype = (((Math.random()<0.5)?0:1) ==
		// 0)?Transformation.Type.WHERE:Transformation.Type.SET;
	}
}