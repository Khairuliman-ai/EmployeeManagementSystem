package servlet;

import dao.AttendanceDAO;
import model.Attendance;
import model.User;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.*;


public class EmployeeAttendanceServlet extends HttpServlet {

    AttendanceDAO dao = new AttendanceDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        // Get user object from session
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            request.setAttribute("msg", "You are not logged in!");
            request.getRequestDispatcher("employeeAttendance.jsp").forward(request, response);
            return;
        }

        int userID = user.getUserID();
        String name = user.getFullName();
        String role = user.getRole();

        try {
            if (action.equals("clockin")) {
                Date now = new Date();
                String currentTime = new SimpleDateFormat("HH:mm:ss").format(now);
                String currentDateStr = new SimpleDateFormat("yyyy-MM-dd").format(now);
                Date currentDate = new SimpleDateFormat("yyyy-MM-dd").parse(currentDateStr);

                // check if already clocked in today
                List<Attendance> list = dao.searchAttendance(String.valueOf(userID));
                boolean alreadyClockedIn = false;

                for (Attendance a : list) {
                    if (isSameDay(a.getDate(), currentDate)) {
                        alreadyClockedIn = true;
                        break;
                    }
                }

                if (alreadyClockedIn) {
                    request.setAttribute("msg", "You already clocked in today.");
                } else {
                    String status = checkLate(now) ? "Late" : "Present";

                    Attendance att = new Attendance();
                    att.setUserID(userID);
                    att.setName(name);
                    att.setRole(role);
                    att.setDate(currentDate);
                    att.setClockIn(currentTime);
                    att.setClockOut("-");
                    att.setAttendanceStatus(status);
                    dao.addAttendance(att);

                    request.setAttribute("msg", "Clock-In Successful [" + status + "]");
                }
            }

            else if (action.equals("clockout")) {
                Date now = new Date();
                String currentTime = new SimpleDateFormat("HH:mm:ss").format(now);
                String currentDateStr = new SimpleDateFormat("yyyy-MM-dd").format(now);
                Date currentDate = new SimpleDateFormat("yyyy-MM-dd").parse(currentDateStr);

                List<Attendance> list = dao.searchAttendance(String.valueOf(userID));
                Attendance lastRecord = null;

                for (Attendance a : list) {
                    if (isSameDay(a.getDate(), currentDate)) {
                        lastRecord = a;
                        break;
                    }
                }

                if (lastRecord != null && lastRecord.getClockOut().equals("-")) {
                    lastRecord.setClockOut(currentTime);
                    dao.updateAttendance(lastRecord);
                    request.setAttribute("msg", "Clock-Out Successful");
                } else {
                    request.setAttribute("msg", "You have not clocked in today.");
                }
            }

            else if (action.equals("history")) {
                List<Attendance> list = dao.searchAttendance(String.valueOf(userID));
                request.setAttribute("attendanceList", list);
                request.getRequestDispatcher("history.jsp").forward(request, response);
                return;
            }

            request.getRequestDispatcher("employeeAttendance.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private boolean isSameDay(Date d1, Date d2) {
        SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMdd");
        return fmt.format(d1).equals(fmt.format(d2));
    }

    private boolean checkLate(Date now) {
        Calendar officeStart = Calendar.getInstance();
        officeStart.setTime(now);
        officeStart.set(Calendar.HOUR_OF_DAY, 8);
        officeStart.set(Calendar.MINUTE, 0);
        officeStart.set(Calendar.SECOND, 0);
        officeStart.set(Calendar.MILLISECOND, 0);

        return now.after(officeStart.getTime());
    }
}
