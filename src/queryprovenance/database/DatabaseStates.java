package queryprovenance.database;

import java.util.ArrayList;
import java.util.List;

import queryprovenance.problemsolution.Complaint;
import queryprovenance.problemsolution.SingleComplaint;

public class DatabaseStates {

	public DatabaseHandler handler;
	private ArrayList<DatabaseState> dbstates;
	private boolean inMemory;
	private List<String> tablenames;
	
	public DatabaseStates(){
		dbstates = new ArrayList<DatabaseState>();
		tablenames = new ArrayList<String>();
		inMemory = true;
	}
	
	public DatabaseStates(DatabaseStates badds, Complaint complaint_set){
		// TODO: given a complaint set, a set of bad databasestates, generate a set of clean databasestates
		
	}
	public void clear(){
		dbstates.clear();
	}
	
	public DatabaseStates subList(int start, int end) {
		DatabaseStates copy = new DatabaseStates();
		for(int i = start; i < end; ++i)
			copy.add(dbstates.get(i));
		return copy;
	}
	
	public void add(DatabaseState dbnew) {
		dbstates.add(dbnew);
	}
	
	public DatabaseState get(int idx) throws Exception {
		if(inMemory) {
			return dbstates.get(idx);
		} else if (dbstates.size() > 0){
			return dbstates.get(idx);}
		else {
			return new DatabaseState(handler, tablenames.get(idx), null);
		}
	}
	
	public DatabaseState getFull(int idx) throws Exception {
		
		return new DatabaseState(handler, tablenames.get(idx), null);
	}
	
	public int size() {
		int size = dbstates.size() > tablenames.size() ? dbstates.size() : tablenames.size();
		return size;
	}
	
	public void settablenames(DatabaseHandler dbhandler, List<String> tnames) {
		handler = dbhandler;
		tablenames = tnames;
		inMemory = false;
	}
	
	// only load tuples in the complaints
	public void loadPartial(Complaint complaints) throws Exception {
		for(String tablename : tablenames) {
			DatabaseState dbstate = new DatabaseState(handler, tablename, complaints);
			dbstates.add(dbstate);
		}
	}
}
