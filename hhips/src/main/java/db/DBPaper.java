package db;

import org.hibernate.Session;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Expression;
import javax.persistence.criteria.Root;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

public class DBPaper {
    public List<ProblemByPaper>  getProblemActivePaper(Integer problemId) {
        Session session = HibernateUtils.openCurrentSession();

        session.beginTransaction();

        List<ProblemByPaper> all;
        try {
            CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
            CriteriaQuery<ProblemByPaper> criteriaQuery = criteriaBuilder.createQuery(ProblemByPaper.class);
            Root<ProblemByPaper> itemRoot = criteriaQuery.from(ProblemByPaper.class);
            criteriaQuery.select(itemRoot).where(criteriaBuilder.equal(itemRoot.get("idproblem"), problemId),
                    criteriaBuilder.equal(itemRoot.get("problemstatus"), 1),
                    criteriaBuilder.notEqual(itemRoot.get("isactive"), 5));
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

    public List<Paper> getAllEditPapers() {
        Session session = HibernateUtils.openCurrentSession();

        session.beginTransaction();
        List<Paper> all;

        try {
            CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
            CriteriaQuery<Paper> criteriaQuery = criteriaBuilder.createQuery(Paper.class);
            Root<Paper> itemRoot = criteriaQuery.from(Paper.class);
            criteriaQuery.select(itemRoot).where(criteriaBuilder.equal(itemRoot.get("isactive"), 1));
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

    public List<Paper> getAllPapers() {
        Session session = HibernateUtils.openCurrentSession();

        session.beginTransaction();
        List<Paper> all;

        try {
            CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
            CriteriaQuery<Paper> criteriaQuery = criteriaBuilder.createQuery(Paper.class);
            Root<Paper> itemRoot = criteriaQuery.from(Paper.class);
            criteriaQuery.select(itemRoot).where(criteriaBuilder.notEqual(itemRoot.get("isactive"), 5));
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

    public List<Paper> getAllActivePapers() {
        Session session = HibernateUtils.openCurrentSession();

        session.beginTransaction();
        List<Paper> all;

        try {
            CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
            CriteriaQuery<Paper> criteriaQuery = criteriaBuilder.createQuery(Paper.class);
            Root<Paper> itemRoot = criteriaQuery.from(Paper.class);
            criteriaQuery.select(itemRoot).where(criteriaBuilder.equal(itemRoot.get("isactive"), 2));
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
