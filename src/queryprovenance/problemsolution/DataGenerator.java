package queryprovenance.problemsolution;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.util.Random;

public class DataGenerator {

	public DataGenerator() throws Exception{
		BufferedReader reader = new BufferedReader( 
				 new FileReader("./data/names.txt"));
		String str;
		String[] names = new String[7000];
		int count = 0;
		while((str=reader.readLine())!=null){
			String[] list = str.split(" ");
			names[count++] = list[0].toLowerCase().trim();
		}
		File filename = new File("./data/inserts.sql");
		if(!filename.exists())
			filename.createNewFile();
		String[] departments = new String[]{"sale","engineer","hr","finance","mangement"};
		FileWriter filewriter = new FileWriter(filename);
		BufferedWriter writer = new BufferedWriter(filewriter); 
		for(int i=0; i<900; ++i){
			Random rand = new Random();
			int val1 = rand.nextInt(count-1);
			int val2 = rand.nextInt(100);
			int val3 = rand.nextInt(departments.length-1);
			int val4 = rand.nextInt(6);
			int val5 = rand.nextInt(150000)+50000;
			writer.write("INSERT INTO Employee VALUES ("+String.valueOf(i)+","+"'"+names[val1]+"',"+"'store"+String.valueOf(val2)+"','"+departments[val3]+"',"+String.valueOf(val4)+","+String.valueOf(val5)+");");
			writer.newLine();
		}
		writer.close();
	}

}
