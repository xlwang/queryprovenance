package queryprovenance.query;

import queryprovenance.problemsolution.DatabaseState;

public class DeleteQuery extends Query{

	public DeleteQuery(String query_, String type_){
		super(query_,type_);
	}
	
	public void queryInitialize(){
		super.addPartition("(delete from) (.+) (where|;) (.+)", "[,]");
		super.addPartition("(where) (.+;)","(and|or)");
		super.construct();
	}
	/* solve insert query by previous correct db state and next correct db state, return fixed query or null if not solvable*/
	public Query solve(DatabaseState pre, DatabaseState next) throws Exception{
		
	}
}
