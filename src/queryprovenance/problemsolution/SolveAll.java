package queryprovenance.problemsolution;


import java.util.regex.Matcher;
import java.util.regex.Pattern;

import queryprovenance.database.DatabaseHandler;
import queryprovenance.database.DatabaseState;
import queryprovenance.harness.QueryLog;
import queryprovenance.query.DeleteQuery;
import queryprovenance.query.InsertQuery;
import queryprovenance.query.Query;
import queryprovenance.query.UpdateQuery;

public class SolveAll {
	private DatabaseState[] db_org; // D, a sequence of db states given a seq of queries. 
	private DatabaseState[] db_fix; // D*, a sequence of correct db states
	
	private Query[] query_seq; // a seq of queries includes errors. 
	private Query[] query_seq_fix; // a seq of queries with no error, ground truth, (optional)
	
	
	public SolveAll(){

	}
	
	public QueryLog solve(QueryLog wrong_query_log, DatabaseState[] database_states, Complaint complaint_set){
		// to be implemented
		return null;
	}
	
	public QueryLog solve(QueryLog wrong_query_log, DatabaseState[] database_states, DatabaseState[] true_database_states){
		// to be implemented
				return null;
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
	/* initialize problem given a sequence of wrong queries, and a sequence of corresponding true queries*/
	public String solveOnQ(String wrong_query, String true_query, String[] options) throws Exception {
		String result = "";
		DatabaseHandler database = new DatabaseHandler();
		database.getConnected();
		database.executePrepFile("./data/setup.sql");
		database.executePrepFile("./data/inserts.sql");
		String querytype = getType(wrong_query);
		Query current;
		DatabaseState pre, next;		
		
		switch(querytype){
		case("update"):
			current = new UpdateQuery(wrong_query, getType(wrong_query));
			current.queryInitialize();			
			pre = new DatabaseState(database, current);	
			if(true_query.length()>0)
				database.queryExecution(true_query);
			next = new DatabaseState(database, current);
			result = current.solve(pre, next, options);
			break;
		case("insert"):
			current = new InsertQuery(wrong_query, getType(wrong_query));
			current.queryInitialize();
			pre = new DatabaseState(database, current);	
			if(true_query.length()>0)
				database.queryExecution(true_query);
			next = new DatabaseState(database, current);
			result = current.solve(pre, next, options);
			break;	
		case("delete"):
			current = new DeleteQuery(wrong_query, getType(wrong_query));
			current.queryInitialize();
			pre = new DatabaseState(database, current);	
			if(true_query.length()>0)
				database.queryExecution(true_query);
			next = new DatabaseState(database, current);
			result = current.solve(pre, next, options);
			break;
		default: 
			System.out.println("Error: Query type not supported");
		}
		return result;
	}
	
	/* get query type */
	public String getType(String query){
		query = query.trim().toLowerCase();
		if(matchtype(query, "(insert into) (.+) (values) (.+)"))
			return "insert";
		if(matchtype(query, "(delete from) (.+)"))
			return "delete";
		if(matchtype(query, "(update) (.+) (set) (.+)"))
			return "update";
		if(matchtype(query, "(select) (.+) (from) (.+)"))
			return "select";
		if(matchtype(query, "(insert into) (.+) (select) (.+) (from) (.+)"))
			return "insertselect";
		return "Error: Invalid query type";
	}
	
	/* whether the query fit a given type based on its regular expression*/
	public boolean matchtype(String query, String regex){
		Pattern p = Pattern.compile(regex);
		Matcher m = p.matcher(query);
		return m.find();
	}
	
	public static void main(String[] arg) throws Exception{
		int tuple_count = 100;
		//DataGenerator datagenerator = new DataGenerator(tuple_count);
		SolveAll solver = new SolveAll();
		// check insert query
		System.out.println("INSERT QUERY DEMO: ");
		String wquery = "INSERT INTO Employee VALUES (101,3,153716);";
		String tquery = "";
		
		String fquery = solver.solveOnQ(wquery, tquery, arg);
		
		System.out.println("WRONG QUERY: "+wquery);
		System.out.println("TRUE QUERY: "+tquery);
		System.out.print("FIXED QUERY: "+fquery);
		
		// check update query
		System.out.println();
		System.out.println("###################");
		System.out.println("UPDATE QUERY DEMO: ");
		wquery = "UPDATE employee SET Salary = salary+1200, level = level+1 WHERE salary >130000;";
		tquery = "UPDATE employee SET Salary = salary+12550, level = level+1 WHERE salary >130000;";
		// test for MILP
		arg = new String[]{"-M","1"};
		// arg = new String[]{"-M", "0"}; // for Decision Tree
		fquery = solver.solveOnQ(wquery, tquery, arg);
		
		System.out.println("WRONG QUERY: "+wquery);
		System.out.println("TRUE QUERY: "+tquery);
		System.out.print("FIXED QUERY: "+fquery);
		
		// check delete query
		System.out.println();
		System.out.println("###################");
		System.out.println("DELETE QUERY DEMO: ");
		wquery = "DELETE FROM employee WHERE salary > 130000;";
		tquery = "";
		arg = new String[]{"-M","1"};
		fquery = solver.solveOnQ(wquery, tquery, arg);
		
		System.out.println("WRONG QUERY: "+wquery);
		System.out.println("TRUE QUERY: "+tquery);
		System.out.print("FIXED QUERY: "+fquery);
				
	} 
}
