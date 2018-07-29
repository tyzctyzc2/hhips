package report;

import javax.persistence.*;
import java.util.Calendar;
import java.util.Date;

@Entity
@Table(name = "daysummary")
public class DaySummary {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Integer iddaysummary;

    public Date getOnday() {
        return onday;
    }

    public void setOnday(Date onday) {
        this.onday = onday;
        Calendar tt = Calendar.getInstance();
        tt.setTime(this.onday);
        tt.set(Calendar.HOUR_OF_DAY, 0);
        tt.set(Calendar.MINUTE, 0);
        tt.set(Calendar.SECOND, 0);
        tt.set(Calendar.MILLISECOND, 0);
        this.onday = tt.getTime();
    }

    Date onday;
    Integer totalminutes;
    Integer totalproblem;
    Integer score;

    public Integer getIddaysummary() {
        return iddaysummary;
    }

    public void setIddaysummary(Integer iddaysummary) {
        this.iddaysummary = iddaysummary;
    }


    public Integer getTotalminutes() {
        return totalminutes;
    }

    public void setTotalminutes(Integer totalminutes) {
        this.totalminutes = totalminutes;
    }

    public Integer getTotalproblem() {
        return totalproblem;
    }

    public void setTotalproblem(Integer totalproblem) {
        this.totalproblem = totalproblem;
    }

    public Integer getScore() { return score;   }

    public void setScore(Integer score) {
        this.score = score;
    }

    @Override
    public String toString() {
        return onday.toString();
    }
}