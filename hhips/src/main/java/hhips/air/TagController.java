package hhips.air;

import db.DBTag;
import dbmodel.ProblemWithLastWork;
import dbmodel.Tag;
import json.TagTreeJson;
import org.json.JSONException;
import org.json.JSONObject;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import requestModel.MoveTagRequest;
import uti.StringHelper;

import java.util.ArrayList;
import java.util.List;

@Controller
public class TagController {
    private static final org.slf4j.Logger logger = LoggerFactory.getLogger(TagController.class);

    @Autowired
    DBTag dbTag;

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

    @GetMapping("/childtag")
    public @ResponseBody List<TagTreeJson> getAllChildTag(Model model, @RequestParam(value="rootid", required=false, defaultValue="1") int rootId) {
        logger.info("TagController - get child tag " + rootId);
        int subjectId  = 1;
        List<Tag> root = dbTag.getChildTag(0, subjectId);
        List<TagTreeJson> tree = new ArrayList<>();
        for(int i = 0; i < root.size(); ++i) {
            TagTreeJson cur = new TagTreeJson(root.get(i));
            cur = getNestedNode(cur, subjectId);
            tree.add(cur);
        }
        return tree;
    }

    TagTreeJson getNestedNode(TagTreeJson parentNode, int subjectId) {
        List<Tag> myChildList = dbTag.getChildTag(parentNode.getId(), subjectId);
        if (myChildList.size() == 0)
            return parentNode;

        List<TagTreeJson> allChildren = new ArrayList<>();
        for(int i = 0; i < myChildList.size(); ++i) {
            TagTreeJson cur = new TagTreeJson(myChildList.get(i));
            cur = getNestedNode(cur, subjectId);
            allChildren.add(cur);
        }
        parentNode.setChildren(allChildren);
        return parentNode;
    }

    @PostMapping("/tag/move")
    public @ResponseBody
    String moveTag(@RequestBody MoveTagRequest moveTagRequest) {
        DBTag dbTag = new DBTag();
        dbTag.moveTag(moveTagRequest);
        return  "";
    }

    @PostMapping("/tag/add")
    public @ResponseBody
    String addTag(@RequestBody String stringToParse) {
        logger.info("add tag " + stringToParse);
        JSONObject res = new JSONObject();
        try {
            JSONObject jsonObject = new JSONObject(stringToParse.toString());
            DBTag dbTag = new DBTag();
            boolean suc = dbTag.saveNewTag(jsonObject.getString("tagname"));
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
