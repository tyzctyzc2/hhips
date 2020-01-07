package hhips.air;

import db.DBWork;
import db.DBWorkCorrect;
import dbmodel.WorkCorrect;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Date;

@Controller
@Service
public class WorkCorrectController {
    private static final org.slf4j.Logger logger = LoggerFactory.getLogger(WorkCorrectController.class);

    @Autowired
    private DBWorkCorrect dbWorkCorrect;

    @Autowired
    private DBWork dbWork;

    @PostMapping("/correct/start")
    public @ResponseBody
    String startCorrect(Model model, @RequestParam(value="workid", required=true) Integer workId) {
        dbWorkCorrect.insertWorkCorrect(workId);
        return "done";
    }

    @PostMapping("/correct/stop")
    public @ResponseBody
    String stopCorrect(Model model, @RequestParam(value="workid", required=true) Integer workId) {
        WorkCorrect workCorrect = dbWorkCorrect.getWorkCorrect(workId);
        Date now = new Date();
        long seconds = (now.getTime()-workCorrect.getStarttime().getTime())/1000;
        dbWork.updateWorkUsedTime(workId, (int) seconds);
        logger.info("add work " + String.valueOf(workId) + " seconds = " + String.valueOf(seconds));
        dbWorkCorrect.removeWorkCorrect(workId);
        return "done";
    }
}
