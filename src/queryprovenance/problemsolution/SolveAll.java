package queryprovenance.problemsolution;

import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import queryprovenance.query.*;

import java.util.regex.Pattern;
import java.util.regex.Matcher;

public class SolveAll {
	private DatabaseState[] db_org; // D, a sequence of db states given a seq of queries. 
	private DatabaseState[] db_fix; // D*, a sequence of correct db states
	
	private Query[] query_seq; // a seq of queries includes errors. 
	private Query[] query_seq_fix; // a seq of queries with no error, ground truth, (optional)
	
	
	public SolveAll(){

	}
	
	/* initialize problem given a sequence of wrong queries, and a sequence of corresponding true queries*/
	public String solveOnQ(String wrong_query, String true_query) throws Exception {
		String result = "";
		DatabaseHandler database = new DatabaseHandler();
		database.getConnected();
		database.executePrepFile("./data/setup.sql");
		database.executePrepFile("./data/inserts.sql");
		String querytype = getType(wrong_query);
		if(querytype.equals("update")){
			Query current = new UpdateQuery(wrong_query, getType(wrong_query));
			current.queryInitialize();
			DatabaseState pre = new DatabaseState(database, current);		
			database.queryExecution(true_query);
			result = current.solve(database, pre);
		}
		return result;
	}
	public String getType(String query){
		query = query.trim().toLowerCase();
		if(matchtype(query, "(insert into) (.+) (values) (.+)"))
			return "insert";
		if(matchtype(query, "(delete from) (,+)"))
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
		String wquery = "UPDATE employee SET Salary = salary+1100 WHERE level >= 2 and salary < 100000;";
		String tquery = "UPDATE employee SET Salary = salary+1100 WHERE level >= 3 and salary < 100000;";
		String fquery = solver.solveOnQ(wquery, tquery);
	} 
}
