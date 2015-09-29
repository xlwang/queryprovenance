package queryprovenance.harness;

import java.io.BufferedReader;
import java.io.FileReader;
import java.util.ArrayList;
import java.util.List;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;

import queryprovenance.database.Table;
import queryprovenance.expression.AdditionExpression;
import queryprovenance.expression.Expression;
import queryprovenance.expression.VariableExpression;
import queryprovenance.query.InsertQuery;
import queryprovenance.query.Query;
import queryprovenance.query.SetClause;
import queryprovenance.query.SetExpr;
import queryprovenance.query.UpdateQuery;
import queryprovenance.query.WhereClause;
import queryprovenance.query.WhereExpr;
import queryprovenance.query.WhereExpr.Op;



public class Util {
	public static String join(Object[] os, String sep) {
		List<Object> l = new ArrayList<Object>();
		for (Object o : os) l.add(o);
		return join(l, sep);
	}
	public static String join(List<? extends Object> l, String sep) {
		String s = "";
		for (int i = 0; i < l.size(); i++) {
			s += l.get(i).toString();
			if (i < l.size() - 1) {
				s += sep;
			}		
		}
		return s;
	}

	public static JSONArray whereToJSON(WhereClause where) {
		JSONArray ret = new JSONArray();
		for (WhereExpr expr : where.getWhereExprs()) {
			Op op = expr.getOperator();
			JSONArray wa = new JSONArray();
			wa.add(expr.getAttrExpr().toString());
			wa.add(expr.getOperatorString());
			wa.add(expr.getVar());
			ret.add(wa);
		}
		return ret;
	}

	public static JSONArray setToJSON(SetClause set) {
		JSONArray ret = new JSONArray();
		for (SetExpr expr : set.getSetExprs()) {
			JSONArray sa = new JSONArray();
			String col = expr.getAttr().toString();
			sa.add(col);
			if (expr.getExpr() instanceof AdditionExpression) {
				JSONArray exprjson = new JSONArray();
				exprjson.add(col);
				exprjson.add("=");
				List<Expression> addExprs = expr.getExpr().getVariable();
				double val = addExprs.get(addExprs.size() - 1)
						.getAssignedEval();
				exprjson.add(val);
				sa.add(exprjson);
			} else {
				sa.add(expr.getExpr().getAssignedEval());
			}
			ret.add(sa);
		}
		return ret;
	}

	public static InsertQuery jsonToInsertQuery(int qid, Table table,
			JSONArray vals) {
		List<String> realvals = new ArrayList<String>();
		for (Object s : vals) {
			if(s instanceof Long || s instanceof Double || s instanceof Integer)
				realvals.add(String.valueOf(s));
		}
		return new InsertQuery(qid, table, realvals);
	}

	public static UpdateQuery jsonToUpdateQuery(int qid, Table table,
			JSONArray setjson, JSONArray wherejson) {
		WhereClause where = jsonToWhereClause(wherejson);
		SetClause set = jsonToSetClause(setjson);
		return new UpdateQuery(qid, set, table, where);
	}

	public static WhereClause jsonToWhereClause(JSONArray where) {
		List<WhereExpr> exprs = new ArrayList<WhereExpr>();
		for (Object wc : where) {
			JSONArray wa = (JSONArray) wc;
			String col = (String) wa.get(0);
			String op = (String) wa.get(1);
			long v = (long) wa.get(2);
			WhereExpr expr = new WhereExpr(new VariableExpression(col, true),
					WhereExpr.getOperator(op), new VariableExpression(v, false));
			exprs.add(expr);
		}
		return new WhereClause(exprs, WhereClause.Op.CONJ);
	}

	public static SetClause jsonToSetClause(JSONArray set) {
		List<SetExpr> setexprs = new ArrayList<SetExpr>();
		for (Object setc : set) {
			VariableExpression lhs = null;
			Expression rhs = null;
			JSONArray seta = (JSONArray) setc;
			String col = (String) seta.get(0);
			lhs = new VariableExpression(col, true);

			if (seta.get(1) instanceof JSONArray) {
				JSONArray exprjson = (JSONArray) seta.get(1);
				String exprcol = (String) exprjson.get(0);
				String exprop = (String) exprjson.get(1);
				float exprv = (float) exprjson.get(2);
				rhs = new AdditionExpression(new VariableExpression(col, true),
						new VariableExpression(exprv, false));
			} else {
				long exprv = (long) seta.get(1);
				rhs = new VariableExpression(exprv, false);
			}

			setexprs.add(new SetExpr(lhs, rhs));
		}
		return new SetClause(setexprs);
	}

}
