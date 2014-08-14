package queryprovenance.harness;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;

import queryprovenance.database.DataGenerator;
import queryprovenance.database.DatabaseHandler;
import queryprovenance.database.DatabaseStates;
import queryprovenance.problemsolution.Complaint;
import queryprovenance.problemsolution.SolveAll;
import queryprovenance.query.Query;
import queryprovenance.query.Table;

public class Harness {
	public static void main(String[] args) throws Exception {
		String filename = "./result/harnessresult(100_2_5).csv";
		File file = new File(filename);
		if(!file.exists())
			file.createNewFile();
		FileWriter filewriter = new FileWriter(file.getAbsoluteFile());
		BufferedWriter out = new BufferedWriter(filewriter);
		out.write(" , True Query Log, Wrong Query Log, Fixed Query Log, Match?,"); out.newLine();
		for(int run = 0; run < 100; run++){
			int tuple_count = 100;
			DataGenerator datagenerator = new DataGenerator(tuple_count);
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
			
			//System.out.println("Transformation: ");
			Transformation trans = Transformation.generate(params);
			QueryLog badqlog = trans.apply(qlog);
			//System.out.println("Wrong Query Log: ");
			DatabaseStates badds = badqlog.execute(handler);
			

			// get complaint set: good ds vs. bad ds
			Complaint complaint = new Complaint(ds.get(ds.size()-1), badds.get(badds.size()-1));
			
			// set parameters for solver
			String[] options = new String[]{"-M", "1", "-E", "0.1", "-O", "abs"};
			SolveAll instance = new SolveAll(options);
			
			// solve bad query log
		    QueryLog fixedqlog = instance.solve(badqlog, ds, badds, complaint);
		    DatabaseStates fixedds = fixedqlog.execute(handler);
		    
		    // get complaint set: good ds vs. fixed ds
		    Complaint complaint_compare = new Complaint(ds.get(ds.size()-1), fixedds.get(badds.size()-1));
			
		    // evaluate fixedqlog vs qlog  
		    boolean[] validtrans = new boolean[qlog.size()+1];
			for(int i = 0; i < ds.size(); ++i)
				validtrans[i] = ds.get(i).isSame(fixedds.get(i));
			
			// write into file
			
			for(int i = 0; i < qlog.size(); ++i){
				out.write(String.valueOf(run) + "," + qlog.get(i) + "," + badqlog.get(i) + "," + fixedqlog.get(i) + "," + String.valueOf(validtrans[i+1]));
				out.newLine();
			}
		}
		out.close();
	}
}
