package queryprovenance.problemsolution;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import ilog.cplex.IloCplex;
import queryprovenance.database.DatabaseHandler;
import queryprovenance.database.DatabaseState;
import queryprovenance.database.DatabaseStates;
import queryprovenance.database.Table;
import queryprovenance.database.Tuple;
import queryprovenance.harness.Util;
import queryprovenance.query.Query;
import weka.core.Utils;

/** FalsePositiveAll: support remove false positives for both set clasue error and where clause error. Use cplex (instead of bounding box) to derive single complaint fix
 *                    * only support query by query pruning *
 *  densityFilter: prune false positives for query qlog(qidx)
 *  create table T (complaintID, tupleID, {set_attributes})
 *  create view V (complaintID, # of tuples only modified by current complaint) from T
 *  create view Contribution (complaintID, #edges in T, #nodes in V + 1)
 *  
 *  algorithm for building T, V, Contribution:
 *  for each complaint c in complaints 
 *      find a fix by Linearization.fixparameter 
 *      find all tuples updated by this fix (value must be different with ds(qidx+1))
 *      update T
 *  end
 *  
 *  algorithm for densest graph
 *  while |T| > 0 
 *      select least contributed complaint
 *      record current density, etc.
 *  end
 *  
 *  
 *      */
public class FalsePositiveAll {
	/* filter complaints based on density */
	public static Complaint densityFilter(IloCplex cplex, DatabaseHandler dbhandler, DatabaseStates dss, QueryLog qlog, int qidx, Complaint complaints, double epsilon, double M) throws Exception {
		// get query
		Query query = qlog.get(qidx);
		DatabaseState preds = dss.get(qidx);
		DatabaseState nextds = dss.get(qidx + 1);
		Table table = preds.getTable();
		// prepare sql query
		String[] attrs = query.getModifiedAttr();
		String setattrs = table.getPrimaryKey() + " int, ";
		String setattrlist = table.getPrimaryKey() + ",";
		String setattrjoin = "T." + table.getPrimaryKey() + "= A." + table.getPrimaryKey() + " and ";
		for(int i = 0; i < attrs.length; ++i) {
			setattrs += attrs[i] + " real";
			setattrlist += attrs[i];
			setattrjoin += "T." + attrs[i] + " = " + "A." + attrs[i];
			if(i < attrs.length - 1) {
				setattrs += ",";
				setattrlist += ",";
				setattrjoin += " and ";
			}
		}		
		// create table etc
		String deleteTsql = "drop table T cascade";
		String createTsql = "create table T (complaintID int, " + setattrs + ")";
		String createVsql = "create view V as select complaintid, count(c >= 1) as edgecount from "
				+ "(select T.complaintid, A.c from T left outer join "
				+ "(select " + setattrlist + ", count(*) as c from T group by " + setattrlist + " having count(*) = 1) as A"
						+ " on " + setattrjoin + ") as B"
								+ " group by complaintid";
		
		String createCsql = "create view contribution as select A.complaintid, edge, (V.edgecount+1) as node, edge/(V.edgecount+1) as cont from "
				+ "(select complaintid, count(*) as edge from T group by complaintid) as A, V where A.complaintid = V.complaintid";
		dbhandler.queryExecution(deleteTsql);
		dbhandler.queryExecution(createTsql);
		dbhandler.queryExecution(createVsql);
		dbhandler.queryExecution(createCsql);
		
		// start the computation
		Linearization linearization = new Linearization(epsilon, M);
		for(int key: complaints.compmap.keySet()) {
			// get complaint set
			SingleComplaint scp = complaints.compmap.get(key);
			// find a fix
			// compare preds and correct ds
			boolean isSame = preds.getTuple(scp.key).compare(scp.values);
			linearization.setSingleFix(isSame);
			Query fixedquery = computeSolution(cplex, linearization, table, dss, qlog, qidx, scp);
			// update related table & views
			update(dbhandler, preds, nextds, qidx, fixedquery, attrs, scp);
			// clear solver
			linearization.clear();
		}
		Complaint pruned = filterByDensity(dbhandler, setattrlist, complaints);
		return pruned;
	}
	
	/* find solution for current complaint*/
	public static Query computeSolution(IloCplex cplex, Linearization linearization, Table table, DatabaseStates dss, QueryLog qlog, int qidx, SingleComplaint scp) throws Exception {
		Complaint complaint = new Complaint();
		complaint.add(scp);
		HashSet<Integer> curcand = new HashSet<Integer>();
		curcand.add(qidx);
		QueryLog qlogfix = linearization.fixParameters(cplex, table, qlog, dss, complaint, curcand, qidx, qlog.size()); 
		return qlogfix.get(qidx);
	}
	
	/* update table T; view V, Contribution based on fix */
	public static void update(DatabaseHandler dbhandler, DatabaseState pre, DatabaseState next, int qidx, Query fixedquery, String[] attrs, SingleComplaint scp) throws Exception {
		// based on current fixedquery, update table T
		DatabaseState fixedds = QueryLog.executeSingleQuery(pre.getTable() + "_" + qidx, qidx, fixedquery, dbhandler);
		// define query
		String inrtsql = "";
		// find all tuples different with values in next state
		for(int key : fixedds.getKeySet()) {
			Tuple fixed = fixedds.getTuple(key);
			Tuple dirty = next.getTuple(key);
			if(!fixed.compare(dirty.values)) {
				inrtsql += "insert into T values (" + scp.key + "," + fixedds.getValue(key, pre.getPrimaryKey()) + ",";
				for(int i = 0; i < attrs.length; ++i) {
					inrtsql += String.valueOf(fixedds.getValue(key, attrs[i]));
					if(i < attrs.length - 1)
						inrtsql += ", ";
				}
				inrtsql += ");";
			}
		}
		dbhandler.queryExecution(inrtsql);
	}
	
	/* find densest complaint set*/
	public static Complaint filterByDensity(DatabaseHandler dbhandler, String setattrlist, Complaint complaints) throws Exception {

		// iteratively find complaint make least contribution, update solutions for the complaint. 
		Complaint pruned = new Complaint();
		// find initial edge count, node count
		String initquery = "SELECT count(*) as edgecount, count(distinct(complaintid)) + count(distinct(" + setattrlist + ")) as nodecount from T";
		// find complaint with minimum contribution
		String minquery = "SELECT complaintid, edge, node from contribution order by cont asc limit 1";
		// update table T
		String deletequery = "DELETE FROM T where complaintid = ";
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
				SingleComplaint sc = complaints.get(key);
				int rmedge = Integer.valueOf(current.getString(2));
				int rmnode = Integer.valueOf(current.getString(3));
				double currdensity = (edgecount - rmedge) / (nodecount - rmnode + 0.0);
				removeorder.add(sc);
				dbhandler.queryExecution(deletequery + key);
				// update max density 
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
}
