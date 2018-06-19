package hhipsair;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;

import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;
import org.hibernate.criterion.Restrictions;
import org.json.JSONException;
import org.json.JSONObject;

import db.Chapter;
import db.Module;
import db.Paper;
import db.PaperWork;
import db.Paperproblem;
import db.Source;
import db.SourceChapter;
import db.Work;
import db.Chapter.ChapterColumnName;
import db.Work.WorkColumnName;

public class DBProblemManagement {
	SessionFactory factory;

	public DBProblemManagement() {
		try {
			Configuration cfg = new Configuration();
			cfg.configure("hibernate.cfg.xml");
			// factory = new Configuration().configure().buildSessionFactory();
			factory = cfg.buildSessionFactory();
		} catch (Throwable ex) {
			System.err.println("Failed to create sessionFactory object." + ex);
			// throw new ExceptionInInitializerError(ex);
			factory = null;
		}
	}
	
	public String getSourceName(int sourceID) {
		Session session = factory.openSession();
		
		Criteria cr = session.createCriteria(db.Source.class);
		cr.add(Restrictions.eq("idsource", sourceID));
		List<db.Source> results = cr.list();
		return results.get(0).getSourcename();
	}
	
	public List<db.Source> getAllSource() {
		Session session = factory.openSession();
		
		CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
        CriteriaQuery<Source> criteriaQuery = criteriaBuilder.createQuery(Source.class);
        Root<Source> itemRoot = criteriaQuery.from(Source.class);
        criteriaQuery.select(itemRoot).where(criteriaBuilder.greaterThan(itemRoot.get("idsource"), 0));
        return session.createQuery(criteriaQuery).getResultList();
	}
	
	public List<Module> getAllModule() {
		Session session = factory.openSession();
		
		Criteria cr = session.createCriteria(db.Module.class);
		List<Module> results = cr.list();
		
		return results;
	}
	
	public List<Paper> getAllPapers() {
		Session session = factory.openSession();
		
		Criteria cr = session.createCriteria(db.Paper.class);
		List<Paper> results = cr.list();
		
		return results;
	}
	
	public List<Paper> getAllEditPapers() {
		Session session = factory.openSession();
		
		Criteria cr = session.createCriteria(db.Paper.class);
		cr.add(Restrictions.eq("isactive", 1));
		List<Paper> results = cr.list();
		
		return results;
	}
	
	boolean insertPaperWork(int idwork, int idpaper, int idproblem) {
		Session session = factory.openSession();
		Transaction tx = null;

		PaperWork pw = new PaperWork();
		pw.setIdpaper(idpaper);
		pw.setIdwork(idwork);
		pw.setIdproblem(idproblem);
		try {
			tx = session.beginTransaction();
			session.save(pw);
			tx.commit();
		} catch (HibernateException e) {
			if (tx != null)
				tx.rollback();
			e.printStackTrace();
		} finally {
			session.close();
		}
		return true;
	}
	
	public boolean UpdatePaperProblemAfterWork(int workid, String workJSON) {
		int problemid=0;
		int paperproblemid=0;
		
		try {
			JSONObject jsonObject = new JSONObject(workJSON);
			problemid = jsonObject.getInt(WorkColumnName.idproblem.toString());
			
			paperproblemid = jsonObject.getInt("paperproblemid");
			
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		if (problemid==0)
			return false;
		if (paperproblemid==0)
			return false;
		Session session = factory.openSession();

		Criteria cr = session.createCriteria(db.Paperproblem.class);
		cr.add(Restrictions.eq("problemid", problemid));
		List<Paperproblem> results = cr.list();
		if(results.size() == 0) {
			System.out.println("not find matched paper problem, cannot update work in this case");
			return false;
		}
		
		Paperproblem pp = results.get(0);
		pp.setProblemstatus(2);
		pp.setIdwork(workid);
		Transaction tx = null;

		try {
			tx = session.beginTransaction();
			session.update(pp);
			tx.commit();
		} catch (HibernateException e) {
			e.printStackTrace();
			return false;
		} finally {
			session.close();
		}
		
		return insertPaperWork(workid, pp.getPaperid(), pp.getProblemid());
	}
	
	public boolean ChangeProblemPaperStatus(int problemid, int paperproblemid, int problemstatus) {
		Session session = factory.openSession();

		Criteria cr = session.createCriteria(db.Paperproblem.class);
		cr.add(Restrictions.eq("paperproblemid", paperproblemid));
		cr.add(Restrictions.eq("problemid", problemid));
		List<Paperproblem> results = cr.list();
		if(results.size() == 0)
			return false;
		
		Paperproblem pp = results.get(0);
		pp.setProblemstatus(problemstatus);
		Transaction tx = null;

		try {
			tx = session.beginTransaction();
			session.update(pp);
			tx.commit();
		} catch (HibernateException e) {
			e.printStackTrace();
			return false;
		} finally {
			session.close();
		}
		return true;
	}
	
	public boolean createPaperProblem(int problemID, int paperID) {
		Session session = factory.openSession();

		Paperproblem pp = new Paperproblem();
		pp.setProblemstatus(1);
		pp.setPaperid(paperID);
		pp.setProblemid(problemID);
		
		Criteria cr = session.createCriteria(db.Paperproblem.class);
		cr.add(Restrictions.eq("paperid", paperID));
		cr.add(Restrictions.eq("problemid", problemID));
		List<Paper> results = cr.list();
		if(results.size() > 0)
			return true;

		try {
			problemID = (Integer) session.save(pp);
		} catch (HibernateException e) {
			e.printStackTrace();
			return false;
		} finally {
			session.close();
		}
		return true;
	}
	
	//chapter part
	public String getChaperName(Chapter c) {
		Session session = factory.openSession();
		
		Criteria cr = session.createCriteria(db.Chapter.class);
		cr.add(Restrictions.eq("idsourcechapter", c.getIdsourcechapter()));
		List<Chapter> results = cr.list();
		return results.get(0).getSourcechaptername();
	}
	
	int insertChapter(Chapter p) {
		Session session = factory.openSession();
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
	
	public int createNewChapter(String json) {
		if (factory == null)
			return 0;

		int cID=0;
		try {
			JSONObject jsonObject = new JSONObject(json);
			Chapter ch = new Chapter();
			if (jsonObject.has(ChapterColumnName.sourcechapterindex.toString()) == true)
				ch.setSourcechapterindex(jsonObject.getInt(ChapterColumnName.sourcechapterindex.toString()));
			if (jsonObject.has(ChapterColumnName.sourceid.toString()) == true)
				ch.setSourceid(jsonObject.getInt(ChapterColumnName.sourceid.toString()));
			if (jsonObject.has(ChapterColumnName.sourcechaptername.toString()) == true)
				ch.setSourcechaptername(jsonObject.getString(ChapterColumnName.sourcechaptername.toString()));
			
			List<SourceChapter> allChapter = getChapterList(ch.getSourceid());
			ch.setSourcechapterindex(allChapter.size()+1);

			cID = insertChapter(ch);

		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return cID;
	}
	
	public List<SourceChapter> getChapterList(int sourceID) {
		Session session = factory.openSession();
		
		CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
        CriteriaQuery<SourceChapter> criteriaQuery = criteriaBuilder.createQuery(SourceChapter.class);
        Root<SourceChapter> itemRoot = criteriaQuery.from(SourceChapter.class);
        criteriaQuery.select(itemRoot).where(criteriaBuilder.equal(itemRoot.get("sourceid"), sourceID));
        return session.createQuery(criteriaQuery).getResultList();
	}
}
