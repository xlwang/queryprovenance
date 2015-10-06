package queryprovenance.query;

import ilog.concert.IloNumVar;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Random;

import queryprovenance.database.DatabaseState;
import queryprovenance.database.Table;
import queryprovenance.expression.AdditionExpression;
import queryprovenance.expression.Expression;
import queryprovenance.expression.VariableExpression;
import queryprovenance.harness.QueryParams;
import queryprovenance.harness.Util;

public class SetClause {
	private List<SetExpr> set_exprs; // a set of conditions
	private long[] times = new long[3];

	public SetClause() {
		set_exprs = new ArrayList<SetExpr>();
	}

	/* construct the where clause given a query */
	public SetClause(List<SetExpr> conditions) {
		set_exprs = conditions;
	}

	public String toString() {
		return Util.join(set_exprs, ", ");
	}

	public List<String> getModifiedAttr() {
		List<String> attrs = new ArrayList<String>();
		for (SetExpr expr : set_exprs) {
			attrs.add(expr.attr.toString());
		}
		return attrs;
	}

	public static SetClause generate(QueryParams params) {
		// generate <random col> = <random col> + <random value>
		Table t = params.from;
		String[] cols = t.getColumns();
		int ncols = t.getColumns().length;
		Random rand = new Random();
		List<SetExpr> conds = new ArrayList<SetExpr>();
		HashSet<Integer> selected = new HashSet<Integer>();
		for (int i = 0; i < 1; i++) {
			int idx = rand.nextInt(ncols);
			while (t.getKeyIdx().contains(idx) || selected.contains(idx))
				idx = rand.nextInt(ncols);
			selected.add(idx);

			if (t.getType(idx) == Table.Type.NUM) {
				long[] dom = t.getNumDomain(idx);
				long v = dom[0];
				if (dom[1] != dom[0]) {
					v = rand.nextInt((int) (dom[1] - dom[0])) + dom[0];
				};
				v = v == 0 ? v + 1 : v;
				// conds.add(new SetExpr(cols[idx], cols[idx] + "+" + v));
				Expression attr = new VariableExpression(cols[idx], true);
				Expression expr = new VariableExpression(v, false);
				conds.add(new SetExpr(attr, expr));
			} else {
				// TODO: function not supported for STR type
				// String[] dom = t.getStrDomain(idx);
				// String v = dom[rand.nextInt(dom.length)];
				// conds.add(new SetExpr(cols[idx], v));
			}
		}
		return new SetClause(conds);
	}

	public void fix(HashMap<IloNumVar, Double> fixedmap,
			HashMap<Expression, IloNumVar> expressionmap) throws Exception {
		for (SetExpr set : set_exprs) {
			set.fix(fixedmap, expressionmap);
		}
	}

	public static SetClause generate(SetClause set, QueryParams params) {
		Table t = params.from;
		String[] cols = t.getColumns();
		Random rand = new Random();

		List<SetExpr> conds = new ArrayList<SetExpr>();
		// for each set expression in original set clause
		for (SetExpr expr : set.getSetExprs()) {
			// duplicate attribute , attribute index
			String attr = expr.getAttr().toString();
			int idx = -1;
			for (int i = 0; i < cols.length; ++i)
				if (cols[i].equals(attr))
					idx = i;
			if (idx == -1)
				return set;
			long[] dom = t.getNumDomain(idx);
			long v = dom[0];
			if (dom[1] != dom[0]) {
				v = rand.nextInt((int) (dom[1] - dom[0])) + dom[0];
			};
			// generate new random number
			v = v == 0 ? v + 1 : v;
			Expression varexpr = new VariableExpression(v, false);
			conds.add(new SetExpr(expr.getAttr().clone(),
					new AdditionExpression(expr.getAttr().clone(), varexpr)));
		}
		return new SetClause(conds);
	}

	/* solve the where clause given the previous/next db states */
	public SetClause solve(DatabaseState pre, DatabaseState next,
			String[] options) throws Exception {

		// prepare feature information
		ArrayList<String[]> pre_values_all = new ArrayList<String[]>();
		ArrayList<String[]> next_values_all = new ArrayList<String[]>();
		String[] value_names = pre.getColumnNames();

		// if size of previous state and next state is different, this query
		// cannot be solved by revise where clause
		if (pre.size() != next.size())
			return null;

		// gather class information
		HashMap<String, String> classinfo = pre.compare(next);

		this.updateValues(pre_values_all, next_values_all, pre, next, classinfo);

		JAMAHandler jama = new JAMAHandler();
		SetClause fixed_set = new SetClause(jama.solve(this, value_names,
				pre_values_all, next_values_all));

		times = jama.getTime();

		return fixed_set;
	}

	public long[] getTime() {
		return times;
	}

	/* update previous state, next state with only relevant tuples */
	public void updateValues(ArrayList<String[]> pre_values_all,
			ArrayList<String[]> next_values_all, DatabaseState pre,
			DatabaseState next, HashMap<String, String> classinfo) {
		String[] colname_pre = pre.getColumnNames();
		String[] colname_next = next.getColumnNames();
		for (String key : classinfo.keySet()) {
			// if the values are changed
			if (classinfo.get(key).equals("b")) {
				pre_values_all.add(pre.getTuple(key).values);
				next_values_all.add(next.getTuple(key).values);
			}
		}

	}

	/* return conditions */
	public List<SetExpr> getSetExprs() {
		return this.set_exprs;
	}

	public SetClause clone() {
		SetClause cloned = new SetClause();
		for (SetExpr set : this.set_exprs)
			cloned.set_exprs.add(set.clone());
		return cloned;
	}
}
