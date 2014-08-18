package queryprovenance.problemsolution;

import java.util.ArrayList;

import queryprovenance.database.DatabaseState;

public class Complaint {
	
	public class SingleComplaint{
		public String key;
		public String[] values;
		SingleComplaint(String key_, String[] values_){
			key = key_;
			values = values_;
		}
	}
	
	ArrayList<SingleComplaint> complaint_set;
	
	/* generateComplaintSet(databasestate1, databasestate2) */
	public Complaint(DatabaseState db_state_clean, DatabaseState db_state){
		
		// initialize a complaint set by providing a "dirty" database state and a "clean" database state
		complaint_set = new ArrayList<SingleComplaint>();
		// add complaints from clean database state
		for(String key:db_state_clean.getKeySet()){
			if(db_state.containTuple(key)){
				String[] values_clean = db_state_clean.getTuple(key);
				String[] values = db_state.getTuple(key);
				boolean isSame = true;
				for(int i = 0; i < values_clean.length; ++i){
					if(!values_clean[i].equals(values[i]))
						isSame = false;
				}
				if(!isSame)
					complaint_set.add(new SingleComplaint(key, values_clean));
			}
			else
				complaint_set.add(new SingleComplaint(key, db_state_clean.getTuple(key)));
		}
		// add complaint from "dirty" database state
		for(String key:db_state.getKeySet()){
			if(!db_state_clean.containTuple(key))
				complaint_set.add(new SingleComplaint(key, null));
		}
	}
	
}
