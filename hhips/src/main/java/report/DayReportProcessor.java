package report;

import db.HibernateUtils;
import db.WorkDetail;
import org.hibernate.Session;
import org.springframework.ui.Model;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

public class DayReportProcessor {
    public class PaperSummary {
        private Integer idpaper;
        private String paperName;
        private Integer totalWorkedProblem;
        private Integer oneTimeCorrectProblem;
        private Integer waitToFixProblem;
        private Integer totalWorkTime;

        public Integer getIdpaper() {
            return idpaper;
        }

        public void setIdpaper(Integer idpaper) {
            this.idpaper = idpaper;
        }

        public String getPaperName() {
            return paperName;
        }

        public void setPaperName(String paperName) {
            this.paperName = paperName;
        }

        public Integer getTotalWorkedProblem() {
            return totalWorkedProblem;
        }

        public void setTotalWorkedProblem(Integer totalWorkedProblem) {
            this.totalWorkedProblem = totalWorkedProblem;
        }

        public Integer getOneTimeCorrectProblem() {
            return oneTimeCorrectProblem;
        }

        public void setOneTimeCorrectProblem(Integer oneTimeCorrectProblem) {
            this.oneTimeCorrectProblem = oneTimeCorrectProblem;
        }

        public Integer getWaitToFixProblem() {
            return waitToFixProblem;
        }

        public void setWaitToFixProblem(Integer waitToFixProblem) {
            this.waitToFixProblem = waitToFixProblem;
        }

        public Integer getTotalWorkTime() {
            return totalWorkTime;
        }

        public void setTotalWorkTime(Integer totalWorkTime) {
            this.totalWorkTime = totalWorkTime;
        }
    }

    int myTotalUserTime = 0;
    Date forDay;
    int myTotalProblem = 0;
    int myScore = 0;

    public int getMyTotalUserTime() {
        return myTotalUserTime;
    }

    public void setMyTotalUserTime(int myTotalUserTime) {
        this.myTotalUserTime = myTotalUserTime;
    }

    public Date getForDay() {
        return forDay;
    }

    public void setForDay(Date forDay) {
        this.forDay = forDay;
    }

    public int getMyTotalProblem() {
        return myTotalProblem;
    }

    public void setMyTotalProblem(int myTotalProblem) {
        this.myTotalProblem = myTotalProblem;
    }

    public int getMyScore() {
        return myScore;
    }

    public void setMyScore(int myScore) {
        this.myScore = myScore;
    }

    public List<WorkDetail> getDayAllWork(String wantDay) {
        Date wantDD = new Date();
        if (wantDay.length() > 0) {
            try {
                wantDD = new SimpleDateFormat("yyyyMMdd").parse(wantDay);
                return getDayAllWork(wantDD);
            } catch (ParseException e) {
                e.printStackTrace();
            }
        }
        return new ArrayList<>();
    }

    public List<WorkDetail> getDayAllWork(Date wantDay) {
        Date ss = new Date(wantDay.getTime());
        Date ee = new Date(wantDay.getTime());
        ss.setHours(0);
        ee.setHours(23);
        forDay = ss;
        Session session = HibernateUtils.openCurrentSession();

        session.beginTransaction();
        CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
        CriteriaQuery<WorkDetail> criteriaQuery = criteriaBuilder.createQuery(WorkDetail.class);
        Root<WorkDetail> itemRoot = criteriaQuery.from(WorkDetail.class);
        criteriaQuery.select(itemRoot).where(criteriaBuilder.greaterThan(itemRoot.get("workdate"), ss), criteriaBuilder.lessThan(itemRoot.get("workdate"), ee));
        List<WorkDetail> all =  session.createQuery(criteriaQuery).getResultList();
        session.getTransaction().commit();

        return all;
    }

