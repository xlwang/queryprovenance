package queryprovenance.problemsolution;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Set;
import java.util.TreeSet;

import queryprovenance.database.DatabaseHandler;
import queryprovenance.database.DatabaseState;
import queryprovenance.harness.Util;
import queryprovenance.query.Query;
import queryprovenance.query.WhereExpr;

/*
 * Density approach for false positives
 */
public class FalsePositive {
	
	static final double epsilon = 0.001;
	
	/*
	 *  A solution for a given complaint moves a single attribute
	 */
	class Solution {
		int key;      // primary key
		String col;
		double value;
		
	}
	
	static class Region {
		// not surewhat to put here
		String col;
		double min;
		double max;
		Region(String col_) {
			col = col_; 
			min = Float.MIN_VALUE; 
			max = Float.MAX_VALUE;
		}
		Region(String col_, double min_, double max_) {
			col = col_;
			min = min_;
			max = max_;
		}
		public Region clone() {
			return new Region(col, min, max);
		}
	}
	
	public static Complaint densityFilter(DatabaseHandler dbhandler, DatabaseState ds, Query q, Complaint complaints) throws Exception {
		
		String tablename = q.getTable().getName();
		String tupleviewclearsql = "DROP TABLE tupleview cascade";
		String tupleviewsql = "CREATE TABLE tupleview AS SELECT *, 0 AS COUNT FROM " + tablename;
		dbhandler.queryExecution(tupleviewclearsql);
		dbhandler.queryExecution(tupleviewsql); // create tupleview
		 
		HashMap<String, Region> queryrange = convertQueryToRange(q);
		String complaintclearsql = "DROP TABLE complaints cascade";
		String complaintsql = "CREATE TABLE complaints (";
		String complaintalter = "alter table complaints add primary key (";
		List<String> attributes = new ArrayList<String>();
		attributes.add("key int");
		for(String attribute : queryrange.keySet()) {
			attributes.add(attribute + "min real");
			attributes.add(attribute + "max real");
			//complaintsql += attribute + "min, " + attribute + "max, ";
		}
		complaintsql = complaintsql + Util.join(attributes, ",") + ")";
		complaintalter += Util.join(attributes.subList(1, attributes.size()), " , ") + ")";
		dbhandler.queryExecution(complaintclearsql);
		dbhandler.queryExecution(complaintsql);
		dbhandler.queryExecution(complaintalter);
		
		// get # of tuple of original query
		String tupleamtsql = "SELECT count(*) FROM tupleview WHERE " + getCondition(queryrange);
		ResultSet rset = dbhandler.queryExecution(tupleamtsql);
		int tupleamt = 0;
		while(rset.next()) {
			tupleamt = Integer.valueOf(rset.getString(1));
		}
		
		HashMap<String, Set<Double>> solutionmap = new HashMap<String, Set<Double>>(); // define solution map for each attribute
		//HashMap<SingleComplaint, HashMap<String, Region>> complaintmap = new HashMap<SingleComplaint, HashMap<String, Region>>(); // define solutions map for each single complaint
		HashMap<SingleComplaint, String> comprangemap = new HashMap<SingleComplaint, String>();
		//Set<Solution> solutions = new HashSet<Solution>(); 
		for (int pk : complaints.keySet()) {
			SingleComplaint sc = complaints.get(pk); // get current complaint
			HashMap<String, Region> solutions = computeSolutions(queryrange, q, sc); // get "best" solution for current complaint
			for(String col : solutions.keySet()) {
				Region region = solutions.get(col);
				Set<Double> boundaries; // get existing boundary list of the attribute
				if(solutionmap.containsKey(col)) {
					boundaries = solutionmap.get(col);
				} else {
					boundaries = new TreeSet<Double>();
				}
				boundaries.add(region.max); // update boundary list
				boundaries.add(region.min);
				solutionmap.put(col, boundaries); // update solution map for attribute
			}
			//complaintmap.put(sc, solutions); // update solutions map for single complaint
			String range = getRange(dbhandler, sc, solutions);
			comprangemap.put(sc, range);
		}
		
		summarizeIntoRegions(dbhandler, tablename, ds, solutionmap, tupleamt);
		
		Complaint pruned = filterByDensity(dbhandler, complaints, comprangemap);
		System.out.println(pruned.size());
		return pruned;
	}
	
