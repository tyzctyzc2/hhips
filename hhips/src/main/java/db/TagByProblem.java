package db;

import javax.persistence.*;

@Entity
@Table(name = "v_tagbyproblem")
public class TagByProblem {
    Integer idtag;

    public Integer getIdtag4problem() {
        return idtag4problem;
    }

    public void setIdtag4problem(Integer idtag4problem) {
        this.idtag4problem = idtag4problem;
    }

    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    Integer idtag4problem;

    public Integer getIdtag() {
        return idtag;
    }

    public void setIdtag(Integer idtag) {
        this.idtag = idtag;
    }

    public String getTagname() {
        return tagname;
    }

    public void setTagname(String tagname) {
        this.tagname = tagname;
    }

    public Integer getIdproblem() {
        return idproblem;
    }

    public void setIdproblem(Integer idproblem) {
        this.idproblem = idproblem;
    }

    String  tagname;
    Integer idproblem;
}
