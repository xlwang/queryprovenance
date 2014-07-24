package queryprovenance.query;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;

import weka.classifiers.rules.JRip;
import weka.classifiers.trees.J48;
import weka.classifiers.trees.j48.ClassifierTree;
import weka.core.Instances;

import java.util.regex.Pattern;
import java.util.regex.Matcher;

public class DecisionTreeHandler {

	private J48 tree; // J48 tree classification type
	
	public DecisionTreeHandler(){
		tree = new J48();
	}
	
	/* build decision tree given fileanme and parameters */
	public String buildTree(String filename) throws Exception{
		// read file 
		BufferedReader reader = new BufferedReader( 
				 new FileReader(filename));
		Instances data = new Instances(reader); 
		reader.close(); 
		
		// Prepare parameters
		data.setClassIndex(data.numAttributes() - 1); 
		
		// call classification tree function for results;
		J48 tree = new J48();
		JRip rule = new JRip();
		rule.buildClassifier(data);
		//tree.buildClassifier(data);		
		//ClassifierTree 
		// print tree
		return rule.toString();
	}
	
	/* convert tree into a set of condition rules*/
	public void toConditionRules(){
		String prunedtree = tree.toString();
		String[] splits = prunedtree.split("\n");
		for(String str:splits){
			
		}
	}
	
	/* return node type */
	public int getNodeType(String str){
		return 0;
	}
}
