package queryprovenance.problemsolution;

import java.util.HashMap;

import queryprovenance.database.Table;

public class ComplaintRange {
	
	private HashMap<Integer, SingleComplaintRange> compmap =  new HashMap<Integer, SingleComplaintRange>(); 
	
	public ComplaintRange() {}
	public ComplaintRange(Complaint comps) {
		for(Integer key : comps.keySet()) {
			SingleComplaintRange comp = new SingleComplaintRange(comps.get(key));
			compmap.put(key, comp);
		}
	}
	
	public void add(SingleComplaintRange scp) {
		compmap.put(scp.key, scp);
	}
	
}
