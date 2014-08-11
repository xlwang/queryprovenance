package queryprovenance.problemsolution;


import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import queryprovenance.database.DataGenerator;
import queryprovenance.database.DatabaseHandler;
import queryprovenance.database.DatabaseState;
import queryprovenance.database.DatabaseStates;
import queryprovenance.expression.*;
import queryprovenance.harness.QueryLog;
import queryprovenance.query.*;

public class SolveAll {
	
	String[] options;
	
	public SolveAll(String[] options){
		this.options = options;
	}
	public QueryLog solve(QueryLog wrong_query_log, DatabaseState[] database_states, Complaint complaint_set){
		// to be implemented
		return null;
	}
	
	public QueryLog solve(QueryLog wrong_query_log, DatabaseState[] database_states, DatabaseState[] true_database_states){
		// to be implemented
				return null;
	}
	
	public QueryLog solve(QueryLog qlog, DatabaseStates ds, DatabaseStates badds, Complaint complaint) throws Exception{
		QueryLog fixed_qlog = new QueryLog();
		// prepare data
		if(ds == null || ds.size()<1)
			ds = new DatabaseStates(badds, complaint);
		
		// check inputs
		if(qlog.size() != ds.size()-1 || ds.size() != badds.size())
			return null;
		
		for(int i = 0; i < qlog.size(); ++i){
			// for each query in the query log
			Query query = qlog.get(i);
			Query fix;
			switch(query.getType()){
			case INSERT: fix = new InsertQuery(query.getTable(), query.getValue()); fix.solve(ds.get(i), ds.get(i+1), badds.get(i+1), options); break;
			case DELETE: fix = new DeleteQuery(query.getTable(), query.getWhere()); fix.solve(ds.get(i), ds.get(i+1), badds.get(i+1), options); break;
			case UPDATE: fix = new UpdateQuery(query.getSet(),query.getTable(), query.getWhere()); fix.solve(ds.get(i), ds.get(i+1), badds.get(i+1), options); break;
			default: fix = query.clone();
			}
			fixed_qlog.add(fix);
		}
		return fixed_qlog;
	}
	/*
	public void Initialize(String wrong_query_path, String true_query_path) throws Exception{
		// read query from files
		// read wrong queries
		String s = new String();  
        StringBuffer sb = new StringBuffer();  	   
        FileReader fr = new FileReader(new File(wrong_query_path));  
        BufferedReader br = new BufferedReader(fr);  	  
        while((s = br.readLine()) != null) {  
            sb.append(s);  
        }  
        br.close();  
        String[] wrong_query_list = sb.toString().split(";");  
        // read true queries
        s = new String();  
        sb = new StringBuffer();  	   
        fr = new FileReader(new File(true_query_path));  
        br = new BufferedReader(fr);  	  
        while((s = br.readLine()) != null) {  
            sb.append(s);  
        }  
        br.close();  
        String[] true_query_list = sb.toString().split(";");  
        
        if(wrong_query_list.length != true_query_list.length){
        	System.out.println("Error: Wrong query list and True query list not match");
        	return;
        }
        
        int query_count = wrong_query_list.length;
        query_seq = new Query[query_count];
        db_org = new DatabaseState[query_count];
        
        // initialize query sequence and database state
        for(int i = 0; i < query_count; ++i){
        	
        }
 
	}
	*/
	  //Single query fix test
	public Query solveOnQ(Query wrong_query, Query true_query) throws Exception {
		String result = "";
		DatabaseHandler database = new DatabaseHandler();
		database.getConnected();
		database.executePrepFile("./data/setup.sql");
		database.executePrepFile("./data/inserts.sql");
		DatabaseState pre, next, bad;		
		pre = new DatabaseState(database, wrong_query.getTable());
		if(true_query.getTable()!=null)
			database.queryExecution(true_query.toString());
		next = new DatabaseState(database, wrong_query.getTable());
		database.executePrepFile("./data/setup.sql");
		database.executePrepFile("./data/inserts.sql");
		if(wrong_query.getTable()!=null)
			database.queryExecution(wrong_query.toString());
		bad = new DatabaseState(database, wrong_query.getTable());
		Query current;
		switch(wrong_query.getType()){
		case INSERT: current = new InsertQuery(wrong_query.getTable(), wrong_query.getValue()); return current.solve(pre, next, bad, options); 
		case DELETE: current = new DeleteQuery(wrong_query.getTable(), wrong_query.getWhere()); return current.solve(pre, next, bad, options);
		case UPDATE: current = new UpdateQuery(wrong_query.getSet(),wrong_query.getTable(), wrong_query.getWhere()); return current.solve(pre, next, bad, options);
		}
		return null;
	}
    // Continued Single query test
	public static void main(String[] arg) throws Exception{
		int tuple_count = 100;
		//DataGenerator datagenerator = new DataGenerator(tuple_count);
		arg = new String[]{"-M","1", "-E", "0.1", "-O", "abs"};
		SolveAll solver = new SolveAll(arg);
		String[] attributes = {"employeeid", "level", "salary"};
		Table t = new Table("employee",attributes, null, null, 0);
		 
		// check insert query
		/*
		System.out.println("INSERT QUERY DEMO: ");
		
		List<String> value = new ArrayList<String>();
		value.add("201,3,153716");
		Query wquery = new Query(t, value);
		List<String> value2 = new ArrayList<String>();
		value2.add("201,3,153726");
		Query tquery = new Query(t,value2);
		
		Query fquery = solver.solveOnQ(wquery, tquery, arg);
		
		System.out.println("WRONG QUERY: "+wquery.toString());
		System.out.println("TRUE QUERY: "+tquery.toString());
		System.out.print("FIXED QUERY: "+fquery.toString());
		*/
		// check update query
		System.out.println();
		System.out.println("###################");
		System.out.println("UPDATE QUERY DEMO: ");
		
		// set up wrong query
		List<SetExpr> set_clause = new ArrayList<SetExpr>();
		Expression attr1 = new VariableExpression("salary", true);
		Expression exprattr1 = new VariableExpression("salary", true);
		Expression exprvar1 = new VariableExpression("", 1000, false);
		Expression exprvar2 = new VariableExpression("", 1.1, false);
		Expression setexpr1 = new MultiplicationExpression(exprattr1, exprvar2);
		Expression setexpr2 = new AdditionExpression(setexpr1, exprvar1);
		set_clause.add(new SetExpr(attr1,setexpr2));
		SetClause set = new SetClause(set_clause);
		
		List<WhereExpr> where_clause = new ArrayList<WhereExpr>();
		Expression var1 = new VariableExpression("salary", true);
		Expression var2 = new VariableExpression("var", 130000, false);
		where_clause.add(new WhereExpr(var1,WhereExpr.Op.g, var2));
		WhereClause where = new WhereClause(where_clause,WhereClause.Op.CONJ);
		Query wquery = new Query(set, t,where,Query.Type.UPDATE);
		
		// set up true query
		List<SetExpr> set_clause_t = new ArrayList<SetExpr>();
		Expression attr1_t = new VariableExpression("salary", true);
		Expression exprattr1_t = new VariableExpression("salary", true);
		Expression exprvar1_t = new VariableExpression("", 1000, false);
		Expression exprvar2_t = new VariableExpression("", 1.1, false);
		Expression setexpr1_t = new MultiplicationExpression(exprattr1_t, exprvar2_t);
		Expression setexpr2_t = new AdditionExpression(setexpr1_t, exprvar1_t);	
		set_clause_t.add(new SetExpr(attr1_t, setexpr2_t));
		SetClause set1 = new SetClause(set_clause_t);
		
		List<WhereExpr> where_clause1 = new ArrayList<WhereExpr>();
		Expression var1_t = new VariableExpression("salary", true);
		Expression var2_t = new VariableExpression("var", 100000, false);
		where_clause1.add(new WhereExpr(var1_t,WhereExpr.Op.g, var2_t));		
		WhereClause where1 = new WhereClause(where_clause1,WhereClause.Op.CONJ);
		Query tquery = new Query(set1, t,where1,Query.Type.UPDATE);
		// test for MILP
		// arg = new String[]{"-M", "0"}; // for Decision Tree
		Query fquery = solver.solveOnQ(wquery, tquery);
		
		System.out.println("WRONG QUERY: "+wquery);
		System.out.println("TRUE QUERY: "+tquery);
		System.out.print("FIXED QUERY: "+fquery);
		/* 
		// check delete query
		System.out.println();
		System.out.println("###################");
		System.out.println("DELETE QUERY DEMO: ");
		
		List<WhereExpr> where_clause = new ArrayList<WhereExpr>();
		where_clause.add(new WhereExpr("salary",WhereExpr.Op.g, "130000"));
		WhereClause where = new WhereClause(where_clause,WhereClause.Op.CONJ);
		
		List<WhereExpr> where_clause1 = new ArrayList<WhereExpr>();
		where_clause1.add(new WhereExpr("salary",WhereExpr.Op.g, "135000"));
		WhereClause where1 = new WhereClause(where_clause1,WhereClause.Op.CONJ);
		
		Query wquery = new Query(t, where, Query.Type.DELETE);
	    Query tquery = new Query(t, where1, Query.Type.DELETE);
		
		Query fquery = solver.solveOnQ(wquery, tquery);
		
		System.out.println("WRONG QUERY: "+wquery);
		System.out.println("TRUE QUERY: "+tquery);
		System.out.print("FIXED QUERY: "+fquery);
		 */		
	} 
	 
}
