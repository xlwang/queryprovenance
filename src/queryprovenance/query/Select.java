package queryprovenance.query;

import java.util.ArrayList;
import java.util.List;

import sun.reflect.generics.reflectiveObjects.NotImplementedException;

public class Select {
	protected String s;
	
	// For now, just stores the SELECT clause as a single string
	// e.g., "*"  or "a as a, b+1 as b"
	public Select(String s) {
		this.s = s;
	}
	
	public List<String> clauses() {
		throw new NotImplementedException();
	}
	
	public List<String> difference(Select o) {
		return new ArrayList<String>();
	}
	
	public String toString() {
		return s;
	}
}
