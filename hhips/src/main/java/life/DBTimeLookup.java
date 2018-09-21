package life;

import db.HibernateUtils;
import org.hibernate.Session;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import java.util.List;

public class DBTimeLookup {
    public TimeCounterLookup getTimeCounterLookup(int idtimecounterlookup) {
        Session session = HibernateUtils.openCurrentSession();

        session.beginTransaction();
        List<TimeCounterLookup> all;

        try {
            CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
            CriteriaQuery<TimeCounterLookup> criteriaQuery = criteriaBuilder.createQuery(TimeCounterLookup.class);
            Root<TimeCounterLookup> itemRoot = criteriaQuery.from(TimeCounterLookup.class);
            criteriaQuery.select(itemRoot).where(criteriaBuilder.equal(itemRoot.get("idtimecounterlookup"), idtimecounterlookup));
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

        if (all.size() == 0) {
            return null;
        }
        return all.get(0);
    }
    public List<TimeCounterLookup> getAllTimeCounterLookup() {
        Session session = HibernateUtils.openCurrentSession();

        session.beginTransaction();
        List<TimeCounterLookup> all;

        try {
            CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
            CriteriaQuery<TimeCounterLookup> criteriaQuery = criteriaBuilder.createQuery(TimeCounterLookup.class);
            Root<TimeCounterLookup> itemRoot = criteriaQuery.from(TimeCounterLookup.class);
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

        return all;
    }
}
