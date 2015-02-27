package queryprovenance.harness;

import ilog.cplex.IloCplex;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.util.HashMap;

import queryprovenance.database.DataGenerator;
import queryprovenance.database.DatabaseHandler;
import queryprovenance.database.DatabaseStates;
import queryprovenance.database.Table;
import queryprovenance.problemsolution.Complaint;
import queryprovenance.problemsolution.QueryLog;
import queryprovenance.problemsolution.Solution;

public class Harness {
	QueryLog qlog = null;
	QueryLog badqlog = null; 
	DatabaseStates ds = null; 
    DatabaseStates badds = null;
	Complaint complaint = null;
	Table table = null;
	
	public static void main(String[] args) throws Exception {
		int[] clause_count = {1,    1,   1, 1,1};// 1,    1,     1,    1,   1,    1,   1,      1,  5,   5,    5,   5,    5,     5,   5,    5,    5,     5,   2,   3,  4,   2,    3,   4,   1,   1,   1,  5,  5,    5};
		int[] qlog_count =   {1,    2,   3,4,5};//5,    5,     5,   20,  20,   20,  20,     20,  5,   5,    5,   5,    5,    20,  20,   20,   20,    20,   5,   5,  5,   20,  20,  20,   1,  10,  15,  1,  10,  15};
		int[] tuple_count =  {500, 500,500,500,500 };//1000, 5000, 10000, 100, 500, 1000, 5000, 10000,100, 500, 1000, 5000, 10000, 100, 500, 1000, 5000, 10000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000};
		
		IloCplex cplex = new IloCplex();
		int run_count = 100;
		int totalcount = 0;
		double percentage = 0.5;
		double[] complaintpercentage = {1};
		double[] complaintpercentage2 = {1};
		
		DatabaseHandler handler = new DatabaseHandler();
		handler.getConnected("dbconn.config");
		handler.executePrepFile("./data/setup.sql");
		handler.executePrepFile("./data/inserts.sql");
		handler.executePrepFile("./data/result.sql");
		for(int i = 0; i < clause_count.length; ++i){
			// prepare data files
			String filename = "./result/harnessresult(" + tuple_count[i] + "_" + qlog_count[i] + "_" + clause_count[i] + ").csv";
			String logpath = "./result/harnessDT" + tuple_count[i] + "_" + qlog_count[i] + "_" + clause_count[i];
			File filepath = new File(logpath);
			// create directory if not exist
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
			// for each random run
			Harness harness = new Harness();
			for(int run = 0; run < run_count; run++){
				// vary the complaint percentage
				int qidx = harness.randomInstance(handler, tuple_count[i], qlog_count[i], clause_count[i], percentage);
				
				for(int solverind = 0; solverind < 4; ++solverind){
					if(solverind == 1){
					for(int percentind = 0; percentind < complaintpercentage.length; ++percentind ){
							// vary the solver
						harness.singleRun(handler, cplex, qlog_count[i], clause_count[i], totalcount++, tuple_count[i],logpath, solverind, complaintpercentage2[percentind], complaintpercentage[percentind], qidx);
					}
					}
					else{
					harness.singleRun(handler, cplex, qlog_count[i], clause_count[i], totalcount++, tuple_count[i],logpath, solverind, 1, 1, qidx);	
					}
				}
			}
			//out.close();
		}
	}

