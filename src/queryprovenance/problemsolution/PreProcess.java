package queryprovenance.problemsolution;

import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import queryprovenance.database.DatabaseState;
import queryprovenance.database.DatabaseStates;
import queryprovenance.database.Tuple;
import queryprovenance.query.Query;

// preprocessing phase
public class PreProcess {

	/* find candidate queries : Single Error */
	public Set<Integer> findCandidate(DatabaseStates badds, QueryLog badqlog, Complaint compset) throws Exception {
		Set<Integer> candidate = new HashSet<Integer>();
		// get error attribute
		HashSet<Integer> wrongattribute = new HashSet<Integer>();
		DatabaseState last = badds.get(badds.size() - 1);
		for(SingleComplaint sp : compset.compmap.values()) {
			Tuple orgtuple = last.getTuple(sp.key);
			for(int i = 0; i < sp.values.length; ++i) {
				if(orgtuple.getValue(i) == null || sp.values[i] == null) {
					if(! (orgtuple.getValue(i) == null && sp.values[i] == null)) {
						wrongattribute.add(i);
					}
				} else if(!orgtuple.getValue(i).equals(sp.values[i])) {
					wrongattribute.add(i);
				}
			}
		}
		// attribute provenance
		HashMap<Integer, List<Query>> provenance = new HashMap<Integer, List<Query>>();
		for(int i = badqlog.size() - 1; i >= 0; --i) {
			Set<Integer> impact = badqlog.get(i).calculatImpact(badqlog, i, provenance);
			// compare impact with wrong attribute list
			int overlap = 0;
			for(int attr : wrongattribute) {
				if(impact.contains(attr))
					overlap ++;
			}
			if(overlap == wrongattribute.size())
				candidate.add(i);
		}
		return candidate;
	}
}
