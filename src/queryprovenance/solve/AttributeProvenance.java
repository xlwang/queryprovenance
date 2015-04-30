package queryprovenance.solve;

import java.util.ArrayList;
import java.util.HashSet;

import queryprovenance.problemsolution.QueryLog;
import queryprovenance.query.Query;

public class AttributeProvenance {

	QueryLog queries;
	ArrayList<String> sortedAttributes = new ArrayList<String>();

	/**
	 * Initialize
	 * 
	 * @param queries_
	 *            query to sort
	 */
	public AttributeProvenance(QueryLog queries_, HashSet<Integer> candidate) {
		queries = queries_;
		sortAttribute(candidate);
	}

	/** Sort attributes for given query log */
	public void sortAttribute(HashSet<Integer> candidate) {
		HashSet<String> attrs = new HashSet<String>();

		for (int i = queries.size() - 1; i >= 0; --i) {
			if(!candidate.contains(i)) {
				continue;
			}
			Query query = queries.get(i);
			// get modified attributes
			HashSet<String> setattr = query.getSetAttr();
			for (String attr : setattr) {
				if (!attrs.contains(attr)) {
					sortedAttributes.add(attr);
					attrs.add(attr);
				}
			}
			HashSet<String> whereattr = query.getWhereAttr();
			for (String attr : whereattr) {
				if (!attrs.contains(attr)) {
					sortedAttributes.add(attr);
					attrs.add(attr);
				}
			}
			if(sortedAttributes.size() == query.getTable().getColumns().length) {
				break;
			}
		}
		// sortedAttributes.add("age");sortedAttributes.add("tax");sortedAttributes.add("employeeid");//sortedAttributes.add("tax");
	}
}
