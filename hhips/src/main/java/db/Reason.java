package db;

import javax.persistence.*;
import java.util.List;
@Entity
@Table(name = "reason")
public class Reason {
    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    Integer idreason;
    String  reasonname;
    Integer reasonfactor;

    public Integer getIdreason() {
        return idreason;
    }

    public void setIdreason(Integer idreason) {
        this.idreason = idreason;
    }

    public String getReasonname() {
        return reasonname;
    }

    public void setReasonname(String reasonname) {
        this.reasonname = reasonname;
    }

    public Integer getReasonfactor() {
        return reasonfactor;
    }

    public void setReasonfactor(Integer reasonfactor) {
        this.reasonfactor = reasonfactor;
    }
}
