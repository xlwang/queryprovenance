package queryprovenance.query;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import weka.classifiers.trees.J48;
import weka.core.Instances;
import java.util.regex.Pattern;
import java.util.regex.Matcher;

public class DecisionTreeHandler {

	private J48 tree;
	
	public DecisionTreeHandler(){
		tree = new J48();
	}
	public void buildTree(String filename) throws Exception{
		BufferedReader reader = new BufferedReader( 
				 new FileReader(filename));
		Instances data = new Instances(reader); 
		reader.close(); 
		data.setClassIndex(data.numAttributes() - 1); 
		// call classification tree function for results;
		J48 tree = new J48();
		tree.buildClassifier(data);		
		System.out.print(tree.toString());
	}
	public void toConditionRules(){
		String prunedtree = tree.toString();
		String[] splits = prunedtree.split("\n");
		for(String str:splits){
			
		}
	}
	public int getNodeType(String str){
		
	}
}
