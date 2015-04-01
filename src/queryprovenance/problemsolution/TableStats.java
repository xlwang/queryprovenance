package queryprovenance.problemsolution;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashSet;
import java.util.Hashtable;
import java.util.List;
import java.util.Random;
import java.util.Set;

import queryprovenance.database.DatabaseState;


/*
 * Computes and stores statics about each column in a table
 * - min/max ranges for numeric type
 * - distinct values for non-numeric types
 * 
 */
public class TableStats {
	Hashtable<String, int[]> num_stats;
	Hashtable<String, List<String>> str_stats;
	Random rand;
	
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
	
	
	/*
	 * Compute min/max statistics for numeric attributes, and 
	 * distinct values for str attributes
	 */
	public static TableStats fromDatabaseState(DatabaseState db) {
		TableStats stats = new TableStats();
		String[] schema = db.getColumnNames();
		Hashtable<String, List<Integer>> _num_stats = new Hashtable<String, List<Integer>>();
		Hashtable<String, Set<String>> _str_stats = new Hashtable<String, Set<String>>();
		Set<String> numericColumns = new HashSet<String>();
		
		// initialize allstats
		for (String col : schema) {
			_num_stats.put(col, new ArrayList<Integer>());
			_str_stats.put(col, new HashSet<String>());
		}
		
		for (Integer key : db.getKeySet()) {
			String[] vals = db.getTuple(key).values;
			
			for (int colidx = 0; colidx < schema.length; colidx++) {
				String attr = schema[colidx];
				try {
					int val = Integer.parseInt(vals[colidx]);
					_num_stats.get(attr).add(val);
					numericColumns.add(attr);
				} catch(Exception e) {
					try {
						int val = (int)Float.parseFloat(vals[colidx]);
						_num_stats.get(attr).add(val);
						numericColumns.add(attr);
					} catch(Exception ee) {
						_str_stats.get(attr).add(vals[colidx]);
					}
				}
			}
		}
		
		for (String col : schema) {
			if (numericColumns.contains(col)) {
				List<Integer> vals = _num_stats.get(col);
				int minv = Integer.MAX_VALUE;
				int maxv = Integer.MIN_VALUE;
				for (int v : vals) {
					minv = Math.min(minv, v);
					maxv = Math.max(maxv, v); 
				}

				stats.add(col,  minv, maxv);
			} else {
				stats.add(col, _str_stats.get(col));
			}
		}
		return stats;
	}
	
	
	
	public String randomVal(String attr) {
		if (num_stats.containsKey(attr)) {
			int[] colstats = num_stats.get(attr);
			int val = 0;
			if(colstats[1] - colstats[0] > 0)
				val = rand.nextInt(colstats[1] - colstats[0]) + colstats[0];
			return String.valueOf(val);
		} 
		List<String> vals = str_stats.get(attr);
		return vals.get(rand.nextInt(vals.size()));
	}
}
