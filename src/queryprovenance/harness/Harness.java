package queryprovenance.harness;

import java.util.Hashtable;

import queryprovenance.database.DatabaseHandler;
import queryprovenance.database.DatabaseStates;
import queryprovenance.problemsolution.Complaint;
import queryprovenance.problemsolution.SolveAll;

public class Harness {
	public static void main(String[] args) throws Exception {
		
		// TODO: somehow generate initial dataset
		Hashtable<String, String> params = null;
		DatabaseHandler handler = null;
		
		// correct query log
		QueryLog qlog = QueryLog.generate(params);
		DatabaseStates ds = qlog.execute(handler);
				
		// bad query log
		Transformation trans = Transformation.generate(params);
		QueryLog badqlog = trans.apply(qlog);
		DatabaseStates badds = badqlog.execute(handler);
		Complaint complaint = null;  // ds.difference(badqlog)
		
		QueryLog fixedqlog = SolveAll.solve(qlog, ds, badds, complaint);
		
		// evaluate fixedqlog vs qlog
		
	}
}
