package queryprovenance.database;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.util.Random;

public class DataGenerator {
	// static final String dir = "/Users/xlwang/queryprovenance/queryprovenance/jar/";
	public static void generatorData(String dir, int tuple_count) throws Exception{
		BufferedReader reader = new BufferedReader( 
				 new FileReader(dir + "/data/names.txt"));
		String str;
		String[] names = new String[7000];
		int count = 0;
		while((str=reader.readLine())!=null){
			String[] list = str.split(" ");
			names[count++] = list[0].toLowerCase().trim();
		}
		File filename = new File(dir + "/data/inserts.sql");
		if(!filename.exists())
			filename.createNewFile();
		String[] departments = new String[]{"sale","engineer","hr","finance","mangement"};
		FileWriter filewriter = new FileWriter(filename);
		BufferedWriter writer = new BufferedWriter(filewriter); 
		for(int i=0; i<tuple_count; ++i){
			Random rand = new Random();
			int val0 = rand.nextInt(20) + 20;
			int val2 = rand.nextInt(60-val0) ;  //employment year
			int val1 = val2 + val0; //age
			
			
			int val4 = rand.nextInt(6); // level
			int val5 = rand.nextInt(150000)+50000; // salary
			
			int val3 = (int) (((double)rand.nextInt(30)/100.0)*val5); //tax
			writer.write("INSERT INTO Employee VALUES ("+String.valueOf(i)+"," + String.valueOf(val4)+","+ String.valueOf(val1) + "," + String.valueOf(val2) + "," + String.valueOf(val3) + "," + String.valueOf(val5)+");");
			writer.newLine();
		}
		writer.close();
		reader.close();
	}
	

}
