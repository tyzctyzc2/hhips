package hhips.air;

import db.DBAppAction;
import model.AppAction;
import repository.AppActionRepository;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.Date;

@Controller
public class AppActionController {
    private static final org.slf4j.Logger logger = LoggerFactory.getLogger(ChapterServlet.class);

    @Autowired
    DBAppAction db;

    @PostMapping("/appaction")
    @ResponseBody
    public String saveAppAction(@RequestBody AppAction data) {
        data.setTime(new Date());
        db.saveAppAction(data);
        return "ok";
    }
}
