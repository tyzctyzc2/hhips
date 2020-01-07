package dbmodel;

import javax.persistence.*;

@Entity
@Table(name = "stage")
public class Stage implements java.io.Serializable {
    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    @Column(name="idstage")
    private Integer idStage;

    @Column(name="stagename")
    private String stageName;

    public Integer getIdStage() {
        return idStage;
    }

    public void setIdStage(Integer idStage) {
        this.idStage = idStage;
    }

    public String getStageName() {
        return stageName;
    }

    public void setStageName(String stageName) {
        this.stageName = stageName;
    }
}
