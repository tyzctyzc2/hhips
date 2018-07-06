package hhips.air;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/hhipsair")
public class ChapterServlet {
    @GetMapping("/Chapter")
    public String processChapterGet(Model model, @RequestParam(value="sourceid", required=false, defaultValue="") String sourceid,
                                    @RequestParam(value="chapterid", required=false, defaultValue="") String chapterid ) {
        System.out.println("ChapterServlet - chapter request");

        if (sourceid.length() > 0)
            return getChapterList(model, sourceid);

        if (chapterid.length() > 0)
            return getChapterProblems(model, chapterid);

        return "error";
    }

    private String getChapterProblems(Model model, String chapterIDString) {
        System.out.println("ChapterServlet - get chapter problem of " + chapterIDString);
        int chapterID = 0;
        try {
            chapterID = Integer.parseInt(chapterIDString);
        } catch (Exception e) {
            chapterID = 1;
        }

        PageMaker.prepareChapterProblems(model, chapterID);

        return "chapterview";
    }

    private String getChapterList(Model model, String sourceIDString) {
        System.out.println("ChapterServlet - get chapter list of " + sourceIDString);
        int sourceID = 0;
        try {
            sourceIDString = sourceIDString.replace(",", "");
            sourceID = Integer.parseInt(sourceIDString);
        } catch (Exception e) {
            sourceID = 1;
        }

        PageMaker.prepareChapterList(model, sourceID);

        return "chapterlist";
    }
}
