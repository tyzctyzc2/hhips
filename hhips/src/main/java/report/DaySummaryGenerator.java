package report;

import db.HibernateUtils;
import db.ProblemByPaper;
import db.WorkDetail;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.slf4j.LoggerFactory;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

public class DaySummaryGenerator extends Thread {
    private static final org.slf4j.Logger logger = LoggerFactory.getLogger(DaySummaryGenerator.class);

    @Override
    public void run() {
        logger.info("Summary thread start");

        for(int i = 90; i > 0; i--) {
            Calendar cal = Calendar.getInstance();
            cal.add(Calendar.DATE, -i);
            Date dateBefore90Days = cal.getTime();

            DayReportProcessor dp = new DayReportProcessor();
            List<WorkDetail> wd = dp.getDayAllWork(dateBefore90Days);

            if (wd.size() == 0)
                continue;

            ArrayList<WorkDetail> processed = dp.processWorkDetail(wd);

            dp.processWorkDetail4Paper(null, wd);

            if (dp.getMyTotalProblem() == 0)
                continue;

            InsertDaySummary(dp);
        }
    }

    private void InsertDaySummary(DayReportProcessor dp) {
        DaySummary daySummary = new DaySummary();

        daySummary.setOnday(dp.forDay);
        daySummary.score = dp.myScore;
        daySummary.totalminutes = dp.myTotalUserTime;
        daySummary.totalproblem = dp.myTotalProblem;

        System.out.println("-----------insert summary on" + daySummary);

        Session session = HibernateUtils.openCurrentSession();
        Transaction tx = null;

        try {
            tx = session.beginTransaction();

            CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
            CriteriaQuery<DaySummary> criteriaQuery = criteriaBuilder.createQuery(DaySummary.class);
            Root<DaySummary> itemRoot = criteriaQuery.from(DaySummary.class);
            criteriaQuery.select(itemRoot).where(criteriaBuilder.equal(itemRoot.get("onday"), daySummary.onday));
            List<DaySummary> all = session.createQuery(criteriaQuery).getResultList();

            if (all.size() > 0) {
                daySummary.iddaysummary = all.get(0).iddaysummary;
                session.update(daySummary);
            }
            else {
                session.save(daySummary);
            }

            tx.commit();
        } catch (HibernateException e) {
            if (tx != null)
                tx.rollback();
            e.printStackTrace();
        } finally {
            session.close();
        }
    }
}