package hhips.air;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class RootServlet {
    @GetMapping("/")
    public String processRootGet(Model model, @RequestParam(value="user", required=false, defaultValue="0") String user) {
        return "root";
    }
}