	/*
	 * Create range for singlecomplaint solutions
	 */
	public static String getRange(DatabaseHandler dbhandler, SingleComplaint sc, HashMap<String, Region> solutions) throws Exception {
		
		
		HashMap<String, Region> complaintrange = new HashMap<String, Region>();
		List<String> where = new ArrayList<String>();
		List<String> insert = new ArrayList<String>();
		insert.add(String.valueOf(sc.key));
		for(String col : solutions.keySet()) {
			Region region = solutions.get(col);
			where.add(col + " >= "  + region.min); where.add(col + " <= " + region.max);
			insert.add(String.valueOf(region.min));insert.add(String.valueOf(region.max));
			//updatesql += col + " >= "  + region.min + " and " + col + " < " + region.max + " and ";
			//cmpinsertsql += region.min + " , " + region.max + " , ";
		}
		String updatesql = "UPDATE tupleview SET count = count + 1 WHERE " + Util.join(where, " and ");
		String cmpinsertsql = "INSERT INTO complaints VALUES (" + Util.join(insert, " , ") + ")";
		dbhandler.queryExecution(updatesql);
		dbhandler.queryExecution(cmpinsertsql);
		
		return Util.join(where, " and ");
	}
	
	public static String getCondition(HashMap<String, Region> range) throws Exception {
		List<String> where = new ArrayList<String>();
		for(String col : range.keySet()) {
			Region region = range.get(col);
			where.add(col + " >= "  + region.min); where.add(col + " <= " + region.max);
			//updatesql += col + " >= "  + region.min + " and " + col + " < " + region.max + " and ";
			//cmpinsertsql += region.min + " , " + region.max + " , ";
		}
		return Util.join(where, " and ");
	}
	
	
	/*
	 * convert query into ranges grouped by attributes
	 * only support where expressions connects by conjunctions
	 * each where expression should only contain one attribute.
	 * e.g., attr >= 4 and attr <= 8 and attr' >= 2 and attr' <= 4 is supported
	 *       attr + attr' >= 4 is not supported
	 *       attr >= 4 or attr <= 1 is not supported
	 */
	public static HashMap<String, Region> convertQueryToRange(Query q) {
		HashMap<String, Region> queryrange = new HashMap<String, Region>();
		List<WhereExpr> exprs = q.getWhere().getWhereExprs();
		for(WhereExpr expr : exprs) {
			String col = expr.getAttrExpr().toString();
			double bound = Double.valueOf(expr.getVarExpr().toString());
			Region currregion;
			if(queryrange.containsKey(col)) {
				currregion = queryrange.get(col);
			} else {
				currregion = new Region(col);
			}
			switch(expr.getOperator()) {
			case le: currregion.max = Math.min(currregion.max, bound); break;
			case l: currregion.max = Math.min(currregion.max - epsilon, bound); break;
			case ge: currregion.min = Math.max(currregion.min, bound); break;
			case g: currregion.min = Math.max(currregion.min + epsilon, bound); break;
			case eq: currregion.min = bound; currregion.max = bound; break;
			}
			queryrange.put(col, currregion);
		}
		return queryrange;
	}
	
	/*
	 *  Given a complaint and a query, find the "best" solution for it, return the difference regions with original query
	 */
	public static HashMap<String, Region> computeSolutions(HashMap<String, Region> queryrange, Query query, SingleComplaint complaint) throws Exception {
		HashMap<String, Region> solutions = new HashMap<String, Region>();
		for(String col : queryrange.keySet()) {
			double compvalue = Double.valueOf(complaint.values[query.getTable().getColumnIdx(col)]);
			Region currregion = queryrange.get(col).clone();
			boolean action = compvalue >= currregion.min && compvalue <= currregion.max; // action:true move complaint out; action:false move complaint in
			if(action) {
				// move complaint out
				if(Math.abs(currregion.min - compvalue) < Math.abs(currregion.max - compvalue)) {
					currregion.max = compvalue + epsilon;
				} else {
					currregion.min = compvalue - epsilon;
				}
			} else {
				// include complaint in
				if(Math.abs(currregion.min - compvalue) < Math.abs(currregion.max - compvalue)) {
					currregion.min = compvalue;
					currregion.max = queryrange.get(col).min;
				} else {
					currregion.min = queryrange.get(col).max;
					currregion.max = compvalue;
				}
			}
			solutions.put(col, currregion);
		}
		return solutions;
	}
	
