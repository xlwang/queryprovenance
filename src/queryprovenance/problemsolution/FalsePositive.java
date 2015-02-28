package queryprovenance.problemsolution;

import java.util.Collection;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import queryprovenance.database.DatabaseState;
import queryprovenance.query.Query;

/*
 * Density approach for false positives
 */
public class FalsePositive {
	
	/*
	 *  A solution for a given complaint moves a single attribute
	 */
	class Solution {
		int key;      // primary key
		String col;
		String value;
	}
	
	class Region {
		// not surewhat to put here
	}
	
	public static Complaint densityFilter(DatabaseState ds, Query q, Complaint complaints) throws Exception {
		Set<Solution> solutions = new HashSet<Solution>();
		for (int pk : complaints.keySet()) {
			SingleComplaint sc = complaints.get(pk);
			solutions.addAll(computeSolutions(q, sc));
		}
		List<Region> regions = summarizeIntoRegions(ds, solutions);
		
		filterByDensity(regions, solutions);
		return complaints;
	}
	
	/*
	 *  Given a complaint and a query, find the "best" solution for it
	 */
	public static List<Solution> computeSolutions(Query q, SingleComplaint complaint) throws Exception {
		List<Solution> solutions = null;
		return solutions;
	}
	
	/*
	 * Given the database and the solutions, summarize the tuples in each region
	 */
	public static List<Region> summarizeIntoRegions(DatabaseState ds, Collection<Solution> solutions) throws Exception {
		return null;
	}
	
	/*
	 * Is the region affected by the solution?
	 */
	public static boolean isAffected(Region region, Solution solution, Query query) {
		return false;
	}
	
	/*
	 * Use the bipartite-graph-based algorithm 
	 */
	public static void filterByDensity(List<Region> regions, Collection<Solution> solutions) {
		
	}

	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

}
