package queryprovenance.harness;

import queryprovenance.query.Query;
import queryprovenance.query.SetClause;
import queryprovenance.query.WhereClause;
import weka.core.Debug.Random;





class Transformation {
	public enum Type {
		DELETE, VALUES, SET, WHERE
	}
	protected int qidx;
	protected Type type;
	protected WhereClause where;
	protected SetClause set;
	public Transformation(int qidx, Type type, WhereClause where, SetClause set) {
		// delete query
		// change insert value
		//   change values at indexes idxs
		// change set clause
		//   change projected column i
		//     change function/udf
		// change where clause
		//   change predicate
		//     set constant value
		this.qidx = qidx;
		this.type = type;
		
		this.where = where;
		this.set = set;
	}

	/*
	 * Apply this transformation to a query log
	 */
	public QueryLog apply(QueryLog ql) {
		ql = (QueryLog)ql.clone();
		switch (this.type) {
		case DELETE:
			ql.remove(qidx);
		case VALUES:
			if (ql.get(qidx).getType() != Query.Type.INSERT) 
				throw new RuntimeException();
			// XXX: change query structure
		case SET:
			// XXX: change set clause
		case WHERE:
			// XXX: replace where clause completely with new clause
			Query q = ql.get(qidx);
			q = q.clone();
			System.out.println(q);
			q.setWhere(where);
			System.out.println(q);
			ql.set(qidx, q);
		}
		return ql;
	}

	/*
	 * Create a transformation for our experiments
	 */
	public static Transformation generate(ExpParams params) {
		Random rand = new Random();
		int idx = rand.nextInt(params.ql_nqueries);
		QueryParams qparams = new QueryParams();
		qparams.from = params.table;
		qparams.nclauses = 1;
		qparams.queryType = Query.Type.UPDATE;
		WhereClause newWhere = WhereClause.generate(qparams);
		return new Transformation(idx, Transformation.Type.WHERE, newWhere, null);
	}
}