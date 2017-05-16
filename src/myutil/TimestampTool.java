package myutil;

import java.sql.Timestamp;

/**
 * Created by mee on 2017/4/25.
 */
public class TimestampTool {
    public static Timestamp convertIntoTimestamp(String time, String status) {
        if (time != null) {
            String year = time.substring(0, 4);
            String month = time.substring(5, 7);
            String day = time.substring(8, 10);
            String hour = time.substring(11, 13);
            String minute = time.substring(14, 16);
            if ("start".equals(status)) {
                return Timestamp.valueOf(year + "-" + month + "-" + day + " " + hour + ":" + minute + ":30");
            } else if ("end".equals(status)) {
                return Timestamp.valueOf(year + "-" + month + "-" + day + " " + hour + ":" + minute + ":00");
            }
        }
        System.out.println("time is null!");
        return null;
    }
    public static Timestamp getEndTime(String time) {
        if (time != null) {
            String year = time.substring(0, 4);
            String month = time.substring(5, 7);
            String day = time.substring(8, 10);
            return Timestamp.valueOf(year + "-" + month + "-"  + day + " " + "23:00:00");
        }
        return null;
    }
}