    public void processWorkDetail4Paper(Model model, List<WorkDetail> workDetails) {
        HashMap<String, Map<String, List<WorkDetail>>> allWorks = new HashMap<>();

        int totalCorrectUsedTime = 0;
        int totalCorrectTime = 0;
        int avgCorrect = 0;
        int totalWrongUsedTime = 0;
        int totalWrongTime =0;
        int avgWrong = 0;
        int totalUnknownUsedTime = 0;
        int totalUnknownTime =0;
        int avgUnknown = 0;

        for (int i = 0; i < workDetails.size(); ++i) {
            WorkDetail curW = workDetails.get(i);
            String paperID = Integer.toString(curW.getIdpaper());

            if (curW.getWorkmark() == null) {
                totalUnknownUsedTime = totalUnknownUsedTime + curW.getUsedtime();
                totalUnknownTime++;
            }
            else {
                if (curW.getWorkmark() == 0) {
                    totalCorrectUsedTime = totalCorrectUsedTime + curW.getUsedtime();
                    totalCorrectTime++;
                }
                else {
                    totalWrongUsedTime = totalWrongUsedTime + curW.getUsedtime();
                    totalWrongTime++;
                }
            }

            Map<String, List<WorkDetail>> paperW = new HashMap<>();
            if (allWorks.containsKey(paperID))
                paperW = allWorks.get(paperID);
            else
                allWorks.put(paperID, paperW);

            String problemID = Integer.toString(curW.getIdproblem());
            List<WorkDetail> problemW = new ArrayList<>();
            if (paperW.containsKey(problemID))
                problemW = paperW.get(problemID);
            else
                paperW.put(problemID, problemW);

            problemW.add(curW);
        }

        if(totalCorrectTime > 0)
            avgCorrect = (int)(totalCorrectUsedTime/totalCorrectTime);

        if (totalWrongTime > 0)
            avgWrong = (int) (totalWrongUsedTime/totalWrongTime);

        if (totalUnknownTime > 0)
            avgUnknown = (int) (totalUnknownUsedTime/totalUnknownTime);

        int totalUsedTime = totalCorrectUsedTime + totalWrongUsedTime +totalUnknownUsedTime;
        int totalTimes = totalCorrectTime + totalWrongTime +totalUnknownTime;
        int avgTotal = 0;
        if (totalTimes > 0)
            avgTotal = totalUsedTime / totalTimes;

        myTotalUserTime = totalUsedTime;

        if (model != null) {
            model.addAttribute("workbypaper", allWorks);
            model.addAttribute("totalCorrectUsedTime", totalCorrectUsedTime);
            model.addAttribute("totalCorrectTime", totalCorrectTime);
            model.addAttribute("avgCorrect", avgCorrect);
            model.addAttribute("totalWrongUsedTime", totalWrongUsedTime);
            model.addAttribute("totalWrongTime", totalWrongTime);
            model.addAttribute("avgWrong", avgWrong);
            model.addAttribute("totalUnknownUsedTime", totalUnknownUsedTime);
            model.addAttribute("totalUnknownTime", totalUnknownTime);
            model.addAttribute("avgUnknown", avgUnknown);
            model.addAttribute("totalUsedTime", totalUsedTime);
            model.addAttribute("totalTimes", totalTimes);
            model.addAttribute("avgTotal", avgTotal);
        }

        generatePaperSummary(model, allWorks);
    }

