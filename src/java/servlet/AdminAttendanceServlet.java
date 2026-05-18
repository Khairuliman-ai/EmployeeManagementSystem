package servlet;

import dao.AttendanceDAO;
import model.Attendance;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.*;


public class AdminAttendanceServlet extends HttpServlet {

    AttendanceDAO dao = new AttendanceDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        List<Attendance> list = new ArrayList<>();

        try {
            if (action == null || action.equals("list")) {
                list = dao.getAllAttendance();
            } 
            else if (action.equals("search")) {
                String keyword = request.getParameter("keyword");
                list = dao.searchAttendance(keyword);
            } 
            else if (action.equals("delete")) {
                int id = Integer.parseInt(request.getParameter("id"));
                dao.deleteAttendance(id);
                list = dao.getAllAttendance(); // reload list after deletion
            } 
            else if (action.equals("edit")) {
                int id = Integer.parseInt(request.getParameter("id"));
                Attendance attendance = dao.getAttendanceById(id);
                request.setAttribute("editAttendance", attendance);
                list = dao.getAllAttendance(); 
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.setAttribute("attendanceList", list);
        request.getRequestDispatcher("manageAttendance.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int attendanceID = Integer.parseInt(request.getParameter("attendanceID"));
        String dateStr = request.getParameter("date");
        String clockIn = request.getParameter("clockIn");
        String clockOut = request.getParameter("clockOut");
        String status = request.getParameter("status");

        try {
            Date date = new SimpleDateFormat("yyyy-MM-dd").parse(dateStr);
            Attendance attendance = new Attendance();
            attendance.setAttendanceID(attendanceID);
            attendance.setDate(date);
            attendance.setClockIn(clockIn);
            attendance.setClockOut(clockOut);
            attendance.setAttendanceStatus(status);

            dao.updateAttendance(attendance);
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("AdminAttendanceServlet?action=list");
    }
}
