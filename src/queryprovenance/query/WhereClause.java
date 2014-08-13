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
		Random rand = new Random();
		Table t = params.from;
		String[] cols = t.getColumns();
		int ncols = cols.length;
		
		List<WhereExpr> conds = new ArrayList<WhereExpr>();
		for (int i = 0; i < params.nclauses; i++) {
			// pick 1 right col
			// pick a random value from the col's domain
			// pick an operator
			WhereExpr.Op op = WhereExpr.Op.le;
			int idx = rand.nextInt(ncols);
			//String attr = cols[idx];
			Table.Type type = t.getType(idx);
			if (type == Table.Type.NUM) {
				int[] dom = t.getNumDomain(idx);
				int v = rand.nextInt(dom[1]-dom[0]) + dom[0];
				v = v == 0? v+1 : v;
				// conds.add(new WhereExpr(v+"", op, attr));
				Expression attr = new VariableExpression(cols[idx], true); 
				Expression expr = new VariableExpression(v, false);
				conds.add(new WhereExpr(attr, op, expr));
			} else {
				//TODO: function not supported. 
				// String[] dom = t.getStrDomain(idx);
				// conds.add(new WhereExpr(dom[rand.nextInt(dom.length)], WhereExpr.Op.eq, attr));
			}
			
		}
		return new WhereClause(conds, Op.CONJ);
	}
	
	public static WhereClause generate(WhereClause where, QueryParams params){
		Table t = params.from;
		String[] cols = t.getColumns();
		Random rand = new Random();
		
		List<WhereExpr> conds = new ArrayList<WhereExpr>();
		// for each where expression in original where clause
		for(WhereExpr expr:where.getWhereExprs()){
			// duplicate attribute , attribute index
			String attr = expr.getAttrExpr().getVariable().get(0).toString();
			int idx = -1;
			for(int i = 0; i < cols.length; ++i)
				if(cols[i].equals(attr))
					idx = i;
			if(idx == -1)
				return where;
			int[] dom = t.getNumDomain(idx);
			// generate new random number
			int v = rand.nextInt(dom[1]-dom[0]) + dom[0];
			v = v==0?v+1:v;
			WhereExpr.Op op = expr.getOperator();
			Expression varexpr = new VariableExpression(v, false);
			conds.add(new WhereExpr(expr.getAttrExpr().clone(), op, varexpr));
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
		
		// gather class information
		HashMap<String, String> classinfo = pre.compare(next);
		// gather class information for bad db state
		HashMap<String, String> badclassinfo = pre.compare(bad);
		
		boolean isSame = true;
		for(String key:classinfo.keySet()){
			if(!classinfo.get(key).equals(badclassinfo.get(key))){
				isSame = false;
				break;
			}
		}
		
		// check whether bad dbstate is the same with good dbstate
		if(isSame)
			return null;
		
		int i = 0;
		while(i < option.length){
			String op = option[i];
			switch(op){
			case "-M": // method choosed for where clause solver
				i++;
				if(option[i].equals("0")) // "0" for Decision tree solver
					result = solveDT(pre,next, bad, classinfo);
				else if(option[i].equals("1")) //"1" for MILP solver
					result = solveMILP(pre,next, bad, classinfo, option);
				else
					result = null;
				break;
			}
			i++;
		}
		
		// return results as a revised query
		return result;
	}
	
	/* solve the where clause by MILP cplex*/
	public WhereClause solveMILP(DatabaseState pre, DatabaseState next, DatabaseState bad, HashMap<String, String> classinfo, String[] option) throws Exception{
		// define parameters
		double ep = Double.MAX_VALUE;
		String objFuc = null;
		// prepare parameters
		int i = 0;
		while(i < option.length){
			String op = option[i];
			switch(op){
			case "-E": 
				try{
					ep = Double.parseDouble(option[++i]);
				} catch (Exception e){
					throw new IllegalArgumentException("MILP parameter error: epsilon must be a number. ");
				}
				break;
			case "-O":
				objFuc = option[++i];
				break;
			default: 
			}
			i++;
		}
		if(ep == Double.MAX_VALUE || objFuc == null)
			throw new IllegalArgumentException("MILP parameter error: not enough parameters. ");
		
		// solve WhereClause
		WhereClause fixed_where = null;
		
		// build cplex solver
		CplexHandler cplex = new CplexHandler(ep);
		
		// prepare cplex
		List<WhereExpr> fixed_values = cplex.solve(this, pre, classinfo, objFuc);
		
		// get fixed where
		if(fixed_values != null)
			fixed_where = new WhereClause(fixed_values, this.operator);
		else
			fixed_where = null;
		
		// return result
		return fixed_where;
	
	}
	
	/* solve the where clause by decision tree */
	public WhereClause solveDT(DatabaseState pre, DatabaseState next, DatabaseState bad, HashMap<String, String> classinfo) throws Exception{
		// prepare input for Decision Tree solver
		WhereClause fixed_where = null;
		
		// buid tree
		DecisionTreeHandler tree = new DecisionTreeHandler();
		
		
		//ResultSet features = database.queryExecution(featurequery);
		tree.prepareARFF(this, pre, classinfo);
		
		// solve 
		List<WhereExpr> fixed_values = tree.buildTree(this, "./data/feature.arff");
		
		// get fixed where
		if(fixed_values != null)
			fixed_where = new WhereClause(fixed_values, this.operator);
		else
			fixed_where = null;
		
		// return result
		return fixed_where;
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
