package servlet;

import dao.AttendanceDAO;
import model.Attendance;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;


public class ViewAttendancePTJServlet extends HttpServlet {

    private AttendanceDAO attendanceDAO;

    @Override
    public void init() {
        attendanceDAO = new AttendanceDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String searchTerm = request.getParameter("searchTerm");
            List<Attendance> attendanceList;

            if (searchTerm != null && !searchTerm.trim().isEmpty()) {
                attendanceList = attendanceDAO.searchAttendance(searchTerm.trim());
            } else {
                attendanceList = attendanceDAO.getAllAttendance();
            }

            request.setAttribute("attendanceList", attendanceList);
            request.getRequestDispatcher("viewAttendancePTJ.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Error loading attendance data.");
            request.getRequestDispatcher("viewAttendancePTJ.jsp").forward(request, response);
        }
    }
}
