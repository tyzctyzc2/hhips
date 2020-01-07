package dbmodel;

import javax.persistence.*;
import javax.persistence.criteria.CriteriaBuilder;

@Entity
@Table(name = "v_chaptersummary")
public class SourceChapterSummary {
    private  Integer chapternotecount;
    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    private Integer idsourcechapter;
    private Integer sourceid;
    private String sourcechaptername;
    private Integer sourcechapterindex;

    public SourceChapterSummary() {
    }
    public Integer getChapterproblemcount() {
        return chapterproblemcount;
    }

    public void setChapterproblemcount(Integer chapterproblemcount) {
        this.chapterproblemcount = chapterproblemcount;
    }

    private Integer chapterproblemcount;

    public Integer getChapternotecount() {
        return chapternotecount;
    }

    public void setChapternotecount(Integer chapternotecount) {
        this.chapternotecount = chapternotecount;
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

    public Integer getSourceid() {
        return sourceid;
    }

    public void setSourceid(Integer sourceid) {
        this.sourceid = sourceid;
    }

}
