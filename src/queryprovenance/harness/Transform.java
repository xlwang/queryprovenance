package queryprovenance.harness;

import queryprovenance.query.Query;





class Transformation {
	public enum Type {
		DELETE, VALUES, SET, WHERE
	}
	protected int qidx;
	protected Type type;
	public Transformation(int qidx, Type type) {
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
	}

	/*
	 * Apply this transformation to a query log
	 */
	public QueryLog apply(QueryLog ql) {
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
			
		}
		return ql;
	}

	/*
	 * Create a transformation for our experiments
	 */
	public static Transformation generate(ExpParams params) {
		
		return null;
	}
}