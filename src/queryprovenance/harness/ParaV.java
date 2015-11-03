package queryprovenance.harness;

import java.io.BufferedReader;
import java.io.FileReader;
import java.util.ArrayList;

public class ParaV {
	public ParaV(){}
	public ArrayList<ArrayList<Integer>> readvalInt(String path) throws Exception {
		BufferedReader br = new BufferedReader(new FileReader(path));
		ArrayList<ArrayList<Integer>> options = new ArrayList<ArrayList<Integer>>();
		String line;
		while((line = br.readLine()) != null) {
			String[] values = line.split(",");
			ArrayList<Integer> current = new ArrayList<Integer>();
			for(int i = 1; i < values.length; ++i)
				current.add(Integer.valueOf((values[i].trim())));
			options.add(current);
		}
		br.close();
		return options;
	}
	public ArrayList<ArrayList<Double>> readvalDbl(String path) throws Exception {
		BufferedReader br = new BufferedReader(new FileReader(path));
		ArrayList<ArrayList<Double>> options = new ArrayList<ArrayList<Double>>();
		String line;
		while((line = br.readLine()) != null) {
			String[] values = line.split(",");
			ArrayList<Double> current = new ArrayList<Double>();
			for(int i = 1; i < values.length; ++i)
				current.add(Double.valueOf((values[i].trim())));
			options.add(current);
		}
		br.close();
		return options;
	}
	public ArrayList<ArrayList<Boolean>> readvalBool(String path) throws Exception {
		BufferedReader br = new BufferedReader(new FileReader(path));
		ArrayList<ArrayList<Boolean>> options = new ArrayList<ArrayList<Boolean>>();
		String line;
		while((line = br.readLine()) != null) {
			String[] values = line.split(",");
			ArrayList<Boolean> current = new ArrayList<Boolean>();
			for(int i = 1; i < values.length; ++i)
				current.add(Boolean.valueOf((values[i].trim())));
			options.add(current);
		}
		br.close();
		return options;
	}
}
