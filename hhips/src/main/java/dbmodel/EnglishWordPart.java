package dbmodel;

import javax.persistence.*;

@Entity
@Table(name = "eng_partword")
public class EnglishWordPart {
    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    Integer idpartword;
    Integer idpart;
    Integer idword;

    public Integer getIdpartword() {
        return idpartword;
    }

    public void setIdpartword(Integer idpartword) {
        this.idpartword = idpartword;
    }

    public Integer getIdpart() {
        return idpart;
    }

    public void setIdpart(Integer idpart) {
        this.idpart = idpart;
    }

    public Integer getIdword() {
        return idword;
    }

    public void setIdword(Integer idword) {
        this.idword = idword;
    }
}
