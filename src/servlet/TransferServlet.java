package servlet;

import DAO.InfoGetter;
import entity.Booking;
import entity.Table;

import javax.servlet.ServletException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * Created by mee on 2017/4/27.
 */
public class TransferServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int bid = Integer.parseInt(request.getParameter("transfertable").substring(11));
        Booking currentBooking = InfoGetter.getBookingByBid(bid);
        List<Table> availableTable
                = InfoGetter.getFreeTableByTime(currentBooking.getStartTime(), currentBooking.getEndTime());
        request.setAttribute("currentBooking", currentBooking);
        request.setAttribute("availableTable", availableTable);
        request.getRequestDispatcher("transfer.jsp").forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}
