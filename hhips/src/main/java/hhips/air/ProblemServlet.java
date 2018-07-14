package hhips.air;

import db.DBProblem;
import db.DBProblemManagement;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@Controller
//@RequestMapping("/hhipsair")
public class ProblemServlet {
    @GetMapping("/Problem")
    public String processProblemGet(Model model, @RequestParam(value="paperid", required=false, defaultValue="0") String paperID,
                                    @RequestParam(value="chapterid", required=false, defaultValue="0") int chapterID,
                                    @RequestParam(value="showanswer", required=false, defaultValue="0") int showAnswer,
                                    @RequestParam(value="problemid", required=false, defaultValue="0") String problemId,
                                    @RequestParam(value="active", required=false, defaultValue="") String active,
                                    @RequestParam(value="idpaper", required=false, defaultValue="") String idpaper) {
        System.out.println("ProblemServlet - problem request");

        if (paperID.compareTo("0") !=0)
            return getPaperRelated(model, paperID, showAnswer);

        if (problemId.compareTo("0") !=0)
            return getProblemDetailCase(model, problemId);

        if (active.length() > 0) {
            if (idpaper.length() > 0)
                return getProblemNextActiveInPaper(model, active, idpaper);
            else
                return getProblemNextActive(model, active);
        }

        return "error";
    }

    private String getProblemNextActiveInPaper(Model model, String active, String idpaper) {
        System.out.println("ProblemServlet - get active problem in paper " + idpaper);
        DBProblem dbProblem = new DBProblem();
        String pp = dbProblem.getNextActiveProblemInPaper(idpaper);

        model.addAttribute("txt", pp);

        return  "textmsg";
    }

    private String getProblemNextActive(Model model, String active) {
        DBProblem dbProblem = new DBProblem();
        String pp = dbProblem.getNextActiveProblem();

        model.addAttribute("txt", pp);

        return  "textmsg";
    }

    private String getProblemDetailCase(Model model, String problemId) {
        System.out.println("ProblemServlet -- get problem detail " + problemId);
        int iPID = 0;

        try {
            iPID = Integer.parseInt(problemId.replaceAll(",",""));
        } catch (Exception e) {
            return "error";
        }
        PageMaker.prepareProblemDetail(model, iPID);

        return "problemdetail";
    }

    private String getPaperRelated(Model model, String paperID, int showAnswer) {
        System.out.println("ProblemServlet - get paper problem request " + paperID);

        if (showAnswer != 0)
            showAnswer = 1;
        if (paperID.indexOf("-1") > -1) {
            System.out.println("ProblemServlet -- get all paper list");
            return getPaperList(model);
        }
        else {
            System.out.println("ProblemServlet -- get paper list of " + paperID);
            return getPaperProblemList(model, paperID, showAnswer);
        }
    }

    private String getPaperProblemList(Model model, String paperID, int showAnswer) {
        Map<String, Object> root = PageMaker.preparePaperProblemList(model, paperID);

        root.put("showAnswer", showAnswer);
        model.addAttribute("showAnswer", showAnswer);

        return "paperproblemlist";
    }

    private String getPaperList(Model model) {
        Map<String, Object> root = PageMaker.preparePaperList(model);
        return "paperlist";
    }

    String JSON_RESPONSE_KEY_SUCCESS = "SUCCESS";

    @PostMapping("/Problem/new")
    public @ResponseBody String createProblem(@RequestBody String stringToParse) {
        System.out.println("ProblemServlet -- post create new problem");
        JSONObject res = new JSONObject();
        try {
            JSONObject jsonObject = new JSONObject(stringToParse.toString());
            DBProblem dbProblem = new DBProblem();
            System.out.println("ProblemServlet - create new problem request");
            Integer newProblemID =dbProblem.PushProblem(jsonObject);
            if (newProblemID == 0) {
                res.append(JSON_RESPONSE_KEY_SUCCESS, false);
            }
            else {
                res.append(JSON_RESPONSE_KEY_SUCCESS, true);
            }

        } catch (JSONException e) {
            System.out.println(stringToParse);
            e.printStackTrace();
            res.append(JSON_RESPONSE_KEY_SUCCESS, false);
        }

        return res.toString();
    }

    @PostMapping("/Problem")
    public @ResponseBody  String problemChangeRequest(
            @RequestParam(value="active", required=false, defaultValue="0") Integer active,@RequestParam(value="problemid", required=false, defaultValue="0") Integer problemid,@RequestParam(value="paperid", required=false, defaultValue="0") Integer paperid,
            @RequestParam(value="problemstatus", required=false, defaultValue="0") Integer problemstatus, @RequestParam(value="paperproblemid", required=false, defaultValue="0") Integer paperproblemid,
            @RequestParam(value="delete", required=false, defaultValue="0") Integer delete)
    {
        System.out.println("ProblemServlet - post change request");
        if (paperid != 0)
            doActiveProblem(problemid, active, paperid);

        if (paperproblemid != 0)
            doChangeProblemStatus(problemid, paperproblemid, problemstatus);

        if (delete != 0) {
            DBProblem dbProblem = new DBProblem();
            dbProblem.deleteProblem(delete);
        }

        JSONObject res = new JSONObject();
        res.append(JSON_RESPONSE_KEY_SUCCESS, false);
        return res.toString();
    }

    private void doChangeProblemStatus(int problemid, int paperproblemid, int problemstatus) {
        System.out.println("ProblemServlet - change paper problem status paperproblemid=" + paperproblemid + " problemstatus " + problemstatus);
        DBProblemManagement dbProblemManagement = new DBProblemManagement();
        dbProblemManagement.ChangeProblemPaperStatus(problemid, paperproblemid, problemstatus);
    }

    private void doActiveProblem(int problemID, int activeLevel, int paperID) {
        System.out.println("ProblemServlet - add " + problemID + " to paper " + paperID);
        DBProblemManagement dbProblemManagement = new DBProblemManagement();
        dbProblemManagement.createPaperProblem(problemID, paperID);
    }
}
