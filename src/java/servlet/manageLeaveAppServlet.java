package servlet;

import java.io.IOException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.LeaveApplication;
import model.LeaveApplicationDAO;

public class ManageLeaveAppServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        LeaveApplicationDAO dao = new LeaveApplicationDAO();
        List<LeaveApplication> applications = dao.getAllLeaveApp();

        request.setAttribute("applications", applications);

        RequestDispatcher dispatcher = request.getRequestDispatcher("manageLeaveAppPTJ.jsp");
        dispatcher.forward(request, response);
    }
}
