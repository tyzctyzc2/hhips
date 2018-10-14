package hhips.air;

import db.*;
import javafx.util.Pair;
import org.json.JSONObject;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import uti.StringHelper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class NoteController extends MyBaseController {

    @Autowired
    ChapterNoteDB noteDB;

    @Autowired
    DBProblemManagement dbProblemManagement;

    private static final org.slf4j.Logger logger = LoggerFactory.getLogger(NoteController.class);
    @GetMapping("/note")
    public String getChapterNotes(Model model, @RequestParam(value="chapterid", required=true) Integer chapterid) {
        System.out.println("NoteController - get chapter notes request");
        logger.info("NoteController - get chapter notes request");

        model.addAttribute("notes", noteDB.getChapterNote(chapterid));

        Chapter c = new Chapter();
        c.setIdsourcechapter(chapterid);
        c = dbProblemManagement.getChaperName(c);
        model.addAttribute("chaptername", c.getSourcechaptername());
        model.addAttribute("chapterid", c.getIdsourcechapter());
        model.addAttribute("chapterindex", c.getSourcechapterindex());

        String sourceName = dbProblemManagement.getSourceName(c.getSourceid());
        model.addAttribute("sourcename", sourceName);
        model.addAttribute("sourceid", c.getSourceid());
        DBChapter dbChapter = new DBChapter();
        Pair<Integer, Integer> beforeAndAfter = dbChapter.getChapterBeforeAfter(c.getIdsourcechapter(), c.getSourceid());
        model.addAttribute("before", beforeAndAfter.getKey());
        model.addAttribute("after", beforeAndAfter.getValue());

        return "chapternotes";
    }

    @ResponseBody @PostMapping(path = "/note/new", consumes = "application/json")
    public ChapterNote  createNewNote(@RequestBody ChapterNote newNote) {
        logger.info("NoteController - post new chapter notes request");
        ChapterNote chapterNote = noteDB.createNewNote(newNote);
        return chapterNote;
    }

    @ResponseBody @GetMapping("/note/allchapternotes")
    public List<ChapterNote> getBase64ChapterNotes(Model model, @RequestParam(value="chapterid", required=true) Integer chapterid) {
        System.out.println("NoteController - get chapter notes request");
        logger.info("NoteController - get chapter notes request");

        return noteDB.getChapterNoteBase64(chapterid);
    }
}
