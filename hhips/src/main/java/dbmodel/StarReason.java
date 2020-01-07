package dbmodel;

import javax.persistence.*;

@Entity
@Table(name = "starreason")
public class StarReason {
    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    Integer idstarreason;
    String  starreasonname;
    String  starreasonfactor;

    public Integer getIdstarreason() {
        return idstarreason;
    }

    public void setIdstarreason(Integer idstarreason) {
        this.idstarreason = idstarreason;
    }

    public String getStarreasonname() {
        return starreasonname;
    }

    public void setStarreasonname(String starreasonname) {
        this.starreasonname = starreasonname;
    }

    public String getStarreasonfactor() {
        return starreasonfactor;
    }

    public void setStarreasonfactor(String starreasonfactor) {
        this.starreasonfactor = starreasonfactor;
    }
}
