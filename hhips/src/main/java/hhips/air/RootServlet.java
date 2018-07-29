package hhips.air;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import uti.StringHelper;

@Controller
public class RootServlet {
    @GetMapping("/")
    public String processRootGet(Model model, @RequestParam(value="user", required=false, defaultValue="0") String user) {
        model.addAttribute("today", StringHelper.GetDateString());
        return "root";
    }
}
