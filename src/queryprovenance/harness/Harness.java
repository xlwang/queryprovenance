package queryprovenance.harness;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.util.HashMap;

import queryprovenance.database.DataGenerator;
import queryprovenance.database.DatabaseHandler;
import queryprovenance.database.DatabaseStates;
import queryprovenance.problemsolution.Complaint;
import queryprovenance.problemsolution.SolveAll;
import queryprovenance.query.CplexHandler;
import queryprovenance.query.Table;

public class Harness {
	public static void main(String[] args) throws Exception {
		int[] clause_count = {1,    1,    1,    1,     1,    1,   1,    1,   1,      1,  5,   5,    5,   5,    5,     5,   5,    5,    5,     5,   2,   3,  4,   2,    3,   4,   1,   1,   1,  5,  5,    5};
		int[] qlog_count =   {5,    5,    5,    5,     5,   20,  20,   20,  20,     20,  5,   5,    5,   5,    5,    20,  20,   20,   20,    20,   5,   5,  5,   20,  20,  20,   1,  10,  15,  1,  10,  15};
		int[] tuple_count =  {100, 500, 1000, 5000, 10000, 100, 500, 1000, 5000, 10000,100, 500, 1000, 5000, 10000, 100, 500, 1000, 5000, 10000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000};
		
		CplexHandler cplex = new CplexHandler();
		//int[] clause_count = {5};
		//int[] qlog_count = {20};
		//int[] tuple_count = {1000};
		int run_count = 20;
		int totalcount = 640;
		double percentage = 0.5;
		for(int i = 0; i < clause_count.length; ++i){
			String filename = "./result/harnessresult(" + tuple_count[i] + "_" + qlog_count[i] + "_" + clause_count[i] + ").csv";
			String logpath = "./result/harnessDT" + tuple_count[i] + "_" + qlog_count[i] + "_" + clause_count[i];
			File filepath = new File(logpath);
			if(!filepath.exists()){
				try{
					filepath.mkdir();
				} catch(Exception e){
					System.out.print(e);
					return;
				}
			}
			File file = new File(filename);
			if(!file.exists())
				file.createNewFile();
			//FileWriter filewriter = new FileWriter(file.getAbsoluteFile());
			//BufferedWriter out = new BufferedWriter(filewriter);
			//out.write(" ,cardinality, logsize, dbsize, #bad_complaints, #fixed_complaints, fixed_rate, noise_rate, remain_rate, prep_time, solve_time, finish_time, total_time"); out.newLine();	
			for(int run = 0; run < run_count; run++){
				Harness instance = new Harness();
				instance.singleRun(cplex, qlog_count[i], clause_count[i], totalcount++, tuple_count[i],logpath, percentage);
			}
			//out.close();
		}
	}


