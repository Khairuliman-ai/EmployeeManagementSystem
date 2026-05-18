/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.LeaveApplicationDAO;

/**
 *
 * @author njae2
 */
public class manageLeaveAppServlet extends HttpServlet {

   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        // Get all leave applications
        List<String[]> applications = LeaveApplicationDAO.getAllLeaveApp();
        System.out.println(applications);

        // Add to request attribute to pass to JSP
        request.setAttribute("applications", applications);

        // Forward to JSP page to display
        RequestDispatcher dispatcher = request.getRequestDispatcher("manageLeaveAppPTJ.jsp");
        dispatcher.forward(request, response);
        
        
    }

}
