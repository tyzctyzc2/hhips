package db;

import org.hibernate.Session;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import java.util.List;

public class DBReason {
    static List<Reason> allReasonList = null;
    static List<StarReason> allStarReasonList = null;

    public List<Reason> getAllReason() {
        if (allReasonList !=null)
            return allReasonList;

        Session session = HibernateUtils.openCurrentSession();

        session.beginTransaction();
        List<Reason> all;
        try {
            CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
            CriteriaQuery<Reason> criteriaQuery = criteriaBuilder.createQuery(Reason.class);
            Root<Reason> itemRoot = criteriaQuery.from(Reason.class);
            criteriaQuery.select(itemRoot);
            all = session.createQuery(criteriaQuery).getResultList();

            session.getTransaction().commit();
        }
        catch ( RuntimeException e ) {
            session.getTransaction().rollback();
            throw e;
        }
        finally {
            session.close();
        }

        allReasonList = all;
        return allReasonList;
    }

    public List<StarReason> getAllStarReason() {
        if (allStarReasonList !=null)
            return allStarReasonList;

        Session session = HibernateUtils.openCurrentSession();

        session.beginTransaction();
        List<StarReason> all;
        try {
            CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
            CriteriaQuery<StarReason> criteriaQuery = criteriaBuilder.createQuery(StarReason.class);
            Root<StarReason> itemRoot = criteriaQuery.from(StarReason.class);
            criteriaQuery.select(itemRoot);
            all = session.createQuery(criteriaQuery).getResultList();

            session.getTransaction().commit();
        }
        catch ( RuntimeException e ) {
            session.getTransaction().rollback();
            throw e;
        }
        finally {
            session.close();
        }

        allStarReasonList = all;
        return allStarReasonList;
    }
}
