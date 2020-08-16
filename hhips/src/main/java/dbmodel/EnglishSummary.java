package dbmodel;

import javax.persistence.*;

@Entity
@Table(name = "v_eng_summary_count")
public class EnglishSummary {
    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    Integer idpart;
    Integer count;

    public Integer getIdpart() {
        return idpart;
    }

    public void setIdpart(Integer idpart) {
        this.idpart = idpart;
    }

    public Integer getCount() {
        return count;
    }

    public void setCount(Integer count) {
        this.count = count;
    }
}
