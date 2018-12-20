package report;

import org.omg.PortableInterceptor.INACTIVE;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "starbalance")
public class StarBalance {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Integer idstarbalance;

    Date changedate;
    Integer changebalance;
    String changenote;

    public Integer getIdstarbalance() {
        return idstarbalance;
    }

    public void setIdstarbalance(Integer idstarbalance) {
        this.idstarbalance = idstarbalance;
    }

    public Date getChangedate() {
        return changedate;
    }

    public void setChangedate(Date changedate) {
        this.changedate = changedate;
    }

    public Integer getChangebalance() {
        return changebalance;
    }

    public void setChangebalance(Integer changebalance) {
        this.changebalance = changebalance;
    }

    public String getChangenote() {
        return changenote;
    }

    public void setChangenote(String changenote) {
        this.changenote = changenote;
    }
}
