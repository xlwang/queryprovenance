package queryprovenance.harness;

import java.util.Hashtable;


class Transformation {
	public enum Type {
		DELETE, INSERT, SET, WHERE
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
	}

	/*
	 * Apply this transformation to a query log
	 */
	public QueryLog apply(QueryLog ql) {
		return ql;
	}

	/*
	 * Create a transformation for our experiments
	 */
	public static Transformation generate(Hashtable<String, String> params) {

		return null;
	}
}