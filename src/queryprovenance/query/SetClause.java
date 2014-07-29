package queryprovenance.query;

import java.util.ArrayList;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import queryprovenance.problemsolution.DatabaseState;

public class SetClause {
	private String set;
	private Condition[] set_conditions; // a set of conditions
	private String fixed_set; 
	
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
		
		String[] classinfo;
		
		// prepare feature information
		ArrayList<String[]> pre_values_all = new ArrayList<String[]>();
		ArrayList<String[]> next_values_all = new ArrayList<String[]>();
		String[] value_names = pre.getColumnNames();
		
		// if size of previous state and next state is different, this query cannot be solved by revise where clause
		if(pre.size()!=next.size())
			return null;
		
		
		// gather class information
		classinfo = pre.compare(next);
				
		// gather feature information
		for(String fname:value_names){
			fname.trim();
			String[] value = pre.getFeature(fname);
			pre_values_all.add(value);
			String[] value2 = next.getFeature(fname, pre.getKeySet());
			next_values_all.add(value2);
		}
		this.updateValues(pre_values_all, next_values_all, classinfo);
		
		JAMAHandler jama = new JAMAHandler();
		fixed_set = jama.solve(this, value_names, pre_values_all, next_values_all);
				
		return fixed_set;
	}
	
	/* update previous state, next state with only relevant tuples*/
	public void updateValues(ArrayList<String[]> pre_values_all, ArrayList<String[]> next_values_all, String[] classinfo){
		ArrayList<String[]> preRevised = new ArrayList<String[]>();
		ArrayList<String[]> nextRevised = new ArrayList<String[]>();
		
		// for each column name
		for(int i = 0; i < pre_values_all.size(); ++i){
			String[] preval = pre_values_all.get(i);
			String[] nextval = next_values_all.get(i);
 			ArrayList<String> temppre = new ArrayList<String>();
			ArrayList<String> tempnext = new ArrayList<String>();
			for(int j = 0; j < classinfo.length; ++j){
				if(classinfo[j].equals("b")){
					temppre.add(preval[j]);
					tempnext.add(nextval[j]);
				}
			}
			// update preRevised, nextRevised
			preRevised.add((String[]) temppre.toArray(new String[temppre.size()]));
			nextRevised.add((String[]) tempnext.toArray(new String[tempnext.size()]));
		}
		
		// update previous, next state value list
		pre_values_all.clear(); pre_values_all.addAll(preRevised);
		next_values_all.clear(); next_values_all.addAll(nextRevised);
	} 
	
	/* return conditions*/
	public Condition[] getConditions(){
		return this.set_conditions;
	}
}
