/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.time.LocalDate;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpSession;

/**
 *
 * @author HP
 */


@WebServlet("/MonthlyReportProcessServlet")

public class MonthlyReportProcessServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet MonthlyReportProcessServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet MonthlyReportProcessServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String department = request.getParameter("department");
        int year = Integer.parseInt(request.getParameter("year"));
        int month = Integer.parseInt(request.getParameter("month"));

        LocalDate currentDate = LocalDate.now(); // Gets current date from system clock in default time zone

        int currentYear = currentDate.getYear();   // Get year
        int currentMonth = currentDate.getMonthValue(); // Get month as number (1-12)
        
        HttpSession session = request.getSession();
        session.removeAttribute("errorMonth");
        session.removeAttribute("errorYear");
        
        if (month > currentMonth) {
            session.setAttribute("department", department);
            session.setAttribute("year", year);
            session.setAttribute("month", month);
            session.setAttribute("errorMonth", "The Month entered is invalid");
            request.getRequestDispatcher("MonthlyReportForm.jsp").forward(request, response);
            return;
        }

        if (year > currentYear) {
            session.setAttribute("department", department);
            session.setAttribute("year", year);
            session.setAttribute("month", month);
            session.setAttribute("errorYear", "The Year entered is invalid");
            request.getRequestDispatcher("MonthlyReportForm.jsp").forward(request, response);
            return;
        }

        request.getRequestDispatcher("MonthlyReport.jsp").forward(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