	public int randomInstance(DatabaseHandler handler, int tuple_count, int qlog_count, int clause_count, double percentage) throws Exception {
			// generate data 
			DataGenerator.generatorData(tuple_count);

			// TODO: somehow generate initial dataset
			ExpParams params = ExpParams.instance();
			String[] cols = new String[]{"employeeId", "level", "age", "employmentyear", "tax", "salary"};
			Table.Type[] types = new Table.Type[]{Table.Type.NUM, Table.Type.NUM, Table.Type.NUM, Table.Type.NUM, Table.Type.NUM, Table.Type.NUM};
			Object[] domains = new Object[]{new int[]{0, 10},new int[]{1, 6}, new int[]{20, 60}, new int[]{0, 40}, new int[]{0, 9000}, new int[]{0, 300000}};
			table = new Table("Employee", cols, types, domains, 0);
			params.table = table;
			params.ql_nqueries = qlog_count;
			params.ql_nclauses = clause_count;
			params.ql_qtypes = null;

			// correct query log
			qlog = QueryLog.generate(params);
			ds = qlog.execute(table.getName(), handler);
			params.qlog = qlog;

			//System.out.println("Transformation: ");
			Transformation trans = Transformation.generate(params, percentage);
			badqlog = trans.apply(qlog);
			//System.out.println("Wrong Query Log: ");
			badds = badqlog.execute(table.getName(), handler);


			// get complaint set: good ds vs. bad ds
			complaint = new Complaint(ds.get(ds.size()-1), badds.get(badds.size()-1));
			
			while(complaint.size() == 0 ){
				handler.executePrepFile("./data/setup.sql");
				handler.executePrepFile("./data/inserts.sql");
				
				qlog = QueryLog.generate(params);
				ds = qlog.execute(table.getName(), handler);
				
				params.qlog = qlog;
				trans = Transformation.generate(params, percentage); 
				
				
				badqlog = trans.apply(qlog);
				badds = badqlog.execute(table.getName(), handler);
				complaint = new Complaint(ds.get(ds.size()-1), badds.get(badds.size()-1));
			}
			return trans.qidx;
	}
	public void singleRun(DatabaseHandler handler, IloCplex cplex, int qlog_count, int clause_count, int run, int tuple_count, String logpath, int solverind, double percentage, double complaintpercentage, int qidx) throws Exception{
		// prepare log data files
		File datapath = new File(logpath + "/" + run);
		if(!datapath.exists())
			datapath.createNewFile();
		BufferedWriter dataout = new BufferedWriter(new FileWriter(datapath.getAbsoluteFile()));
		
		
		// set parameters for solver
		String[] options = new String[]{"-M", String.valueOf(solverind) , "-E", "0.1", "-O", "abs"};

		// solve bad query log
		//QueryLog fixedqlog = instance.solve(cplex, badqlog, ds, badds, complaint);
		//
		
		// solve bad query log with incomplete complaint set
		// Complaint incomplete = complaint.getPart(complaintpercentage);
		Solution solver2 = new Solution(handler, badds, badqlog, complaint);
		//QueryLog fixedqlog = solver2.onePassSolution(cplex, handler, badds, badqlog, complaint, 0.1, 300000, true, options);
		QueryLog fixedqlog = new QueryLog();
		switch(solverind) {
		case 0: fixedqlog = solver2.onePassSolution(cplex, 0.1, 300000, true, false, false, options); break;
		case 1: fixedqlog = solver2.onePassSolution(cplex, 0.1, 300000, false, false, false, options); break;
		case 2: fixedqlog = solver2.twoPassSolution(cplex, 0.1, 300000, true, false, false, 1, options); break;
		case 3: fixedqlog = solver2.twoPassSolution(cplex, 0.1, 300000, false, false, false, 1, options);
		}
		/*
		if(solverind != 1) {
			fixedqlog = solver2.onePassSolution(cplex, handler, badds, badqlog, complaint, 0.1, 300000, false, options);
		} else {
			fixedqlog = solver2.twoPassSolution(cplex, handler, badds, badqlog, complaint, 0.1, 300000, false, 1, options);
		}
		*/
		long[] computetime = solver2.getTime();
		//Linearization linearizesolver = new Linearization(0);
		// Complaint rollback = new Complaint();
		//linearizesolver.solve(cplex, table, badqlog, badds, complaint, fixedqlog, rollback);
		/*
		if(percentage < 1){
			complaint = complaint.getPart(complaintpercentage);
			fixedqlog = instance.solveIncomplete(cplex, badqlog, ds, badds, complaint);
		}
		else
			fixedqlog = instance.solve(cplex, badqlog, ds, badds, complaint);
		*/
		DatabaseStates fixedds = fixedqlog.execute(table.getName(), handler);
		
		// get metrics 
		// long[] computetime = instance.computeTime();

		// get metrics
		HashMap<Metrics.Type, Double> metrics = Metrics.evaluateAll2(qlog, ds, badqlog, badds, fixedqlog, fixedds);
		
		String metric_value = Metrics.toString(metrics);
		Metrics.Index diff = Metrics.compare(badqlog, fixedqlog, 0.1);
		
		// insert data into result table
		String solver = solverind < 2 ? "cplex_1":"cplex_2";
		String preprocess = solverind % 2 == 0 ? "1" : "0";
		String resultqurey = "INSERT INTO RESULT VALUES (" +run +"," + percentage+ "," + "'" + solver + "'" + ","
				+ "" + clause_count + "," + qlog_count + "," + tuple_count + ",'" + preprocess + "'," + "1," + metric_value + "'" + qidx+ "','" + diff + "',"
								+ ""+ computetime[0] + "," + computetime[1] + "," + computetime[2] + "," + computetime[3] + ")";
		handler.queryExecution(resultqurey);
		dataout.write("query log, bad query log, fixed query log"); dataout.newLine();
		for(int i = 0; i < qlog.size(); ++i){
			dataout.write(qlog.get(i) + "," + badqlog.get(i) + "," + fixedqlog.get(i));
			dataout.newLine();
		}
		dataout.close();
	}
}
