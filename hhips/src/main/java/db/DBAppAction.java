package db;

import model.AppAction;
import org.hibernate.Session;
import org.springframework.stereotype.Service;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import java.util.List;

@Service
public class DBAppAction {
    public void saveAppAction(AppAction action) {
        Session session = HibernateUtils.openCurrentSession();

        session.beginTransaction();
        try {
            session.save(action);
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
}