	/*
	 * Given the database and the solutions, summarize the tuples in each region
	 */
	public static void summarizeIntoRegions(DatabaseHandler dbhandler, String tablename, DatabaseState ds, HashMap<String, Set<Double>> solutionmap, int tupleamt) throws Exception {
		// maintain four views in the database:
		// view 1: tuple view, include all tuples modified by the complaints, maintain remaining graph (created in densityFilter method)
		// 		   CREATE VIEW tupleview AS SELECT *, 0 AS COUNT FROM tablename;
		// view 2: data cube with tuple count based on attributes' boundaries, calculate edge
		//         CREATE VIEW edgeview AS col1.min AS col1min, col1.max AS col1max, ..., count(*) FROM tupleview JOIN bucket1 ON tupleview.col1 >= bucket1.min and tupleview.col1 <= bucket1.max JOIN... WHERE tupleview.count > 0 GROUP BY bucket1.min, ... 
		// view 3: data cube with tuple count equals to 1 based on attributes' boundaries, calculate node
		//         CREATE VIEW nodeview AS col1.min AS col1min, col1.max AS col1max, ..., count(*) FROM tupleview JOIN bucket1 ON tupleview.col1 >= bucket1.min and tupleview.col1 <= bucket1.max JOIN... WHERE tupleview.count < 2 GROUP BY bucket1.min, ...
		// view 4: dynamic complaint contribution
		//         CREATE VIEW contribution AS SELECT sum(edgeview.count), sum(nodeview.count + 1) FROM edgeview, nodeview WHERE edgeview.col1min = nodeview.col1min and ...;

		Set<String> cols = solutionmap.keySet();
		List<String> select = new ArrayList<String>();
		List<String> select1 = new ArrayList<String>();
		List<String> select2 = new ArrayList<String>();
		List<String> join1 = new ArrayList<String>();
		List<String> groupby1 = new ArrayList<String>();
		List<String> join2 = new ArrayList<String>();
		List<String> join = new ArrayList<String>();
		List<String> groupby2 = new ArrayList<String>();
		List<String> selectedge = new ArrayList<String>();
		List<String> selectnode = new ArrayList<String>();
		List<String> joinedge = new ArrayList<String>();
		List<String> joinnode = new ArrayList<String>();
		List<String> groupbyedge = new ArrayList<String>();
		List<String> groupbynode = new ArrayList<String>();
		List<String> contselect = new ArrayList<String>();
		List<String> contjoin = new ArrayList<String>();
		
		selectedge.add("c1.key AS key");
		selectnode.add("c2.key AS key2");
		contselect.add("DISTINCT(key)");
		groupbyedge.add("c1.key");
		groupbynode.add("c2.key");
		
		for(String col : cols) {
			// create buckets for attributes
			String clearsql = "DROP TABLE " + col + " cascade";
			String bucketsql = "CREATE TABLE " + col + " (min real, max real)";
			String insertsql = "INSERT INTO " + col + " VALUES ";  
			double min = Float.MIN_VALUE;
			for(double max : solutionmap.get(col)) {
				if(min < max) {
					insertsql += "(" + min + "," + (max - epsilon) + "),";
				}
				insertsql += "(" + max + "," + max + "),";
				min = max + epsilon;
			}
			insertsql += "(" + min + "," + Float.MAX_VALUE + ")";
			dbhandler.queryExecution(clearsql);
			dbhandler.queryExecution(bucketsql);
			dbhandler.queryExecution(insertsql);
			// update select, join field for view2, view 3
			select.add(col + "min1 AS " + col + "min"); select.add(col + "max1 AS " + col + "max");
			select1.add("c1.min AS " + col + "min1");select1.add("c1.max AS " + col + "max1");
			select2.add(col + "min1 AS " + col + "min");select2.add(col + "max1 AS " + col + "max");
			join1.add(col + " c1 ON " + " t1." + col + ">=" + "c1.min and t1." + col + "<=" + "c1.max");
			join2.add(" t1." + col + ">=" + col + "min1 and t1." + col + "<=" + col + "max1");
			groupby1.add(col + "min1"); groupby1.add(col + "max1");
			groupby2.add(col + "min2"); groupby2.add(col + "max2");
			join.add(col + "min1 = " + col + "min2"); join.add(col + "max1 = " + col + "max2");
			
			selectedge.add("c1." + col + "min AS " + col + "min"); selectedge.add("c1." + col + "max AS " + col + "max");
			joinedge.add("c1." + col + "min <= " + "E." + col + "min1"); joinedge.add("c1." + col + "max >= " + "E." + col + "max1");
			groupbyedge.add("c1." + col + "min"); groupbyedge.add("c1." + col + "max");
			
			selectnode.add("c2." + col + "min AS " + col + "minE2"); selectnode.add("c2." + col + "max AS " + col + "maxE2");
			joinnode.add("c2." + col + "min <= " + "N." + col + "min"); joinnode.add("c2." + col + "max >= " + "N." + col + "max");
			groupbynode.add("c2." + col + "min"); groupbynode.add("c2." + col + "max");
			
			contselect.add(col + "min"); contselect.add(col + "max");
			contjoin.add(col + "min = " + col + "minE2"); contjoin.add(col + "max = " + col + "maxE2"); 
			
			//joinedge.append("c1." + attribute + "min + <= " + "E." + attribute + "minE" + " and " + "c1." + attribute + "max >= " + attribute + "maxE" + " and ");
		}
		String view2sql = "CREATE VIEW edgeview AS SELECT " + Util.join(select1, " , ") + ", count(*) as edge FROM tupleview t1 LEFT OUTER JOIN " + Util.join(join1, " LEFT OUTER JOIN ") + " WHERE t1.count > 0 " + " GROUP BY " + Util.join(groupby1, ",");
		String view3sql = "CREATE VIEW nodeview AS SELECT " + Util.join(select2, " , ") + ", count(t1.count) as node FROM edgeview LEFT OUTER JOIN tupleview t1 ON " + Util.join(join2, " and ") + " and t1.count = 1 GROUP BY " + Util.join(groupby1, ",");
		String view4sql = "CREATE VIEW contribution AS SELECT " + Util.join(contselect, ",") + ", edgecount, nodecount, edgecount/(nodecount + 1) AS cont FROM"
				+ "(SELECT " + Util.join(selectedge, " , ") + ", sum(edge) AS edgecount FROM edgeview E JOIN complaints c1 ON " + Util.join(joinedge, " and ") + " GROUP BY " + Util.join(groupbyedge, " , ") + ") AS ED "
				+ " JOIN "
				+ "(SELECT " + Util.join(selectnode, " , ") + ", sum(node) AS nodecount FROM nodeview N JOIN complaints c2 ON " + Util.join(joinnode, " and ") + " GROUP BY " + Util.join(groupbynode, " , ") + ") AS ND "
				+ " ON  "
				+ Util.join(contjoin, " and ");
		dbhandler.queryExecution("DROP VIEW edgeview; DROP VIEW nodeview; DROP VIEW contribution");
		dbhandler.queryExecution(view2sql);
		dbhandler.queryExecution(view3sql);
		dbhandler.queryExecution(view4sql);
		
	}
	
