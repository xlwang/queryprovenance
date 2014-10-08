package queryprovenance.problemsolution;

import java.util.ArrayList;
import java.util.Hashtable;
import java.util.Set;

import queryprovenance.database.DatabaseState;

public class Complaint {
	
	public class SingleComplaint{
		public String key;
		public String[] values;
		SingleComplaint(String key_, String[] values_){
			key = key_;
			values = values_;
		}
	}
	
	ArrayList<SingleComplaint> complaint_set;
	Hashtable<String, SingleComplaint> complaint_ht;
	
	public Complaint() {
		complaint_set = new ArrayList<SingleComplaint>();
		complaint_ht = new Hashtable<String, SingleComplaint>();
	}
	
	/* generateComplaintSet(databasestate1, databasestate2) */
	public Complaint(DatabaseState db_state_clean, DatabaseState db_state){
		complaint_ht = new Hashtable<String, SingleComplaint>();
		
		// initialize a complaint set by providing a "dirty" database state and a "clean" database state
		complaint_set = new ArrayList<SingleComplaint>();
		// add complaints from clean database state
		for(String key:db_state_clean.getKeySet()){
			if(db_state.containTuple(key)){
				String[] values_clean = db_state_clean.getTuple(key);
				String[] values = db_state.getTuple(key);
				boolean isSame = true;
				for(int i = 0; i < values_clean.length; ++i){
					if(!values_clean[i].equals(values[i]))
						isSame = false;
				}
				if(!isSame)
					complaint_set.add(new SingleComplaint(key, values_clean));
			}
			else
				complaint_set.add(new SingleComplaint(key, db_state_clean.getTuple(key)));
		}
		// add complaint from "dirty" database state
		for(String key:db_state.getKeySet()){
			if(!db_state_clean.containTuple(key))
				complaint_set.add(new SingleComplaint(key, null));
		}
		
		for (SingleComplaint sc: complaint_set) {
			complaint_ht.put(sc.key, sc);
		}
	}
	
	public void add(SingleComplaint sc) {
		complaint_set.add(sc);
		complaint_ht.put(sc.key,  sc);
	}
	
	public boolean contains(String key) {
		return complaint_ht.contains(key);
	}
	
	public SingleComplaint get(String key) {
		return complaint_ht.get(key);
	}
	
	public Set<String> keySet() {
		return complaint_ht.keySet();
	}
	
	public Complaint difference(Complaint o) {
		Complaint ret = new Complaint();
		for (String key : keySet()) {
			if (!o.complaint_ht.containsKey(key)) {
				ret.add(this.get(key));
			}
		}
		return ret;
	}
	
	public Complaint intersect(Complaint o) {
		return o.difference(this.difference(o));
	}
	
	public int size() {
		return complaint_set.size();
	}
	
}
