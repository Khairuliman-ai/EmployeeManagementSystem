// servlet/OvertimeSubmitServlet.java

package servlet;

import model.OvertimeDAO;
import model.Overtime;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Time;
import java.sql.Date;


public class OvertimeSubmitServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int userID = Integer.parseInt(request.getParameter("userID"));
            String startTimeStr = request.getParameter("startTime") + ":00";
            String endTimeStr = request.getParameter("endTime") + ":00";
            String dateStr = request.getParameter("dateOvertime");

            Time startTime = Time.valueOf(startTimeStr);
            Time endTime = Time.valueOf(endTimeStr);
            Date dateOvertime = Date.valueOf(dateStr);

            Overtime overtime = new Overtime    ();
            overtime.setUserID(userID);
            overtime.setStartTime(startTime);
            overtime.setEndTime(endTime);
            overtime.setDateOvertime(dateOvertime);
            overtime.setVerification("Pending");

            OvertimeDAO dao = new OvertimeDAO();
            boolean success = dao.insertOvertime(overtime);

            if (success) {
                response.sendRedirect("overtime.jsp?success=true");
            } else {
                response.sendRedirect("overtime.jsp?success=false");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("overtime.jsp?error=true");
        }
    }
}
