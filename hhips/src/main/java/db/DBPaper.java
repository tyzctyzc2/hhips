package db;

import dbmodel.Paper;
import dbmodel.PaperSummary;
import dbmodel.Paperproblem;
import dbmodel.ProblemByPaper;
import org.hibernate.Session;
import org.springframework.stereotype.Service;
import uti.FileHelper;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import java.util.List;

@Service
public class DBPaper {
    public DBPaper() {
    }

    public Integer getAfterPaperId(Integer paperId) {
        Session session = HibernateUtils.openCurrentSession();

        session.beginTransaction();
        List<Paper> all;

        try {
            CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
            CriteriaQuery<Paper> criteriaQuery = criteriaBuilder.createQuery(Paper.class);
            Root<Paper> itemRoot = criteriaQuery.from(Paper.class);
            criteriaQuery.select(itemRoot).where(criteriaBuilder.greaterThan(itemRoot.get("idpaper"), paperId),
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

        if (all.size() > 0)
            return all.get(0).getIdpaper();

        return 0;
    }

    public Integer getBeforePaperId(Integer paperId) {
        Session session = HibernateUtils.openCurrentSession();

        session.beginTransaction();
        List<Paper> all;

        try {
            CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
            CriteriaQuery<Paper> criteriaQuery = criteriaBuilder.createQuery(Paper.class);
            Root<Paper> itemRoot = criteriaQuery.from(Paper.class);
            criteriaQuery.select(itemRoot).where(criteriaBuilder.lessThan(itemRoot.get("idpaper"), paperId),
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

        if (all.size() > 0)
            return all.get(all.size()-1).getIdpaper();

        return 0;
    }

    public Paper getPaperDetail(Integer paperId) {
        Session session = HibernateUtils.openCurrentSession();

        session.beginTransaction();
        List<Paper> all;

        try {
            CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
            CriteriaQuery<Paper> criteriaQuery = criteriaBuilder.createQuery(Paper.class);
            Root<Paper> itemRoot = criteriaQuery.from(Paper.class);
            criteriaQuery.select(itemRoot).where(criteriaBuilder.equal(itemRoot.get("idpaper"), paperId));
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

        if (all.size() > 0)
            return all.get(0);

        return null;
    }

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

    public  void removePaperProblem(int idproblem, int paperproblemid, int paperid) {
        Session session = HibernateUtils.openCurrentSession();

        session.beginTransaction();
        List<Paperproblem> all;

        try {
            CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
            CriteriaQuery<Paperproblem> criteriaQuery = criteriaBuilder.createQuery(Paperproblem.class);
            Root<Paperproblem> itemRoot = criteriaQuery.from(Paperproblem.class);
            criteriaQuery.select(itemRoot).where(criteriaBuilder.equal(itemRoot.get("paperid"), paperid),
                    criteriaBuilder.equal(itemRoot.get("problemid"), idproblem),
                    criteriaBuilder.equal(itemRoot.get("paperproblemid"), paperproblemid));
            all = session.createQuery(criteriaQuery).getResultList();

            Paperproblem pp = all.get(0);
            session.delete(pp);

            session.getTransaction().commit();
        }
        catch ( RuntimeException e ) {
            session.getTransaction().rollback();
            throw e;
        }
        finally {
            session.close();
        }

    }

    public void togglePaperProblemActive(int idproblem, int paperproblemid, int paperid) {
        Session session = HibernateUtils.openCurrentSession();

        session.beginTransaction();
        List<Paperproblem> all;

        try {
            CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
            CriteriaQuery<Paperproblem> criteriaQuery = criteriaBuilder.createQuery(Paperproblem.class);
            Root<Paperproblem> itemRoot = criteriaQuery.from(Paperproblem.class);
            criteriaQuery.select(itemRoot).where(criteriaBuilder.equal(itemRoot.get("paperid"), paperid),
                    criteriaBuilder.equal(itemRoot.get("problemid"), idproblem),
                    criteriaBuilder.equal(itemRoot.get("paperproblemid"), paperproblemid));
            all = session.createQuery(criteriaQuery).getResultList();

            Paperproblem pp = all.get(0);
            if (pp.getProblemstatus() == 1)
                pp.setProblemstatus(0);
            else
                pp.setProblemstatus(1);

            session.save(pp);

            session.getTransaction().commit();
        }
        catch ( RuntimeException e ) {
            session.getTransaction().rollback();
            throw e;
        }
        finally {
            session.close();
        }

    }

    public List<Paper> getAllArchivedPapers() {
        Session session = HibernateUtils.openCurrentSession();

        session.beginTransaction();
        List<Paper> all;

        try {
            CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
            CriteriaQuery<Paper> criteriaQuery = criteriaBuilder.createQuery(Paper.class);
            Root<Paper> itemRoot = criteriaQuery.from(Paper.class);
            criteriaQuery.select(itemRoot).where(criteriaBuilder.equal(itemRoot.get("isactive"), 5)).orderBy(criteriaBuilder.desc(itemRoot.get("idpaper")));
            all = session.createQuery(criteriaQuery).setMaxResults(200).getResultList();

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

    public List<PaperSummary> getAllActivePaperSummary() {
        Session session = HibernateUtils.openCurrentSession();

        session.beginTransaction();
        List<PaperSummary> all;

        try {
            CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
            CriteriaQuery<PaperSummary> criteriaQuery = criteriaBuilder.createQuery(PaperSummary.class);
            Root<PaperSummary> itemRoot = criteriaQuery.from(PaperSummary.class);
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

    public List<ProblemByPaper> getAllActiveProblemInPaper(Integer paperId) {
        Session session = HibernateUtils.openCurrentSession();

        session.beginTransaction();
        List<ProblemByPaper> all;

        try {
            CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
            CriteriaQuery<ProblemByPaper> criteriaQuery = criteriaBuilder.createQuery(ProblemByPaper.class);
            Root<ProblemByPaper> itemRoot = criteriaQuery.from(ProblemByPaper.class);
            criteriaQuery.select(itemRoot).where(criteriaBuilder.equal(itemRoot.get("problemstatus"), 1),
                    criteriaBuilder.equal(itemRoot.get("idpaper"), paperId));
            all = session.createQuery(criteriaQuery).getResultList();

            session.getTransaction().commit();
        } catch (RuntimeException e) {
            session.getTransaction().rollback();
            throw e;
        } finally {
            session.close();
        }

        if (all.size() == 0)
            return all;

        for(int i = 0; i < all.size(); ++i) {
            ProblemByPaper p = all.get(i);
            String img = FileHelper.getBase64String(p.getProblemdetail());
            p.setProblemdetail(img);
        }
        return all;
    }
}
