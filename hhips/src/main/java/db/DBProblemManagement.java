package db;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.json.JSONException;
import org.json.JSONObject;

import db.Chapter.ChapterColumnName;
import db.Work.WorkColumnName;

public class DBProblemManagement {

	public DBProblemManagement() {
	}
	
	public String getSourceName(int sourceID) {
		Session session = HibernateUtils.openCurrentSession();
		
		session.beginTransaction();
		
		CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
        CriteriaQuery<Source> criteriaQuery = criteriaBuilder.createQuery(Source.class);
        Root<Source> itemRoot = criteriaQuery.from(Source.class);
        criteriaQuery.select(itemRoot).where(criteriaBuilder.equal(itemRoot.get("idsource"), sourceID));
        List<Source> all = session.createQuery(criteriaQuery).getResultList();
        
        session.getTransaction().commit();
		
		return all.get(0).getSourcename();
	}
	
	public List<Source> getAllSource() {
		Session session = HibernateUtils.openCurrentSession();
		
		session.beginTransaction();
		
		CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
        CriteriaQuery<Source> criteriaQuery = criteriaBuilder.createQuery(Source.class);
        Root<Source> itemRoot = criteriaQuery.from(Source.class);
        criteriaQuery.select(itemRoot).where(criteriaBuilder.greaterThan(itemRoot.get("idsource"), 0));
        List<Source> all = session.createQuery(criteriaQuery).getResultList();
        
        session.getTransaction().commit();
		
        return all;
	}
	
	public List<Module> getAllModule() {
		Session session = HibernateUtils.openCurrentSession();
		
		session.beginTransaction();
		
		CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
        CriteriaQuery<Module> criteriaQuery = criteriaBuilder.createQuery(Module.class);
        Root<Module> itemRoot = criteriaQuery.from(Module.class);
        criteriaQuery.select(itemRoot).where(criteriaBuilder.greaterThan(itemRoot.get("idmodule"), 0));
        List<Module> all = session.createQuery(criteriaQuery).getResultList();
        
        session.getTransaction().commit();
		
		return all;
	}
	
