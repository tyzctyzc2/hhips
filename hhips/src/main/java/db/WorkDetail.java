package db;

import javax.persistence.*;
import java.util.Date;
@Entity
@Table(name = "v_workdetaillist")
public class WorkDetail {
    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    private Integer idwork;
    private Integer idproblem;
    public Integer getIdproblem() {
        return idproblem;
    }

    public void setIdproblem(Integer idproblem) {
        this.idproblem = idproblem;
    }

    public Date getStartdate() {
        return startdate;
    }

    public void setStartdate(Date startdate) {
        this.startdate = startdate;
    }

    public String getPapername() {
        return papername;
    }

    public void setPapername(String papername) {
        this.papername = papername;
    }

    private String papername;

    public String getModulename() {
        return modulename;
    }

    public void setModulename(String modulename) {
        this.modulename = modulename;
    }

    public Integer getProblemlevel() {
        return problemlevel;
    }

    public void setProblemlevel(Integer problemlevel) {
        this.problemlevel = problemlevel;
    }

    private  Integer problemlevel;
    private  String modulename;
    private Date startdate;
    private Date workdate;
    private Integer usedtime;
    private String workdetail;
    private Integer workmark;
    private Integer reason;

    public String getProblemindex() {
        return problemindex;
    }

    public void setProblemindex(String problemindex) {
        this.problemindex = problemindex;
    }

    String problemindex;

    public String getStarreasonname() {
        return starreasonname;
    }

    public void setStarreasonname(String starreasonname) {
        this.starreasonname = starreasonname;
    }

    private String starreasonname;

    public Integer getIdstarreason() {
        return idstarreason;
    }

    public void setIdstarreason(Integer idstarreason) {
        this.idstarreason = idstarreason;
    }

    private Integer idstarreason;

    public Integer getProblemchapterid() {
        return problemchapterid;
    }

    public void setProblemchapterid(Integer problemchapterid) {
        this.problemchapterid = problemchapterid;
    }

    private Integer problemchapterid;

    public Integer getIdpaper() {
        return idpaper;
    }

    public void setIdpaper(Integer idpaper) {
        this.idpaper = idpaper;
    }

    private  Integer idpaper;
    public WorkDetail() {
    }


    public Integer getIdwork() {
        return this.idwork;
    }

    public void setIdwork(Integer idwork) {
        this.idwork = idwork;
    }

    public Date getWorkdate() {
        return this.workdate;
    }

    public void setWorkdate(Date workdate) {
        this.workdate = workdate;
    }

    public Integer getUsedtime() {
        return this.usedtime;
    }

    public void setUsedtime(Integer usedtime) {
        this.usedtime = usedtime;
    }

    public String getWorkdetail() {
        return this.workdetail;
    }

    public void setWorkdetail(String workdetail) {
        this.workdetail = workdetail;
    }

    public Integer getWorkmark() {
        return this.workmark;
    }

    public void setWorkmark(Integer workmark) {
        this.workmark = workmark;
    }

    public Integer getReason() {
        return this.reason;
    }

    public void setReason(Integer reason) {
        this.reason = reason;
    }
}
