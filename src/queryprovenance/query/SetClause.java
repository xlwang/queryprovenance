package queryprovenance.query;

import java.util.ArrayList;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import queryprovenance.problemsolution.DatabaseState;

public class SetClause {
	private String set;
	private Condition[] set_conditions; // a set of conditions
	
	/* construct the where clause given a query*/
	public SetClause(ArrayList<Partition> groups_){
		for(Partition part: groups_){
			if(part.getPartitionName().equals("set")){
				set = part.getContent();
				ArrayList<String> contents = part.getSplitedContent();
				set_conditions = new Condition[contents.size()];
				for(int i=0; i<contents.size(); ++i){
					set_conditions[i] = new Condition(contents.get(i));
				}
				break;
			}
		}
	}
	
	/* solve the where clause given the previous/next db states */
	public String solve(DatabaseState pre, DatabaseState next) throws Exception{
		
	}
}
