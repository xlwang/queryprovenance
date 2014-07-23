package queryprovenance.query;

import queryprovenance.problemsolution.DatabaseState;

public class InsertQuery extends Query {
	
	public InsertQuery(String query_, String type_){
		super(query_,type_);
	}
	
	public void queryInitialize(){
		super.addPartition("(insert into) (.+) ([(]) (.+)", "[,]");
		super.addPartition("([(] (.+) [)] values) ([(].+[)];)","[,]");
		super.construct();
	}
	
	/* solve insert query by previous correct db state and next correct db state, return fixed query or null if not solvable*/
	public Query solve(DatabaseState pre, DatabaseState next) throws Exception{
		
	}
}
