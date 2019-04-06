package uti;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

public class StringHelper {
    static public String JSON_RESPONSE_KEY_SUCCESS = "SUCCESS";
    static public String JSON_RESPONSE_KEY_FAILED = "FAILED";
    static public String JSON_RESPONSE_KEY_MESSAGE = "Message";

    static public String GetDateString() {
        DateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
        Date date = new Date();
        String day = dateFormat.format(date);
        return day;
    }
}
