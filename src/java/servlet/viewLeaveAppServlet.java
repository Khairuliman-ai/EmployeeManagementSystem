package servlet;

import java.io.IOException;
import java.util.List;
import javax.servlet.*;
import javax.servlet.http.*;
import model.LeaveApplicationDAO;
import model.User;

public class viewLeaveAppServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get user session
        HttpSession session = request.getSession(false);
        User userSession = (User) session.getAttribute("user");

        if (userSession == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String userId = String.valueOf(userSession.getUserID());

        List<String[]> applications = LeaveApplicationDAO.getLeavesByUserID(userId);
        request.setAttribute("applications", applications);

        RequestDispatcher dispatcher = request.getRequestDispatcher("viewLeaveApp.jsp");
        dispatcher.forward(request, response);
    }
}
