package hhips.air;

import life.DBTimeLookup;
import life.TimeCounterLookup;
import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import uti.FileHelper;
import uti.StringHelper;

import java.util.List;

@Controller
public class TimeCounterController {
    private static final org.slf4j.Logger logger = LoggerFactory.getLogger(TimeCounterController.class);

    @GetMapping("/life/counterlist")
    public @ResponseBody
    String getActiveCounterList(Model model) {
        logger.info("TimeCounterController - get counterlist !");

        DBTimeLookup dbTimer = new DBTimeLookup();
        List<TimeCounterLookup> ll = dbTimer.getAllTimeCounterLookup();
        JSONArray ary = new JSONArray();
        for (TimeCounterLookup p: ll)
            ary.put(p);

        return  ary.toString();
    }

    @GetMapping("/life/counterdetail")
    public @ResponseBody
    String getCounterDetail(Model model, @RequestParam(value="idtimecounterlookup", required=true) Integer idtimecounterlookup) {
        logger.info("TimeCounterController - get getCounterDetail !");

        DBTimeLookup dbTimer = new DBTimeLookup();
        TimeCounterLookup ll = dbTimer.getTimeCounterLookup(idtimecounterlookup);
        ll.setTimecounterimage(FileHelper.getBase64String(ll.getTimecounterimage()));

        return  ll.toString();
    }

    @PostMapping("/life/newdetail")
    public @ResponseBody
    String saveCounterDetail(Model model, @RequestParam(value="idtimecounterlookup", required=true) Integer idtimecounterlookup,
                             @RequestParam(value="timecountevalue", required=true) Integer timecountevalue) {
        logger.info("TimeCounterController - post saveCounterDetail !");

        DBTimeLookup dbTimer = new DBTimeLookup();
        dbTimer.createNewTimeLookupValue(idtimecounterlookup, timecountevalue);

        return  "1";
    }
}
