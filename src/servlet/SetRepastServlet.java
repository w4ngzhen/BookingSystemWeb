package servlet;

import DAO.InfoSetter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by mee on 2017/5/3.
 */
public class SetRepastServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int bid = Integer.parseInt(request.getParameter("setRepastBooking").substring(11));
        request.setAttribute("content", "添加就餐");
        if (InfoSetter.setRepastByBid(bid)) {
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
