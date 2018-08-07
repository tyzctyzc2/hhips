package report;

import db.HibernateUtils;
import org.hibernate.Session;
import org.hibernate.criterion.Order;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import java.util.List;

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
}