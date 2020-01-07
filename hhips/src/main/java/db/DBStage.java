package db;

import dbmodel.Source;
import dbmodel.Stage;
import org.hibernate.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import repository.StageRepository;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import java.util.List;

@Service
public class DBStage {
    public List<Stage> getAllStage() {
        Session session = HibernateUtils.openCurrentSession();

        session.beginTransaction();
        List<Stage> all;
        try {
            CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
            CriteriaQuery<Stage> criteriaQuery = criteriaBuilder.createQuery(Stage.class);
            Root<Stage> itemRoot = criteriaQuery.from(Stage.class);
            criteriaQuery.select(itemRoot);
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
}
