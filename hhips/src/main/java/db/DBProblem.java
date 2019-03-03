package db;

import javafx.util.Pair;
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
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import uti.FileHelper;

import java.util.List;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;


@Component
public class DBProblem {

	private static final org.slf4j.Logger logger = LoggerFactory.getLogger(DBProblem.class);

	public DBProblem() {
	}
	
	public Problem getProblemDetail(int problemID) {
		Session session = HibernateUtils.openCurrentSession();
		session.beginTransaction();
		Problem p;
		try {
			p = session.get(Problem.class, problemID);
			session.getTransaction().commit();
		}
		catch ( RuntimeException e ) {
			session.getTransaction().rollback();
			throw e;
		}
		finally {
			session.close();
		}

		return p;
	}
	
	public boolean activeProblem(int problemID, int activeLevel) {
		Session session = HibernateUtils.openCurrentSession();
		Problem p;
		try {
			p = session.get(Problem.class, problemID);
			p.setProblemcisactive(activeLevel);

			this.updateProbelm(p);
		}
		catch ( RuntimeException e ) {
			throw e;
		}
		finally {
			session.close();
		}

		return true;
	}
	
	public boolean deleteProblem(int problemID) {
		Problem p = getProblemDetail(problemID);

		String fileName = FileHelper.getAbsolutePath() + p.getProblemdetail();
		FileHelper.deleteOneFile(fileName);
		fileName = FileHelper.getAbsolutePath() + p.getProblemanswerdetail();
		FileHelper.deleteOneFile(fileName);

		this.deleteProbelm(p);
		return true;
	}

