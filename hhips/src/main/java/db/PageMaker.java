package db;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import db.Chapter;
import db.Module;
import db.Paper;
import db.Problem;
import db.ProblemByPaper;
import db.ProblemWithLastWork;
import db.ProblemWithWork;
import db.SourceChapter;
import db.Work;

public class PageMaker {
    public static Map<String, Object> prepareSourceList() {
        DBProblemManagement mySourceDB = new DBProblemManagement();

        Map<String, Object> root = new HashMap<String, Object>();

        List<db.Source> allWork = mySourceDB.getAllSource();
        root.put("sourcelength", allWork.size()-1);
        root.put("sources", allWork);

        return root;
    }
}
