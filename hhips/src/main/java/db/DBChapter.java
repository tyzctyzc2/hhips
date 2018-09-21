package db;

import javafx.util.Pair;
import org.hibernate.Session;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import java.util.List;

public class DBChapter {
    public Pair<Integer, Integer> getChapterBeforeAfter(int chapterID, int sourceID) {
        Session session = HibernateUtils.openCurrentSession();

        session.beginTransaction();
        List<Chapter> all;
        Pair<Integer, Integer> beforeAndAfter = new Pair<Integer, Integer>(0,0);
        int before = 0;
        int after = 0;

        try {
            CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
            CriteriaQuery<Chapter> criteriaQuery = criteriaBuilder.createQuery(Chapter.class);
            Root<Chapter> itemRoot = criteriaQuery.from(Chapter.class);
            criteriaQuery.select(itemRoot).where(criteriaBuilder.equal(itemRoot.get("sourceid"), sourceID));

            all = session.createQuery(criteriaQuery).getResultList();

            session.getTransaction().commit();

            int index = -1;
            for(int i = 0; i < all.size(); ++i) {
                int curID = all.get(i).getIdsourcechapter();
                if ( curID == chapterID) {
                    index = i;
                    break;
                }
            }

            if (index > -1) {
                if (index > 0)
                    before = all.get(index - 1).getIdsourcechapter();
                if (index < (all.size() - 1)) {
                    after = all.get(index+1).getIdsourcechapter();
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
}
