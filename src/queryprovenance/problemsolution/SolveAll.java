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
		
		boolean fixed = false;
		for(int i = 0; i < qlog.size(); ++i){
			// for each query in the query log
			Query query = qlog.get(i);
			Query fix;
			if(!fixed && !badds.get(i+1).isSame(ds.get(i+1))){
				
				switch(query.getType()){
				case INSERT: fix = new InsertQuery(query.getId(), query.getTable(), query.getValue()); fix = fix.solve(ds.get(i), ds.get(i+1), badds.get(i+1), options); break;
				case DELETE: fix = new DeleteQuery(query.getId(), query.getTable(), query.getWhere()); fix = fix.solve(ds.get(i), ds.get(i+1), badds.get(i+1), options); break;
				case UPDATE: fix = new UpdateQuery(query.getId(), query.getSet(),query.getTable(), query.getWhere()); fix = fix.solve(ds.get(i), ds.get(i+1), badds.get(i+1), options); break;
				default: fix = query.clone();
				}
				
				if(!fix.toString().toLowerCase().trim().equals(query.toString().toLowerCase().trim()))
					fixed = true;
			}
			else
				fix = query.clone();
			fixed_qlog.add(fix);
		}
		return fixed_qlog;
	}

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
		case INSERT: current = new InsertQuery(wrong_query.getId(), wrong_query.getTable(), wrong_query.getValue()); return current.solve(pre, next, bad, options); 
		case DELETE: current = new DeleteQuery(wrong_query.getId(), wrong_query.getTable(), wrong_query.getWhere()); return current.solve(pre, next, bad, options);
		case UPDATE: current = new UpdateQuery(wrong_query.getId(), wrong_query.getSet(),wrong_query.getTable(), wrong_query.getWhere()); return current.solve(pre, next, bad, options);
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
		Expression var2 = new VariableExpression("var", 143284, false);
		where_clause.add(new WhereExpr(var1,WhereExpr.Op.ne, var2));
		WhereClause where = new WhereClause(where_clause,WhereClause.Op.CONJ);
		Query wquery = new Query(-1, set, t,where,Query.Type.UPDATE);
		
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
		Expression var2_t = new VariableExpression("var", 178024, false);
		where_clause1.add(new WhereExpr(var1_t,WhereExpr.Op.ne, var2_t));		
		WhereClause where1 = new WhereClause(where_clause1,WhereClause.Op.CONJ);
		Query tquery = new Query(-1, set1, t,where1,Query.Type.UPDATE);
		// test for MILP
		// arg = new String[]{"-M", "0"}; // for Decision Tree
		Query fquery = solver.solveOnQ(wquery, tquery);
		
		System.out.println("WRONG QUERY: "+wquery);
		System.out.println("TRUE QUERY: "+tquery);
		System.out.print("FIXED QUERY: "+fquery);
	
	} 
	 
}
