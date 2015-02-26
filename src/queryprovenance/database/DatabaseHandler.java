package queryprovenance.database;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileReader;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Properties;

public class DatabaseHandler {
		
		private static Properties configProps = new Properties();

	    private static String dbUrl;

	    private static String postgreSQLDriver;
	    private static String postgreSQLUser;
	    private static String postgreSQLPassword;

	    // DB Connection
	    private Connection db;
		
		// connected to databasse
		public DatabaseHandler() {
		}
		public void executePrepFile(String filename){
		 	String s            = new String();  
	        StringBuffer sb = new StringBuffer();  	  
	        try  
	        {  
	            FileReader fr = new FileReader(new File(filename));  
	            BufferedReader br = new BufferedReader(fr);  	  
	            while((s = br.readLine()) != null) {  
	                sb.append(s);  
	            }  
	            br.close();  

	            String[] inst = sb.toString().split(";");  
	  
	            for(int i = 0; i<inst.length; i++)  
	            {   
	                if(!inst[i].trim().equals(""))  
	                {  
	                	queryExecution(inst[i]+";"); 
	                }  
	            }      
	        }catch(Exception e){
	        	System.out.print(e);
	        }
		}
		
		public DatabaseMetaData getMetaData() throws Exception{
			return db.getMetaData();
		}
		
		public void getConnected(String configfile) throws Exception{
			configProps.load(new FileInputStream(configfile));
	        configProps.load(new FileInputStream(configfile));
	        
	        
	        dbUrl        = configProps.getProperty("dbUrl");
	        postgreSQLDriver   = configProps.getProperty("postgreSQLDriver");
	        postgreSQLUser     = configProps.getProperty("postgreSQLUser");
	        postgreSQLPassword = configProps.getProperty("postgreSQLPassword");


	        /* load jdbc drivers */
	        Class.forName(postgreSQLDriver).newInstance();

	        /* open connections to TWO databases: imdb and the customer database */
	        db = DriverManager.getConnection(dbUrl, // database
	                postgreSQLUser, // user
	                postgreSQLPassword); // password
		}
		
		public ResultSet queryExecution(String query) throws Exception{
			PreparedStatement preparedquery = db.prepareStatement(query+";");
			preparedquery.clearParameters();
			ResultSet result = null;
			try{
				result = preparedquery.executeQuery();
				
			}catch(Exception ex){
			}
			return result;
		}
		
		public String getUrl() { 
			return this.dbUrl;
		}

		//Close database and end connection
		public void closeAll()
		{
			if(null != db)
			{
				try
				{
					db.close();
				}
				catch(Exception e)
				{
					e.printStackTrace();
				}
			}
		}
}
