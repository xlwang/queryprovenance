package queryprovenance.problemsolution;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Hashtable;
import java.util.List;
import java.util.Random;

import queryprovenance.database.DatabaseState;



public class TableStats {
	Hashtable<String, int[]> num_stats;
	Hashtable<String, List<String>> str_stats;
	Random rand;
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;



	public TableStats() {
		num_stats = new Hashtable<String, int[]>();
		str_stats = new Hashtable<String, List<String>>();
		rand = new Random();
		rand.setSeed(0);
	}
	
	public void add(String attr, int minv, int maxv) {
		int[] range = new int[]{minv, maxv};
		num_stats.put(attr, range);
	}
	
	public void add(String attr, Collection<String> vals) {
		List<String> lvals = new ArrayList<String>();
		lvals.addAll(vals);
		str_stats.put(attr, lvals);
		
	}
	
	public static TableStats fromDatabaseState(DatabaseState db) {
		TableStats stats = new TableStats();
		String[] schema = db.getColumnNames();
		Hashtable<String, List<Integer>> allstats = new Hashtable<String, List<Integer>>();
		
		// initialize allstats
		for (String col : schema) {
			allstats.put(col, new ArrayList<Integer>());
		}
		
		for (String key : db.getKeySet()) {
			String[] vals = db.getTuple(key);
			
			for (int colidx = 0; colidx < schema.length; colidx++) {
				allstats.get(schema[colidx]).add(Integer.parseInt(vals[colidx]));
			}
		}
		
		for (String col : schema) {
			List<Integer> vals = allstats.get(col);
			int minv = Integer.MAX_VALUE;
			int maxv = Integer.MIN_VALUE;
			for (int v : vals) {
				minv = Math.min(minv, v);
				maxv = Math.max(maxv, v); 
			}
			
			stats.add(col,  minv, maxv);
		}
		return stats;
	}
	
	
	
	public String randomVal(String attr) {
		if (num_stats.contains(attr)) {
			int[] colstats = num_stats.get(attr);
			int val = rand.nextInt(colstats[1] - colstats[0]) + colstats[0];
			return String.valueOf(val);
		} 
		List<String> vals = str_stats.get(attr);
		return vals.get(rand.nextInt(vals.size()));
	}
}
