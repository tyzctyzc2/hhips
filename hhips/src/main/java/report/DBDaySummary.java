package report;

import db.HibernateUtils;
import org.hibernate.Session;

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
        criteriaQuery.select(itemRoot);//.where(criteriaBuilder.equal(itemRoot.get("idproblem"), problemID));
        List<DaySummary> all =  session.createQuery(criteriaQuery).getResultList();

        session.getTransaction().commit();
        return all;
    }
}