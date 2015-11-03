package queryprovenance.database;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Random;

import queryprovenance.harness.Util;

public class DataGenerator {

	public static String insert_sql = "INSERT INTO synth VALUES (DEFAULT, %s);";
	public static String drop_table = "DROP TABLE synth CASCADE;";
	public static String define_table = "CREATE TABLE synth (id serial PRIMARY KEY, %s);";

	public static void generatorData(int tuple_count, String[] attr_def, int domain_max) throws Exception{
		
		File filename = new File("./data/inserts.sql");
		if(!filename.exists())
			filename.createNewFile();

		FileWriter filewriter = new FileWriter(filename);
		BufferedWriter writer = new BufferedWriter(filewriter); 
		// Add table def.
		writer.write(drop_table);
		writer.newLine();
		writer.write(String.format(define_table, Util.join(attr_def, ",")));
		writer.newLine();
		// Add tuples
		for(int i=0; i<tuple_count; ++i){
			Random rand = new Random();
			ArrayList<Integer> insert_val = new ArrayList<Integer>();
			for (int j = 0; j < attr_def.length; ++j) {
				int val = rand.nextInt(domain_max);
				insert_val.add(val);
			}
			
			// Construct insert sql
			writer.write(String.format(insert_sql, Util.join(insert_val, ",")));
			writer.newLine();
		}
		writer.close();
	}
	
	public static void generatorData(DatabaseHandler handler, int attr_count, int tuple_count, int domain_max) throws Exception{
		
		// Drop existing table
		handler.updateExecution(drop_table);
		// Create table definition
		String[] attr_def = new String[attr_count];
		for (int num_attr = 0; num_attr < attr_count; ++num_attr) {
			attr_def[num_attr] = "a" + num_attr + "\t int";
		}
		handler.updateExecution(String.format(define_table, Util.join(attr_def, ",")));
		
		// Insert tuples
		for(int i = 0; i < tuple_count; ++i){
			Random rand = new Random();
			Integer[] insert_val = new Integer[attr_count];
			for (int num_attr = 0; num_attr < attr_count; ++num_attr) {
				insert_val[num_attr] = rand.nextInt(domain_max);
			}
			// Insert
			handler.updateExecution(String.format(insert_sql, Util.join(insert_val, ",")));
		}
	}
}
