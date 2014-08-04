package queryprovenance.harness;

public class ExpParams {
	protected static ExpParams _instance = new ExpParams();
	
	/*
	 * QueryLog generator configs
	 * prefix: ql_
	 */
	public int ql_nqueries = 0;
	public float[] ql_qtypes = null;
	
	/*
	 * Transform selection configs
	 * prefix: tr_
	 */
	
	/*
	 * Solve configs
	 * prefix: s_
	 */
	
	
	
	
	
	private ExpParams() {}
	
	public static ExpParams instance() {
		return _instance;
	}
}
