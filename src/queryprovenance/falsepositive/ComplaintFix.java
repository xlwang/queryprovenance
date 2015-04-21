package queryprovenance.falsepositive;

import java.util.HashMap;
import java.util.HashSet;
import java.util.PriorityQueue;

public class ComplaintFix implements Comparable<ComplaintFix>{
	public int id; // complaint identifier
	HashSet<String> fulltuplelist = new HashSet<String>(); // list of tuples: edge
	HashSet<String> nodelist = new HashSet<String>();
	public double contribution = 0; // current contribution
	
	public ComplaintFix(int id_) {
		id = id_;
	}
	
	public void addTuple(TupleFix tuple) {
		fulltuplelist.add(tuple.toString());
	}
	
	public void addNode(String key) {
		nodelist.add(key);
	}
	
	public void update() {
		contribution = (double) (fulltuplelist.size() / (1.0 + nodelist.size()));
	}
	
	public void delete(HashMap<Integer, ComplaintFix> allcomplaints, HashMap<String, TupleFix> alltuples, HashSet<String> nodelist, PriorityQueue<ComplaintFix> sortedcomplaints) {
		// delete current complaint from all complaints list
		allcomplaints.remove(this.id);
		// update tuples
		for(String tuplekey : fulltuplelist) {
			if(nodelist.contains(tuplekey)) {
				alltuples.remove(tuplekey);
				nodelist.remove(tuplekey);
			} else {
				TupleFix tuple = alltuples.get(tuplekey);
				tuple.complaintlist.remove(this.id);
				// if tuple has only one edge
				if(tuple.complaintlist.size() == 1) {
					nodelist.add(tuplekey);
					ComplaintFix modify = allcomplaints.get(tuple.complaintlist.iterator().next());
					modify.addNode(tuple.toString());
					modify.update();
					sortedcomplaints.remove(modify);
					sortedcomplaints.offer(modify);
				}
			}
		}
	}
	
	public int compareTo(ComplaintFix o) {
		return Double.compare(this.contribution, o.contribution);
	}
}
