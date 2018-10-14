package db;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "chapternote")
public class ChapterNote  {
    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    Integer idchapternote;
    String  chapternotedetail;

    public Integer getIdchapternote() {
        return idchapternote;
    }

    public void setIdchapternote(Integer idchapternote) {
        this.idchapternote = idchapternote;
    }

    public String getChapternotedetail() {
        return chapternotedetail;
    }

    public void setChapternotedetail(String chapternotedetail) {
        this.chapternotedetail = chapternotedetail;
    }

    public Integer getIdsourcechapter() {
        return idsourcechapter;
    }

    public void setIdsourcechapter(Integer idsourcechapter) {
        this.idsourcechapter = idsourcechapter;
    }

    public Date getChapternotetime() {
        return chapternotetime;
    }

    public void setChapternotetime(Date chapternotetime) {
        this.chapternotetime = chapternotetime;
    }

    Integer idsourcechapter;
    Date    chapternotetime;
}
