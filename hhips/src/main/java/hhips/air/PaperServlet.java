package hhips.air;

import db.DBPaper;
import db.DBProblem;
import db.DBProblemManagement;
import db.Paper;
import jdk.nashorn.internal.parser.JSONParser;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import uti.StringHelper;

import java.util.List;


@Controller
//@RequestMapping("/hhipsair")
public class PaperServlet {
    private static final org.slf4j.Logger logger = LoggerFactory.getLogger(PaperServlet.class);
    String JSON_RESPONSE_KEY_SUCCESS = "SUCCESS";
    @GetMapping("/Paper/active")
    public @ResponseBody String getActivePaper(Model model, @RequestParam(value="paperid", required=false, defaultValue="0") String paperID) {
        logger.info("PaperServlet - get active !");
        model.addAttribute("today", StringHelper.GetDateString());

        DBPaper dbPaper = new DBPaper();
        List<Paper> ll = dbPaper.getAllActivePapers();
        JSONArray ary = new JSONArray();
        for (Paper p: ll)
            ary.put(p);

        model.addAttribute("txt", ary.toString());
        JSONObject jo = new JSONObject();

        return  ary.toString();
    }

    //active all problems in a paper
    @PostMapping("/Paper/addchapter2paper")
    public @ResponseBody String addChapter2Paper(Model model, @RequestParam(value="chapterid", required=false, defaultValue="0") Integer chapterid,
                                                 @RequestParam(value="paperid", required=false, defaultValue="0") Integer paperid) {
        logger.info("PaperServlet - [addchapter2paper] paper request " + paperid);
        System.out.println("PaperServlet - [addchapter2paper] paper request " + paperid);
        JSONObject res = new JSONObject();

        DBProblemManagement pm = new DBProblemManagement();
        pm.insertPaperWholeChapter(chapterid, paperid);
        res.append(JSON_RESPONSE_KEY_SUCCESS, false);
        return res.toString();
    }

    //active all problems in a paper
    @PostMapping("/Paper/activewholeproblem")
    public @ResponseBody String activeWholePaperRequest(Model model, @RequestParam(value="idpaper", required=false, defaultValue="0") Integer paperID) {
        logger.info("PaperServlet - [activeWholePaperRequest] paper problem request " + paperID);
        System.out.println("PaperServlet - [activeWholePaperRequest] paper problem request " + paperID);
        JSONObject res = new JSONObject();

        DBProblemManagement pm = new DBProblemManagement();
        pm.changeAllPaperProblemStatus(paperID, 1);
        res.append(JSON_RESPONSE_KEY_SUCCESS, false);
        return res.toString();
    }

    @PostMapping("/Paper")
    public @ResponseBody String changePaperRequest(@RequestBody String stringToParse) {
        JSONObject res = new JSONObject();
        try {
            JSONObject jsonObject = new JSONObject(stringToParse.toString());

            if (jsonObject.has("isactive") == true) {
                System.out.println("PaperServlet - change paper isactive");
                logger.info("PaperServlet - change paper isactive");
                doChangePaperIsactive(jsonObject.getInt("idpaper"), jsonObject.getInt("isactive"));
                res.append(JSON_RESPONSE_KEY_SUCCESS, true);
                return res.toString();

            }
            else if (jsonObject.has("papername") == true) {
                System.out.println("PaperServlet - create new paper");
                logger.info("PaperServlet - create new paper");
                doCreateNewPaper(jsonObject.getString("papername"));
                res.append(JSON_RESPONSE_KEY_SUCCESS, true);
                return res.toString();
            }
        } catch (JSONException e) {
            e.printStackTrace();
        }
        res.append(JSON_RESPONSE_KEY_SUCCESS, false);
        return res.toString();
    }

    private void doChangePaperIsactive(int idpaper, int isactive) {
        DBProblemManagement dbm = new DBProblemManagement();
        dbm.updatePaperIsactive(idpaper, isactive);
    }
    private void doCreateNewPaper(String papername) {
        DBProblemManagement dbm = new DBProblemManagement();
        dbm.insertNewPaper(papername);
    }
}
