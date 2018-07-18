package hhips.air;

import db.DBWork;
import db.Work;
import db.WorkDetail;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.persistence.criteria.CriteriaBuilder;
import java.util.ArrayList;
import java.util.List;
@Controller
public class ReportServlet {
    @GetMapping("/Report/day")
    public String processProblemGet(Model model, @RequestParam(value="wantday", required=false, defaultValue="") String wantDay) {
        System.out.println("ReportServlet - report request --" + wantDay);

        DBWork dw = new DBWork();
        List<WorkDetail> wd = dw.getDayAllWork(wantDay);

        ArrayList<WorkDetail> processed = processWorkDetail(wd);

        model.addAttribute("allworks", wd);
        model.addAttribute("segworks", processed);
        model.addAttribute("maxseg", processed.size()-1);
        return "reportday";
    }

    private ArrayList<WorkDetail> processWorkDetail(List<WorkDetail> wd) {
        ArrayList<WorkDetail> processed = new ArrayList<>();

        if (wd.size() == 0)
            return processed;

        WorkDetail curWork = new WorkDetail();
        curWork.setStartdate(wd.get(0).getStartdate());
        curWork.setWorkmark(1);
        for(int i =0;i<wd.size()-1;++i) {
            WorkDetail thisW = wd.get(i);
            WorkDetail nextW = wd.get(i+1);

            long seconds = (nextW.getStartdate().getTime() - thisW.getWorkdate().getTime())/1000;

            curWork.setWorkdate(nextW.getWorkdate());
            if (seconds < 120)
                continue;

            curWork.setWorkdate(thisW.getWorkdate());
            long pass = (curWork.getWorkdate().getTime()-curWork.getStartdate().getTime())/1000/60;
            curWork.setUsedtime( (int) (long) pass);
            processed.add(curWork);

            curWork = new WorkDetail();
            curWork.setStartdate(thisW.getWorkdate());
            curWork.setWorkdate(nextW.getStartdate());
            pass = (curWork.getWorkdate().getTime()-curWork.getStartdate().getTime())/1000/60;
            curWork.setUsedtime( (int) (long) pass);
            curWork.setWorkmark(0);
            processed.add(curWork);

            curWork = new WorkDetail();
            curWork.setStartdate(nextW.getStartdate());
            curWork.setWorkdate(nextW.getWorkdate());
            curWork.setWorkmark(1);

        }
        return processed;
    }
}
