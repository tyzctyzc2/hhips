package life;

import org.json.JSONObject;

import javax.persistence.*;

@Entity
@Table(name = "timecounterlookup")
public class TimeCounterLookup {
    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    Integer idtimecounterlookup;

    public Integer getIdtimecounterlookup() {
        return idtimecounterlookup;
    }

    public void setIdtimecounterlookup(Integer idtimecounterlookup) {
        this.idtimecounterlookup = idtimecounterlookup;
    }

    public String getTimecounterdescription() {
        return timecounterdescription;
    }

    public void setTimecounterdescription(String timecounterdescription) {
        this.timecounterdescription = timecounterdescription;
    }

    public String getTimecounterimage() {
        return timecounterimage;
    }

    public void setTimecounterimage(String timecounterimage) {
        this.timecounterimage = timecounterimage;
    }

    public Integer getTimecountertype() {
        return timecountertype;
    }

    public void setTimecountertype(Integer timecountertype) {
        this.timecountertype = timecountertype;
    }

    public Integer getMaxtime() {
        return maxtime;
    }

    public void setMaxtime(Integer maxtime) {
        this.maxtime = maxtime;
    }

    public Integer getBesttime() {
        return besttime;
    }

    public void setBesttime(Integer besttime) {
        this.besttime = besttime;
    }

    public Integer getBestcount() {
        return bestcount;
    }

    public void setBestcount(Integer bestcount) {
        this.bestcount = bestcount;
    }

    String timecounterdescription;
    String timecounterimage;

    Integer timecountertype;
    Integer maxtime;
    Integer besttime;
    Integer bestcount;

    @Override
    public String toString() {
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("idtimecounterlookup", idtimecounterlookup);
        jsonObject.put("timecounterdescription", timecounterdescription);
        jsonObject.put("timecounterimage", timecounterimage);

        jsonObject.put("timecountertype", timecountertype);
        jsonObject.put("maxtime", maxtime);
        jsonObject.put("besttime", besttime);
        jsonObject.put("bestcount", bestcount);
        return jsonObject.toString();
    }
}
