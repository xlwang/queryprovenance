package queryprovenance.query;

import queryprovenance.problemsolution.*;

public class UpdateQuery extends Query{
	WhereClause where_clause;
	SetClause set_clause;
	
	public UpdateQuery(String query_, String type_){
		super(query_,type_);
	}
	
	public void queryInitialize(){
		super.addPartition("(update) (.+) (set) (.+)", "[,]");
		super.addPartition("(set) (.+) (where|;) (.+)","[,]");
		super.addPartition("(where) (.+;)","(and|or)");
		super.construct();
		where_clause = new WhereClause(groups, this.getTables());
		set_clause = new SetClause(groups);
	}
	
	/* solve insert query by previous correct db state and next correct db state, return fixed query or null if not solvable*/
	public String solve(DatabaseHandler database, DatabaseState pre) throws Exception{
		String result = "";
		result = where_clause.solve(database, pre, 0);
		String fixed_query = super.query;
		if(result!=null&&result.length()>0){
			fixed_query.replaceAll("(where.*;)", "where "+result+";");
		}
		return fixed_query;
	}
}
