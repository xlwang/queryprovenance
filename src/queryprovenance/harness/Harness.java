package queryprovenance.harness;

import queryprovenance.database.DatabaseHandler;
import queryprovenance.database.DatabaseStates;
import queryprovenance.problemsolution.Complaint;
import queryprovenance.problemsolution.SolveAll;

public class Harness {
	public static void main(String[] args) throws Exception {
		
		// TODO: somehow generate initial dataset
		ExpParams params = null;
		DatabaseHandler handler = null;
		
		// correct query log
		QueryLog qlog = QueryLog.generate(params);
		DatabaseStates ds = qlog.execute(handler);
				
		// bad query log
		Transformation trans = Transformation.generate(params);
		QueryLog badqlog = trans.apply(qlog);
		DatabaseStates badds = badqlog.execute(handler);
		Complaint complaint = null;  // ds.difference(badqlog)
		
		String[] options = new String[]{"-M","1"};
		SolveAll instance = new SolveAll(options);
		QueryLog fixedqlog = instance.solve(qlog, ds, badds, complaint);
		
		// evaluate fixedqlog vs qlog
		
	}
}
