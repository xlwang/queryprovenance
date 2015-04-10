package queryprovenance.falsepositive;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.PriorityQueue;
import java.util.Set;

import ilog.cplex.IloCplex;
import queryprovenance.database.DatabaseHandler;
import queryprovenance.database.DatabaseState;
import queryprovenance.database.DatabaseStates;
import queryprovenance.database.Table;
import queryprovenance.database.Tuple;
import queryprovenance.harness.Util;
import queryprovenance.problemsolution.Complaint;
import queryprovenance.problemsolution.Linearization;
import queryprovenance.problemsolution.QueryLog;
import queryprovenance.problemsolution.SingleComplaint;
import queryprovenance.query.Query;
import weka.core.Utils;

/** FalsePositiveAll: support remove false positives for both set clasue error and where clause error. Use cplex (instead of bounding box) to derive single complaint fix
 *                    * only support query by query pruning *
 *  densityFilter: prune false positives for query badQueries(qidx)
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
	public static Complaint densityFilter(IloCplex cplex, 
			DatabaseHandler dbhandler,  
			DatabaseStates badDss, 
			QueryLog badQueries, 
			HashSet<Integer> qidxs, 
			int startidx, int endidx, 
			Complaint complaints, 
			double epsilon, double M,
			float percentage, 
			long[] time) throws Exception {
		long solvertime = 0, updatetime = 0, starttime, endtime;
		// initialize variables
		HashMap<Integer, ComplaintFix> allcomplaints = new HashMap<Integer, ComplaintFix>();
		HashMap<String, TupleFix> alltuples = new HashMap<String, TupleFix>();
		HashSet<String> nodelist = new HashSet<String>();
		PriorityQueue<ComplaintFix> sortedcomplaints = new PriorityQueue<ComplaintFix>();
		
		Table table = badDss.iterator().next().getTable();
		// get modified attributes
		List<String> attrs = new ArrayList<String>();
		attrs.add(table.getPrimaryKey());
		// get query
		for(Integer qidx : qidxs) {
			Query query = badQueries.get(qidx);
			// prepare sql query
			 attrs.addAll(query.getModifiedAttr());
		}
		
		DatabaseState preds = badDss.get(startidx);
		DatabaseState nextds = badDss.get(endidx > startidx ? endidx : endidx + 1);
		HashSet<String> dirtymap = new HashSet<String>();
		for(Integer key : nextds.getKeySet()) {
			dirtymap.add(Util.join(nextds.getTuple(key).values, ":)"));
		}
		// start the computation
		Linearization linearization = new Linearization(epsilon, M);
		int edgecount = 0;

		HashMap<String, DatabaseStates> fixedDssmap = new HashMap<String, DatabaseStates>();
		HashMap<String, QueryLog> solutionmap = new HashMap<String, QueryLog>();
		for(int key: complaints.compmap.keySet()) {
			// get complaint set
			SingleComplaint scp = complaints.compmap.get(key);
			String values = Util.join(scp.values, ":");
			// find a fix
			starttime = System.nanoTime();
			QueryLog fixedQueries;
			if(solutionmap.containsKey(values)) {
				fixedQueries = solutionmap.get(values);
			} else {
				// compare preds and correct ds
				boolean isSame = preds.getTuple(scp.key).compare(scp.values);
				linearization.setSingleFix(isSame);
				fixedQueries = computeSolution(cplex, linearization, table, badDss, badQueries, qidxs, startidx, endidx, scp);	
			}
			endtime = System.nanoTime();
			solvertime += endtime - starttime;
			// update related table & views
			starttime = System.nanoTime();
			edgecount += update(dbhandler, preds, badDss, dirtymap, fixedQueries, fixedDssmap, attrs, startidx, endidx, scp, allcomplaints, alltuples, nodelist);
			endtime = System.nanoTime();
			updatetime += endtime - starttime;
			// clear solver
			linearization.clear();
			// early pruning
			if(fixedDssmap.size() > 20) {
				return complaints;
			}
		}
		starttime = System.nanoTime();
		// update variables
		// 1st: update nodelist
		for(String node : nodelist) {
			TupleFix tuplefix = alltuples.get(node);
			ComplaintFix complaintfix = allcomplaints.get(tuplefix.complaintlist.iterator().next());
			complaintfix.addNode(node);
		}
		// 2nd: update complaint list
		for(ComplaintFix complaintfix : allcomplaints.values()) {
			complaintfix.update();
			sortedcomplaints.offer(complaintfix);
		}
		Complaint pruned;
		if(percentage > 0) {
			pruned = filterByDensity(allcomplaints, alltuples, nodelist, sortedcomplaints, complaints, percentage);
		} else {
			pruned = filterByDensity(edgecount, allcomplaints, alltuples, nodelist, sortedcomplaints, complaints);}
		endtime = System.nanoTime();
		time[0] += solvertime;
		time[1] += updatetime;
		time[2] += endtime - starttime;
		//System.out.println(solvertime + " : " + updatetime + " : " + (endtime - starttime));
		//System.out.println(complaints.size() + " : " + fixedDssmap.size());
		return pruned;
	}
	
	/* find solution for current complaint*/
	public static QueryLog computeSolution(IloCplex cplex, 
			Linearization linearization, 
			Table table, 
			DatabaseStates badDss, 
			QueryLog badQueries, HashSet<Integer> qidxs, 
			int startidx, int endidx, 
			SingleComplaint scp) throws Exception {
		// define single complaint
		Complaint complaint = new Complaint();
		complaint.add(scp);
		QueryLog fixedQueries = linearization.fixParameters(cplex, table, badQueries, badDss, complaint, qidxs, startidx, badQueries.size()); 
		return fixedQueries;
	}
	
	/* update table T; view V, Contribution based on fix */
	public static int update(DatabaseHandler dbhandler, 
			DatabaseState pre, 
			DatabaseStates badDss, 
			HashSet<String> dirtymap, 
			QueryLog fixedQueries, 
			HashMap<String, DatabaseStates> fixedDssmap,
			List<String> attrs, 
			int startidx, int endidx, 
			SingleComplaint scp,
			HashMap<Integer, ComplaintFix> allcomplaints, 
			HashMap<String, TupleFix> alltuples, 
			HashSet<String> nodelist) throws Exception {
		int edgecount = 0;
		// create complaint
		ComplaintFix complaintfix = new ComplaintFix(scp.key);
		
		// based on current fixedquery, update table T
		if(fixedQueries == null)
			return edgecount;
		DatabaseStates fixedDss = new DatabaseStates();
		if(fixedDssmap.containsKey(fixedQueries.toString())) {
			fixedDss = fixedDssmap.get(fixedQueries.toString());
		} else {
			//fixedDss.addAll(badDss.subList(0, startidx));
			String tablename = pre.getTable().toString();
			fixedDss.addAll(fixedQueries.subList(startidx, endidx > startidx ? endidx : endidx + 1).execute(tablename, dbhandler)); //QueryLog.execute(pre.getTable().toString(), dbhandler);
			fixedDssmap.put(fixedQueries.toString(), fixedDss);
		}
		DatabaseState fixedDs = fixedDss.get(fixedDss.size() - 1);
		// define query
		// String inrtsql = "";
		// find all tuples different with values in next state
		 
		for(int key : fixedDs.getKeySet()) {
			
			Tuple fixed = fixedDs.getTuple(key);
			if(dirtymap.contains(Util.join(fixed.values, ":"))) {
				
				edgecount++;
				String[] tuplevalue = new String[attrs.size()];
				//inrtsql += "insert into T values (" + scp.key + "," + fixedDs.getValue(key, pre.getPrimaryKey()) + ",";
				for(int i = 0; i < attrs.size(); ++i) {
					tuplevalue[i] = String.valueOf(fixedDs.getValue(key, attrs.get(i)));
					//inrtsql += String.valueOf(fixedDs.getValue(key, attrs.get(i)));
					//if(i < attrs.size() - 1)
					//	inrtsql += ", ";
				}
				// create tuple if not exist
				String tuplekey = Util.join(tuplevalue, ":");
				TupleFix curtuple;
				if(alltuples.containsKey(tuplekey)) {
					curtuple = alltuples.get(tuplekey);
					if (curtuple.complaintlist.size() == 1) {
						nodelist.remove(tuplekey);
					} 
				} else {
					curtuple = new TupleFix(tuplevalue);
					alltuples.put(tuplekey, curtuple);
					nodelist.add(tuplekey);
				}
				curtuple.addComplaint(complaintfix);
				complaintfix.addTuple(curtuple);
				//inrtsql += ");";
				 
				 
			}
			
		} 
		allcomplaints.put(scp.key, complaintfix);
		//dbhandler.queryExecution(inrtsql);
		return edgecount;
	}
	
	public static Complaint filterByDensity(int edgecount, HashMap<Integer, ComplaintFix> allcomplaints,
			HashMap<String, TupleFix> alltuples, HashSet<String> nodelist, PriorityQueue<ComplaintFix> sortedcomplaints, Complaint complaints) {

		// iteratively find complaint make least contribution, update solutions for the complaint. 
		Complaint pruned = new Complaint();
		//int edgecount = allcomplaints.size();
		int nodecount = allcomplaints.size() + alltuples.size();
		double density = edgecount / (nodecount + 0.0) ;
		int maxind = 0;
		double maxdensity = density;
		List<SingleComplaint> removeorder = new ArrayList<SingleComplaint>();
		while(!sortedcomplaints.isEmpty()) {
			ComplaintFix rmvcomplaint = sortedcomplaints.poll();
			int rmedge = rmvcomplaint.fulltuplelist.size();
			int rmnode = rmvcomplaint.nodelist.size();
			double currdensity = (edgecount - rmedge) / (nodecount - rmnode + 1.0);
			removeorder.add(complaints.get(rmvcomplaint.id));
			// update max density 
			if(currdensity > maxdensity) {
				maxdensity = currdensity;
				maxind = removeorder.size();
			}
			edgecount -= rmedge;
			nodecount -= rmnode + 1;
			// update others
			rmvcomplaint.delete(allcomplaints, alltuples, nodelist, sortedcomplaints);
		}
		for(int i = maxind; i < removeorder.size(); ++i) {
			pruned.add(removeorder.get(i));
		}
		return pruned;
	}
	
	public static Complaint filterByDensity(HashMap<Integer, ComplaintFix> allcomplaints,
			HashMap<String, TupleFix> alltuples, HashSet<String> nodelist, PriorityQueue<ComplaintFix> sortedcomplaints, Complaint complaints, double percentage) {

		int removecount = (int) (complaints.size() * percentage);
		// iteratively find complaint make least contribution, update solutions for the complaint. 
		Complaint pruned = complaints.clone();
		int count = 0;
		while(count++ < removecount) {
			ComplaintFix rmvcomplaint = sortedcomplaints.poll();
			pruned.remove(rmvcomplaint.id);
			rmvcomplaint.delete(allcomplaints, alltuples, nodelist, sortedcomplaints);
		}
		
		return pruned;
	}
	
	/* find densest complaint set 
	
			/*
		String setattrs = table.getPrimaryKey() + " int, ";
		String setattrlist = table.getPrimaryKey() + ",";
		String setattrjoin = "T." + table.getPrimaryKey() + "= A." + table.getPrimaryKey() + " and ";
		for(int i = 0; i < attrs.size(); ++i) {
			setattrs += attrs.get(i) + " real";
			setattrlist += attrs.get(i);
			setattrjoin += "T." + attrs.get(i) + " = " + "A." + attrs.get(i);
			if(i < attrs.size() - 1) {
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
		public static Complaint filterByDensity(DatabaseHandler dbhandler, 
			String setattrlist, 
			Complaint complaints) throws Exception {

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
			if(nodecount < 1)
				return complaints;
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
	

	/* find densest complaint set
	public static Complaint filterByDensity2(DatabaseHandler dbhandler, 
			String setattrlist, 
			Complaint complaints, 
			float percentage) throws Exception {
		
		int removecount = (int) (complaints.size() * percentage);
		// iteratively find complaint make least contribution, update solutions for the complaint. 
		Complaint pruned = complaints.clone();
		// find complaint with minimum contribution
		String minquery = "SELECT complaintid, edge, node from contribution order by cont asc limit 1";
		// update table T
		String deletequery = "DELETE FROM T where complaintid = ";
		try {
			ResultSet current;
			int removed = 0;
			while((current = dbhandler.queryExecution(minquery)).next() && removed < removecount) {
				int key = Integer.valueOf(current.getString(1));
				pruned.compmap.remove(key);
				dbhandler.queryExecution(deletequery + key);
				removed ++;
			}
		} catch(Exception e) {
			
		}
		return pruned;
	}
	*/
}
