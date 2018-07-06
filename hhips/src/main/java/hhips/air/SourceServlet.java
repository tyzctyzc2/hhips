package hhips.air;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/hhipsair")
public class SourceServlet {
    @GetMapping("/Source")
    public String getSourceList(Model model, @RequestParam(value="name", required=false, defaultValue="World") String name) {
        System.out.println("SourceServlet - get all source list");
        model.addAttribute("name", name);
        PageMaker.prepareSourceList(model);
        return "source";
    }

}
