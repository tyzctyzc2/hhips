package hhips.air;

import db.DBTag;
import db.ProblemWithLastWork;
import db.ProblemWithWork;
import db.Tag;
import org.json.JSONException;
import org.json.JSONObject;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import uti.StringHelper;

import java.util.List;

@Controller
public class TagController {
    private static final org.slf4j.Logger logger = LoggerFactory.getLogger(TagController.class);

    @GetMapping("/tag")
    public String processProblemGet(Model model, @RequestParam(value="tagid", required=false, defaultValue="0") int tagid) {
        logger.info("TagController - get tag problem " + tagid);
        DBTag dbTag = new DBTag();
        List<ProblemWithLastWork> ps = dbTag.getProblemByTag(tagid);
        model.addAttribute("problems", ps);
        Tag want = dbTag.getTag(tagid);
        model.addAttribute("myTag", want);
        model.addAttribute("today", StringHelper.GetDateString());
        return "tagproblem";
    }

    @PostMapping("/tag/update")
    public @ResponseBody
    String updateProblem(@RequestBody String stringToParse) {
        logger.info("update tag of " + stringToParse);
        JSONObject res = new JSONObject();
        try {
            JSONObject jsonObject = new JSONObject(stringToParse.toString());
            DBTag dbTag = new DBTag();
            boolean suc = dbTag.updateProblemTag(jsonObject.getInt("idproblem"), jsonObject.getInt("idtag"));
            if (suc) {
                res.append(StringHelper.JSON_RESPONSE_KEY_SUCCESS, false);
            }
            else {
                res.append(StringHelper.JSON_RESPONSE_KEY_SUCCESS, true);
            }

        } catch (JSONException e) {
            System.out.println(stringToParse);
            logger.error(e.getStackTrace().toString());
            e.printStackTrace();
            res.append(StringHelper.JSON_RESPONSE_KEY_SUCCESS, false);
        }

        return res.toString();
    }
}
