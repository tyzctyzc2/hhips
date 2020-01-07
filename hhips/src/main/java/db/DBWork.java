package db;

import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;

import dbmodel.Work;
import dbmodel.WorkDetail;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.json.JSONException;
import org.json.JSONObject;

import dbmodel.Work.WorkColumnName;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import uti.FileHelper;

@Service
public class DBWork {
	public static String absolutePath = "";
	private static final org.slf4j.Logger logger = LoggerFactory.getLogger(DBWork.class);

	public DBWork() {
	}

	public static Date getLastDateOfMonth(Date date){
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		cal.set(Calendar.DAY_OF_MONTH, cal.getActualMaximum(Calendar.DAY_OF_MONTH));
		return cal.getTime();
	}

	public int getDayReason(Date wantDay) {
		DateFormat dfStart = new SimpleDateFormat("yyyy-MM-dd 00:00:00");
		String startDate = dfStart.format(wantDay);

		DateFormat dfEnd = new SimpleDateFormat("yyyy-MM-dd 23:59:59");
		String endDate = dfEnd.format(wantDay);

		String sql = "SELECT sum(reasonfactor) cnt FROM hhips.v_workbypaper where workdate>'" + startDate + "'" + " and workdate<'" + endDate + "'";
		return doGetReason(sql);
	}

	public int getMonthReason(Date wantDay) {
		DateFormat dfStart = new SimpleDateFormat("yyyy-MM-01 00:00:00");
		String startDate = dfStart.format(wantDay);

		DateFormat dfEnd = new SimpleDateFormat("yyyy-MM-dd 23:59:59");
		String endDate = dfEnd.format(DBWork.getLastDateOfMonth(wantDay));

		String sql = "SELECT sum(reasonfactor) cnt FROM hhips.v_workbypaper where workdate>'" + startDate + "'" + " and workdate<'" + endDate + "'";
		return doGetReason(sql);
	}

	public int getDayStar(Date wantDay) {
		DateFormat dfStart = new SimpleDateFormat("yyyy-MM-dd 00:00:00");
		String startDate = dfStart.format(wantDay);

		DateFormat dfEnd = new SimpleDateFormat("yyyy-MM-dd 23:59:59");
		String endDate = dfEnd.format(wantDay);

		String sql = "SELECT sum(starreasonfactor) cnt FROM hhips.v_workbypaper where workdate>'" + startDate + "'" + " and workdate<'" + endDate + "'";
		return doGetReason(sql);
	}

	public int getMonthStar(Date wantDay) {
		DateFormat dfStart = new SimpleDateFormat("yyyy-MM-01 00:00:00");
		String startDate = dfStart.format(wantDay);

		DateFormat dfEnd = new SimpleDateFormat("yyyy-MM-dd 23:59:59");
		String endDate = dfEnd.format(DBWork.getLastDateOfMonth(wantDay));

		String sql = "SELECT sum(starreasonfactor) cnt FROM hhips.v_workbypaper where workdate>'" + startDate + "'" + " and workdate<'" + endDate + "'";
		return doGetReason(sql);
	}

	private int doGetReason(String sql) {
		List<Object[]> cnt = null;
		Session session = HibernateUtils.openCurrentSession();
		try {
			session.beginTransaction();
			cnt = (List<Object[]>) session.createSQLQuery(sql)
					.addScalar("cnt")
					.setFirstResult(0).setMaxResults(20)
					.list();
		} catch (Exception e) {
		}
		finally {
			session.getTransaction().commit();
			session.close();
		}

		if (cnt.get(0) == null)
			return 0;
		Object cc = cnt.get(0);
		BigDecimal bb = (BigDecimal) cc;
		return bb.intValue();
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

	public List<Work> getOldWork(Integer dayBefore) {
		Session session = HibernateUtils.openCurrentSession();

		session.beginTransaction();
		List<Work> all;
		try {
			CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
			CriteriaQuery<Work> criteriaQuery = criteriaBuilder.createQuery(Work.class);
			Root<Work> itemRoot = criteriaQuery.from(Work.class);
			LocalDate now = LocalDate.now();
			now.minusDays(dayBefore);
			criteriaQuery.select(itemRoot).where(criteriaBuilder.lessThan(itemRoot.get("workdate"), now));
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
					logger.error(e.toString());
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

	public boolean updateWorkUsedTime(int idWork, int addSecond) {

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
		w.setUsedtime(w.getUsedtime() + addSecond);
		updateWork(w);
		return true;
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
