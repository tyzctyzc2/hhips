package db;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "v_paperproblem")
public class ProblemByPaper  {

	/**
	 * 
	 */
	private static final long serialVersionUID = 161911564797047951L;

	@Id
	@GeneratedValue(strategy= GenerationType.AUTO)
	private int paperproblemid;
	Integer usedtime;
	Integer workmark;

	public Date getWorkdate() {
		return workdate;
	}

	public void setWorkdate(Date workdate) {
		this.workdate = workdate;
	}

	Date workdate;

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

	public String getModulename() {
		return modulename;
	}

	public void setModulename(String modulename) {
		this.modulename = modulename;
	}

	String modulename;
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

	private Integer idproblem;
	private Integer problemchapterid;
	public Integer getProblemchapterid() {
		return problemchapterid;
	}

	public void setProblemchapterid(Integer problemchapterid) {
		this.problemchapterid = problemchapterid;
	}

	private Integer problemmodule;
	public Integer getProblemmodule() {
		return problemmodule;
	}

	public void setProblemmodule(Integer problemmodule) {
		this.problemmodule = problemmodule;
	}

	private Integer problemlevel;
	private String problemdetail;
	private String problemindex;
	private Integer problemcisactive;
	private String problemanswerstring;
	private String problemanswerdetail;

	Integer 	reason;
	Integer    	idstarreason;

	public Integer getReason() {
		return reason;
	}

	public void setReason(Integer reason) {
		this.reason = reason;
	}

	public Integer getIdstarreason() {
		return idstarreason;
	}

	public void setIdstarreason(Integer idstarreason) {
		this.idstarreason = idstarreason;
	}

	public Integer getIdproblem() {
		return this.idproblem;
	}

	public void setIdproblem(Integer idproblem) {
		this.idproblem = idproblem;
	}

	public Integer getProblemlevel() {
		return this.problemlevel;
	}

	public void setProblemlevel(Integer problemlevel) {
		this.problemlevel = problemlevel;
	}

	public String getProblemdetail() {
		return this.problemdetail;
	}

	public void setProblemdetail(String problemdetail) {
		this.problemdetail = problemdetail;
	}

	public String getProblemindex() {
		return this.problemindex;
	}

	public void setProblemindex(String problemindex) {
		this.problemindex = problemindex;
	}

	public Integer getProblemcisactive() {
		return this.problemcisactive;
	}

	public void setProblemcisactive(Integer problemcisactive) {
		this.problemcisactive = problemcisactive;
	}

	public String getProblemanswerstring() {
		return this.problemanswerstring;
	}

	public void setProblemanswerstring(String problemanswerstring) {
		this.problemanswerstring = problemanswerstring;
	}

	public String getProblemanswerdetail() {
		return this.problemanswerdetail;
	}

	public void setProblemanswerdetail(String problemanswerdetail) {
		this.problemanswerdetail = problemanswerdetail;
	}
}
