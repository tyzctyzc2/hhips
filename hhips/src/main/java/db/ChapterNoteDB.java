package db;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import uti.FileHelper;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import java.util.Date;
import java.util.List;

@Service
public class ChapterNoteDB {
    public List<ChapterNote> getChapterNoteBase64(Integer idsourcechapter) {
        List<ChapterNote> allNotes = getChapterNote(idsourcechapter);

        for(int i = 0; i < allNotes.size(); ++i) {
            String img = FileHelper.getBase64String(allNotes.get(i).getChapternotedetail());
            allNotes.get(i).setChapternotedetail(img);
        }

        return  allNotes;
    }

    public List<ChapterNote> getChapterNote(Integer idsourcechapter) {
        Session session = HibernateUtils.openCurrentSession();

        session.beginTransaction();
        List<ChapterNote> all;

        try {
            CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
            CriteriaQuery<ChapterNote> criteriaQuery = criteriaBuilder.createQuery(ChapterNote.class);
            Root<ChapterNote> itemRoot = criteriaQuery.from(ChapterNote.class);
            criteriaQuery.select(itemRoot).where(criteriaBuilder.equal(itemRoot.get("idsourcechapter"), idsourcechapter));
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

    public ChapterNote createNewNote(ChapterNote chapterNote) {
        int newNoteId = 0;
        String img = chapterNote.getChapternotedetail();
        chapterNote.setChapternotedetail("");
        chapterNote.setChapternotetime(new Date());
        newNoteId = insertNote(chapterNote);

        if (newNoteId == 0) {
            chapterNote.setIdchapternote(0);
            return chapterNote;
        }

        chapterNote.setIdchapternote(newNoteId);
        chapterNote.setChapternotedetail(FileHelper.saveBase64File(img, "n", newNoteId));
        updateNote(chapterNote);
        return chapterNote;
    }

    private  void updateNote(ChapterNote chapterNote) {
        Session session = HibernateUtils.openCurrentSession();
        Transaction tx = null;
        boolean suc = false;

        try {
            tx = session.beginTransaction();
            session.update(chapterNote);
            tx.commit();
        } catch (HibernateException e) {
            if (tx != null)
                tx.rollback();
            e.printStackTrace();
        } finally {
            session.close();
        }
    }

    private int insertNote(ChapterNote chapterNote) {
        Session session = HibernateUtils.openCurrentSession();
        Transaction tx = null;
        int noteId = 0;

        try {
            tx = session.beginTransaction();
            noteId = (Integer) session.save(chapterNote);
            tx.commit();
        } catch (HibernateException e) {
            if (tx != null)
                tx.rollback();
            e.printStackTrace();
        } finally {
            session.close();
        }
        return noteId;
    }
}
