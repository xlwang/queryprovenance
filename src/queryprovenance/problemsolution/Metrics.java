package queryprovenance.problemsolution;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import queryprovenance.database.DatabaseStates;

/*
 * Currently just a wrapper for computing a set of metrics for different
 * querylogs and database states
 */
public class Metrics {
	// list of metric types
	public enum Type {
		BADCOMPLAINT, FIXEDCOMPLAINT, REMOVEDRATE, NOISERATE, QLOGDIST
	}
	public static class Index extends ArrayList<Integer>{
		public String toString() {
			String str = "";
			for(Integer index : this)
				str += index + ",";
			if (str.length() > 0)
				return str.substring(0, str.length() - 1);
			else
				return str;
		}
	}
	public static Index compare(QueryLog badqlog, QueryLog fixedqlog, double epsilon) {
		// compare to original querylog, get the index(es) of queries that are modified
		Index diff = new Index();
		diff.clear();
		int i = 0, j = 0;
		
		while(i < badqlog.size() && j < fixedqlog.size()) {
			boolean isSame = true;
			if(badqlog.get(i).getType() != fixedqlog.get(j).getType()) {
				diff.add(i);
				if(!isSame)
					diff.add(i);
				i++;
			} else {
				// compare set clause and where clause
				isSame &= badqlog.get(i).compare(fixedqlog.get(j), epsilon);
				if(!isSame)
					diff.add(i);
				i++; j++;
			}
		}
		return diff;
	}
	
	// wrapper to compute _all_ metrics we can think of
	// XXX: how to represent all these metrics?
	public static HashMap<Type, String> evaluateAll(
			QueryLog qlog, DatabaseStates ds,
			QueryLog badqlog, DatabaseStates badds, 
			QueryLog fixedqlog, DatabaseStates fixedds) throws Exception {
		
		
		// XXX: assume the NUMBER of queries in each qlog has not changed
		HashMap<Type, String> metrics = new HashMap<Type, String>();
		
		for (int i = 0; i < qlog.size(); i++) {
			Complaint true2badc = new Complaint(ds.get(i), badds.get(i));	
			Complaint true2fixc = new Complaint(ds.get(i), fixedds.get(i));	
			
			if (!ds.get(i).equals(fixedds.get(i))) {
				// record DS state as different
			}
			
			// compare i'th database state using their complaint sets
			if (true2fixc.size() != 0) {
				// how many complaints were _not_ fixed?
				true2badc.difference(true2fixc).size();
				
				// how many new complaints were created?
				true2fixc.difference(true2badc).size();
				
				// percentage of complaints as ratio of clean database
				float perc = (float) ((float)true2fixc.size()) / ds.get(i).size();
			}
			
			if (!qlog.get(i).equals(fixedds.get(i))) {
				// record queries are different
				
				// figure out how different they are..
				qlog.get(i).difference(fixedqlog.get(i));
			}
		}
	
		return null;
	}
	public static HashMap<Type, Double> evaluateAll2(
			QueryLog qlog, DatabaseStates ds,
			QueryLog badqlog, DatabaseStates badds, 
			QueryLog fixedqlog, DatabaseStates fixedds) throws Exception {
	
		HashMap<Type, Double> metrics = new HashMap<Type, Double>();
		// compare database state differences
		Complaint true2badc = new Complaint(ds.get(ds.size()-1), badds.get(badds.size()-1));	 // complaint set from true db state to bad db state
		Complaint true2fixc = new Complaint(ds.get(ds.size()-1), fixedds.get(fixedds.size()-1));	// complaint set from true db state to fixed db state
		metrics.put(Type.BADCOMPLAINT, (double) true2badc.size()); // insert # of complaints in bad db state
		metrics.put(Type.FIXEDCOMPLAINT, (double) true2fixc.size()); // insert # of complaints in fixed db state
		if(true2fixc.size() > 0){
			int inter_fixbad = true2badc.intersect(true2fixc).size(); // get # of overlap complaints between fixed and bad
			int fix2bad_diff = true2fixc.difference(true2badc).size(); 
			int bad2fix_diff = true2badc.difference(true2fixc).size();
			metrics.put(Type.REMOVEDRATE, (double) bad2fix_diff/true2badc.size());
			metrics.put(Type.NOISERATE, (double) fix2bad_diff/true2badc.size());
			//metrics.put(Type.REMAINRATE, (double) inter_fixbad/true2badc.size());
		}
		else{
			metrics.put(Type.REMOVEDRATE, 1.0);
			metrics.put(Type.NOISERATE, 0.0);
			//metrics.put(Type.REMAINRATE, 0.0);
		}
		
		// compare query log difference
		
		return metrics;
	}
	
	public static String toString(HashMap<Type, Double> metrics){
		String out = metrics.get(Type.BADCOMPLAINT) + "," + metrics.get(Type.FIXEDCOMPLAINT) + "," + metrics.get(Type.REMOVEDRATE) + "," + metrics.get(Type.NOISERATE) + ",";
		return out;
	}
}
