package queryprovenance.harness;

import queryprovenance.problemsolution.QueryLog;
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
	protected QueryParams params;
	public Transformation(int qidx, Type type, WhereClause where, SetClause set, QueryParams params) {
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
		this.params = params;
	}

	/*
	 * Apply this transformation to a query log
	 */
	public QueryLog apply(QueryLog ql) {
		ql = (QueryLog)ql.clone();
		Query q;
		switch (this.type) {
		case DELETE:
			ql.remove(qidx);
			break;
		case VALUES:
			if (ql.get(qidx).getType() != Query.Type.INSERT) 
				throw new RuntimeException();
			break;
			// XXX: change query structure
		case SET:
			// XXX: change set clause
			set = SetClause.generate(ql.get(qidx).getSet(), params);
			while(ql.get(qidx).getSet().toString().equals(set.toString()))
				set = SetClause.generate(ql.get(qidx).getSet(), params);
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
			while(ql.get(qidx).getWhere().toString().equals(where.toString()))
				where = WhereClause.generate(ql.get(qidx).getWhere(), params);
			q = ql.get(qidx);
			q = q.clone();
			System.out.println(q);
			q.setWhere(where);
			System.out.println(q);
			ql.set(qidx, q);
			break;
		}
		return ql;
	}

	/*
	 * Create a transformation for our experiments
	 */
	public static Transformation generate(ExpParams params, double percentage) {
		Random rand = new Random();
		int lowerbd = (int) (params.ql_nqueries*( (double) (percentage-0.2) >0 ? percentage - 0.2: 0));
		int upperbd = (int) (params.ql_nqueries*((double) (percentage+0.2) <1 ? percentage + 0.2: 1));
		upperbd = upperbd == 0?1:upperbd;
		int idx = rand.nextInt(upperbd-lowerbd) + lowerbd;
		QueryParams qparams = new QueryParams();
		qparams.from = params.table;
		qparams.nclauses = 1;
		qparams.queryType = Query.Type.UPDATE;
		//WhereClause newWhere = WhereClause.generate(qparams);
		//Transformation.Type transtype = (((Math.random()<0.5)?0:1) == 0)?Transformation.Type.WHERE:Transformation.Type.SET;
		Transformation.Type transtype = Transformation.Type.WHERE;
		return new Transformation(idx, transtype, null, null, qparams);
	}
}