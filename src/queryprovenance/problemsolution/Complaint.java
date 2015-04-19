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
	
	public Hashtable<Integer, SingleComplaint> compmap;
	
	public Complaint() {
		//complaint_set = new ArrayList<SingleComplaint>();
		compmap = new Hashtable<Integer, SingleComplaint>();
	}
	
	/* generateComplaintSet(databasestate1, databasestate2) */
	public Complaint(DatabaseState ds, DatabaseState badds){
		compmap = new Hashtable<Integer, SingleComplaint>();
		
		// initialize a complaint set by providing a "dirty" database state and a "clean" database state
		// add complaints from clean database state
		for(Integer key:ds.getKeySet()){
			if(badds.containTuple(key)){
				String[] values_clean = ds.getTuple(key).values;
				String[] values = badds.getTuple(key).values;
				boolean isSame = true;
				for(int i = 0; i < values_clean.length; ++i){
					if(!values_clean[i].equals(values[i]))
						isSame = false;
				}
				if(!isSame)
					compmap.put(key, new SingleComplaint(key, values_clean));
			}
			else
				compmap.put(key, new SingleComplaint(key, ds.getTuple(key).values));
		}
		// add complaint from "dirty" database state
		for(Integer key:badds.getKeySet()){
			if(!ds.containTuple(key))
				compmap.put(key, new SingleComplaint(key, null));
		}
	}
	public void addAll(Complaint comp) {
		this.compmap.putAll(comp.compmap);
	}
	/* get partial complaints */ 
	public Complaint getPart(double ratio){
		
		int size = compmap.size();
		int reducedsize = (int) (size * ratio); // get size of reduced complaint
		// must larger than 1
		if(reducedsize < 1)
			return this;
		// define reduced complaint set
		Object[] keys = compmap.keySet().toArray(); // get key list
		Complaint reducedcomps = new Complaint(); // initial reduced complaint
		while(reducedcomps.size() < reducedsize){
			Random rand = new Random();
			int ind = rand.nextInt(size);
			reducedcomps.add(compmap.get(keys[ind]));
		}
		return reducedcomps;
	}
	
	/* add single complaint */
	public void add(SingleComplaint sc) {
		//complaint_set.add(sc);
		compmap.put(sc.key,  sc);
	}
	
	/* add complaint by key value*/
	public void add(Integer key, String[] value){
		SingleComplaint comp = new SingleComplaint(key, value);
		compmap.put(key, comp);
	}
	
	/* check existance of key */
	public boolean contains(Integer key) {
		return compmap.contains(key);
	}
	
	/* get single complaint by key */
	public SingleComplaint get(Integer key) {
		return compmap.get(key);
	}
	
	/* get complaint key set*/
	public Set<Integer> keySet() {
		return compmap.keySet();
	}
	
	/* compare two complaints: this - o*/
	public Complaint difference(Complaint o) {
		Complaint ret = new Complaint();
		for (Integer key : keySet()) {
			if (!o.compmap.containsKey(key)) {
				ret.add(this.get(key));
			}
		}
		return ret;
	}
	
	/* compare two complaint: this intersect o*/
	public Complaint intersect(Complaint o) {
		return o.difference(this.difference(o));
	}
	
	/* return the size of complaint */
	public int size() {
		return compmap.size();
	}
	
	public Complaint clone() {
		Complaint ret = new Complaint();
		for (SingleComplaint sc : compmap.values()) {
			ret.add(sc.clone());
		}
		return ret;
	}
	
	public SingleComplaint remove(Integer key) {
		SingleComplaint sc = compmap.remove(key);
		return sc;
	}
	/*
	 * @param stats table statistics 
	 * First remove complaints randomly according to false negative percentage (fn)
	 * Then add randomly fake complaints according to false positive rate (fp)
	 */
	public static Complaint addNoise(
			Complaint c,
			DatabaseState db,
			float fp, 
			float fn) {
		
		Complaint ret = c.clone();
		TableStats stats = TableStats.fromDatabaseState(db);
		int primarykeyidx = db.getTable().getKeyIdx();

		// remove complaints for false negatives
		if (fn > 0) {
			List<Integer> ckeys = new ArrayList<Integer>();
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
			Set<Integer> allkeysSet = db.getKeySet();
			allkeysSet.removeAll(c.keySet());
			List<Integer> allkeys = new ArrayList<Integer>();
			allkeys.addAll(allkeysSet);

			Random rand = new Random();
			//int numPos = (int)(ret.size() * (1 - fp) / fp);
			int numPos = (int) (ret.size() * fp);
			String[] schema = db.getColumnNames();
			for (int i = 0; i < numPos && ret.size() < db.getKeySet().size(); i++) {
				Integer key = allkeys.get(i);
				String[] vals = db.getTuple(allkeys.get(i)).values.clone();

				// pick random values for each attribute dictated by the Table statistics
				for (int colidx = 0; colidx < schema.length; colidx++) {
					if (colidx != primarykeyidx)
						vals[colidx] = stats.randomVal(schema[colidx]);
				}
				ret.add(key, vals);
			}
		}
		return ret;
	}	
	
	public static Complaint getPartial(Complaint c, int count) {
		List<Integer> ckeys = new ArrayList<Integer>();
		ckeys.addAll(c.keySet());
		Collections.shuffle(Arrays.asList(c.keySet()));
		Complaint ret = c.clone();
		for (int i = 0; i < c.size() - count; i++) {
			ret.remove(ckeys.get(i));
		}
		return ret;
	}

}
