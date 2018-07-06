package db;

import org.json.*;

import db.HibernateUtils;
import db.Problem;
import db.Problem.ProblemColumnName;
import db.ProblemByPaper;
import db.ProblemWithLastWork;
import db.ProblemWithWork;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import uti.FileHelper;

import java.util.List;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;


public class DBProblem {

	public DBProblem() {
	}
	
	public Problem getProblemDetail(int problemID) {
		Session session = HibernateUtils.openCurrentSession();
		session.beginTransaction();
		Problem p = session.get(Problem.class, problemID);
		session.getTransaction().commit();
		return p;
	}
	
	public boolean activeProblem(int problemID, int activeLevel) {
		Session session = HibernateUtils.openCurrentSession();

		Problem p = session.get(Problem.class, problemID);
		p.setProblemcisactive(activeLevel);

		this.updateProbelm(p);

		return true;
	}
	
	public boolean deleteProblem(int problemID) {
		Problem p = getProblemDetail(problemID);

		this.deleteProbelm(p);
		return true;
	}
	
	public String getNextActiveProblem() {
		Session session = HibernateUtils.openCurrentSession();

		session.beginTransaction();
		
		CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
        CriteriaQuery<ProblemByPaper> criteriaQuery = criteriaBuilder.createQuery(ProblemByPaper.class);
        Root<ProblemByPaper> itemRoot = criteriaQuery.from(ProblemByPaper.class);
        criteriaQuery.select(itemRoot).where(criteriaBuilder.equal(itemRoot.get("isactive"), 2),
        									criteriaBuilder.equal(itemRoot.get("problemstatus"), 1));
        List<ProblemByPaper> all = session.createQuery(criteriaQuery).getResultList();
        
        session.getTransaction().commit();
        
		if (all.size() == 0)
			return "";
		ProblemByPaper p =  all.get(0);
		String img = FileHelper.getBase64String(p.getProblemdetail());
		p.setProblemdetail(img);
		return p.toString();
	}
	
	public List<ProblemByPaper> getActiveProblemList(String paperID) {
		
		Session session = HibernateUtils.openCurrentSession();

		session.beginTransaction();
		
		CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
        CriteriaQuery<ProblemByPaper> criteriaQuery = criteriaBuilder.createQuery(ProblemByPaper.class);
        Root<ProblemByPaper> itemRoot = criteriaQuery.from(ProblemByPaper.class);
        criteriaQuery.select(itemRoot).where(criteriaBuilder.equal(itemRoot.get("idpaper"), paperID));
        List<ProblemByPaper> all = session.createQuery(criteriaQuery).getResultList();
        
        session.getTransaction().commit();
		return all;	
	}
	
	public List<ProblemByPaper> getPaperProblemList(String paperID) {
		
		Session session = HibernateUtils.openCurrentSession();
		
		session.beginTransaction();
		
		CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
        CriteriaQuery<ProblemByPaper> criteriaQuery = criteriaBuilder.createQuery(ProblemByPaper.class);
        Root<ProblemByPaper> itemRoot = criteriaQuery.from(ProblemByPaper.class);
        criteriaQuery.select(itemRoot).where(criteriaBuilder.equal(itemRoot.get("idpaper"), Integer.parseInt(paperID)));
        List<ProblemByPaper> all = session.createQuery(criteriaQuery).getResultList();
        
        session.getTransaction().commit();
		return all;	
	}

