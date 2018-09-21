package db;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "v_chapterproblemwithlastwork")
public class ProblemWithLastWork {
	public Integer getIdwork() {
		return idwork;
	}
	public void setIdwork(Integer idwork) {
		this.idwork = idwork;
	}
	public Integer getUsedtime() {
		return usedtime;
	}
	public void setUsedtime(Integer usedtime) {
		this.usedtime = usedtime;
	}
	public Integer getWorkmark() {
		return workmark;
	}
	public void setWorkmark(Integer workmark) {
		this.workmark = workmark;
	}
	public String getWorkdetail() {
		return workdetail;
	}
	public void setWorkdetail(String workdetail) {
		this.workdetail = workdetail;
	}
	public Integer getReason() {
		return reason;
	}
	public void setReason(Integer reason) {
		this.reason = reason;
	}
	public Integer getProblemchapterid() {
		return problemchapterid;
	}
	public void setProblemchapterid(Integer problemchapterid) {
		this.problemchapterid = problemchapterid;
	}
	public Integer getIdproblem() {
		return idproblem;
	}
	public void setIdproblem(Integer idproblem) {
		this.idproblem = idproblem;
	}
	public String getProblemanswerdetail() {
		return problemanswerdetail;
	}
	public void setProblemanswerdetail(String problemanswerdetail) {
		this.problemanswerdetail = problemanswerdetail;
	}
	public String getProblemanswerstring() {
		return problemanswerstring;
	}
	public void setProblemanswerstring(String problemanswerstring) {
		this.problemanswerstring = problemanswerstring;
	}
	public Integer getProblemcisactive() {
		return problemcisactive;
	}
	public void setProblemcisactive(Integer problemcisactive) {
		this.problemcisactive = problemcisactive;
	}
	public String getProblemdetail() {
		return problemdetail;
	}
	public void setProblemdetail(String problemdetail) {
		this.problemdetail = problemdetail;
	}
	public String getProblemindex() {
		return problemindex;
	}
	public void setProblemindex(String problemindex) {
		this.problemindex = problemindex;
	}
	public Integer getProblemlevel() {
		return problemlevel;
	}
	public void setProblemlevel(Integer problemlevel) {
		this.problemlevel = problemlevel;
	}
	public Integer getProblemmodule() {
		return problemmodule;
	}
	public void setProblemmodule(Integer problemmodule) {
		this.problemmodule = problemmodule;
	}

	public String getModulename() {
		return modulename;
	}
	public void setModulename(String modulename) {
		this.modulename = modulename;
	}
	public Date getWorkdate() {
		return workdate;
	}
	public void setWorkdate(Date workdate) {
		this.workdate = workdate;
	}
	Integer idwork;
	Integer	usedtime; 
	Integer	workmark; 
	String workdetail; 
	Integer	reason; 
	Integer	problemchapterid; 
	String problemanswerdetail;
	String problemanswerstring; 
	Integer	problemcisactive; 
	String problemdetail;

	public String getProblemdetailb() {
		return problemdetailb;
	}

	public void setProblemdetailb(String problemdetailb) {
		this.problemdetailb = problemdetailb;
	}

	public String getProblemdetailc() {
		return problemdetailc;
	}

	public void setProblemdetailc(String problemdetailc) {
		this.problemdetailc = problemdetailc;
	}

	String problemdetailb;
	String problemdetailc;
	String problemindex; 
	Integer	problemlevel; 
	Integer	problemmodule;
	String modulename;
	Date workdate;

	public Integer getProblemtotalworktime() {
		return problemtotalworktime;
	}

	public void setProblemtotalworktime(Integer problemtotalworktime) {
		this.problemtotalworktime = problemtotalworktime;
	}

	public Integer getProblemtotalusetime() {
		return problemtotalusetime;
	}

	public void setProblemtotalusetime(Integer problemtotalusetime) {
		this.problemtotalusetime = problemtotalusetime;
	}

	Integer problemtotalusetime;
	Integer problemtotalworktime;

	public Integer getOldusedtime() {
		return oldusedtime;
	}

	public void setOldusedtime(Integer oldusedtime) {
		this.oldusedtime = oldusedtime;
	}

	Integer oldusedtime;

	@Id
	@GeneratedValue(strategy= GenerationType.AUTO)
	Integer	idproblem;
}
