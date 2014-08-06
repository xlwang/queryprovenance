package queryprovenance.problemsolution;

import java.util.ArrayList;

import queryprovenance.database.DatabaseState;

public class Complaint {
	
	public class SingleComplaint{
	public String key;
	public String[] values;
	}
	
	ArrayList<SingleComplaint> complaint_set;
	
	/* generateComplaintSet(databasestate1, databasestate2) */
	public static Complaint generateComplaintSet(DatabaseState db_state_1, DatabaseState db_state_2){
		// to be implemented
		// initialize a complaint set by providing a "dirty" database state and a "clean" database state
		return null;
	}
}
