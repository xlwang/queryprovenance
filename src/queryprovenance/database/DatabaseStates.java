package queryprovenance.database;

import java.util.ArrayList;

import queryprovenance.harness.QueryLog;
import queryprovenance.problemsolution.Complaint;

public class DatabaseStates extends ArrayList<DatabaseState> {

	public DatabaseStates(){
		
	}
	
	public DatabaseStates(DatabaseStates badds, Complaint complaint_set){
		// TODO: given a complaint set, a set of bad databasestates, generate a set of clean databasestates
		
	}
	public void clear(){
		super.clear();
	}
	
	public DatabaseStates subList(int start, int end) {
		DatabaseStates copy = new DatabaseStates();
		for(int i = start; i < end; ++i)
			copy.add(this.get(i));
		return copy;
	}
}
