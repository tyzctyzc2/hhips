package dbmodel;

import org.json.JSONObject;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "v_papersummary")
public class PaperSummary implements java.io.Serializable {

    /**
     *
     */
    private static final long serialVersionUID = 8783428714781245116L;
    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    private Integer idpaper;
    private String papername;
    private Date paperdate;
    private Integer isactive;

    public Integer getTotalproblem() {
        return totalproblem;
    }

    public void setTotalproblem(Integer totalproblem) {
        this.totalproblem = totalproblem;
    }

    public Integer getTotaldone() {
        return totaldone;
    }

    public void setTotaldone(Integer totaldone) {
        this.totaldone = totaldone;
    }

    private Integer totalproblem;
    private Integer totaldone;

    public PaperSummary() {
    }

    public Integer getIdpaper() {
        return this.idpaper;
    }

    public void setIdpaper(Integer idpaper) {
        this.idpaper = idpaper;
    }

    public String getPapername() {
        return this.papername;
    }

    public void setPapername(String papername) {
        this.papername = papername;
    }

    public Date getPaperdate() {
        return this.paperdate;
    }

    public void setPaperdate(Date paperdate) {
        this.paperdate = paperdate;
    }

    public Integer getIsactive() {
        return this.isactive;
    }

    public void setIsactive(Integer isactive) {
        this.isactive = isactive;
    }

    @Override
    public String toString() {
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("idpaper", idpaper);
        jsonObject.put("papername", papername);
        jsonObject.put("isactive", isactive);
        jsonObject.put("totalproblem", totalproblem);
        jsonObject.put("totaldone", totaldone);
        return jsonObject.toString();
    }
}
