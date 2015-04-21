package queryprovenance.problemsolution;

import java.util.HashMap;
import java.util.Set;

import queryprovenance.database.DatabaseHandler;
import queryprovenance.database.Table;

public class ComplaintRange {
	
	public HashMap<Integer, SingleComplaintRange> compmap =  new HashMap<Integer, SingleComplaintRange>(); 
	
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
	/* get single complaint by key */
	public SingleComplaintRange get(Integer key) {
		return compmap.get(key);
	}
	/* get complaint key set*/
	public Set<Integer> keySet() {
		return compmap.keySet();
	}
	/* check existance of key */
	public boolean containsKey(Integer key) {
		return compmap.containsKey(key);
	}
}
