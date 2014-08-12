package queryprovenance.harness;

import queryprovenance.database.DatabaseHandler;
import queryprovenance.database.DatabaseStates;
import queryprovenance.problemsolution.Complaint;
import queryprovenance.problemsolution.SolveAll;
import queryprovenance.query.Query;
import queryprovenance.query.Table;

public class Harness {
	public static void main(String[] args) throws Exception {
		DatabaseHandler handler = new DatabaseHandler();
		handler.getConnected();
		handler.executePrepFile("./data/setup.sql");
		handler.executePrepFile("./data/inserts.sql");
		
		// TODO: somehow generate initial dataset
		ExpParams params = ExpParams.instance();
		String[] cols = new String[]{"employeeId", "level", "salary"};
		Table.Type[] types = new Table.Type[]{Table.Type.NUM, Table.Type.NUM, Table.Type.NUM};
		Object[] domains = new Object[]{new int[]{0, 10}, new int[]{1, 6}, new int[]{0, 300000}};
		Table t = new Table("Employee", cols, types, domains, 0);
		params.table = t;
		params.ql_nqueries = 5;
		params.ql_qtypes = null;
		
		// correct query log
		System.out.println("True Query Log: ");
		QueryLog qlog = QueryLog.generate(params);
		DatabaseStates ds = qlog.execute(handler);
		params.qlog = qlog;
				
		// bad query log
		// xl: transformation will not change query structure
		// for example,
		// we don't support transfer from UPDATE Employee SET level = (level+1.0) WHERE employeeId<=4.0 to UPDATE Employee SET level = (level+1.0) WHERE salary<=273963.0.
		// but support transfer from UPDATE Employee SET level = (level+1.0) WHERE employeeId<=4.0 to UPDATE Employee SET level = (level+1.0) WHERE employeeId<=3.0 . 
		// revert db state to original
		System.out.println("Transformation: ");
		Transformation trans = Transformation.generate(params);
		QueryLog badqlog = trans.apply(qlog);
		System.out.println("Wrong Query Log: ");
		DatabaseStates badds = badqlog.execute(handler);
		//Complaint complaint = Complaint.generateComplaintSet(ds.get(ds.size()-1), badds.get(badds.size()-1));
		Complaint complaint = null;
		String[] options = new String[]{"-M", "1", "-E", "0.1", "-O", "abs"};
		SolveAll instance = new SolveAll(options);
		
		// xl: need for input
		// 1. query log; size m
		// 2. ds: size m+1: initial states with no query execute
		// 3. badds: size m+1. 
		boolean validtrans= true;
		for(int i = 0; i < ds.size(); ++i)
			validtrans &= ds.get(i).isSame(badds.get(i));
		if(validtrans)
			return;
	    QueryLog fixedqlog = instance.solve(badqlog, ds, badds, complaint);
		
	    System.out.println("Fixed Query Log: ");
	    for(Query q:fixedqlog)
	    	System.out.println(q.toString());
	    	
		// evaluate fixedqlog vs qlog
		
	}
}
