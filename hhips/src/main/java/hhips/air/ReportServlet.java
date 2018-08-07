package hhips.air;

import db.DBWork;
import report.*;
import db.WorkDetail;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import uti.StringHelper;

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
        model.addAttribute("today", StringHelper.GetDateString());

        DBDaySummary dbDaySummary = new DBDaySummary();
        List<DaySummary> allS = dbDaySummary.Get90DaySummary();
        GenerateChartData(model, allS);

        dp.processWorkDetail4Paper(model, wd);

        DaySummaryGenerator.InsertDaySummary(dp);
        return "reportday";
    }

    private void GenerateChartData(Model model, List<DaySummary> allS) {
        StringBuilder scoreChartData = new StringBuilder();
        StringBuilder usedTimeChartData = new StringBuilder();
        StringBuilder problemChartData = new StringBuilder();
        for(int i = 0; i < allS.size(); ++i) {
            DaySummary curS = allS.get(i);
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(curS.getOnday());

            //[Date.UTC(1970, 10, 25), 0],
            scoreChartData.append("[Date.UTC(");
            scoreChartData.append(calendar.get(Calendar.YEAR));
            scoreChartData.append(",");
            scoreChartData.append(calendar.get(Calendar.MONTH));
            scoreChartData.append(",");
            scoreChartData.append(calendar.get(Calendar.DAY_OF_MONTH));
            scoreChartData.append("),");
            scoreChartData.append(curS.getScore());
            scoreChartData.append("],");

            usedTimeChartData.append("[Date.UTC(");
            usedTimeChartData.append(calendar.get(Calendar.YEAR));
            usedTimeChartData.append(",");
            usedTimeChartData.append(calendar.get(Calendar.MONTH));
            usedTimeChartData.append(",");
            usedTimeChartData.append(calendar.get(Calendar.DAY_OF_MONTH));
            usedTimeChartData.append("),");
            usedTimeChartData.append(curS.getTotalminutes());
            usedTimeChartData.append("],");

            problemChartData.append("[Date.UTC(");
            problemChartData.append(calendar.get(Calendar.YEAR));
            problemChartData.append(",");
            problemChartData.append(calendar.get(Calendar.MONTH));
            problemChartData.append(",");
            problemChartData.append(calendar.get(Calendar.DAY_OF_MONTH));
            problemChartData.append("),");
            problemChartData.append(curS.getTotalproblem());
            problemChartData.append("],");
        }

        model.addAttribute("scoreHis", scoreChartData.toString());
        model.addAttribute("usedTimeHis", usedTimeChartData.toString());
        model.addAttribute("problemHis", problemChartData.toString());
    }

}