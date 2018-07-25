package hhips.air;

import db.DBWork;
import report.DayReportProcessor;
import report.ProblemScoreCalculator;
import db.WorkDetail;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import report.ScoreCalculator;

import java.util.*;

@Controller
public class ReportServlet {
    @GetMapping("/Report")
    public String processProblemGet(Model model, @RequestParam(value = "wantday", required = false, defaultValue = "") String wantDay) {
        System.out.println("ReportServlet - report request --" + wantDay);

        DayReportProcessor dp = new DayReportProcessor();
        List<WorkDetail> wd = dp.getDayAllWork(wantDay);
        ArrayList<WorkDetail> processed = dp.processWorkDetail(wd);

        model.addAttribute("wantday", wantDay);
        model.addAttribute("allworks", wd);
        model.addAttribute("segworks", processed);
        model.addAttribute("maxseg", processed.size() - 1);

        dp.processWorkDetail4Paper(model, wd);
        return "reportday";
    }


}