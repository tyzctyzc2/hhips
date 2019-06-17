package hhips.air;

import db.DBPaper;
import db.DBWork;
import org.json.JSONObject;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class HistoryController {
    private static final org.slf4j.Logger logger = LoggerFactory.getLogger(HistoryController.class);

    @Autowired
    private DBWork dbWork;

    @GetMapping("/history/remove")
    public @ResponseBody String getActivePaper(Model model, @RequestParam(value="backday", required=false, defaultValue="90") Integer backDay) {
        logger.info("HistoryController - remove history !");
        return  "done";
    }
}
