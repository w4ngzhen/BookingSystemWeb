package servlet;

import DAO.InfoSetter;
import entity.Booking;
import myutil.TimestampTool;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.logging.SimpleFormatter;

/**
 * Created by mee on 2017/4/24.
 */
public class SubmitServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String from = request.getParameter("from");
        Timestamp st = TimestampTool.convertIntoTimestamp(request.getParameter("startTime"),"start");
        Timestamp et = TimestampTool.convertIntoTimestamp(request.getParameter("endTime"), "end");
        int tno = Integer.parseInt(request.getParameter("tableSelect"));
        String name = new String(request.getParameter("cName").getBytes("ISO8859-1"),"UTF-8");
        String cPhoneNumber = request.getParameter("cPhoneNumber");

        Booking booking = new Booking();
        booking.setStartTime(st);
        booking.setEndTime(et);
        booking.setTno(tno);
        booking.setcName(name);
        booking.setcPhoneNumber(cPhoneNumber);
        if ("add_booking".equals(from)) {
            booking.setStatus("pre");
            request.setAttribute("content", "预约");
        } else if ("add_orderwithoutbooking".equals(from)){
            booking.setStatus("ing");
            request.setAttribute("content", "添加");
        }

        System.out.println("提交订单：" + booking);

        if (InfoSetter.addBookingSuccess(booking)) {
            request.setAttribute("result", "成功");
        } else {
            request.setAttribute("result", "失败");
        }
        request.getRequestDispatcher("result.jsp").forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

}
