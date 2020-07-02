package dbmodel;

import javax.persistence.*;

@Entity
@Table(name = "eng_part")
public class EnglishPart {
    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    Integer idpart;
    String partname;
    Integer maxword;

    public Integer getIdpart() {
        return idpart;
    }

    public void setIdpart(Integer idpart) {
        this.idpart = idpart;
    }

    public String getPartname() {
        return partname;
    }

    public void setPartname(String partname) {
        this.partname = partname;
    }

    public Integer getMaxword() {
        return maxword;
    }

    public void setMaxword(Integer maxword) {
        this.maxword = maxword;
    }
}
