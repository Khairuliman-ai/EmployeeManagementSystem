// servlet/OvertimeUpdateServlet.java

package servlet;

import model.OvertimeDAO;
import model.Overtime;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Time;
import java.sql.Date;

@WebServlet("/updateOvertime")
public class OvertimeUpdateServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int overtimeID = Integer.parseInt(request.getParameter("overtimeID"));
            Date dateOvertime = Date.valueOf(request.getParameter("dateOvertime"));
            Time startTime = Time.valueOf(request.getParameter("startTime") + ":00");
            Time endTime = Time.valueOf(request.getParameter("endTime") + ":00");
            

            Overtime overtime = new Overtime();
            overtime.setOvertimeID(overtimeID);
            overtime.setDateOvertime(dateOvertime);
            overtime.setStartTime(startTime);
            overtime.setEndTime(endTime);

            OvertimeDAO dao = new OvertimeDAO();
            boolean success = dao.updateOvertime(overtime);

            response.sendRedirect("overtime.jsp?updated=" + success);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("overtime.jsp?updated=false");
        }
    }
}
