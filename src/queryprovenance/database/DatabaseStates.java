package queryprovenance.database;

import java.util.ArrayList;

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
}
