package hhips.air;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import uti.StringHelper;

@Controller
public class MyBaseController {
    @ModelAttribute("today")
    public String foo() {
        return StringHelper.GetDateString();
    }
}
