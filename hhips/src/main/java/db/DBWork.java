package db;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
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

import db.Work.WorkColumnName;
import uti.FileHelper;

public class DBWork {
	public static String absolutePath = "";
	
	public DBWork() {
	}
	
	public List<Work> getProblemAllWork(int problemID) {
		Session session = HibernateUtils.openCurrentSession();
		
		session.beginTransaction();
		List<Work> all;
		try {
			CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
			CriteriaQuery<Work> criteriaQuery = criteriaBuilder.createQuery(Work.class);
			Root<Work> itemRoot = criteriaQuery.from(Work.class);
			criteriaQuery.select(itemRoot).where(criteriaBuilder.equal(itemRoot.get("idproblem"), problemID));
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

	public List<WorkDetail> getProblemAllWorkDetail(Integer idproblem) {
		Session session = HibernateUtils.openCurrentSession();

		session.beginTransaction();
		List<WorkDetail> all;
		try {
			CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
			CriteriaQuery<WorkDetail> criteriaQuery = criteriaBuilder.createQuery(WorkDetail.class);
			Root<WorkDetail> itemRoot = criteriaQuery.from(WorkDetail.class);
			criteriaQuery.select(itemRoot).where(criteriaBuilder.equal(itemRoot.get("idproblem"), idproblem));
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

	public  List<WorkDetail> getPaperProblemWork(Integer idpaper, Integer idproblem) {
		Session session = HibernateUtils.openCurrentSession();

		session.beginTransaction();
		List<WorkDetail> all;
		try {
			CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
			CriteriaQuery<WorkDetail> criteriaQuery = criteriaBuilder.createQuery(WorkDetail.class);
			Root<WorkDetail> itemRoot = criteriaQuery.from(WorkDetail.class);
			criteriaQuery.select(itemRoot).where(criteriaBuilder.equal(itemRoot.get("idproblem"), idproblem), criteriaBuilder.equal(itemRoot.get("idpaper"), idpaper));
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

	public int PushWork(JSONObject jsonObject) {
		int pID = 0;

		try {
			//JSONObject jsonObject = new JSONObject(workJSON);
			Work w = new Work();
			if (jsonObject.has(WorkColumnName.workdate.toString()) == true) {
				SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd HH:mm:ss");
				Date date;
				try {
					date = formatter.parse(jsonObject.getString(WorkColumnName.workdate.toString()));
					w.setWorkdate(date);
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if (jsonObject.has(WorkColumnName.idproblem.toString()) == true)
				w.setIdproblem(jsonObject.getInt(WorkColumnName.idproblem.toString()));
			
			if (jsonObject.has(WorkColumnName.usedtime.toString()) == true)
				w.setUsedtime(jsonObject.getInt(WorkColumnName.usedtime.toString()));
			
			if (jsonObject.has(WorkColumnName.workdetail.toString()) == false) {
				w.setWorkmark(1);
				w.setWorkdetail("201804\\t.png");
			}

			pID = insertWork(w);

			w.setIdwork(pID);
			boolean needUpdate = false;
			if (jsonObject.has(WorkColumnName.workdetail.toString()) == true) {
				if (jsonObject.getString(WorkColumnName.workdetail.toString()).length() > 1) {
					w.setWorkdetail(FileHelper.saveBase64File(jsonObject.getString(WorkColumnName.workdetail.toString()), "w", pID));
					needUpdate = true;
				}
			}

			if (needUpdate == false)
				return pID;
			updateWork(w);

		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return pID;
	}
	
	public boolean updateWorkMark(int idWork, int mark) {
	
		Session session = HibernateUtils.openCurrentSession();
		session.beginTransaction();
		List<Work> all;
		try {
			CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
			CriteriaQuery<Work> criteriaQuery = criteriaBuilder.createQuery(Work.class);
			Root<Work> itemRoot = criteriaQuery.from(Work.class);
			criteriaQuery.select(itemRoot).where(criteriaBuilder.equal(itemRoot.get("idwork"), idWork));
         	all=session.createQuery(criteriaQuery).getResultList();
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
        	return false;
        
        Work w = all.get(0);
        w.setWorkmark(mark);
        updateWork(w);
		return true;
	}

	public boolean updateWorkReason(int idWork, int reason) {

		Session session = HibernateUtils.openCurrentSession();
		session.beginTransaction();
		List<Work> all;
		try {
			CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
			CriteriaQuery<Work> criteriaQuery = criteriaBuilder.createQuery(Work.class);
			Root<Work> itemRoot = criteriaQuery.from(Work.class);
			criteriaQuery.select(itemRoot).where(criteriaBuilder.equal(itemRoot.get("idwork"), idWork));
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
			return false;

		Work w = all.get(0);
		w.setReason(reason);
		if(reason == 0)
			w.setReason(null);
		updateWork(w);
		return true;
	}

	public boolean updateWorkStarReason(int idWork, int idstarreason) {

		Session session = HibernateUtils.openCurrentSession();
		session.beginTransaction();
		List<Work> all;
		try {
			CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
			CriteriaQuery<Work> criteriaQuery = criteriaBuilder.createQuery(Work.class);
			Root<Work> itemRoot = criteriaQuery.from(Work.class);
			criteriaQuery.select(itemRoot).where(criteriaBuilder.equal(itemRoot.get("idwork"), idWork));
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
			return false;

		Work w = all.get(0);
		w.setIdstarreason(idstarreason);
		if (idstarreason == 0)
			w.setIdstarreason(null);
		updateWork(w);
		return true;
	}

	private boolean updateWork(Work w) {
		
		Session session = HibernateUtils.openCurrentSession();
		Transaction tx = null;
		boolean suc = false;

		try {
			tx = session.beginTransaction();
			session.update(w);
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

	private int insertWork(Work w) {
		Session session = HibernateUtils.openCurrentSession();
		Transaction tx = null;
		int workID = 0;

		try {
			tx = session.beginTransaction();
			workID = (Integer) session.save(w);
			tx.commit();
		} catch (HibernateException e) {
			if (tx != null)
				tx.rollback();
			e.printStackTrace();
		} finally {
			session.close();
		}
		return workID;
	}

}
