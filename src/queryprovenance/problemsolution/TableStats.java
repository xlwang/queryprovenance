package queryprovenance.problemsolution;

import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;

import queryprovenance.database.DatabaseState;



public class TableStats extends Hashtable<String, int[]> {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;



	public TableStats() {
	}
	
	public void add(String attr, int minv, int maxv) {
		int[] range = new int[]{minv, maxv};
		this.put(attr, range);
	}
	
	public static TableStats fromTable(DatabaseState db) {
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
		
		return null;
	}
}
