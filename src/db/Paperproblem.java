package db;
// default package
// Generated May 27, 2018 11:48:26 AM by Hibernate Tools 5.3.0.Beta2

/**
 * Paperproblem generated by hbm2java
 */
public class Paperproblem implements java.io.Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -7840552136163598987L;
	private Integer paperproblemid;
	private int paperid;
	private int problemid;
	private int problemstatus;
	Integer idwork;

	public Integer getIdwork() {
		return idwork;
	}

	public void setIdwork(Integer idwork) {
		this.idwork = idwork;
	}

	public int getProblemstatus() {
		return problemstatus;
	}

	public void setProblemstatus(int problemstatus) {
		this.problemstatus = problemstatus;
	}

	public Paperproblem() {
	}

	public Paperproblem(int paperid, int problemid) {
		this.paperid = paperid;
		this.problemid = problemid;
	}

	public Integer getPaperproblemid() {
		return this.paperproblemid;
	}

	public void setPaperproblemid(Integer paperproblemid) {
		this.paperproblemid = paperproblemid;
	}

	public int getPaperid() {
		return this.paperid;
	}

	public void setPaperid(int paperid) {
		this.paperid = paperid;
	}

	public int getProblemid() {
		return this.problemid;
	}

	public void setProblemid(int problemid) {
		this.problemid = problemid;
	}

}
