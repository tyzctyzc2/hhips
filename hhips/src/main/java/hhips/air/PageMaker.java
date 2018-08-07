package hhips.air;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import db.*;
import org.springframework.ui.Model;

public class PageMaker {
	public static Map<String, Object> prepareChapterProblems(Model model, int chapterID) {
		DBProblem myDBProblem = new DBProblem(); 
		DBProblemManagement myProblemManagementDB = new DBProblemManagement();
		Chapter chp = new Chapter();
		try {
			chp.setIdsourcechapter(chapterID);
		}
		catch (Exception e){
			chp.setIdsourcechapter(1);
		}
		Chapter cp = myProblemManagementDB.getChaperName(chp);
		String chapterName = cp.getSourcechaptername();
		String sourceName = myProblemManagementDB.getSourceName(cp.getSourceid());
		model.addAttribute("sourcename", sourceName);
		model.addAttribute("sourceid", cp.getSourceid());

		Map<String, Object> root = new HashMap<String, Object>();
		root.put("chapername", chapterName);
		model.addAttribute("chapername", chapterName);
		model.addAttribute("chapterindex", cp.getSourcechapterindex());
		root.put("chaperid", chapterID);
		model.addAttribute("chaperid", chapterID);
		List<ProblemWithLastWork> problems = myDBProblem.getProblemWithLastWorkByCharpter(chp.getIdsourcechapter());
		root.put("problems", problems);
		model.addAttribute("problems", problems);

		ArrayList<List<WorkDetail>> allWork = new ArrayList<List<WorkDetail>>();
		for(int i =0;i<problems.size();++i) {
			ProblemWithLastWork pp = problems.get(i);
			DBWork ww = new DBWork();
			List<WorkDetail> thisW = ww.getProblemAllWorkDetail(pp.getIdproblem());
			allWork.add(thisW);
		}
		model.addAttribute("works", allWork);

		if (problems.size() == 0) {
			root.put("max", -1);
			root.put("lastindex", -1);
			root.put("lastmodule", -1);
			root.put("lastlevel", -1);

			model.addAttribute("max", -1);
			model.addAttribute("lastindex", -1);
			model.addAttribute("lastmodule", -1);
			model.addAttribute("lastlevel", -1);
		}
		else {
			root.put("max", problems.size()-1);
			root.put("lastindex", problems.get(problems.size()-1).getProblemindex());
			root.put("lastmodule", problems.get(problems.size()-1).getProblemmodule());
			root.put("lastlevel", problems.get(problems.size()-1).getProblemlevel());

			model.addAttribute("max", problems.size()-1);
			model.addAttribute("lastindex", problems.get(problems.size()-1).getProblemindex());
			model.addAttribute("lastmodule", problems.get(problems.size()-1).getProblemmodule());
			model.addAttribute("lastlevel", problems.get(problems.size()-1).getProblemlevel());
		}
		
		List<Module> modules = myProblemManagementDB.getAllModule();
		root.put("modules", modules);
		root.put("maxmodule", modules.size()-1);

		model.addAttribute("modules", modules);
		model.addAttribute("maxmodule", modules.size()-1);

		DBPaper dbPaper = new DBPaper();
		List<Paper> papers = dbPaper.getAllEditPapers();
		root.put("papers", papers);
		root.put("maxpaper", papers.size()-1);

		model.addAttribute("papers", papers);
		model.addAttribute("maxpaper", papers.size()-1);

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
		Chapter cp = myProblemManagementDB.getChaperName(chp);
		String chapterName =cp.getSourcechaptername();

		Map<String, Object> root = new HashMap<String, Object>();
		root.put("chapername", chapterName);
		root.put("chaperid", chapterID);
		
		List<Module> modules = myProblemManagementDB.getAllModule();
		root.put("modules", modules);
		root.put("maxmodule", modules.size()-1);
		
		return root;
	}
	
