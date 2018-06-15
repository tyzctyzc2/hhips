package db;

public class Chapter {
	
	public enum ChapterColumnName { sourcechaptername, sourcechapterindex, sourceid};

	private int idsourcechapter;
	private String sourcechaptername;
	private int sourcechapterindex;
	private int sourceid;
	public int getIdsourcechapter() {
		return idsourcechapter;
	}
	public void setIdsourcechapter(int idsourcechapter) {
		this.idsourcechapter = idsourcechapter;
	}
	public String getSourcechaptername() {
		return sourcechaptername;
	}
	public void setSourcechaptername(String sourcechaptername) {
		this.sourcechaptername = sourcechaptername;
	}
	public int getSourcechapterindex() {
		return sourcechapterindex;
	}
	public void setSourcechapterindex(int sourcechapterindex) {
		this.sourcechapterindex = sourcechapterindex;
	}
	public int getSourceid() {
		return sourceid;
	}
	public void setSourceid(int sourceid) {
		this.sourceid = sourceid;
	}
	
	
}
