package db;

import javax.persistence.*;

@Entity
@Table(name = "tag")
public class Tag {

    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    Integer idtag;

    String tagname;

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
}
