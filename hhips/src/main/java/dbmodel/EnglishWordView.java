package dbmodel;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "v_eng_detail_list")
public class EnglishWordView {
    @Id
    Integer idpartword;
    Integer idpart;
    String partname;
    Integer idword;
    String word;
    String explanation;
    String meaning;

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

    public String getPartname() {
        return partname;
    }

    public void setPartname(String partname) {
        this.partname = partname;
    }

    public Integer getIdword() {
        return idword;
    }

    public void setIdword(Integer idword) {
        this.idword = idword;
    }

    public String getWord() {
        return word;
    }

    public void setWord(String word) {
        this.word = word;
    }

    public String getExplanation() {
        return explanation;
    }

    public void setExplanation(String explanation) {
        this.explanation = explanation;
    }

    public String getMeaning() {
        return meaning;
    }

    public void setMeaning(String meaning) {
        this.meaning = meaning;
    }
}
