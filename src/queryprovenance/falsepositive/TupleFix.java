package queryprovenance.falsepositive;

import java.util.HashSet;

import queryprovenance.harness.Util;

public class TupleFix {
	public String[] values; // identify a tuple
	public HashSet<Integer> complaintlist = new HashSet<Integer>();
	
	public TupleFix(String[] v_) {
		values = v_;
	}
	
	public void addComplaint(ComplaintFix complaint) {
		complaintlist.add(complaint.id);
	}
	
	public String toString() {
		return Util.join(values, ":");
	}
}
