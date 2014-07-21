package queryprovenance.query;

public class Condition {
	private String left; // left side of equation or inequality; fixed;
	private String operator; // operator connects left and right side; =/>/</>=/<=.
	private String right; // variables to be solved;
	
	public Condition(String condition_){
		
	}
	/* given the attribute values of one entity/row, return the condition*/
	public String solve(String[] attributes, boolean conditionISIncluded) throws Exception {
		
	}
}
