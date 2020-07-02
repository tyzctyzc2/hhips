package db;

import dbmodel.EnglishPart;
import dbmodel.EnglishWord;
import dbmodel.EnglishWordPart;
import dbmodel.EnglishWordView;
import json.WordCreateRequest;
import org.hibernate.Session;
import org.springframework.stereotype.Service;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import java.util.ArrayList;
import java.util.List;

@Service
public class DBEnglish {
    public boolean createAllWord(WordCreateRequest wordCreateRequest) {
        Integer wordId = createWord(wordCreateRequest);
        EnglishWordPart englishWordPart = new EnglishWordPart();
        englishWordPart.setIdpart(wordCreateRequest.getPartId());
        englishWordPart.setIdword(wordId);
        createWordPart(englishWordPart);
        return true;
    }
    private Integer createWordPart(EnglishWordPart englishWordPart) {
        Session session = HibernateUtils.openCurrentSession();
        session.beginTransaction();

        try {
            session.save(englishWordPart);
            session.getTransaction().commit();
        }
        catch ( RuntimeException e ) {
            session.getTransaction().rollback();
            throw e;
        }
        finally {
            session.close();
        }
        return englishWordPart.getIdpartword();
    }

    private Integer createWord(WordCreateRequest wordCreateRequest) {
        EnglishWord englishWord = new EnglishWord(wordCreateRequest);
        Session session = HibernateUtils.openCurrentSession();

        session.beginTransaction();

        try {
            session.save(englishWord);
            session.getTransaction().commit();
        }
        catch ( RuntimeException e ) {
            session.getTransaction().rollback();
            throw e;
        }
        finally {
            session.close();
        }
        return englishWord.getIdword();
    }

    public List<EnglishWordView> getPartDetailList(Integer partId) {
        Session session = HibernateUtils.openCurrentSession();

        session.beginTransaction();
        List<EnglishWordView> all = new ArrayList<>();

        try {
            CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
            CriteriaQuery<EnglishWordView> criteriaQuery = criteriaBuilder.createQuery(EnglishWordView.class);
            Root<EnglishWordView> itemRoot = criteriaQuery.from(EnglishWordView.class);
            criteriaQuery.select(itemRoot).where(criteriaBuilder.equal(itemRoot.get("idpart"), partId));
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

        all.forEach(ev -> ev.setMeaning(ev.getMeaning().replaceAll("\r\n", "").replaceAll("　", "").trim()));

        return all;
    }

    public List<EnglishPart> getPartList() {
        Session session = HibernateUtils.openCurrentSession();

        session.beginTransaction();
        List<EnglishPart> all = new ArrayList<>();

        try {
            CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
            CriteriaQuery<EnglishPart> criteriaQuery = criteriaBuilder.createQuery(EnglishPart.class);
            Root<EnglishPart> itemRoot = criteriaQuery.from(EnglishPart.class);
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

    public List<EnglishWordView> getWordHistory(String wordText) {
        Session session = HibernateUtils.openCurrentSession();

        session.beginTransaction();
        List<EnglishWordView> all = new ArrayList<>();

        try {
            CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
            CriteriaQuery<EnglishWordView> criteriaQuery = criteriaBuilder.createQuery(EnglishWordView.class);
            Root<EnglishWordView> itemRoot = criteriaQuery.from(EnglishWordView.class);
            criteriaQuery.select(itemRoot).where(criteriaBuilder.equal(itemRoot.get("word"), wordText));
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
