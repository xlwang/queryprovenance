package queryprovenance.problemsolution;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import queryprovenance.database.DataGenerator;
import queryprovenance.database.DatabaseHandler;
import queryprovenance.database.DatabaseState;
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
		}
		return result;
	}
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
		return "error";
	}
	/* whether the query fit a given type based on its regular expression*/
	public boolean matchtype(String query, String regex){
		Pattern p = Pattern.compile(regex);
		Matcher m = p.matcher(query);
		return m.find();
	}
	
	public static void main(String[] arg) throws Exception{
		DataGenerator datagenerator = new DataGenerator();
		SolveAll solver = new SolveAll();
		// check insert query
		System.out.println("INSERT QUERY DEMO: ");
		String wquery = "INSERT INTO Employee VALUES (101,3,153716);";
		String tquery = "INSERT INTO Employee VALUES (101,3,153726);";
		
		String fquery = solver.solveOnQ(wquery, tquery, arg);
		
		System.out.println("WRONG QUERY: "+wquery);
		System.out.println("TRUE QUERY: "+tquery);
		System.out.print("FIXED QUERY: "+fquery);
		
		// check update query
		System.out.println();
		System.out.println("###################");
		System.out.println("UPDATE QUERY DEMO: ");
		wquery = "UPDATE employee SET Salary = salary+1100, level = level+1 WHERE level >= 2 and salary < 80000;";
		tquery = "UPDATE employee SET Salary = salary+1260, level = level+1 WHERE level >= 2 and salary < 80000;";
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
		tquery = "DELETE FROM employee WHERE salary > 120000;";
		arg = new String[]{"-M","1"};
		fquery = solver.solveOnQ(wquery, tquery, arg);
		
		System.out.println("WRONG QUERY: "+wquery);
		System.out.println("TRUE QUERY: "+tquery);
		System.out.print("FIXED QUERY: "+fquery);
				
	} 
}
