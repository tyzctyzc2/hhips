package hhips.air;

import db.Chapter;
import db.DBProblem;
import db.DBProblemManagement;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
//@RequestMapping("/hhipsair")
public class ChapterServlet {
    @GetMapping("/Chapter")
    public String processChapterGet(Model model, @RequestParam(value="sourceid", required=false, defaultValue="") String sourceid,
                                    @RequestParam(value="chapterid", required=false, defaultValue="") String chapterid ) {
        System.out.println("ChapterServlet - chapter request");

        if (sourceid.length() > 0)
            return getChapterList(model, sourceid);

        if (chapterid.length() > 0)
            return getChapterProblems(model, chapterid);

        return "error";
    }

    private String getChapterProblems(Model model, String chapterIDString) {
        System.out.println("ChapterServlet - get chapter problem of " + chapterIDString);
        int chapterID = 0;
        try {
            chapterID = Integer.parseInt(chapterIDString);
        } catch (Exception e) {
            chapterID = 1;
        }

        PageMaker.prepareChapterProblems(model, chapterID);

        return "chapterview";
    }

    private String getChapterList(Model model, String sourceIDString) {
        System.out.println("ChapterServlet - get chapter list of " + sourceIDString);
        int sourceID = 0;
        try {
            sourceIDString = sourceIDString.replace(",", "");
            sourceID = Integer.parseInt(sourceIDString);
        } catch (Exception e) {
            sourceID = 1;
        }

        PageMaker.prepareChapterList(model, sourceID);

        return "chapterlist";
    }

    String JSON_RESPONSE_KEY_SUCCESS = "SUCCESS";
    @PostMapping("/Chapter")
    public @ResponseBody    String createNewChapter(@RequestBody String stringToParse) {
        System.out.println("ChapterServlet -- post create new chapter");
        JSONObject res = new JSONObject();
        try {
            JSONObject jsonObject = new JSONObject(stringToParse.toString());
            Chapter cc = new Chapter();
            DBProblemManagement dbm = new DBProblemManagement();
            Integer newChapterID = dbm.createNewChapter(stringToParse);
            if (newChapterID == 0) {
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
}