	public static Map<String, Object> prepareProblemDetail(Model model, int problemID) {
		DBProblem myDBProblem = new DBProblem(); 
		Problem p = myDBProblem.getProblemDetail(problemID);

		model.addAttribute("lastindex", p.getProblemindex());
		model.addAttribute("lastmodule", p.getProblemmodule());
		model.addAttribute("lastlevel", p.getProblemlevel());

		Map<String, Object> root = new HashMap<String, Object>();
		root.put("problemdetail", p);
		model.addAttribute("problemdetail", p);
	
		DBWork myDBWork = new DBWork();
		List<WorkDetail> allWork = myDBWork.getProblemAllWorkDetail(problemID);
		root.put("worklength", allWork.size()-1);
		root.put("works", allWork);

		model.addAttribute("worklength", allWork.size()-1);
		model.addAttribute("works", allWork);

		DBProblemManagement myProblemManagementDB = new DBProblemManagement();
		List<Module> modules = myProblemManagementDB.getAllModule();

		model.addAttribute("modules", modules);
		model.addAttribute("maxmodule", modules.size()-1);

		Chapter cp = new Chapter();
		cp.setIdsourcechapter(p.getProblemchapterid());
		cp = myProblemManagementDB.getChaperName(cp);
		String chapterName = cp.getSourcechaptername();
		model.addAttribute("chapterName", chapterName);
		model.addAttribute("chapterIndex", cp.getSourcechapterindex());

		String sourceName = myProblemManagementDB.getSourceName(cp.getSourceid());
		model.addAttribute("sourceName", sourceName);
		model.addAttribute("sourceId", cp.getSourceid());

		DBPaper dbPaper = new DBPaper();
		List<ProblemByPaper> pbp = dbPaper.getProblemActivePaper(problemID);
		model.addAttribute("inActivePaper", pbp);

		return root;
	}
	
	public static Map<String, Object> preparePaperList(Model model) {
		DBPaper dbPaper = new DBPaper();
		
		Map<String, Object> root = new HashMap<String, Object>();
		
		List<Paper> allWork = dbPaper.getAllPapers();
		root.put("paperlength", allWork.size()-1);
		root.put("papers", allWork);

        model.addAttribute("paperlength", allWork.size()-1);
        model.addAttribute("papers", allWork);
		
		return root;
	}
	
	public static void preparePaperProblemList(Model model, String activeParameter) {
		DBProblem myDBProblem = new DBProblem(); 
		List<ProblemByPaper> problems = myDBProblem.getPaperProblemList(activeParameter);

		ArrayList<List<WorkDetail>> allWork = new ArrayList<List<WorkDetail>>();
		List<Integer> problemStar = new ArrayList<>();
		for(int i =0;i<problems.size();++i) {
			ProblemByPaper pp = problems.get(i);
			DBWork ww = new DBWork();
			List<WorkDetail> thisW = ww.getPaperProblemWork(Integer.parseInt(activeParameter), pp.getIdproblem());
			allWork.add(thisW);

			int thisStar = 0;
			for (WorkDetail wwd:thisW) {
				if (wwd.getIdstarreason() !=null)
					thisStar = wwd.getIdstarreason();
			}
			problemStar.add(thisStar);
		}

		model.addAttribute("problems", problems);
		model.addAttribute("works", allWork);
        model.addAttribute("stars", problemStar);
		
		System.out.println("paper problem ==== " + problems.size());
	
        model.addAttribute("papername", "Active Problems");
		if (problems.size() == 0) {
			model.addAttribute("max", -1);
		}
		else {
			model.addAttribute("max", problems.size()-1);
			model.addAttribute("papername", problems.get(0).getPapername());
		}

		DBReason dbReason = new DBReason();
		model.addAttribute("allReason", dbReason.getAllReason());
		model.addAttribute("allStarReason", dbReason.getAllStarReason());
	}

	public static Map<String, Object> prepareChapterList(Model model, int sourceID) {
		DBProblemManagement myProblemManagementDB = new DBProblemManagement();
		
		String sourceName = myProblemManagementDB.getSourceName(sourceID);
		System.out.println(String.valueOf(sourceID));
		System.out.println(sourceName);

		Map<String, Object> root = new HashMap<String, Object>();
	
		//List<SourceChapter> allWork = myProblemManagementDB.getChapterList(sourceID);
		List<SourceChapterSummary> allWork = myProblemManagementDB.getChapterSummaryList(sourceID);
		root.put("chapterlength", allWork.size()-1);
		root.put("chapters", allWork);
		root.put("sourcename", sourceName);
		root.put("sourceid", sourceID);
		root.put("newchapterindex", allWork.size()+1);

		model.addAttribute("chapterlength", allWork.size()-1);
		model.addAttribute("chapters", allWork);
		model.addAttribute("sourcename", sourceName);
		model.addAttribute("sourceid", sourceID);
		model.addAttribute("newchapterindex", allWork.size()+1);
		
		return root;
	}
	
	public static Map<String, Object> prepareSourceList(Model model) {
		DBProblemManagement mySourceDB = new DBProblemManagement();
		
		Map<String, Object> root = new HashMap<String, Object>();
		
		List<db.Source> allWork = mySourceDB.getAllSource();
		root.put("sourcelength", allWork.size()-1);
		root.put("sources", allWork);

		model.addAttribute("sourcelength", allWork.size()-1);
		model.addAttribute("sources", allWork);
		
		return root;
	}
}
