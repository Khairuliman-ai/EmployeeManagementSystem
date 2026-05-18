package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.LeaveApplicationDAO;

public class DeleteLeaveAppServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        
        String leaveIdStr = request.getParameter("leaveId");
        String userId = request.getParameter("userId");

        if (leaveIdStr != null) {
            int leaveId = Integer.parseInt(leaveIdStr);

            LeaveApplicationDAO dao = new LeaveApplicationDAO();
            String status = dao.getLeaveStatusById(leaveId);

            if ("Pending".equalsIgnoreCase(status)) {
                dao.deleteLeave(leaveId);
                response.sendRedirect("viewLeaveApp.jsp?msg=deleted&userId=" + userId);
            } else {
                response.sendRedirect("viewLeaveApp.jsp?msg=nodelete&userId=" + userId);
            }
        } else {
            response.sendRedirect("viewLeaveApp.jsp?msg=invalid");
        }
    }
}
