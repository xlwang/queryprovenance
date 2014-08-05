package queryprovenance.query;

public class WhereExpr {
	public static enum Op {
		l,  // <
		le, // <=
		g,  // >
		ge, // >=
		eq, // =
		ne  // !=
	}
	// Assume the given expression in the form of <attribute arithmetic expression> <Op> <variable>
	protected String attr_expr;
	protected Op operator;
	protected String var;
	
	public WhereExpr(String attr_expr_, Op operator_, String var_){
		this.attr_expr = attr_expr_;
		this.operator = operator_;
		this.var = var_;
	}
	
	public WhereExpr(String attr_expr_, String op_, String var_){
		this.attr_expr = attr_expr_;
		this.operator = this.getOperator(op_);
		this.var = var_;
	}
	public String getAttrExpr(){
		return this.attr_expr;
	}
	
	public String getVar(){
		return this.var;
	}
	
	public Op getOperator(){
		return this.operator;
	}
	
	public Op getOperator(String op){
		switch(op){
		case ">=": return Op.ge;
		case "<=": return Op.le;
		case ">" : return Op.g;
		case "<" : return Op.l;
		case "!=": return Op.ne;
		case "=" : return Op.eq;
		}
		return null;
	}
	
	public String toString(){
		String str = attr_expr;
		switch(operator){
		case l: str = str + "<";break;
		case le: str = str + "<=";break;
		case g: str = str + ">";break;
		case ge: str = str + ">=";break;
		case eq: str = str + "=";break;
		case ne: str = str + "!=";break;
		default: return null;
		}
		return str + var;
	}
}
