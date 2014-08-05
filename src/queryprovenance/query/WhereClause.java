package queryprovenance.query;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import queryprovenance.database.DatabaseState;
import queryprovenance.harness.QueryParams;
import queryprovenance.harness.Util;


public class WhereClause {
	public static enum Op {
		DISJ, // disjunction 
		CONJ  // conjunction
	};
	
	private List<WhereExpr> where_exprs; // a set of WhereExprs
	private Op operator; // disjunction/conjunction
	
	public WhereClause(Op operator_){
		this.where_exprs = new ArrayList<WhereExpr>();
		this.operator = operator_;
	}
	/* construct the where clause given a query*/
	public WhereClause(List<WhereExpr> where_exprs_, Op operator_) {
		this.where_exprs = where_exprs_;
		this.operator = operator_;
	}
	
	public static WhereClause generate(QueryParams params) {
		List<WhereExpr> conds = new ArrayList<WhereExpr>();
		for (int i = 0; i < params.nclauses; i++) {
			if (true) {
				// TODO: ewu: verify this format is correct
				conds.add(new WhereExpr("x", WhereExpr.Op.eq, "99"));
			} else {
				
			}			
		}
		return new WhereClause(conds, Op.CONJ);
	}
	
	public String toString() {
		switch(this.operator){
		case DISJ: return Util.join(where_exprs, " or ");
		case CONJ: return Util.join(where_exprs, " and ");
		}
		return null;
		// return Util.join(where_exprs, " and ");
	}
	
	/* solve the where clause given the previous/next db states */
	public WhereClause solve(DatabaseState pre, DatabaseState next, DatabaseState bad, String[] option) throws Exception{
		
		WhereClause result = null;
		
		// prepare for options
		if(option.length%2>0){
			System.out.println("option not supported by Where clause solver");
			return null;
		}
		for(int i=0; i<option.length; i=i+2){
			String op = option[i];
			switch(op){
			case "-M": // method choosed for where clause solver
				if(option[i+1].equals("0")) // "0" for Decision tree solver
					result = solveDT(pre,next, bad);
				else if(option[i+1].equals("1")) //"1" for MILP solver
					result = solveMILP(pre,next, bad, 0.1);
				else
					result = null;
				break;
			}
		}
		
		// return results as a revised query
		return result;
	}
	
	/* solve the where clause by MILP cplex*/
	public WhereClause solveMILP(DatabaseState pre, DatabaseState next, DatabaseState bad, double ep) throws Exception{
		WhereClause fixed_where = null;
		// build cplex solver
		CplexHandler cplex = new CplexHandler(ep);
		// prepare class information
		String[] classinfo;
		
		// prepare feature information
		ArrayList<String[]> valuesAll = new ArrayList<String[]>();
		String[] value_names = this.getFeature().split(",");
		
		// gather class information
		classinfo = pre.compare(next);
		// gather class information for bad db state
		String[] badclassinfo = pre.compare(bad);
		
		boolean isSame = true;
		for(int i = 0; i < classinfo.length; ++i){
			if(!classinfo[i].equals(badclassinfo[i])){
				isSame = false;
				break;
			}
		}
		
		if(isSame)
			return fixed_where;
		
		// gather feature information
		for(String fname:value_names){
			fname.trim();
			String[] value = pre.getFeature(fname);
			valuesAll.add(value);
		}
		
		// prepare cplex
		double[] fixed_values = cplex.solve(this, valuesAll, classinfo, "abs");
		
		// get fixed where
		if(fixed_values != null)
			fixed_where = new WhereClause(cplex.toConditionRules(this, fixed_values), this.operator);
		else
			fixed_where = null;
		return fixed_where;
	
	}
	
	/* solve the where clause by decision tree */
	public WhereClause solveDT(DatabaseState pre, DatabaseState next, DatabaseState bad) throws Exception{
		// prepare input for Decision Tree solver
		// buid tree
		WhereClause fixed_where = null;
		
		DecisionTreeHandler tree = new DecisionTreeHandler();
		
		// prepare class information
		String[] classinfo;
		
		// prepare feature information
		ArrayList<String[]> features = new ArrayList<String[]>();
		String[] feature_names = this.getFeature().split(",");
		
		// gather class information
		classinfo = pre.compare(next);
		
		// gather feature information
		for(String fname:feature_names){
			fname.trim();
			String[] value = pre.getFeature(fname);
			features.add(value);
		}
		
		//ResultSet features = database.queryExecution(featurequery);
		tree.prepareARFF(features, classinfo, this);
		
		// solve 
		String rulelist = tree.buildTree("./data/feature.arff");
		
		//convertIntoRules(rulelist);
		fixed_where = new WhereClause(tree.toConditionRules(rulelist, this), this.operator);
		
		//System.out.println(getFixedClause());
		return fixed_where;
	}
	
	/* get decision tree features: represented as arithmetic expressions, connected by "," */
	public String getFeature(){
		String feature = "";
		for(WhereExpr subexpr:where_exprs){
			feature = feature + subexpr.getAttrExpr() + ",";
		}
		return feature;
	}
	
	/* return node type */
	public int getNodeType(String str){
		return 0;
	}
	
	
	/* get operator */
	public Op getOperator(){
		return this.operator;
	}
	
	/* get WhereExpr sets*/
	public List<WhereExpr> getWhereExprs(){
		return this.where_exprs;
	}

}
