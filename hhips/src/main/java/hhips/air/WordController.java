package hhips.air;

import db.DBEnglish;
import dbmodel.EnglishPart;
import dbmodel.EnglishWordView;
import json.WordCreateRequest;
import json.WordSearchResponse;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import sun.net.www.http.HttpClient;
import uti.StringHelper;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.List;

import static org.springframework.http.HttpHeaders.USER_AGENT;

@Controller
public class WordController {
    private static final org.slf4j.Logger logger = LoggerFactory.getLogger(WordController.class);

    @Autowired
    DBEnglish dbEnglish;

    @GetMapping("/english")
    public String getPartList(Model model) {
        System.out.println("WordController - get all english root");
        model.addAttribute("today", StringHelper.GetDateString());
        List<EnglishPart> partList = dbEnglish.getPartList();
        model.addAttribute("partlist", partList);
        if (partList.size() > 0) {
            model.addAttribute("partmax", partList.size() - 1);
        }
        return "engroot";
    }

    @GetMapping("/english/part")
    public String getPartWord(Model model, @RequestParam(value="partid", required=true, defaultValue="1") Integer partId,
                              @RequestParam(value="showanswer", required=false, defaultValue="true") boolean showAnswer) {
        System.out.println("WordController - get part of " + String.valueOf(partId));
        model.addAttribute("today", StringHelper.GetDateString());
        List<EnglishWordView> wordList = dbEnglish.getPartDetailList(partId);
        model.addAttribute("words", wordList);
        if (wordList.size() > 0) {
            model.addAttribute("name", wordList.get(0).getPartname());
            model.addAttribute("max", wordList.size() - 1);
        }
        model.addAttribute("showanswer", showAnswer);
        return "engpartdetail";
    }

    @GetMapping("/english/word")
    public @ResponseBody
    WordSearchResponse getWordHistory(Model model, @RequestParam(value="search", required=true, defaultValue="") String search) {
        System.out.println("WordController - search word " + search);
        model.addAttribute("today", StringHelper.GetDateString());
        List<EnglishWordView> foundWord = dbEnglish.getWordHistory(search);
        WordSearchResponse wordSearchResponse = new WordSearchResponse();
        if (foundWord.size() > 0) {
            wordSearchResponse.setFoundDuplicate(true);
            wordSearchResponse.setExplanation(foundWord.get(0).getExplanation());
            wordSearchResponse.setWord(foundWord.get(0).getWord());
            return wordSearchResponse;
        }
        String explanation = getWordExplanation(search);
        wordSearchResponse.setExplanation(explanation);
        return wordSearchResponse;
    }

    private String phaseHtml4Level(String html) {
        if (html.contains("基本词汇")) {
            return "基本词汇\n";
        }else if (html.contains("常用词汇")) {
            return "常用词汇\n";
        }else if (html.contains("核心词汇")) {
            return "核心词汇\n";
        }else if (html.contains("扩展词汇")) {
            return "扩展词汇\n";
        }else if (html.contains("畅通词汇")) {
            return "畅通词汇\n";
        }
        return "";
    }

    private String phaseHtml4Sound(String html) {
        int start = html.indexOf("<div class=\"phonetic\">");
        if (start < 0) {
            return "";
        }
        String sound = "";

        String part = html.substring(start);
        int end = part.indexOf("</div>");
        part = part.substring(0, end);
        logger.info(part);

        while (part.indexOf("[") > 0) {
            start = part.indexOf("[");
            end = part.indexOf("]") + 1;
            sound = sound + part.substring(start, end);
            sound = sound.trim();
            sound = sound + "\n";
            part = part.substring(part.indexOf("]") + 10);
        }
        return sound;
    }

    private String phaseHtml4Explanation(String html) {
        int start = html.indexOf("ul class=\"dict-basic-ul\"");
        if (start < 0) {
            return "";
        }
        String exp = "";

        start = html.indexOf("ul class=\"dict-basic-ul\"");
        String part = html.substring(start);
        int end = part.indexOf("</ul>");
        part = part.substring(0, end);
        logger.info(part);

        while (part.indexOf("span") > 0) {
            start = part.indexOf("<span>");
            end = part.indexOf("</span>");
            exp = exp + part.substring(start + 6, end);
            start = part.indexOf("<strong>") + 8;
            end = part.indexOf("</strong>");
            exp = exp + " " + part.substring(start, end) + "\n";
            part = part.substring(part.indexOf("</strong>") + 10);
        }
        return exp;
    }

    private String getWordExplanation(String word) {
        try {
            URL obj = new URL("http://dict.cn/" + word);
            HttpURLConnection httpURLConnection = (HttpURLConnection) obj.openConnection();
            httpURLConnection.setRequestMethod("GET");
            httpURLConnection.setRequestProperty("User-Agent", USER_AGENT);
            int responseCode = httpURLConnection.getResponseCode();
            //logger.info("GET Response Code :: " + responseCode);
            if (responseCode == HttpURLConnection.HTTP_OK) { // success
                BufferedReader in = new BufferedReader(new InputStreamReader(httpURLConnection.getInputStream(), "UTF-8"));
                String inputLine;
                StringBuffer response = new StringBuffer();

                while ((inputLine = in.readLine()) != null) {
                    response.append(inputLine);
                }
                in.close();

                // print result
                logger.info(response.toString());
                String xml = response.toString();
                String level = phaseHtml4Level(xml);
                String sound = phaseHtml4Sound(xml);
                String explanation = phaseHtml4Explanation(xml);
                logger.info(level);
                logger.info(sound);
                logger.info(explanation);
                return  level + sound + explanation;
            } else {
                logger.info("dict GET request not worked");
            }
        } catch (Exception e) {
            logger.error("***", e);
        }
        return "";
    }

    @GetMapping("/english/word/new")
    public String getWordCreatePage(Model model) {
        logger.info("WordController - get create word page ");
        model.addAttribute("today", StringHelper.GetDateString());
        List<EnglishPart> partList = dbEnglish.getPartList();
        model.addAttribute("partlist", partList);
        if (partList.size() > 0) {
            model.addAttribute("partmax", partList.size() - 1);
        }
        return "engwordcreate";
    }

    @PostMapping("/english/word/create")
    public @ResponseBody String createNewChapter(@RequestBody WordCreateRequest wordCreateRequest) {
        logger.info("WordController - create new word " + wordCreateRequest.getExplanation());
        dbEnglish.createAllWord(wordCreateRequest);
        return "done";
    }
}
