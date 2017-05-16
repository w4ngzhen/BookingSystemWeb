package servlet;

import DAO.InfoSetter;
import entity.Table;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by mee on 2017/5/14.
 */
public class AddTableResultServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int tno = Integer.parseInt(request.getParameter("tno"));
        int places = Integer.parseInt(request.getParameter("capa"));
        Table table = new Table();
        table.setTno(tno);
        table.setPlaces(places);
        request.setAttribute("content", "新增桌子");
        if (InfoSetter.addTable(table)) {
            request.setAttribute("result", "成功");
        } else {
            request.setAttribute("result", "失败");
        }
        request.getRequestDispatcher("result.jsp").forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
