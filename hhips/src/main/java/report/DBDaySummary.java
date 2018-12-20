package report;

import db.HibernateUtils;
import org.hibernate.Session;
import org.hibernate.criterion.Order;
import org.springframework.stereotype.Service;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Service
public class DBDaySummary {
    public List<DaySummary> Get90DaySummary() {
        Session session = HibernateUtils.openCurrentSession();

        session.beginTransaction();
        CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
        CriteriaQuery<DaySummary> criteriaQuery = criteriaBuilder.createQuery(DaySummary.class);
        Root<DaySummary> itemRoot = criteriaQuery.from(DaySummary.class);
        criteriaQuery.orderBy(criteriaBuilder.asc(itemRoot.get("onday")));
        criteriaQuery.select(itemRoot);
        List<DaySummary> all =  session.createQuery(criteriaQuery).getResultList();

        session.getTransaction().commit();

        for (DaySummary ds : all){
            ds.setTotalproblem(ds.getTotalproblem() * 10);
        }
        return all;
    }

    public void updateMonthStar(int star, int egg) {
        Date now = new Date();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMM01");
        String dateString = dateFormat.format( now );
        Date nn = null;
        SimpleDateFormat dateFormat2 = new SimpleDateFormat("yyyyMMdd");
        try {
            nn = dateFormat2.parse(dateString);
        } catch (ParseException e) {
            e.printStackTrace();
        }

        Session session = HibernateUtils.openCurrentSession();

        session.beginTransaction();
        CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
        CriteriaQuery<StarBalance> criteriaQuery = criteriaBuilder.createQuery(StarBalance.class);
        Root<StarBalance> itemRoot = criteriaQuery.from(StarBalance.class);
        criteriaQuery.select(itemRoot).where(criteriaBuilder.equal(itemRoot.get("changedate"), nn));
        List<StarBalance> all =  session.createQuery(criteriaQuery).getResultList();

        StarBalance starBalance = new StarBalance();
        if (all.size() > 0) {
            starBalance = all.get(0);
        }

        starBalance.setChangebalance(star+egg);
        starBalance.setChangedate(nn);
        starBalance.setChangenote(Integer.toString(star) + Integer.toString(egg));
        session.save(starBalance);
        session.getTransaction().commit();
    }
}