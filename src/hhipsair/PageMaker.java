package hhipsair;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import db.Chapter;
import db.Module;
import db.Paper;
import db.Problem;
import db.ProblemByPaper;
import db.ProblemWithWork;
import db.SourceChapter;
import db.Work;

public class PageMaker {
	public static Map<String, Object> prepareChapterProblems(int chapterID) {
		DBProblem myDBProblem = new DBProblem(); 
		DBProblemManagement myProblemManagementDB = new DBProblemManagement();
		Chapter chp = new Chapter();
		try {
			chp.setIdsourcechapter(chapterID);
		}
		catch (Exception e){
			chp.setIdsourcechapter(1);
		}
		String chapterName = myProblemManagementDB.getChaperName(chp);

		Map<String, Object> root = new HashMap<String, Object>();
		root.put("chapername", chapterName);
		root.put("chaperid", chapterID);
		List<ProblemWithWork> problems = myDBProblem.getProblemByCharpter(chp.getIdsourcechapter());
		root.put("problems", problems);
		if (problems.size() == 0) {
			root.put("max", -1);
			root.put("lastindex", -1);
			root.put("lastmodule", -1);
			root.put("lastlevel", -1);
		}
		else {
			root.put("max", problems.size()-1);
			root.put("lastindex", problems.get(problems.size()-1).getProblemindex());
			root.put("lastmodule", problems.get(problems.size()-1).getProblemmodule());
			root.put("lastlevel", problems.get(problems.size()-1).getProblemlevel());
		}
		
		List<Module> modules = myProblemManagementDB.getAllModule();
		root.put("modules", modules);
		root.put("maxmodule", modules.size()-1);
		
		List<Paper> papers = myProblemManagementDB.getAllEditPapers();
		root.put("papers", papers);
		root.put("maxpaper", papers.size()-1);
		
		return root;
	}

	public static Map<String, Object> prepareNewProblemData(int chapterID) {
		DBProblemManagement myProblemManagementDB = new DBProblemManagement(); 
		Chapter chp = new Chapter();
		try {
			chp.setIdsourcechapter(chapterID);
		}
		catch (Exception e){
			chp.setIdsourcechapter(1);
		}
		String chapterName = myProblemManagementDB.getChaperName(chp);

		Map<String, Object> root = new HashMap<String, Object>();
		root.put("chapername", chapterName);
		root.put("chaperid", chapterID);
		
		List<Module> modules = myProblemManagementDB.getAllModule();
		root.put("modules", modules);
		root.put("maxmodule", modules.size()-1);
		
		return root;
	}
	
	public static Map<String, Object> prepareProblemDetail(int problemID) {
		DBProblem myDBProblem = new DBProblem(); 
		Problem p = myDBProblem.getProblemDetail(problemID);

		Map<String, Object> root = new HashMap<String, Object>();
		root.put("problemdetail", p);
	
		DBWork myDBWork = new DBWork();
		List<Work> allWork = myDBWork.getProblemAllWork(problemID);
		root.put("worklength", allWork.size()-1);
		root.put("works", allWork);
		
		return root;
	}
	
	public static Map<String, Object> preparePaperList() {
		DBProblemManagement mySourceDB = new DBProblemManagement();
		
		Map<String, Object> root = new HashMap<String, Object>();
		
		List<db.Paper> allWork = mySourceDB.getAllPapers();
		root.put("paperlength", allWork.size()-1);
		root.put("papers", allWork);
		
		return root;
	}
	
	public static Map<String, Object> preparePaperProblemList(String activeParameter) {
		DBProblem myDBProblem = new DBProblem(); 
		List<ProblemByPaper> problems = myDBProblem.getPaperProblemList(activeParameter);

		Map<String, Object> root = new HashMap<String, Object>();
		root.put("problems", problems);
		
		System.out.println("paper problem ==== " + problems.size());
	
		root.put("papername", "Active Problems");
		if (problems.size() == 0) {
			root.put("max", -1);
		}
		else {
			root.put("max", problems.size()-1);
			root.put("papername", problems.get(0).getPapername());
		}
		return root;
	}

	public static Map<String, Object> prepareChapterList(int sourceID) {
		DBProblemManagement myProblemManagementDB = new DBProblemManagement();
		
		String sourceName = myProblemManagementDB.getSourceName(sourceID);
		System.out.println(String.valueOf(sourceID));
		System.out.println(sourceName);

		Map<String, Object> root = new HashMap<String, Object>();
	
		List<SourceChapter> allWork = myProblemManagementDB.getChapterList(sourceID);
		root.put("chapterlength", allWork.size()-1);
		root.put("chapters", allWork);
		root.put("sourcename", sourceName);
		root.put("sourceid", sourceID);
		root.put("newchapterindex", allWork.size()+1);
		
		return root;
	}
	
	public static Map<String, Object> prepareSourceList() {
		DBProblemManagement mySourceDB = new DBProblemManagement();
		
		Map<String, Object> root = new HashMap<String, Object>();
		
		List<db.Source> allWork = mySourceDB.getAllSource();
		root.put("sourcelength", allWork.size()-1);
		root.put("sources", allWork);
		
		return root;
	}
}
