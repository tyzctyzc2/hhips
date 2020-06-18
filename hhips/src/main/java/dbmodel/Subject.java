package dbmodel;

import javax.persistence.*;

@Entity
@Table(name = "v_subject")
public class Subject {
    @Column(name="idstage")
    private Integer idStage;

    @Column(name="stagename")
    private String stageName;

    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    @Column(name="idsubject")
    private Integer idSubject;

    @Column(name="subjectname")
    private String subjectName;

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

    public Integer getIdSubject() {
        return idSubject;
    }

    public void setIdSubject(Integer idSubject) {
        this.idSubject = idSubject;
    }

    public String getSubjectName() {
        return subjectName;
    }

    public void setSubjectName(String subjectName) {
        this.subjectName = subjectName;
    }
}
