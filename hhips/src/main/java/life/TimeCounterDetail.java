package life;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "timecounterlookup")
public class TimeCounterDetail {
    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    Integer idtimecounterdetail;

    public Integer getIdtimecounterdetail() {
        return idtimecounterdetail;
    }

    public void setIdtimecounterdetail(Integer idtimecounterdetail) {
        this.idtimecounterdetail = idtimecounterdetail;
    }

    public Integer getIdtimecounterlookup() {
        return idtimecounterlookup;
    }

    public void setIdtimecounterlookup(Integer idtimecounterlookup) {
        this.idtimecounterlookup = idtimecounterlookup;
    }

    public Integer getTimecountevalue() {
        return timecountevalue;
    }

    public void setTimecountevalue(Integer timecountevalue) {
        this.timecountevalue = timecountevalue;
    }

    public Date getTimecountertime() {
        return timecountertime;
    }

    public void setTimecountertime(Date timecountertime) {
        this.timecountertime = timecountertime;
    }

    Integer idtimecounterlookup;
    Integer timecountevalue;
    Date    timecountertime;
}
