package queryprovenance.query;

import ilog.concert.IloNumVar;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;

import queryprovenance.expression.Expression;

public class WhereExpr {
	public static enum Op {
		l("<"), // <
		le("<="), // <=
		g(">"), // >
		ge(">="), // >=
		eq("="), // =
		ne("!="); // !=
		private final String op;

		private Op(String op_) {
			op = op_;
		}

		public String toString() {
			return this.op;
		}
	}

	// Assume the given expression in the form of <attribute arithmetic
	// expression> <Op> <variable>
	protected Expression attr_expr; // expression that is fixed: no revision
									// needed
	protected Op operator; // relationship between two expressions
	protected Expression var; // expression need revision
	public HashSet<String> attrs = new HashSet<String>();;

	/* initialize where expression */
	public WhereExpr(Expression attr_expr_, Op operator_, Expression var_) {
		this.attr_expr = attr_expr_;
		this.operator = operator_;
		this.var = var_;
		attrs.addAll(attr_expr.getAssignedVariable());
	}

	/* initialize where expression */
	public WhereExpr(Expression attr_expr_, String op_, Expression var_) {
		this.attr_expr = attr_expr_;
		this.operator = this.getOperator(op_);
		this.var = var_;
		attrs.addAll(attr_expr.getAssignedVariable());
	}

	/* return attr_expr */
	public Expression getAttrExpr() {
		return this.attr_expr;
	}

	/* return var value */
	public double getVar() {
		return this.var.Evaluate();
	}

	/* return operation */
	public Op getOperator() {
		return this.operator;
	}

	public static Op getOperator(String op) {
		switch (op) {
		case ">=":
			return Op.ge;
		case "<=":
			return Op.le;
		case ">":
			return Op.g;
		case "<":
			return Op.l;
		case "!=":
			return Op.ne;
		case "=":
			return Op.eq;
		}
		return null;
	}

	public String toString() {
		String str = attr_expr.toString();
		return String.format("%s %s %s", attr_expr.toString(), operator.toString(),
				var.toString());
	}

	/* clone expression */
	public WhereExpr clone() {
		return new WhereExpr(this.attr_expr.clone(), this.operator,
				this.var.clone());
	}

	/* get var expression */
	public Expression getVarExpr() {
		return this.var;
	}

	public void fix(HashMap<IloNumVar, Double> fixedmap,
			HashMap<Expression, IloNumVar> expressionmap) throws Exception {
		// this.attr_expr.fixExpression(fixedmap, expressionmap);
		this.var.fixExpression(fixedmap, expressionmap);
	}

	// Update where expr by converting string value into integer value.
	public void strToNum(HashMap<String, Integer> attr_value_map, String attr) {
		// check if current expression is involved in the update
		if (attr_expr.containsVar(attr)) {
			var.StrToNum(attr_value_map, attr);
		}
	}

	// Convert where expression into JSON format.
	public String queryToJSON() {
		String whereexpr_json = "\"" + attr_expr.toString() + "\"" + "," + "\""
				+ this.operator.toString() + "\"" + "," + "\"" + var.toString() + "\"";
		return whereexpr_json;
	}
}
