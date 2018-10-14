package hhips.air;

import db.DBProblemManagement;
import db.Source;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import uti.StringHelper;

import java.util.List;

@Controller
//@RequestMapping("/hhipsair")
public class SourceServlet {
    @Autowired
    DBProblemManagement dbProblemManagement;

    @GetMapping("/Source")
    public String getSourceList(Model model, @RequestParam(value="name", required=false, defaultValue="World") String name) {
        System.out.println("SourceServlet - get all source list");
        model.addAttribute("today", StringHelper.GetDateString());

        model.addAttribute("name", name);
        PageMaker.prepareSourceList(model);
        return "source";
    }
    @GetMapping("/source/list")
    @ResponseBody
    public List<Source> getSourceListAPI() {
        System.out.println("SourceServlet - get getSourceListAPI");
        return dbProblemManagement.getAllSource();
    }
}
