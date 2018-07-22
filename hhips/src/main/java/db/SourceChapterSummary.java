package db;

import javax.persistence.*;

@Entity
@Table(name = "v_chaptersummary")
public class SourceChapterSummary {
    public Integer getChapterproblemcount() {
        return chapterproblemcount;
    }

    public void setChapterproblemcount(Integer chapterproblemcount) {
        this.chapterproblemcount = chapterproblemcount;
    }

    private Integer chapterproblemcount;

    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    private Integer idsourcechapter;
    private Integer sourceid;
    public Integer getSourceid() {
        return sourceid;
    }

    public void setSourceid(Integer sourceid) {
        this.sourceid = sourceid;
    }

    private String sourcechaptername;
    private Integer sourcechapterindex;


    public SourceChapterSummary() {
    }

    public Integer getIdsourcechapter() {
        return this.idsourcechapter;
    }

    public void setIdsourcechapter(Integer idsourcechapter) {
        this.idsourcechapter = idsourcechapter;
    }

    public String getSourcechaptername() {
        return this.sourcechaptername;
    }

    public void setSourcechaptername(String sourcechaptername) {
        this.sourcechaptername = sourcechaptername;
    }

    public Integer getSourcechapterindex() {
        return this.sourcechapterindex;
    }

    public void setSourcechapterindex(Integer sourcechapterindex) {
        this.sourcechapterindex = sourcechapterindex;
    }
}
