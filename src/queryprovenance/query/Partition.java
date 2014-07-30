package queryprovenance.query;

import java.util.ArrayList;
import java.util.regex.Pattern;
import java.util.regex.Matcher;

public class Partition {

	private String partition_name;
	private String content_body;
	private String remain;
	private ArrayList<String> content;
	private String connector;
	
	private String body_split_pattern;
	private String content_split_pattern;
	
	public Partition(String content_split_pattern_, String body_split_pattern_){
		this.content_split_pattern = content_split_pattern_;
		this.body_split_pattern = body_split_pattern_;
		partition_name = "";
		content_body = "";
		remain = "";
		connector = "";
		content = new ArrayList<String>();
	}
	public String getContentSplit(String query){
		Pattern pattern = Pattern.compile(content_split_pattern,Pattern.CASE_INSENSITIVE);
		Matcher matcher = pattern.matcher(query);
		if(matcher.find()){
			partition_name = matcher.group(1);
			content_body = matcher.group(2).trim();
			content_body = content_body.replaceAll("[;]", "");
			getContentSplit();
			if(matcher.groupCount() < 4)
				remain = "";
			else
				remain = matcher.group(3)+" "+matcher.group(4);
			return remain;	
		}
		else
			return null;
	}
	public void getContentSplit(){
		Pattern pattern = Pattern.compile(body_split_pattern);
		Matcher matcher = pattern.matcher(content_body);
		StringBuffer sb = new StringBuffer();
		while(matcher.find()){
			matcher.appendReplacement(sb, " next ");
		}
		matcher.appendTail(sb);
		String result = sb.toString();
		String[] resultsplit = result.split("next");
		for(int i=0; i<resultsplit.length; ++i){
			String tempcontent = resultsplit[i].trim();
			if(tempcontent.length()>0)
				content.add(tempcontent);
		}
	}
	
	public String getPartitionName(){
		return partition_name;
	}
	public String getContent(){
		return content_body;
	}
	public ArrayList<String> getSplitedContent(){
		return content;
	}
	public String getRemain(){
		return remain;
	}
	
}
