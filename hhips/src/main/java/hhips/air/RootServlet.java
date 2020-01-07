package hhips.air;

import db.DBStage;
import dbmodel.Stage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import uti.StringHelper;

import java.util.List;

@Controller
public class RootServlet {
    @Autowired
    private DBStage dbStage;

    @GetMapping("/")
    public String processRootGet(Model model, @RequestParam(value="user", required=false, defaultValue="0") String user) {
        model.addAttribute("today", StringHelper.GetDateString());
        List<Stage> allStage = dbStage.getAllStage();
        model.addAttribute("stages", allStage);
        return "root";
    }

    @GetMapping("/edit")
    public String processEditRootGet(Model model, @RequestParam(value="user", required=false, defaultValue="0") String user) {
        return "index";
    }
}
