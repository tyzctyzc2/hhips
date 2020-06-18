package hhips.air;

import db.DBTag;
import dbmodel.Tag;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import uti.DmmUti;

import java.util.List;

@Controller
public class FilterController extends MyBaseController {
    private static final org.slf4j.Logger logger = LoggerFactory.getLogger(FilterController.class);
    String JSON_RESPONSE_KEY_SUCCESS = "SUCCESS";

    @GetMapping("/filter")
    public String processProblemGet(Model model, @RequestParam(value="stage", required=true, defaultValue="1") Integer idStage) {
        logger.info("request filter for stage " + idStage.toString());
        DBTag dbTag=new DBTag();
        List<Tag> allTags = dbTag.getBaseTagMap();
        List<List<Tag>> chopedTag = DmmUti.chopped(allTags, 7);
        model.addAttribute("allTags", chopedTag);

        return "filter";
    }
}
