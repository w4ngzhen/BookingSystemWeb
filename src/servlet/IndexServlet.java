package servlet;

import entity.Booking;
import entity.Table;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import DAO.InfoGetter;
import myutil.TimestampTool;

/**
 * Created by mee on 2017/4/24.
 */
public class IndexServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
                                            throws ServletException, IOException {
        Timestamp now = new Timestamp(System.currentTimeMillis());
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:30.0");
        String sTime = sdf.format(now);
        Timestamp startTime = Timestamp.valueOf(sTime);
        Timestamp endTime = TimestampTool.getEndTime(startTime.toString());
        List<Table> freeTables = InfoGetter.getFreeTableByTime(startTime, endTime);
        List<Booking> preBookings = InfoGetter.getBookingsByStatus("pre");
        List<Table> onGoingTables = InfoGetter.getTablesByStatus("onGoing");
        List<Table> allTables = InfoGetter.getAllTable();
        request.setAttribute("preBookings", preBookings);
        request.setAttribute("onGoingTables", onGoingTables);
        request.setAttribute("allTables", allTables);
        request.setAttribute("startTime", startTime.toString());
        request.setAttribute("endTime", endTime.toString());
        request.setAttribute("freeTables", freeTables);
        request.getRequestDispatcher("bookingsystem.jsp").forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
                                            throws ServletException, IOException {
        doPost(request, response);
    }
}
