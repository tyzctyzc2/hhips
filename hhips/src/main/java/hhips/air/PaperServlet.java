package hhips.air;

import db.DBProblemManagement;
import db.Paper;
import jdk.nashorn.internal.parser.JSONParser;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;


@Controller
//@RequestMapping("/hhipsair")
public class PaperServlet {
    String JSON_RESPONSE_KEY_SUCCESS = "SUCCESS";
    @GetMapping("/Paper/active")
    public @ResponseBody String getActivePaper(Model model, @RequestParam(value="paperid", required=false, defaultValue="0") String paperID) {
        DBProblemManagement dbp = new DBProblemManagement();
        List<Paper> ll = dbp.getAllActivePapers();
        JSONArray ary = new JSONArray();
        for (Paper p: ll)
            ary.put(p);

        model.addAttribute("txt", ary.toString());
        JSONObject jo = new JSONObject();

        return  ary.toString();
    }

    @PostMapping("/Paper")
    public @ResponseBody String changePaperRequest(@RequestBody String stringToParse) {
        JSONObject res = new JSONObject();
        try {
            JSONObject jsonObject = new JSONObject(stringToParse.toString());

            if (jsonObject.has("isactive") == true) {
                System.out.println("PaperServlet - change paper isactive");
                doChangePaperIsactive(jsonObject.getInt("idpaper"), jsonObject.getInt("isactive"));
                res.append(JSON_RESPONSE_KEY_SUCCESS, true);
                return res.toString();

            }
            else if (jsonObject.has("papername") == true) {
                System.out.println("PaperServlet - create new paper");
                doCreateNewPaper(jsonObject.getString("papername"));
                res.append(JSON_RESPONSE_KEY_SUCCESS, true);
                return res.toString();
            }
        } catch (JSONException e) {
            e.printStackTrace();
        }
        res.append(JSON_RESPONSE_KEY_SUCCESS, false);
        return res.toString();
    }

    private void doChangePaperIsactive(int idpaper, int isactive) {
        DBProblemManagement dbm = new DBProblemManagement();
        dbm.updatePaperIsactive(idpaper, isactive);
    }
    private void doCreateNewPaper(String papername) {
        DBProblemManagement dbm = new DBProblemManagement();
        dbm.insertNewPaper(papername);
    }
}
