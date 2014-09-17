package queryprovenance.harness;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import queryprovenance.database.DatabaseStates;
import queryprovenance.problemsolution.Complaint;

/*
 * Currently just a wrapper for computing a set of metrics for different
 * querylogs and database states
 */
public class Metrics {
	// list of metric types
	public static enum Type {
		
	}
	
	// wrapper to compute _all_ metrics we can think of
	// XXX: how to represent all these metrics?
	public static HashMap<Type, String> evaluateAll(
			QueryLog qlog, DatabaseStates ds,
			QueryLog badqlog, DatabaseStates badds, 
			QueryLog fixedqlog, DatabaseStates fixedds) {
		
		
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
}
