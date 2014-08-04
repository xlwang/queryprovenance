package queryprovenance.query;

import queryprovenance.database.DatabaseState;

public class UpdateQuery extends Query{
	WhereClause where_clause;
	SetClause set_clause;
	
	public UpdateQuery(SetClause set, Table table, WhereClause where){
		super(set, table, where, Query.Type.UPDATE);
	}
	

	
	/* solve insert query by previous correct db state and next correct db state, return fixed query or null if not solvable*/
	public Query solve(DatabaseState pre, DatabaseState next, String[] options) throws Exception{
		
		String result = "";
		
		// send to where clause. 
		WhereClause fixedWhere = where_clause.solve(pre, next, options);
		Query q = clone();
		if(fixedWhere != null) {
			q.where = fixedWhere;
		}
		
		// send to set clause
		SetClause fixedSet = set_clause.solve(pre, next);
		if(fixedSet != null) {
			q.select = fixedSet;
			/*
			String temp = fixed_query.replaceAll("set.*where", "set "+result+" where");
			if(!temp.equals(fixed_query))
				fixed_query = temp;
			else
				fixed_query = fixed_query.replaceAll("set.*;", "set "+result+";");
			 */
		}
		// System.out.println(q.toString());
		return q;
	}
}
