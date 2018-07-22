package hhips.air;

import db.DBProblemManagement;
import db.DBWork;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import uti.StringHelper;

@Controller
//@RequestMapping("/hhipsair")
public class WorkServlet {
    @PostMapping("/Work/wrong")
    public @ResponseBody
    String wrongPaperProblem(@RequestBody String stringToParse) {
        System.out.println("WorkServlet - post request - mark work wrong");
        int idwork = 0;
        int workmark = -1;
        JSONObject res = new JSONObject();
        try {
            JSONObject jsonObject = new JSONObject(stringToParse.toString());
            idwork = jsonObject.getInt("idwork");
            workmark = jsonObject.getInt("workmark");

            DBWork dbWork = new DBWork();

            if (dbWork.updateWorkMark(idwork, workmark)==true)
                res.append(StringHelper.JSON_RESPONSE_KEY_SUCCESS, true);
            else
                res.append(StringHelper.JSON_RESPONSE_KEY_SUCCESS, false);
        } catch (JSONException e1) {
            // TODO Auto-generated catch block
            e1.printStackTrace();
        }
        return res.toString();
    }

    @PostMapping("/Work/active")
    public @ResponseBody
    String activePaperProblem(@RequestBody String stringToParse) {
        System.out.println("WorkServlet - post request - active problem");
        try {
            JSONObject jsonObject = new JSONObject(stringToParse.toString());

            int idwork = jsonObject.getInt("idwork");

            DBProblemManagement dbm = new DBProblemManagement();
            dbm.ChangeProblemPaperStatus(jsonObject.getInt("idproblem"), jsonObject.getInt("paperproblemid"), 1);
        } catch (JSONException e) {
            e.printStackTrace();
        }
        JSONObject res = new JSONObject();
        res.append(StringHelper.JSON_RESPONSE_KEY_SUCCESS, true);
        return res.toString();
    }

    @PostMapping("/Work")
    public @ResponseBody
    String changePaperRequest(@RequestBody String stringToParse) {
        System.out.println("WorkServlet - post request");
        try {
            JSONObject jsonObject = new JSONObject(stringToParse.toString());

            if (jsonObject.has("idwork") == true) {
                System.out.println("WorkServlet - mark a work request");
                return processMarkWork(jsonObject);
            }

            createNewWork(jsonObject);
        } catch (JSONException e) {
            e.printStackTrace();
        }
        JSONObject res = new JSONObject();
        res.append(StringHelper.JSON_RESPONSE_KEY_SUCCESS, true);
        return res.toString();
    }

    private void createNewWork(JSONObject jsonObject) {
        DBWork dbWork = new DBWork();

        int workID = dbWork.PushWork(jsonObject);
        if (workID == 0) {
            System.out.println("WorkServlet - Save work failed");
            return;
        }

        DBProblemManagement dbm = new DBProblemManagement();
        dbm.UpdatePaperProblemAfterWork(workID, jsonObject);
    }

    String processMarkWork(JSONObject jsonObject) {
        System.out.println("WorkServlet - mark a work ");
        int idwork = 0;
        int workmark = -1;
        try {
            idwork = jsonObject.getInt("idwork");
            workmark = jsonObject.getInt("workmark");

            DBProblemManagement dbm = new DBProblemManagement();
            if (workmark == 1) {//wrong case
                dbm.ChangeProblemPaperStatus(jsonObject.getInt("idproblem"), jsonObject.getInt("paperproblemid"), 1);
            }
            else if (workmark == 0) {//correct case
                dbm.ChangeProblemPaperStatus(jsonObject.getInt("idproblem"), jsonObject.getInt("paperproblemid"), 3);
            }
        } catch (JSONException e1) {
            // TODO Auto-generated catch block
            e1.printStackTrace();
        }
        DBWork dbWork = new DBWork();
        JSONObject res = new JSONObject();
        if (dbWork.updateWorkMark(idwork, workmark)==true)
            res.append(StringHelper.JSON_RESPONSE_KEY_SUCCESS, true);
        else
            res.append(StringHelper.JSON_RESPONSE_KEY_SUCCESS, false);
        return res.toString();
    }
}
