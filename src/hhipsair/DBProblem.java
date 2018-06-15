package hhipsair;

import org.json.*;

import db.Problem;
import db.Problem.ProblemColumnName;
import db.ProblemByPaper;
import db.ProblemWithWork;

import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

import java.io.DataOutputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Base64;
import java.util.Date;
import java.util.List;


public class DBProblem {
	SessionFactory factory;

	public DBProblem() {
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
	
	public Problem getProblemDetail(int problemID) {
		Session session = factory.openSession();
		Problem p = session.get(Problem.class, problemID);
		return p;
	}
	
	public boolean activeProblem(int problemID, int activeLevel) {
		Session session = factory.openSession();
		Problem p = session.get(Problem.class, problemID);
		p.setProblemcisactive(activeLevel);

		this.updateProbelm(p);
		return true;
	}
	
	public boolean deleteProblem(int problemID) {
		Session session = factory.openSession();
		Problem p = session.get(Problem.class, problemID);

		this.deleteProbelm(p);
		return true;
	}
	
	public String getNextActiveProblem() {
		Session session = factory.openSession();

		Criteria cr = session.createCriteria(ProblemByPaper.class);
		cr.add(Restrictions.eq("isactive", 2));//paper is active
		cr.add(Restrictions.eq("problemstatus", 1));
		List<ProblemByPaper> results = cr.list();
		if (results.size() == 0)
			return "";
		ProblemByPaper p =  results.get(0);
		String img = FileHelper.getBase64String(p.getProblemdetail());
		p.setProblemdetail(img);
		return p.toString();
	}
	
	public List<ProblemByPaper> getActiveProblemList(String paperID) {
		
		Session session = factory.openSession();

		Criteria cr = session.createCriteria(ProblemByPaper.class);
		cr.add(Restrictions.eq("idpaper", paperID));
		List<ProblemByPaper> results = cr.list();
		return results;	
	}
	
	public List<ProblemByPaper> getPaperProblemList(String paperID) {
		
		Session session = factory.openSession();

		Criteria cr = session.createCriteria(ProblemByPaper.class);
		cr.add(Restrictions.eq("idpaper", Integer.parseInt(paperID)));
		List<ProblemByPaper> results = cr.list();
		return results;	
	}

	public boolean PushProblem(String problemJSON) {
		if (factory == null)
			return false;

		System.out.println("save new problem request...");
		String log = "";
		try {
			JSONObject jsonObject = new JSONObject(problemJSON);
			Problem p = new Problem();
			if (jsonObject.has(ProblemColumnName.problemlevel.toString()) == true) {
				p.setProblemlevel(jsonObject.getInt(ProblemColumnName.problemlevel.toString()));
				log = log + ProblemColumnName.problemlevel.toString() + "=" + p.getProblemlevel().toString() + ";";
			}
			if (jsonObject.has(ProblemColumnName.problemchapterid.toString()) == true) {
				p.setProblemchapterid(jsonObject.getInt(ProblemColumnName.problemchapterid.toString()));
				log = log + ProblemColumnName.problemchapterid.toString() + "=" + p.getProblemchapterid().toString() + ";";
			}
			if (jsonObject.has(ProblemColumnName.problemindex.toString()) == true) {
				p.setProblemindex(jsonObject.getString(ProblemColumnName.problemindex.toString()));
				log = log + ProblemColumnName.problemindex.toString() + "=" + p.getProblemindex() + ";";
			}
			if (jsonObject.has(ProblemColumnName.problemmodule.toString()) == true) {
				p.setProblemmodule(jsonObject.getInt(ProblemColumnName.problemmodule.toString()));
				log = log + ProblemColumnName.problemmodule.toString() + "=" + p.getProblemmodule().toString() + ";";
			}
			if (jsonObject.has(ProblemColumnName.problemanswerstring.toString()) == true) {
				p.setProblemanswerstring(jsonObject.getString(ProblemColumnName.problemanswerstring.toString()));
				log = log + ProblemColumnName.problemanswerstring.toString() + "=" + p.getProblemanswerstring() + ";";
			}
			if (jsonObject.has(ProblemColumnName.problemcisactive.toString()) == true)
				p.setProblemcisactive(jsonObject.getInt(ProblemColumnName.problemcisactive.toString()));

			int pID = insertProbelm(p);
			System.out.println(log);

			p.setIdproblem(pID);
			boolean needUpdate = false;
			if (jsonObject.has(ProblemColumnName.problemdetail.toString()) == true) {
				if (jsonObject.getString(ProblemColumnName.problemdetail.toString()).length() > 1) {
					p.setProblemdetail(FileHelper.saveBase64File(jsonObject.getString(ProblemColumnName.problemdetail.toString()), "p", pID));
					needUpdate = true;
				}
			}

			if (jsonObject.has(ProblemColumnName.problemanswerdetail.toString()) == true) {
				if (jsonObject.getString(ProblemColumnName.problemanswerdetail.toString()).length() > 1) {
					p.setProblemanswerdetail(FileHelper.saveBase64File(jsonObject.getString(ProblemColumnName.problemanswerdetail.toString()), "a", pID));
					needUpdate = true;
				}
			}

			if (needUpdate == false)
				return true;
			updateProbelm(p);

		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return true;
	}

	int insertProbelm(Problem p) {
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

	public List<ProblemWithWork> getProblemByCharpter(int chapterID) {
		Session session = factory.openSession();

		Criteria cr = session.createCriteria(ProblemWithWork.class);
		cr.add(Restrictions.eq("problemchapterid", chapterID));
		List<ProblemWithWork> results = cr.list();
		return results;
	}

	boolean updateProbelm(Problem p) {
		Session session = factory.openSession();
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
		Session session = factory.openSession();
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
