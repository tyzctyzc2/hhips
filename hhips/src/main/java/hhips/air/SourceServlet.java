package hhips.air;

import db.*;
import dbmodel.ProblemWithLastWork;
import dbmodel.Source;
import dbmodel.SourceChapterSummary;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import report.SourceChapterReport;
import uti.StringHelper;

import java.util.LinkedList;
import java.util.List;

@Controller
public class SourceServlet {
    private static final org.slf4j.Logger logger = LoggerFactory.getLogger(SourceServlet.class);
    @Autowired
    DBProblemManagement dbProblemManagement;

    @Autowired
    DBProblem dbProblem;

    @GetMapping("/Source")
    public String getSourceList(Model model, @RequestParam(value="stage", required=true, defaultValue="1") Integer idStage) {
        System.out.println("SourceServlet - get all source list");
        model.addAttribute("today", StringHelper.GetDateString());

        PageMaker.prepareSourceList(model, idStage);
        return "source";
    }
    @GetMapping("/source/list")
    @ResponseBody
    public List<Source> getSourceListAPI() {
        System.out.println("SourceServlet - get getSourceListAPI");
        return dbProblemManagement.getAllSource();
    }

    @CrossOrigin
    @GetMapping("/source/summary")
    @ResponseBody
    public List<SourceChapterReport> getSourceSummaryAPI(@RequestParam(value="id", required=true, defaultValue="6") Integer sourceId) {
        logger.info("SourceServlet - get getSourceSummaryAPI");
        List<SourceChapterSummary> sourceChapterSummaries = dbProblemManagement.getChapterSummaryList(sourceId);
        List<SourceChapterReport> sourceChapterReports = new LinkedList<>();
        for(int i = 0; i < sourceChapterSummaries.size(); ++i) {
            List<ProblemWithLastWork> problemWithLastWorks =  dbProblem.getProblemWithLastWorkByCharpter(sourceChapterSummaries.get(i).getIdsourcechapter());
            int doneCount = 0;
            int wrongCount = 0;
            int blankCount = 0;
            for(int j = 0; j < problemWithLastWorks.size(); ++j) {
                if (problemWithLastWorks.get(j).getWorkmark() == null) {
                    blankCount++;
                } else if (problemWithLastWorks.get(j).getWorkmark() == 0) {
                    doneCount++;
                } else if (problemWithLastWorks.get(j).getWorkmark() == 1) {
                    wrongCount++;
                }
            }
            SourceChapterReport cur = new SourceChapterReport(sourceChapterSummaries.get(i));
            cur.setProblemDoneCount(doneCount);
            cur.setProblemWrongCount(wrongCount);
            cur.setProblemBlankCount(blankCount);
            sourceChapterReports.add(cur);
        }
        return sourceChapterReports;
    }
}