	public Integer PushProblem(JSONObject jsonObject) {

		System.out.println("save new problem request...");
		String log = "";
		int pID = 0;
		try {
			Problem p = new Problem();
			if (jsonObject.has(ProblemColumnName.problemlevel.toString())) {
				p.setProblemlevel(jsonObject.getInt(ProblemColumnName.problemlevel.toString()));
				log = log + ProblemColumnName.problemlevel.toString() + "=" + p.getProblemlevel().toString() + ";";
			}
			if (jsonObject.has(ProblemColumnName.problemchapterid.toString())) {
				p.setProblemchapterid(jsonObject.getInt(ProblemColumnName.problemchapterid.toString()));
				log = log + ProblemColumnName.problemchapterid.toString() + "=" + p.getProblemchapterid().toString() + ";";
			}
			if (jsonObject.has(ProblemColumnName.problemindex.toString())) {
				p.setProblemindex(jsonObject.getString(ProblemColumnName.problemindex.toString()));
				log = log + ProblemColumnName.problemindex.toString() + "=" + p.getProblemindex() + ";";
			}
			if (jsonObject.has(ProblemColumnName.problemmodule.toString())) {
				p.setProblemmodule(jsonObject.getInt(ProblemColumnName.problemmodule.toString()));
				log = log + ProblemColumnName.problemmodule.toString() + "=" + p.getProblemmodule().toString() + ";";
			}
			if (jsonObject.has(ProblemColumnName.problemanswerstring.toString())) {
				p.setProblemanswerstring(jsonObject.getString(ProblemColumnName.problemanswerstring.toString()));
				log = log + ProblemColumnName.problemanswerstring.toString() + "=" + p.getProblemanswerstring() + ";";
			}
			if (jsonObject.has(ProblemColumnName.problemcisactive.toString()))
				p.setProblemcisactive(jsonObject.getInt(ProblemColumnName.problemcisactive.toString()));

			pID = insertProbelm(p);
			System.out.println(log);

			p.setIdproblem(pID);
			boolean needUpdate = false;
			if (jsonObject.has(ProblemColumnName.problemdetail.toString())) {
				if (jsonObject.getString(ProblemColumnName.problemdetail.toString()).length() > 1) {
					p.setProblemdetail(FileHelper.saveBase64File(jsonObject.getString(ProblemColumnName.problemdetail.toString()), "p", pID));
					needUpdate = true;
				}
			}

			if (jsonObject.has(ProblemColumnName.problemanswerdetail.toString())) {
				if (jsonObject.getString(ProblemColumnName.problemanswerdetail.toString()).length() > 1) {
					p.setProblemanswerdetail(FileHelper.saveBase64File(jsonObject.getString(ProblemColumnName.problemanswerdetail.toString()), "a", pID));
					needUpdate = true;
				}
			}

			if (needUpdate == false)
				return pID;
			updateProbelm(p);

		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return pID;
	}

	int insertProbelm(Problem p) {
		Session session = HibernateUtils.openCurrentSession();
		Transaction tx = null;
		int problemID = 0;

		try {
			tx = session.beginTransaction();
			problemID = (Integer) session.save(p);
			tx.commit();
		} catch (HibernateException e) {
			if (tx != null)
				tx.rollback();
			e.printStackTrace();
		} finally {
			session.close();
		}
		return problemID;
	}
	
	public List<ProblemWithLastWork> getProblemWithLastWorkByCharpter(int chapterID) {
		Session session = HibernateUtils.openCurrentSession();

		session.beginTransaction();
		
		CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
        CriteriaQuery<ProblemWithLastWork> criteriaQuery = criteriaBuilder.createQuery(ProblemWithLastWork.class);
        Root<ProblemWithLastWork> itemRoot = criteriaQuery.from(ProblemWithLastWork.class);
        criteriaQuery.select(itemRoot).where(criteriaBuilder.equal(itemRoot.get("problemchapterid"), chapterID));

        List<ProblemWithLastWork> all = session.createQuery(criteriaQuery).getResultList();
        
        session.getTransaction().commit();
		return all;
	}

	public List<ProblemWithWork> getProblemByCharpter(int chapterID) {
		Session session = HibernateUtils.openCurrentSession();

		session.beginTransaction();
		
		CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
        CriteriaQuery<ProblemWithWork> criteriaQuery = criteriaBuilder.createQuery(ProblemWithWork.class);
        Root<ProblemWithWork> itemRoot = criteriaQuery.from(ProblemWithWork.class);
        criteriaQuery.select(itemRoot).where(criteriaBuilder.equal(itemRoot.get("problemchapterid"), chapterID));

        List<ProblemWithWork> all = session.createQuery(criteriaQuery).getResultList();
        
        session.getTransaction().commit();
        for(int i=0; i < all.size(); ++i) {
        	ProblemWithWork pw = all.get(i);
        	System.out.println(pw.getMyWork().size());
        }
		return all;
	}

	boolean updateProbelm(Problem p) {
		Session session = HibernateUtils.openCurrentSession();
		Transaction tx = null;
		boolean suc = false;

		try {
			tx = session.beginTransaction();
			session.update(p);
			tx.commit();
			suc = true;
		} catch (HibernateException e) {
			if (tx != null)
				tx.rollback();
			e.printStackTrace();
		} finally {
			session.close();
		}
		return suc;
	}
	
	boolean deleteProbelm(Problem p) {
		Session session = HibernateUtils.openCurrentSession();
		Transaction tx = null;
		boolean suc = false;

		try {
			tx = session.beginTransaction();
			session.delete(p);
			tx.commit();
			suc = true;
		} catch (HibernateException e) {
			if (tx != null)
				tx.rollback();
			e.printStackTrace();
		} finally {
			session.close();
		}
		return suc;
	}
}
