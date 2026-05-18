package servlet;

import dao.AttendanceDAO;
import model.Attendance;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;


public class ViewAttendanceFilterServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String dayParam = request.getParameter("day");
            String monthParam = request.getParameter("month");
            String yearParam = request.getParameter("year");

            Integer day = (dayParam != null && !dayParam.isEmpty()) ? Integer.parseInt(dayParam) : null;
            Integer month = (monthParam != null && !monthParam.isEmpty()) ? Integer.parseInt(monthParam) : null;
            Integer year = (yearParam != null && !yearParam.isEmpty()) ? Integer.parseInt(yearParam) : null;

            AttendanceDAO dao = new AttendanceDAO();
            List<Attendance> attendanceList = dao.getAttendanceByDateFilter(day, month, year);

            request.setAttribute("attendanceList", attendanceList);
            request.getRequestDispatcher("viewAttendancePTJ.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}
