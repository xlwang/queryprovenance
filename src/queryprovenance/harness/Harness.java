package queryprovenance.harness;

import queryprovenance.database.DatabaseHandler;
import queryprovenance.database.DatabaseStates;
import queryprovenance.problemsolution.Complaint;
import queryprovenance.problemsolution.SolveAll;
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
		QueryLog qlog = QueryLog.generate(params);
		DatabaseStates ds = qlog.execute(handler);
		params.qlog = qlog;
				
		// bad query log
		Transformation trans = Transformation.generate(params);
		QueryLog badqlog = trans.apply(qlog);
		DatabaseStates badds = badqlog.execute(handler);
		Complaint complaint = Complaint.generateComplaintSet(ds.get(ds.size()-1), badds.get(badds.size()-1));
		
		String[] options = new String[]{"-M","1"};
		SolveAll instance = new SolveAll(options);
		QueryLog fixedqlog = instance.solve(qlog, ds, badds, complaint);
		
		// evaluate fixedqlog vs qlog
		
	}
}
