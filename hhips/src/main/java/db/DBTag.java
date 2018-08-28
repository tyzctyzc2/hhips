package db;

import org.hibernate.Session;
import org.hibernate.Transaction;

import javax.persistence.criteria.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DBTag {
    static List<Tag> allTagList = null;

    public List<TagByProblem> getProblemTag(int idProblem) {
        Session session = HibernateUtils.openCurrentSession();

        session.beginTransaction();
        List<TagByProblem> all;
        try {
            CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
            CriteriaQuery<TagByProblem> criteriaQuery = criteriaBuilder.createQuery(TagByProblem.class);
            Root<TagByProblem> itemRoot = criteriaQuery.from(TagByProblem.class);
            criteriaQuery.select(itemRoot).where(criteriaBuilder.equal(itemRoot.get("idproblem"), idProblem));
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

    public boolean updateProblemTag(Integer problemID, Integer tagID) {
        Session session = HibernateUtils.openCurrentSession();

        session.beginTransaction();
        try {
            List<TagProblemTable> all;
            CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
            CriteriaQuery<TagProblemTable> criteriaQuery = criteriaBuilder.createQuery(TagProblemTable.class);
            Root<TagProblemTable> itemRoot = criteriaQuery.from(TagProblemTable.class);
            criteriaQuery.select(itemRoot).where(criteriaBuilder.equal(itemRoot.get("idproblem"), problemID),
                    criteriaBuilder.equal(itemRoot.get("idtag"), tagID));
            all = session.createQuery(criteriaQuery).getResultList();

            if (all.size() > 0) {
                session.delete(all.get(0));
                return true;
            }

            TagProblemTable problemTag = new TagProblemTable();
            problemTag.idproblem = problemID;
            problemTag.idtag = tagID;
            session.save(problemTag);
        }
        catch ( RuntimeException e ) {
            session.getTransaction().rollback();
            throw e;
        }
        finally {
            session.getTransaction().commit();
            session.close();
        }
        return true;
    }

    public boolean saveNewTag(String tagName) {
        Session session = HibernateUtils.openCurrentSession();

        boolean suc = false;
        session.beginTransaction();
        try {
            Tag t = new Tag();
            t.setTagname(tagName);
            session.save(t);
            suc = true;
        }
        catch ( RuntimeException e ) {
            suc = false;
            session.getTransaction().rollback();
            throw e;
        }
        finally {
            session.getTransaction().commit();
            session.close();
        }
        allTagList = null;
        return suc;
    }

    public Tag getTag(int tagID) {
        Session session = HibernateUtils.openCurrentSession();

        session.beginTransaction();
        List<Tag> all;
        try {
            CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
            CriteriaQuery<Tag> criteriaQuery = criteriaBuilder.createQuery(Tag.class);
            Root<Tag> itemRoot = criteriaQuery.from(Tag.class);
            criteriaQuery.select(itemRoot).where(criteriaBuilder.equal(itemRoot.get("idtag"), tagID));
            all = session.createQuery(criteriaQuery).getResultList();
        }
        catch ( RuntimeException e ) {
            session.getTransaction().rollback();
            throw e;
        }
        finally {
            session.getTransaction().commit();
            session.close();
        }
        if (all.size() > 0)
            return all.get(0);
        return null;
    }

    public List<Tag> getBaseTagMap() {
        if (allTagList != null)
            return allTagList;

        Session session = HibernateUtils.openCurrentSession();

        session.beginTransaction();
        List<Tag> all;
        try {
            CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
            CriteriaQuery<Tag> criteriaQuery = criteriaBuilder.createQuery(Tag.class);
            Root<Tag> itemRoot = criteriaQuery.from(Tag.class);
            criteriaQuery.select(itemRoot);
            all = session.createQuery(criteriaQuery).getResultList();

            session.getTransaction().commit();

            allTagList = all;
        }
        catch ( RuntimeException e ) {
            session.getTransaction().rollback();
            throw e;
        }
        finally {
            session.close();
        }
        return  allTagList;
    }

    public List<ProblemWithLastWork> getProblemByTag(int tagID) {
        Session session = HibernateUtils.openCurrentSession();
        List<ProblemWithLastWork> allProblem = new ArrayList<>();
        Transaction tx = session.beginTransaction();
        try {
            List<TagByProblem> all;
            CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
            CriteriaQuery<TagByProblem> criteriaQuery = criteriaBuilder.createQuery(TagByProblem.class);
            Root<TagByProblem> itemRoot = criteriaQuery.from(TagByProblem.class);
            criteriaQuery.select(itemRoot).where(criteriaBuilder.equal(itemRoot.get("idtag"), tagID));
            all = session.createQuery(criteriaQuery).getResultList();

            if (all.size() == 0) {
                return allProblem;
            }

            //tx.commit();
            //session.close();
            //session = HibernateUtils.openCurrentSession();
            //tx = session.beginTransaction();

            List<Integer> allProblemIDs = new ArrayList<Integer> ();
            for (TagByProblem u : all) {
                allProblemIDs.add(u.idproblem);
            }

            //CriteriaBuilder criteriaBuilder2 = session.getCriteriaBuilder();
            CriteriaQuery<ProblemWithLastWork> criteriaQuery2 = criteriaBuilder.createQuery(ProblemWithLastWork.class);
            Root<ProblemWithLastWork> itemRoot2 = criteriaQuery2.from(ProblemWithLastWork.class);

            Expression<String> exp = itemRoot2.get("idproblem");
            Predicate predicate = exp.in(allProblemIDs);

            criteriaQuery2.select(itemRoot2).where(predicate);
            allProblem = session.createQuery(criteriaQuery2).getResultList();
        }
        catch ( RuntimeException e ) {
            session.getTransaction().rollback();
            throw e;
        }
        finally {
            tx.commit();
            session.close();
        }
        return allProblem;
    }
}