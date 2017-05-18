package servlet;

import DAO.InfoGetter;
import entity.Booking;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created by mee on 2017/5/18.
 */
public class TableDetailServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String info
                = new String(request.getParameter("info").getBytes("ISO8859-1"),"UTF-8");
        int tno = getTno(info);
        int places = getPlaces(info);
        String currentStatus = getCurrentStatus(info);
        List<Booking> realtedBookings = InfoGetter.getRelatedBookings(tno);
        request.setAttribute("tno", tno);
        request.setAttribute("places", places);
        request.setAttribute("currentStatus", currentStatus);
        request.setAttribute("relatedBookings", realtedBookings);
        request.getRequestDispatcher("table_detail.jsp").forward(request, response);
    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
    private int getTno(String info) {
        int tno = 0;
        Pattern p = Pattern.compile("(?<=-).*?(?=号桌)");
        Matcher m = p.matcher(info);
        if (m.find()) {
            tno = Integer.parseInt(m.group());
        }
        return tno;
    }
    private int getPlaces(String info) {
        int places = 0;
        Pattern p = Pattern.compile("(?<=\\().*?(?=人)");
        Matcher m = p.matcher(info);
        if (m.find()) {
            places = Integer.parseInt(m.group());
        }
        return places;
    }
    private String getCurrentStatus(String info) {
        String currentStatus = null;
        Pattern p = Pattern.compile("(?<=\\[).*?(?=\\])");
        Matcher m = p.matcher(info);
        if (m.find()) {
            currentStatus = m.group();
        }
        return currentStatus;
    }

}