	/*
	 * Is the region affected by the solution?
	 */
	public static boolean isAffected(Region region, Solution solution, Query query) {
		return false;
	}
	
	/*
	 * Use the bipartite-graph-based algorithm 
	 */
	public static Complaint filterByDensity(DatabaseHandler dbhandler, Complaint complaint, HashMap<SingleComplaint, String> comprangemap) {
		// iteratively find complaint make least contribution, update solutions for the complaint. 
		Complaint pruned = new Complaint();
		String initquery = "SELECT sum(count) as edge, count(*) FROM tupleview WHERE count > 0";
		String minquery = "SELECT key, edgecount, nodecount FROM contribution C WHERE C.cont = (SELECT min(cont) FROM contribution C2)";
		String updatequery = "UPDATE tupleview SET count = count - 1 WHERE count > 0 and ";
		String deletequery = "DELETE FROM complaints WHERE key = ";
		try {
			ResultSet rset = dbhandler.queryExecution(initquery);
			int edgecount = 0, nodecount = 0;
			if(rset.next()){
				edgecount = Integer.valueOf(rset.getString(1));
				nodecount = Integer.valueOf(rset.getString(2));
			}	
			double density = edgecount / (nodecount + 0.0) ;
			int maxind = 0;
			double maxdensity = density;
			List<SingleComplaint> removeorder = new ArrayList<SingleComplaint>();
			ResultSet current;
			while((current = dbhandler.queryExecution(minquery)).next()) {
				int key = Integer.valueOf(current.getString(1));
				SingleComplaint sc = complaint.get(key);
				int rmedge = Integer.valueOf(current.getString(2));
				int rmnode = Integer.valueOf(current.getString(3));
				double currdensity = (edgecount - rmedge) / (nodecount - rmnode - 1);
				removeorder.add(sc);
				dbhandler.queryExecution(updatequery + comprangemap.get(sc));  
				dbhandler.queryExecution(deletequery + key);
				if(currdensity > maxdensity) {
					maxdensity = currdensity;
					maxind = removeorder.size();
				}
				edgecount -= rmedge;
				nodecount -= rmnode;
			}
			for(int i = maxind; i < removeorder.size(); ++i) {
				pruned.add(removeorder.get(i));
			}
		} catch(Exception e) {
			
		}
		return pruned;
	}

	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

}
