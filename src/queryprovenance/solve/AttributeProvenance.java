package queryprovenance.solve;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;

import queryprovenance.problemsolution.QueryLog;
import queryprovenance.query.Query;

public class AttributeProvenance {

	QueryLog queries;
	ArrayList<String> sortedAttributes = new ArrayList<String>();
	int num_direct_attr = 0;
	int random_num = 0;
	HashSet<String> dirty_attr;

	/**
	 * Initialize
	 * 
	 * @param queries_
	 *            query to sort
	 */
	public AttributeProvenance(QueryLog queries_, HashSet<Integer> queryToFix,
			int attr_per_iter, boolean fix_relv_attr,
			HashSet<String> dirty_attr_, int randomnum, int opt_param) {
		random_num = randomnum;
		queries = queries_;
		dirty_attr = dirty_attr_;
		if (fix_relv_attr) {
			if (opt_param == 0)
				sortAttribute(queryToFix);
			else
				getDirectAttr(queryToFix);
		} else {
			for (String attr : queries_.get(0).getTable().getColumns()) {
				sortedAttributes.add(attr);
			}
		}
	}

	/** Sort attributes for given query log */
	public void sortAttribute(HashSet<Integer> queryToFix) {
		HashSet<String> set_attrs = new HashSet<String>();
		HashSet<String> attrs = new HashSet<String>();

		// add relevant attributes
		Integer[] sortedcandidate = new Integer[queryToFix.size()];
		sortedcandidate = queryToFix.toArray(sortedcandidate);
		Arrays.sort(sortedcandidate);

		// process candidate first
		for (int i : queryToFix) {
			Query query = queries.get(i);
			// add set clause in sorted attributes
			AttributeProvenance.addAttrs(query.getSetAttr(), set_attrs,
					new ArrayList<String>(), false, false);
			// add where clause in sorted attributes
			AttributeProvenance.addAttrs(query.getSetAttr(), attrs,
					this.sortedAttributes, false, false);

		}
		num_direct_attr = this.sortedAttributes.size();

		for (int i = sortedcandidate[0] + 1; i < queries.size(); ++i) {
			Query query = queries.get(i);
			// check if query in queryToFix
			HashSet<String> whereattr = query.getWhereAttr();
			HashSet<String> setattr = query.getSetAttr();
			boolean addset = false, addwhere = false;
			if (queryToFix.contains(i)) {
				continue;
			} else {
				for (String attr : whereattr) {
					if (set_attrs.contains(attr)) {
						// Add set attributes in
						addset = true;
					}
				}
				// check set clause
				for (String attr : setattr) {
					if (set_attrs.contains(attr)) {
						// add where attribute in sortedAttributes
						addset = true;
						addwhere = true;
					}
				}
			}
			if (addset) {
				// add set clause in sorted attributes
				AttributeProvenance.addAttrs(setattr, set_attrs,
						new ArrayList<String>(), false, false);
				// add where clause in sorted attributes
				AttributeProvenance.addAttrs(setattr, attrs,
						this.sortedAttributes, false, false);
			}
			if (addwhere) {
				AttributeProvenance.addAttrs(whereattr, attrs,
						sortedAttributes, false, false);
			}

			if (sortedAttributes.size() == query.getTable().getColumns().length
					|| (this.random_num > 0 && sortedAttributes.size() == this.num_direct_attr
							+ this.random_num)) {
				break;
			}
		}
		// process candidate first
		for (int i : queryToFix) {
			Query query = queries.get(i);
			AttributeProvenance.addAttrs(query.getWhereAttr(), attrs,
					sortedAttributes, false, true);

		}
		// process dirty_attr
		AttributeProvenance.addAttrs(dirty_attr, attrs, this.sortedAttributes,
				true, true);
		// sortedAttributes.add("age");sortedAttributes.add("tax");sortedAttributes.add("employeeid");//sortedAttributes.add("tax");
	}

	public static void addAttrs(HashSet<String> attr_to_add,
			HashSet<String> existing_attr, ArrayList<String> list,
			boolean infront, boolean resort) {
		for (String attr : attr_to_add) {
			attr = attr.toLowerCase();
			if (resort) {
				if(existing_attr.contains(attr)) {
					for (Object obj : list) {
						if (attr.equals(obj.toString())) {
							list.remove(obj);
							break;
						}
					}
				}
			} else {
				if (existing_attr.contains(attr)) {
					continue;
				}
			}
			if (infront) {
				list.add(0, attr);
			} else {
				list.add(attr);
			}
			existing_attr.add(attr);
		}

	}
	
	public void getDirectAttr(HashSet<Integer> queryToFix) {
		HashSet<String> attrs = new HashSet<String>();
		for (int i : queryToFix) {
			Query query = queries.get(i);
			// add set clause in sorted attributes
			AttributeProvenance.addAttrs(query.getSetAttr(), attrs,
					sortedAttributes, false, false);
			// add where clause in sorted attributes
			AttributeProvenance.addAttrs(query.getWhereAttr(), attrs,
					sortedAttributes, false, false);

		}
		AttributeProvenance.addAttrs(dirty_attr, attrs, sortedAttributes,
				true, true);

	}

	public List<String> getCurIterAttr(HashSet<Integer> queryToFix,
			boolean fix_relv_attr, int processed, int attr_per_iter) {
		if (fix_relv_attr && attr_per_iter > 0) {
			int attrsnum = processed + attr_per_iter < sortedAttributes.size() ? processed
					+ attr_per_iter
					: sortedAttributes.size();
			return sortedAttributes.subList(processed, attrsnum);

		} else {
			return sortedAttributes;
		}
	}

	public List<String> getRelvAttr(HashSet<Integer> query_to_fix) {
		HashSet<String> relv_attr = new HashSet<String>();
		for (int qidx : query_to_fix) {
			Query query = queries.get(qidx);
			relv_attr.addAll(query.getRelvAttr());
		}
		return new ArrayList<String>(relv_attr);
	}
}
