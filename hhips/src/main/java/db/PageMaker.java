package db;

import dbmodel.Source;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PageMaker {
    public static Map<String, Object> prepareSourceList() {
        DBProblemManagement mySourceDB = new DBProblemManagement();

        Map<String, Object> root = new HashMap<String, Object>();

        List<Source> allWork = mySourceDB.getAllSource();
        root.put("sourcelength", allWork.size()-1);
        root.put("sources", allWork);

        return root;
    }
}
