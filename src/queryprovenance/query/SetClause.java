package queryprovenance.query;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Random;

import queryprovenance.database.DatabaseState;
import queryprovenance.expression.AdditionExpression;
import queryprovenance.expression.Expression;
import queryprovenance.expression.VariableExpression;
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
		// generate <random col> = <random col> + <random value>
		Table t = params.from;
		String[] cols = t.getColumns();
		int ncols = t.getColumns().length;
		Random rand = new Random();
		List<SetExpr> conds = new ArrayList<SetExpr>();
		
		int idx = rand.nextInt(ncols);
		if (t.getType(idx) == Table.Type.NUM) {
			int[] dom = t.getNumDomain(idx);
			int v = rand.nextInt(dom[1]-dom[0]) + dom[0];
			// conds.add(new SetExpr(cols[idx], cols[idx] + "+" + v)); 
			Expression attr = new VariableExpression(cols[idx], true); 
			Expression expr = new AdditionExpression(new VariableExpression(cols[idx], true), new VariableExpression(v, false));
			conds.add(new SetExpr(attr, expr));
		} else {
			// TODO: function not supported for STR type
			// String[] dom = t.getStrDomain(idx);
			// String v = dom[rand.nextInt(dom.length)];
			// conds.add(new SetExpr(cols[idx], v));
		}
		
		return new SetClause(conds);
	}
	
	/* solve the where clause given the previous/next db states */
	public SetClause solve(DatabaseState pre, DatabaseState next, String[] options) throws Exception{
		
		
		// prepare feature information
		ArrayList<String[]> pre_values_all = new ArrayList<String[]>();
		ArrayList<String[]> next_values_all = new ArrayList<String[]>();
		String[] value_names = pre.getColumnNames();
		
		// if size of previous state and next state is different, this query cannot be solved by revise where clause
		if(pre.size()!=next.size())
			return null;
		
		
		// gather class information
		HashMap<String, String> classinfo = pre.compare(next);

		this.updateValues(pre_values_all, next_values_all, pre, next, classinfo);

		JAMAHandler jama = new JAMAHandler();
		SetClause fixed_set = new SetClause(jama.solve(this, value_names, pre_values_all, next_values_all));
				
		return fixed_set;
	}
	
	/* update previous state, next state with only relevant tuples*/
	public void updateValues(ArrayList<String[]> pre_values_all, ArrayList<String[]> next_values_all, DatabaseState pre, DatabaseState next, HashMap<String, String> classinfo){
		
		for(String key:classinfo.keySet()){
			// if the values are changed
			if(classinfo.get(key).equals("b")){
				pre_values_all.add(pre.getTuple(key));
				next_values_all.add(next.getTuple(key));
			}
		}

	} 
	
	/* return conditions*/
	public List<SetExpr> getSetExprs(){
		return this.set_exprs;
	}
}
