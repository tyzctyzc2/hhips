package dbmodel;

import json.WordCreateRequest;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "eng_word")
public class EnglishWord {
    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    Integer idword;
    String word;
    String explanation;
    Date inserttime = new Date();

    public EnglishWord() {
    }

    public EnglishWord(WordCreateRequest wordCreateRequest) {
        word = wordCreateRequest.getWord();
        explanation = wordCreateRequest.getExplanation();
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

    public Date getInserttime() {
        return inserttime;
    }

    public void setInserttime(Date inserttime) {
        this.inserttime = inserttime;
    }
}
