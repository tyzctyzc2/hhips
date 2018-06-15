package db;

public class ProblemByPaper extends Problem {

	/**
	 * 
	 */
	private static final long serialVersionUID = 161911564797047951L;

	private int paperproblemid;
	Integer usedtime;
	Integer workmark;
	
	
	public Integer getWorkmark() {
		return workmark;
	}
	public void setWorkmark(Integer workmark) {
		this.workmark = workmark;
	}
	public Integer getUsedtime() {
		return usedtime;
	}
	public void setUsedtime(Integer usedtime) {
		this.usedtime = usedtime;
	}
	public int getPaperproblemid() {
		return paperproblemid;
	}
	public void setPaperproblemid(int paperproblemid) {
		this.paperproblemid = paperproblemid;
	}
	private int problemstatus;
	public int getProblemstatus() {
		return problemstatus;
	}
	public void setProblemstatus(int problemstatus) {
		this.problemstatus = problemstatus;
	}
	public int getIdpaper() {
		return idpaper;
	}
	public void setIdpaper(int idpaper) {
		this.idpaper = idpaper;
	}
	public int getIsactive() {
		return isactive;
	}
	public void setIsactive(int isactive) {
		this.isactive = isactive;
	}
	public String getPapername() {
		return papername;
	}
	public void setPapername(String papername) {
		this.papername = papername;
	}
	private int idpaper;
	private int isactive;
	private String papername;
	String workdetail;
	public String getWorkdetail() {
		return workdetail;
	}
	public void setWorkdetail(String workdetail) {
		this.workdetail = workdetail;
	}
	public Integer getIdwork() {
		return idwork;
	}
	public void setIdwork(Integer idwork) {
		this.idwork = idwork;
	}
	Integer idwork;
	
	public String toString() {
		return "{" 
				+ "\"problemdetail\":\"" + this.getProblemdetail() +"\","
				+ "\"idproblem\":" + this.getIdproblem() +","
				+ "\"paperproblemid\":" + this.getPaperproblemid() +""
				+"}";
	}
}