	public int insertNewPaper(String paperName) {
		Paper p = new Paper();
		p.setIsactive(1);
		p.setPaperdate(new Date());
		p.setPapername(paperName);
		
		Transaction tx = null;

		Session session = HibernateUtils.openCurrentSession();
		int newPaperID = 0;
		try {
			tx = session.beginTransaction();
			newPaperID = (Integer) session.save(p);
			tx.commit();
		} catch (HibernateException e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return newPaperID;
	}
	
	public void updatePaperIsactive(int idpaper, int isactive) {
		Session session = HibernateUtils.openCurrentSession();
		
		session.beginTransaction();
		
		CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
        CriteriaQuery<Paper> criteriaQuery = criteriaBuilder.createQuery(Paper.class);
        Root<Paper> itemRoot = criteriaQuery.from(Paper.class);
        criteriaQuery.select(itemRoot).where(criteriaBuilder.equal(itemRoot.get("idpaper"), idpaper));
        List<Paper> all = session.createQuery(criteriaQuery).getResultList();
        
        session.getTransaction().commit();
        
        if (all.size() == 0)
        	return;
        
        Paper p = all.get(0);
        p.setIsactive(isactive);
        
        Transaction tx = null;

		try {
			session = HibernateUtils.openCurrentSession(); 
			tx = session.beginTransaction();
			session.update(p);
			tx.commit();
		} catch (HibernateException e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
	}
	
	public List<Paper> getAllPapers() {
		Session session = HibernateUtils.openCurrentSession();
		
		session.beginTransaction();
		
		CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
        CriteriaQuery<Paper> criteriaQuery = criteriaBuilder.createQuery(Paper.class);
        Root<Paper> itemRoot = criteriaQuery.from(Paper.class);
        criteriaQuery.select(itemRoot).where(criteriaBuilder.notEqual(itemRoot.get("isactive"), 5));
        List<Paper> all = session.createQuery(criteriaQuery).getResultList();
        
        session.getTransaction().commit();
		
		return all;
	}

	public List<Paper> getAllActivePapers() {
		Session session = HibernateUtils.openCurrentSession();

		session.beginTransaction();

		CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
		CriteriaQuery<Paper> criteriaQuery = criteriaBuilder.createQuery(Paper.class);
		Root<Paper> itemRoot = criteriaQuery.from(Paper.class);
		criteriaQuery.select(itemRoot).where(criteriaBuilder.equal(itemRoot.get("isactive"), 2));
		List<Paper> all = session.createQuery(criteriaQuery).getResultList();

		session.getTransaction().commit();

		return all;
	}
	
	public List<Paper> getAllEditPapers() {
		Session session = HibernateUtils.openCurrentSession();
		
		session.beginTransaction();
		
		CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
        CriteriaQuery<Paper> criteriaQuery = criteriaBuilder.createQuery(Paper.class);
        Root<Paper> itemRoot = criteriaQuery.from(Paper.class);
        criteriaQuery.select(itemRoot).where(criteriaBuilder.equal(itemRoot.get("isactive"), 1));
        List<Paper> all = session.createQuery(criteriaQuery).getResultList();
        
        session.getTransaction().commit();
		
		return all;
	}
	
	boolean insertPaperWork(int idwork, int idpaper, int idproblem) {
		Session session = HibernateUtils.openCurrentSession();
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
	
	public boolean UpdatePaperProblemAfterWork(int workid, JSONObject jsonObject) {
		int problemid=0;
		int paperproblemid=0;
		
		try {
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
		System.out.println("Save work problemid = "+String.valueOf(problemid)+" paperproblemid="+String.valueOf(paperproblemid));
		Session session = HibernateUtils.openCurrentSession();
		
		session.beginTransaction();
		
		CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
        CriteriaQuery<Paperproblem> criteriaQuery = criteriaBuilder.createQuery(Paperproblem.class);
        Root<Paperproblem> itemRoot = criteriaQuery.from(Paperproblem.class);
        criteriaQuery.select(itemRoot).where(criteriaBuilder.equal(itemRoot.get("problemid"), problemid),
        		criteriaBuilder.equal(itemRoot.get("paperproblemid"), paperproblemid));
        List<Paperproblem> all = session.createQuery(criteriaQuery).getResultList();
        
        session.getTransaction().commit();

		if(all.size() == 0) {
			System.out.println("not find matched paper problem, cannot update work in this case");
			return false;
		}
		
		Paperproblem pp = all.get(0);
		pp.setProblemstatus(2);
		pp.setIdwork(workid);
		Transaction tx = null;

		try {
			session = HibernateUtils.openCurrentSession(); 
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

	public boolean changeAllPaperProblemStatus(int paperID, int problemstatus) {
		Session session = HibernateUtils.openCurrentSession();

		session.beginTransaction();

		CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
		CriteriaQuery<Paperproblem> criteriaQuery = criteriaBuilder.createQuery(Paperproblem.class);
		Root<Paperproblem> itemRoot = criteriaQuery.from(Paperproblem.class);
		criteriaQuery.select(itemRoot).where(criteriaBuilder.equal(itemRoot.get("paperid"), paperID));
		List<Paperproblem> all = session.createQuery(criteriaQuery).getResultList();

		session.getTransaction().commit();

		for(int i = 0; i<all.size();++i) {
			Paperproblem pp = all.get(i);
			pp.setProblemstatus(problemstatus);
			pp.update();
		}

		return true;
	}

	public boolean ChangeProblemPaperStatus(int problemid, int paperproblemid, int problemstatus) {
		Session session = HibernateUtils.openCurrentSession();

		session.beginTransaction();
		
		CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
        CriteriaQuery<Paperproblem> criteriaQuery = criteriaBuilder.createQuery(Paperproblem.class);
        Root<Paperproblem> itemRoot = criteriaQuery.from(Paperproblem.class);
        criteriaQuery.select(itemRoot).where(criteriaBuilder.equal(itemRoot.get("paperproblemid"), paperproblemid),
        		criteriaBuilder.equal(itemRoot.get("problemid"), problemid));
        List<Paperproblem> all = session.createQuery(criteriaQuery).getResultList();
        
        session.getTransaction().commit();
        
		if(all.size() == 0)
			return false;
		
		Paperproblem pp = all.get(0);
		pp.setProblemstatus(problemstatus);
		pp.update();
		return true;
	}
	
	public boolean createPaperProblem(int problemID, int paperID) {
		Session session = HibernateUtils.openCurrentSession();

		Paperproblem pp = new Paperproblem();
		pp.setProblemstatus(1);
		pp.setPaperid(paperID);
		pp.setProblemid(problemID);
		
		session.beginTransaction();
		
		CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
        CriteriaQuery<Paperproblem> criteriaQuery = criteriaBuilder.createQuery(Paperproblem.class);
        Root<Paperproblem> itemRoot = criteriaQuery.from(Paperproblem.class);
        criteriaQuery.select(itemRoot).where(criteriaBuilder.equal(itemRoot.get("paperid"), paperID),
        									criteriaBuilder.equal(itemRoot.get("problemid"), problemID));
        List<Paperproblem> all = session.createQuery(criteriaQuery).getResultList();
        
		if(all.size() > 0) {
			session.getTransaction().commit();
			return true;
		}

		try {
			problemID = (Integer) session.save(pp);
		} catch (HibernateException e) {
			e.printStackTrace();
			return false;
		} finally {
			//session.close();
			session.getTransaction().commit();
		}
		return true;
	}
	
	//chapter part
	public Chapter getChaperName(Chapter c) {
		Session session = HibernateUtils.openCurrentSession();
		
		session.beginTransaction();
		
		CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
        CriteriaQuery<Chapter> criteriaQuery = criteriaBuilder.createQuery(Chapter.class);
        Root<Chapter> itemRoot = criteriaQuery.from(Chapter.class);
        criteriaQuery.select(itemRoot).where(criteriaBuilder.equal(itemRoot.get("idsourcechapter"), c.getIdsourcechapter()));
        List<Chapter> all = session.createQuery(criteriaQuery).getResultList();
        
        session.getTransaction().commit();
        
		return all.get(0);
	}
	
	int insertChapter(Chapter p) {
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
	
	public int createNewChapter(String json) {

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

	public List<SourceChapterSummary> getChapterSummaryList(int sourceID) {
		Session session = HibernateUtils.openCurrentSession();

		session.beginTransaction();

		CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
		CriteriaQuery<SourceChapterSummary> criteriaQuery = criteriaBuilder.createQuery(SourceChapterSummary.class);
		Root<SourceChapterSummary> itemRoot = criteriaQuery.from(SourceChapterSummary.class);
		criteriaQuery.select(itemRoot).where(criteriaBuilder.equal(itemRoot.get("sourceid"), sourceID)).orderBy(criteriaBuilder.asc(itemRoot.get("sourcechapterindex")));
		List<SourceChapterSummary> all = session.createQuery(criteriaQuery).getResultList();

		session.getTransaction().commit();


		return all;
	}
	
	public List<SourceChapter> getChapterList(int sourceID) {
		Session session = HibernateUtils.openCurrentSession();
		
		session.beginTransaction();
		
		CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
        CriteriaQuery<SourceChapter> criteriaQuery = criteriaBuilder.createQuery(SourceChapter.class);
        Root<SourceChapter> itemRoot = criteriaQuery.from(SourceChapter.class);
        criteriaQuery.select(itemRoot).where(criteriaBuilder.equal(itemRoot.get("sourceid"), sourceID));
        List<SourceChapter> all = session.createQuery(criteriaQuery).getResultList();
        
        session.getTransaction().commit();
        
		
		return all;
	}
}
