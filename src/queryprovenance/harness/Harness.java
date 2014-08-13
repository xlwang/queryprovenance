package queryprovenance.harness;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;

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
		
		String filename = "./result/harnessresult.txt";
		File file = new File(filename);
		if(!file.exists())
			file.createNewFile();
		FileWriter filewriter = new FileWriter(file.getAbsoluteFile());
		BufferedWriter out = new BufferedWriter(filewriter);

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
		
		// write into file
		out.write("True Query Log: "); out.newLine();
		for(Query q:qlog){
			out.write(q.toString()); out.newLine();		
		}
				
		// bad query log
		// xl: transformation will not change query structure
		// for example,
		// we don't support transfer from UPDATE Employee SET level = (level+1.0) WHERE employeeId<=4.0 to UPDATE Employee SET level = (level+1.0) WHERE salary<=273963.0.
		// but support transfer from UPDATE Employee SET level = (level+1.0) WHERE employeeId<=4.0 to UPDATE Employee SET level = (level+1.0) WHERE employeeId<=3.0 . 
		// revert db state to original
		//System.out.println("Transformation: ");
		Transformation trans = Transformation.generate(params);
		QueryLog badqlog = trans.apply(qlog);
		//System.out.println("Wrong Query Log: ");
		DatabaseStates badds = badqlog.execute(handler);
		
		// write into file
		out.write("Wrong Query Log: "); out.newLine();
		for(Query q:badqlog){
			out.write(q.toString()); out.newLine();		
		}
		//Complaint complaint = Complaint.generateComplaintSet(ds.get(ds.size()-1), badds.get(badds.size()-1));
		Complaint complaint = null;
		String[] options = new String[]{"-M", "1", "-E", "0.1", "-O", "abs"};
		SolveAll instance = new SolveAll(options);
		
		// solve bad query log
	    QueryLog fixedqlog = instance.solve(badqlog, ds, badds, complaint);
		
		// write into file
		out.write("Fixed Query Log: "); out.newLine();
		for(Query q:fixedqlog){
			out.write(q.toString()); out.newLine();		
		}
		
		// evaluate fixedqlog vs qlog
	    DatabaseStates fixedds = fixedqlog.execute(handler);
	    boolean validtrans= true;
		for(int i = 0; i < ds.size(); ++i)
			validtrans &= ds.get(i).isSame(fixedds.get(i));
		// write into file
		out.write("Matching all Database States with true query log? " + String.valueOf(validtrans)); out.newLine();
		out.close();

	}
}