	public void singleRun(CplexHandler cplex, int qlog_count, int clause_count, int run, int tuple_count, String logpath, double percentage) throws Exception{
		// prepare log data files
		File datapath = new File(logpath + "/" + run);
		if(!datapath.exists())
			datapath.createNewFile();
		BufferedWriter dataout = new BufferedWriter(new FileWriter(datapath.getAbsoluteFile()));
		
		// generate data 
		DataGenerator.generatorData(tuple_count);
		//DataGenerator datagenerator = new DataGenerator(tuple_count);
		DatabaseHandler handler = new DatabaseHandler();
		handler.getConnected();
		handler.executePrepFile("./data/setup.sql");
		handler.executePrepFile("./data/inserts.sql");


		// TODO: somehow generate initial dataset
		ExpParams params = ExpParams.instance();
		String[] cols = new String[]{"employeeId", "age", "employmentyear", "level", "tax", "salary"};
		Table.Type[] types = new Table.Type[]{Table.Type.NUM, Table.Type.NUM, Table.Type.NUM, Table.Type.NUM, Table.Type.NUM, Table.Type.NUM};
		Object[] domains = new Object[]{new int[]{0, 10},new int[]{20, 60}, new int[]{0, 40}, new int[]{1, 6}, new int[]{0, 9000}, new int[]{0, 300000}};
		Table t = new Table("Employee", cols, types, domains, 0);
		params.table = t;
		params.ql_nqueries = qlog_count;
		params.ql_nclauses = clause_count;
		params.ql_qtypes = null;

		// correct query log
		QueryLog qlog = QueryLog.generate(params);
		DatabaseStates ds = qlog.execute(handler);
		params.qlog = qlog;

		//System.out.println("Transformation: ");
		Transformation trans = Transformation.generate(params, percentage);
		QueryLog badqlog = trans.apply(qlog);
		//System.out.println("Wrong Query Log: ");
		DatabaseStates badds = badqlog.execute(handler);


		// get complaint set: good ds vs. bad ds
		Complaint complaint = new Complaint(ds.get(ds.size()-1), badds.get(badds.size()-1));
		
		while(complaint.size() == 0){
			handler.executePrepFile("./data/setup.sql");
			handler.executePrepFile("./data/inserts.sql");
			
			qlog = QueryLog.generate(params);
			ds = qlog.execute(handler);
			
			params.qlog = qlog;
			trans = Transformation.generate(params, percentage); 
			
			
			badqlog = trans.apply(qlog);
			badds = badqlog.execute(handler);
			complaint = new Complaint(ds.get(ds.size()-1), badds.get(badds.size()-1));
		}

		// set parameters for solver
		String[] options = new String[]{"-M", "0", "-E", "0.1", "-O", "abs"};
		SolveAll instance = new SolveAll(options);

		// solve bad query log
		QueryLog fixedqlog = instance.solve(cplex, badqlog, ds, badds, complaint);
		DatabaseStates fixedds = fixedqlog.execute(handler);
		
		// get metrics 
		// Metrics.evaluateAll(qlog, ds, badqlog, badds, fixedqlog, fixedds);
		long[] computetime = instance.computeTime();

		// get metrics
		HashMap<Metrics.Type, Double> metrics = Metrics.evaluateAll2(qlog, ds, badqlog, badds, fixedqlog, fixedds);
		
		String metric_value = Metrics.toString(metrics);
		
		//write files
		//out.write(String.valueOf(run) + "," + clause_count + "," + qlog_count + "," + tuple_count + "," + metric_value + computetime[0] + "," + computetime[1] + "," + computetime[2] + "," + computetime[3] + ",");
		//out.newLine();
		String resultqurey = "INSERT INTO RESULT VALUES (" +run +"," + "1.0"+ "," + "'dt'" + "," + clause_count + "," + qlog_count + "," + tuple_count + "," + metric_value + trans.qidx+ "," + instance.qidx + "," + instance.badclausesize + "," + instance.fixedclausesize +","+ computetime[0] + "," + computetime[1] + "," + computetime[2] + "," + computetime[3] + ")";
		handler.queryExecution(resultqurey);
		dataout.write("query log, bad query log, fixed query log"); dataout.newLine();
		for(int i = 0; i < qlog.size(); ++i){
			dataout.write(qlog.get(i) + "," + badqlog.get(i) + "," + fixedqlog.get(i));
			dataout.newLine();
		}
		dataout.close();
		handler = null;
		ds = null;
		badds = null;
		fixedds = null;
		qlog = null;
		badqlog = null;
		fixedqlog = null;
		/*
		// evaluate fixedqlog vs qlog  
		boolean[] validtrans = new boolean[qlog.size()+1];
		for(int i = 0; i < ds.size(); ++i)
			validtrans[i] = ds.get(i).isSame(fixedds.get(i));

		// write into file

		for(int i = 0; i < qlog.size(); ++i){
			out.write(String.valueOf(run) + "," + qlog.get(i) + "," + badqlog.get(i) + "," + fixedqlog.get(i) + "," + String.valueOf(validtrans[i+1]));
			out.newLine();
		}
		*/
	}
}