	public String getNextActiveProblemInPaper(String paperID) {
		Session session = HibernateUtils.openCurrentSession();

		session.beginTransaction();
		List<ProblemByPaper> all;

		try {
			CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
			CriteriaQuery<ProblemByPaper> criteriaQuery = criteriaBuilder.createQuery(ProblemByPaper.class);
			Root<ProblemByPaper> itemRoot = criteriaQuery.from(ProblemByPaper.class);
			criteriaQuery.select(itemRoot).where(criteriaBuilder.equal(itemRoot.get("isactive"), 2),
					criteriaBuilder.equal(itemRoot.get("problemstatus"), 1),
					criteriaBuilder.equal(itemRoot.get("idpaper"), paperID));
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

		if (all.size() == 0)
			return "";
		ProblemByPaper p =  all.get(0);
		String img = FileHelper.getBase64String(p.getProblemdetail());
		p.setProblemdetail(img);
		return p.toString();
	}
	
	public String getNextActiveProblem() {
		Session session = HibernateUtils.openCurrentSession();

		session.beginTransaction();
		List<ProblemByPaper> all;
		try {
			CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
			CriteriaQuery<ProblemByPaper> criteriaQuery = criteriaBuilder.createQuery(ProblemByPaper.class);
			Root<ProblemByPaper> itemRoot = criteriaQuery.from(ProblemByPaper.class);
			criteriaQuery.select(itemRoot).where(criteriaBuilder.equal(itemRoot.get("isactive"), 2),
					criteriaBuilder.equal(itemRoot.get("problemstatus"), 1));
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
		List<ProblemByPaper> all;
		try {
			CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
			CriteriaQuery<ProblemByPaper> criteriaQuery = criteriaBuilder.createQuery(ProblemByPaper.class);
			Root<ProblemByPaper> itemRoot = criteriaQuery.from(ProblemByPaper.class);
			criteriaQuery.select(itemRoot).where(criteriaBuilder.equal(itemRoot.get("idpaper"), paperID));
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
	
	public List<ProblemByPaper> getPaperProblemList(String paperID) {
		
		Session session = HibernateUtils.openCurrentSession();
		
		session.beginTransaction();
		List<ProblemByPaper> all;
		try {
			CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
			CriteriaQuery<ProblemByPaper> criteriaQuery = criteriaBuilder.createQuery(ProblemByPaper.class);
			Root<ProblemByPaper> itemRoot = criteriaQuery.from(ProblemByPaper.class);
			criteriaQuery.select(itemRoot).where(criteriaBuilder.equal(itemRoot.get("idpaper"), Integer.parseInt(paperID)));
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

	public Integer UpdateProblem(JSONObject jsonObject) {
		System.out.println("update problem request...");
		String log = "";
		int pID = 0;
		try {
			Problem p = new Problem();
			if (jsonObject.has(ProblemColumnName.idproblem.toString())) {
				p.setIdproblem(jsonObject.getInt(ProblemColumnName.idproblem.toString()));
				log = log + ProblemColumnName.idproblem.toString() + "=" + p.getIdproblem().toString() + ";";
			}
			p = getProblemDetail(p.getIdproblem());

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
				if (jsonObject.getString(ProblemColumnName.problemanswerstring.toString()).length() > 0) {
					p.setProblemanswerstring(jsonObject.getString(ProblemColumnName.problemanswerstring.toString()));
					log = log + ProblemColumnName.problemanswerstring.toString() + "=" + p.getProblemanswerstring() + ";";
				}
			}
			if (jsonObject.has(ProblemColumnName.problemcisactive.toString()))
				p.setProblemcisactive(jsonObject.getInt(ProblemColumnName.problemcisactive.toString()));

			System.out.println(log);
			logger.info(log);
			updateProbelm(p);

			if (jsonObject.has(ProblemColumnName.problemdetail.toString())) {
				if (jsonObject.getString(ProblemColumnName.problemdetail.toString()).length() > 0) {
					logger.info("update problem to " + p.getProblemdetail());
					FileHelper.updateBase64File(jsonObject.getString(ProblemColumnName.problemdetail.toString()), p.getProblemdetail());
				}
			}

			if (jsonObject.has(ProblemColumnName.problemanswerdetail.toString())) {
				if (jsonObject.getString(ProblemColumnName.problemanswerdetail.toString()).length() > 0) {
					logger.info("update problem answer to " + p.getProblemanswerdetail());
					FileHelper.updateBase64File(jsonObject.getString(ProblemColumnName.problemanswerdetail.toString()), p.getProblemanswerdetail());
				}
			}

		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return pID;
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

			if (jsonObject.has(ProblemColumnName.problemdetailb.toString())) {
				if (jsonObject.getString(ProblemColumnName.problemdetailb.toString()).length() > 1) {
					p.setProblemdetailb(FileHelper.saveBase64File(jsonObject.getString(ProblemColumnName.problemdetailb.toString()), "pb", pID));
					needUpdate = true;
				}
			}

			if (jsonObject.has(ProblemColumnName.problemdetailc.toString())) {
				if (jsonObject.getString(ProblemColumnName.problemdetailc.toString()).length() > 1) {
					p.setProblemdetailc(FileHelper.saveBase64File(jsonObject.getString(ProblemColumnName.problemdetailc.toString()), "pc", pID));
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

	public int insertProbelm(Problem p) {
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

	public Pair<Integer, Integer> getProblemBeforeAfter(Problem problem) {
		Session session = HibernateUtils.openCurrentSession();

		session.beginTransaction();
		List<Problem> all;
		Pair<Integer, Integer> beforeAndAfter = new Pair<Integer, Integer>(0,0);
		int before = 0;
		int after = 0;

		try {
			CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
			CriteriaQuery<Problem> criteriaQuery = criteriaBuilder.createQuery(Problem.class);
			Root<Problem> itemRoot = criteriaQuery.from(Problem.class);
			criteriaQuery.select(itemRoot).where(criteriaBuilder.equal(itemRoot.get("problemchapterid"), problem.getProblemchapterid()));

			all = session.createQuery(criteriaQuery).getResultList();

			session.getTransaction().commit();

			int index = -1;
			for(int i = 0; i < all.size(); ++i) {
				int curID = all.get(i).getIdproblem();
				int myID = problem.getIdproblem();
				if ( curID == myID) {
					index = i;
					break;
				}
			}

			if (index > -1) {
				if (index > 0)
					before = all.get(index - 1).getIdproblem();
				if (index < (all.size() - 1)) {
					after = all.get(index+1).getIdproblem();
				}

				beforeAndAfter = new Pair<Integer, Integer>(before, after);
			}
		}
		catch ( RuntimeException e ) {
			session.getTransaction().rollback();
			throw e;
		}
		finally {
			session.close();
		}

		return beforeAndAfter;
	}
	
	public List<ProblemWithLastWork> getProblemWithLastWorkByCharpter(int chapterID) {
		Session session = HibernateUtils.openCurrentSession();

		session.beginTransaction();
		List<ProblemWithLastWork> all;

		try {
			CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
			CriteriaQuery<ProblemWithLastWork> criteriaQuery = criteriaBuilder.createQuery(ProblemWithLastWork.class);
			Root<ProblemWithLastWork> itemRoot = criteriaQuery.from(ProblemWithLastWork.class);
			criteriaQuery.select(itemRoot).where(criteriaBuilder.equal(itemRoot.get("problemchapterid"), chapterID));

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

	public List<ProblemWithWork> getProblemByCharpter(int chapterID) {
		Session session = HibernateUtils.openCurrentSession();

		session.beginTransaction();
		List<ProblemWithWork> all;

		try {
			CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
			CriteriaQuery<ProblemWithWork> criteriaQuery = criteriaBuilder.createQuery(ProblemWithWork.class);
			Root<ProblemWithWork> itemRoot = criteriaQuery.from(ProblemWithWork.class);
			criteriaQuery.select(itemRoot).where(criteriaBuilder.equal(itemRoot.get("problemchapterid"), chapterID));
			all =session.createQuery(criteriaQuery).getResultList();

			session.getTransaction().commit();
			for (int i = 0; i < all.size(); ++i) {
				ProblemWithWork pw = all.get(i);
				System.out.println(pw.getMyWork().size());
			}
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

	public boolean updateProbelm(Problem p) {
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
