package queryprovenance.harness;

import java.util.ArrayList;
import java.util.List;



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
}
