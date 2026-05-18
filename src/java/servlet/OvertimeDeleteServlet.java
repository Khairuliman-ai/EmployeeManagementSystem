// servlet/OvertimeDeleteServlet.java

package servlet;

import model.OvertimeDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;


public class OvertimeDeleteServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int overtimeID = Integer.parseInt(request.getParameter("overtimeID"));
            OvertimeDAO dao = new OvertimeDAO();
            boolean success = dao.deleteOvertime(overtimeID);

            response.sendRedirect("overtime.jsp?deleted=" + success);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("overtime.jsp?deleted=false");
        }
    }
}
