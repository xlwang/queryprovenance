package queryprovenance.query;

import java.util.ArrayList;
import java.util.List;

import queryprovenance.database.DatabaseState;
import queryprovenance.harness.QueryParams;
import queryprovenance.harness.Util;

public class SetClause {
	private List<SetExpr> set_exprs; // a set of conditions
	
	public SetClause(){
		set_exprs = new ArrayList<SetExpr>();
	}
	/* construct the where clause given a query*/
	public SetClause(List<SetExpr> conditions) {
		set_exprs = conditions;
	}
	
	public String toString() {
		return Util.join(set_exprs, ", ");
	}
	
	public static SetClause generate(QueryParams params) {
		return new SetClause(null);
	}
	
	/* solve the where clause given the previous/next db states */
	public SetClause solve(DatabaseState pre, DatabaseState next, String[] options) throws Exception{
		
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
		
		// prepare set information
		for(SetExpr expr:set_exprs)
			expr.processVar();
		JAMAHandler jama = new JAMAHandler();
		SetClause fixed_set = new SetClause(jama.solve(this, value_names, pre_values_all, next_values_all));
				
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
	public List<SetExpr> getSetExprs(){
		return this.set_exprs;
	}
}
