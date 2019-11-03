package db;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.stereotype.Service;

@Service
public class DBWorkCorrect {
    public void insertWorkCorrect(Integer workId) {
        WorkCorrect workCorrect = new WorkCorrect();
        workCorrect.setWorkid(workId);
        Session session = HibernateUtils.openCurrentSession();
        Transaction tx = null;
        int workID = 0;

        try {
            tx = session.beginTransaction();
            workID = (Integer) session.save(workCorrect);
            tx.commit();
        } catch (HibernateException e) {
            if (tx != null)
                tx.rollback();
            e.printStackTrace();
        } finally {
            session.close();
        }
    }

    public void removeWorkCorrect(Integer workId) {
        WorkCorrect workCorrect = new WorkCorrect();
        workCorrect.setWorkid(workId);
        Session session = HibernateUtils.openCurrentSession();
        Transaction tx = null;

        try {
            tx = session.beginTransaction();
            session.delete(workCorrect);
            tx.commit();
        } catch (HibernateException e) {
            if (tx != null)
                tx.rollback();
            e.printStackTrace();
        } finally {
            session.close();
        }
    }

    public WorkCorrect getWorkCorrect(Integer workId) {
        Session session = HibernateUtils.openCurrentSession();
        Transaction tx = null;
        WorkCorrect workCorrect = null;

        try {
            tx = session.beginTransaction();
            workCorrect = (WorkCorrect) session.get(WorkCorrect.class, workId);
            tx.commit();
        } catch (HibernateException e) {
            if (tx != null)
                tx.rollback();
            e.printStackTrace();
        } finally {
            session.close();
        }
        return workCorrect;
    }
}
