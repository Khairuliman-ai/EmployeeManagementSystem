// servlet/OvertimeApprovalServlet.java

package servlet;

import model.OvertimeDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;


public class OvertimeApprovalServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int overtimeID = Integer.parseInt(request.getParameter("overtimeID"));
            String status = request.getParameter("status");

            OvertimeDAO dao = new OvertimeDAO();
            boolean success = dao.updateVerification(overtimeID, status);

            if (success) {
                response.sendRedirect("adminOvertimeList.jsp?result=success");
            } else {
                response.sendRedirect("adminOvertertimeList.jsp?result=fail");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("adminOvertimeList.jsp?result=fail");
        }
    }
}
