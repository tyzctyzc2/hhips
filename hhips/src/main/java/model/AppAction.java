package model;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;
import com.fasterxml.jackson.annotation.JsonSetter;

import javax.persistence.*;
import java.util.Date;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
        "Address1",
        "City",
        "StateProvince",
        "PostalCode",
        "Country",
        "Location"
})
@Entity
@Table(name = "useractivity")
public class AppAction {
    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    private Integer iduseractivity;

    @JsonProperty("ID")
    Integer activityid;
    @JsonProperty("Action")
    private String activitynotes;
    private Date time;

    public Integer getIduseractivity() {
        return iduseractivity;
    }

    public void setIduseractivity(Integer iduseractivity) {
        this.iduseractivity = iduseractivity;
    }

    public Integer getActivityid() {
        return activityid;
    }

    public void setActivityid(Integer activityid) {
        this.activityid = activityid;
    }

    public String getActivitynotes() {
        return activitynotes;
    }

    public void setActivitynotes(String activitynotes) {
        this.activitynotes = activitynotes;
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }
}