    private void generatePaperSummary(Model model, HashMap<String, Map<String, List<WorkDetail>>> allWorks) {
        int paperIndex = 0;
        int score = 0;
        List<PaperSummary> paperSummaryList = new ArrayList<>();

        for (Map.Entry<String, Map<String, List<WorkDetail>>> paper : allWorks.entrySet()) {
            Map<String, List<WorkDetail>> curPaper = paper.getValue();

            int problemCountInPaper = curPaper.size();
            int solvedProblem = 0;
            int unsolvedProblem = 0;
            int unknownProblem = 0;
            int oneTimePassProblem = 0;
            int paperUsedTime = 0;
            PaperSummary ps = new PaperSummary();

            ArrayList<Integer> paperProblemTime = new ArrayList<>();//sort to get 90 avg.
            for (Map.Entry<String, List<WorkDetail>> problem : curPaper.entrySet()) {
                List<WorkDetail> workList = problem.getValue();
                boolean curSolved = false;
                boolean notMarked = false;
                boolean oneTimePassed = true;
                int curProblemTime = 0;
                int curLevel = 0;

                for(int k=0; k < workList.size(); ++k) {
                    WorkDetail curWd = workList.get(k);

                    ps.setIdpaper(curWd.getIdpaper());
                    ps.setPaperName(curWd.getPapername());
                    curLevel = curWd.getProblemlevel();

                    if (curWd.getWorkmark() == null) {
                        unknownProblem++;
                        notMarked = true;
                    }
                    else {
                        if (curWd.getWorkmark() == 0)
                            curSolved = true;
                        else
                            oneTimePassed = false;
                    }

                    curProblemTime = curProblemTime + curWd.getUsedtime();
                }

                if (curSolved)
                    solvedProblem++;
                else
                    unsolvedProblem++;

                if (oneTimePassed)
                    oneTimePassProblem++;

                if (notMarked == false) {
                    ScoreCalculator sc = ProblemScoreCalculator.GetCalculator(curLevel);
                    score = score + sc.GetBaseScore(curSolved);
                    score = score + sc.GetWrongTimeScore(workList.size() - 1);
                    score = score + sc.GetUsedTimeScore(curProblemTime);
                }

                paperProblemTime.add(curProblemTime);
                paperUsedTime = paperUsedTime + curProblemTime;
            }

            myTotalProblem = myTotalProblem + solvedProblem + unsolvedProblem + unknownProblem;

            ps.setTotalWorkedProblem(problemCountInPaper);
            ps.setOneTimeCorrectProblem(oneTimePassProblem);
            ps.setWaitToFixProblem(unsolvedProblem);
            ps.setTotalWorkTime(paperUsedTime);
            paperSummaryList.add(ps);
        }
        myScore = score;

        if (model != null) {
            model.addAttribute("todayScore", score);
            model.addAttribute("papersummary", paperSummaryList);
        }
    }

    public ArrayList<WorkDetail> processWorkDetail(List<WorkDetail> wd) {
        ArrayList<WorkDetail> processed = new ArrayList<>();

        if (wd.size() == 0)
            return processed;

        WorkDetail curWork = new WorkDetail();
        curWork.setStartdate(wd.get(0).getStartdate());
        curWork.setUsedtime(wd.get(0).getUsedtime());
        curWork.setWorkmark(1);
        for (int i = 0; i < wd.size() - 1; ++i) {
            WorkDetail thisW = wd.get(i);
            WorkDetail nextW = wd.get(i + 1);

            long seconds = (nextW.getStartdate().getTime() - thisW.getWorkdate().getTime()) / 1000;

            curWork.setWorkdate(nextW.getWorkdate());
            if (seconds < 120)
                continue;

            curWork.setWorkdate(thisW.getWorkdate());
            long pass = (curWork.getWorkdate().getTime() - curWork.getStartdate().getTime()) / 1000 / 60;
            curWork.setUsedtime((int) (long) pass);
            processed.add(curWork);

            curWork = new WorkDetail();
            curWork.setStartdate(thisW.getWorkdate());
            curWork.setWorkdate(nextW.getStartdate());
            pass = (curWork.getWorkdate().getTime() - curWork.getStartdate().getTime()) / 1000 / 60;
            curWork.setUsedtime((int) (long) pass);
            curWork.setWorkmark(0);
            processed.add(curWork);

            curWork = new WorkDetail();
            curWork.setStartdate(nextW.getStartdate());
            curWork.setWorkdate(nextW.getWorkdate());
            curWork.setWorkmark(1);

        }
        if (wd.size() > 1) {
            long pass = (curWork.getWorkdate().getTime() - curWork.getStartdate().getTime()) / 1000 / 60;
            curWork.setUsedtime((int) (long) pass);
        }
        else {
            curWork.setUsedtime(curWork.getUsedtime());
        }
        processed.add(curWork);

        return processed;
    }
}