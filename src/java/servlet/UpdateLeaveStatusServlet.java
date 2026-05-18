/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.LeaveApplicationDAO;

/**
 *
 * @author njae2
 */
public class UpdateLeaveStatusServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try {

            int leaveId = Integer.parseInt(request.getParameter("leaveId"));
            String status = request.getParameter("status");//for ptj to approved or reject the form

            boolean updated = LeaveApplicationDAO.updateLeaveStatus(leaveId, status);

            if (updated) {
                response.sendRedirect("manageLeaveAppServlet");
            } else {
                response.getWriter().println("Failed to update leave status.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error processing request.");
        }
    }
}
