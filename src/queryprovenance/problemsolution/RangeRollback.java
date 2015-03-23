package queryprovenance.problemsolution;

import ilog.cplex.IloCplex;
import queryprovenance.database.DatabaseState;
import queryprovenance.database.DatabaseStates;
import queryprovenance.query.DeleteQuery;
import queryprovenance.query.InsertQuery;
import queryprovenance.query.Query;
import queryprovenance.query.UpdateQuery;

public class RangeRollback {
	
	
	/* solve by two passes: cplex or decision tree */
	public static DatabaseStates rollback(Complaint comp, 
			QueryLog badQueries) throws Exception {
		
		
		return null;
	}
	
	/* roll back from current state to previous state given the query*/
	public ComplaintRange rollbackByQuery(Query query,
			DatabaseStates badDss,
			ComplaintRange compnext) {
		
		return null;
	}
	
	public ComplaintRange rollbackByUpdate(UpdateQuery query, 
			DatabaseStates badDss,
			ComplaintRange compnext) {
		// rollback from current complaint range to previous complaint range for a update query
		
		return null;
	}
	
	public ComplaintRange rollbackByInsert(InsertQuery query, 
			DatabaseStates badDss,
			ComplaintRange compnext) {
		return null;
	}
	
	public ComplaintRange rollbackByDelete(DeleteQuery query, 
			DatabaseStates badDss,
			ComplaintRange compnext) {
		return null;
	}
	
}
