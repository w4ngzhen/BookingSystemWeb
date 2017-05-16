package servlet;

import DAO.InfoSetter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by mee on 2017/4/27.
 */
@WebServlet(name = "TransferCompleteServlet")
public class TransferCompleteServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int newTno = Integer.parseInt(request.getParameter("transferTableSelect"));
        int currentBid = Integer.parseInt(request.getParameter("currentBid"));
        request.setAttribute("content", "餐桌调换");
        if (InfoSetter.transferTableSuccess(currentBid, newTno)) {
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
