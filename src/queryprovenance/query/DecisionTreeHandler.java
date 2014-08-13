package queryprovenance.query;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import queryprovenance.database.DatabaseState;
import queryprovenance.expression.Expression;
import queryprovenance.expression.VariableExpression;
import weka.classifiers.trees.J48;
import weka.core.Instances;
import context.arch.intelligibility.expression.Comparison;
import context.arch.intelligibility.expression.DNF;
import context.arch.intelligibility.expression.Reason;
import context.arch.intelligibility.weka.j48.J48Parser;

public class DecisionTreeHandler {

	private J48 tree; // J48 tree 
	Map<String, WhereExpr> map;
	
	public DecisionTreeHandler(){
		//initialize J48 decidion tree
		tree = new J48();
		map = new HashMap<String, WhereExpr>();
	}
	
	/* build decision tree given fileanme and parameters */
	public List<WhereExpr> buildTree(WhereClause where, String filename) throws Exception{
		// define fixed where expression list
		List<WhereExpr> fixed_values;
		
		// read file 
		BufferedReader reader = new BufferedReader( 
				 new FileReader(filename));
		Instances data = new Instances(reader); 
		reader.close(); 
		
		// Prepare parameters
		data.setClassIndex(data.numAttributes() - 1); 
		
		// ClassifierTree 
		tree.buildClassifier(data);
		
		// convert into conditional rules
        Map<String, DNF> valueTraces = J48Parser.parse(tree, data);
		
        // return result
		return this.toConditionRules(where, valueTraces);
	}
	
	/* convert tree into a set of condition rules*/
	public List<WhereExpr> toConditionRules(WhereClause where, Map<String, DNF> valueTraces){
		List<WhereExpr> fixed_values = new ArrayList<WhereExpr>(); 
		// check structure
		int orgsize = where.getWhereExprs().size();
		int dtsize = 0;
		DNF traces = null;
		
		// get DNF traces for class "b"
		for(String key:valueTraces.keySet())
			if(key.equals("b"))
				traces = valueTraces.get(key);
		
		// traces must exist
		if(traces == null || traces.size() < 1)
			return null;
		
		// check overall structure; operation connects each condition rules must be the same
		if((traces.size()>1 && where.getOperator() != WhereClause.Op.DISJ) ||(traces.size() == 1 && where.getOperator() != WhereClause.Op.CONJ)){
			return null;
			
		}
		// compose conditions
		for(int i = 0; i < traces.size(); ++i){
			Reason sub_reason = traces.get(i); // each sub_reason in DISJ relationship
			for(int j = 0; j < sub_reason.size(); ++j){
				Comparison condition = (Comparison) sub_reason.get(j); // each condition in CONJ relationship
				WhereExpr orgexpr = map.get(condition.getName()); // get original where expression
				String operation = condition.getRelationship().toString();
				Expression value = new VariableExpression(Double.valueOf(condition.getValue().toString()), false);
				WhereExpr newexpr = new WhereExpr(orgexpr.getAttrExpr().clone(), operation, value);
				fixed_values.add(newexpr);
			}
		}
		if(fixed_values.size() != where.getWhereExprs().size())
			return null;
		return fixed_values;
	}
	
	/* prepare input file for Decision tree solver */
	public void prepareARFF(WhereClause where, DatabaseState pre, HashMap<String, String> classinfo) throws Exception {
		
		// prepare file for Decision tree solver
		File filename = new File("./data/feature.arff");
		if(!filename.exists())
			filename.createNewFile();
		FileWriter filewriter = new FileWriter(filename);
		BufferedWriter writer = new BufferedWriter(filewriter); 
		
		// write data name
		writer.write("@RELATION test"); writer.newLine();
		
		// write feature/attributes names
		for(int i = 0; i < where.getWhereExprs().size(); ++i){
			writer.write("@ATTRIBUTE" + " col"+String.valueOf(i) + " NUMERIC"); writer.newLine();
			map.put("col" + String.valueOf(i), where.getWhereExprs().get(i));
		}
		
		// write class information
		writer.write("@ATTRIBUTE class {'g','b'}"); writer.newLine();
		
		// write data
		writer.write("@DATA"); writer.newLine();
		
		// write data from dbstate
		String[] column_names = pre.getColumnNames();
		for(String key: pre.getKeySet()){
			// for every tuple
			String[] tuple_values = pre.getTuple(key);
			
			// get feature info from each where expression
			for(WhereExpr expr: where.getWhereExprs()){
				// update attributes' values
				for(int i = 0; i < column_names.length; ++i)
					expr.getAttrExpr().setVariable(column_names[i], Double.valueOf(tuple_values[i]));
				writer.write(String.valueOf(expr.getAttrExpr().Evaluate()) + ",");
			}
			
			// write class info
			writer.write("'"+classinfo.get(key)+"'"); 
			writer.newLine();
		}
		
		// finish prepare file for DT solver
		writer.close();	
	}
	
}
