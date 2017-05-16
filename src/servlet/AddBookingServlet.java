package servlet;

import entity.Table;
import DAO.InfoGetter;
import myutil.TimestampTool;

import javax.jws.WebService;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by mee on 2017/4/24.
 */
public class AddBookingServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
                                            throws ServletException, IOException {
        Timestamp st = TimestampTool.convertIntoTimestamp(request.getParameter("startTimeSelect"), "start");
        Timestamp et = TimestampTool.convertIntoTimestamp(request.getParameter("endTimeSelect"), "end");
        List<Table> freeTables = InfoGetter.getFreeTableByTime(st, et);
        if (freeTables.size() > 0) {
            request.setAttribute("startTime", st.toString());
            request.setAttribute("endTime", et.toString());
            request.setAttribute("freeTables", freeTables);
            request.getRequestDispatcher("add_booking.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("nofreetable.jsp").forward(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
                                            throws ServletException, IOException {
        doPost(request, response);
    }
}
