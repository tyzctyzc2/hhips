package dbmodel;

import javax.persistence.*;

@Entity
@Table(name = "tag")
public class Tag {

    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    Integer idtag;
    String tagname;
    Integer idsubject;
    Integer parentid;

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

    public Integer getIdsubject() {
        return idsubject;
    }

    public void setIdsubject(Integer idsubject) {
        this.idsubject = idsubject;
    }

    public Integer getParentid() {
        return parentid;
    }

    public void setParentid(Integer parentid) {
        this.parentid = parentid;
    }
}
