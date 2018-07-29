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

        CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
        CriteriaQuery<Reason> criteriaQuery = criteriaBuilder.createQuery(Reason.class);
        Root<Reason> itemRoot = criteriaQuery.from(Reason.class);
        criteriaQuery.select(itemRoot);
        List<Reason> all = session.createQuery(criteriaQuery).getResultList();

        session.getTransaction().commit();

        allReasonList = all;
        return allReasonList;
    }

    public List<StarReason> getAllStarReason() {
        if (allStarReasonList !=null)
            return allStarReasonList;

        Session session = HibernateUtils.openCurrentSession();

        session.beginTransaction();

        CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
        CriteriaQuery<StarReason> criteriaQuery = criteriaBuilder.createQuery(StarReason.class);
        Root<StarReason> itemRoot = criteriaQuery.from(StarReason.class);
        criteriaQuery.select(itemRoot);
        List<StarReason> all = session.createQuery(criteriaQuery).getResultList();

        session.getTransaction().commit();

        allStarReasonList = all;
        return allStarReasonList;
    }
}
