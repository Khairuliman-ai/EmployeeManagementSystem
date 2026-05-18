package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.UserAttendance;

@WebServlet("/generate")
public class AttendanceReportGenerator extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AttendanceReportGenerator</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AttendanceReportGenerator at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        UserAttendance userAtt = new UserAttendance();

        userAtt.setUserID(Integer.parseInt(request.getParameter("userId")));
        userAtt.setFullName(request.getParameter("userName"));
        userAtt.setRole(request.getParameter("role"));
        userAtt.setDepartment(request.getParameter("department"));
        userAtt.setMonth(request.getParameter("month"));
        userAtt.setAttendedDays(Integer.parseInt(request.getParameter("attendedDays")));
        userAtt.setAttendancePercentage(Double.parseDouble(request.getParameter("attendancePercentage")));

        request.setAttribute("userAttribute", userAtt);
        
        request.getRequestDispatcher("WarningLetter.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
