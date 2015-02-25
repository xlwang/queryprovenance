package queryprovenance.problemsolution;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Hashtable;
import java.util.List;
import java.util.Random;
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
		
		public SingleComplaint clone() {
			String[] vals = new String[values.length];
			return new SingleComplaint(key, vals);
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
	
	public Complaint clone() {
		Complaint ret = new Complaint();
		for (SingleComplaint sc : complaint_set) {
			ret.add(sc.clone());
		}
		return ret;
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
	
	public SingleComplaint remove(String key) {
		SingleComplaint sc = complaint_ht.remove(key);
		complaint_set.remove(sc);
		return sc;
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
	
	/*
	 * @param stats table statistics 
	 * First remove complaints randomly according to false negative percentage (fn)
	 * Then add randomly fake complaints according to false positive rate (fp)
	 */
	public static Complaint addNoise(
			Complaint c,
			DatabaseState db,
			TableStats stats, 
			float fp, 
			float fn) {
		
		Complaint ret = c.clone();

		// remove complaints for false negatives
		if (fn > 0) {
			List<String> ckeys = new ArrayList<String>();
			ckeys.addAll(c.keySet());
			Collections.shuffle(Arrays.asList(c.keySet()));
			
			int numNegs = (int)(fn * ckeys.size());			
			for (int i = 0; i < numNegs; i++) {
				ret.remove(ckeys.get(i));
			}
		}
		
		// add false positive complaints
		if (fp > 0) {
			// List of tuple IDs that can be used to make false positives 
			Set<String> allkeysSet = db.getKeySet();
			allkeysSet.removeAll(c.keySet());
			List<String> allkeys = new ArrayList<String>();
			allkeys.addAll(allkeysSet);

			Random rand = new Random();
			int numPos = (int)(ret.size() * (1 - fp) / fp);
			String[] schema = db.getColumnNames();
			for (int i = 0; i < numPos; i++) {
				String key = allkeys.get(i);
				String[] vals = db.getTuple(allkeys.get(i)).clone();

				// pick random values for each attribute dictated by the Table statistics
				for (int colidx = 0; colidx < schema.length; colidx++) {
					int[] colstats = stats.get(schema[colidx]);
					int val = rand.nextInt(colstats[1] - colstats[0]) + colstats[0];
					vals[colidx] = String.valueOf(val);
				}
			}
		}
				
		return ret;
	}	
}
