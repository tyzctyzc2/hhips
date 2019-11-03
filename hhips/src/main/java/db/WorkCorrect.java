package db;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.util.Date;

@Entity
@Table(name = "workcorrect")
public class WorkCorrect {
    @Id
    @Column(columnDefinition = "workid")
    private Integer workid;

    @Column(columnDefinition = "starttime")
    private Date starttime;

    @Column(columnDefinition = "correctstatus")
    private Integer correctstatus;

    public WorkCorrect() {
        starttime = new Date();
        correctstatus = 0;
    }

    public Integer getWorkid() {
        return workid;
    }

    public void setWorkid(Integer workid) {
        this.workid = workid;
    }

    public Date getStarttime() {
        return starttime;
    }

    public void setStarttime(Date starttime) {
        this.starttime = starttime;
    }

    public Integer getCorrectstatus() {
        return correctstatus;
    }

    public void setCorrectstatus(Integer correctstatus) {
        this.correctstatus = correctstatus;
    }
}
