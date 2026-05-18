package servlet;

import java.io.*;
import java.nio.file.Paths;
import java.sql.Date;
import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;

import model.LeaveApplicationDAO;
import model.User;

@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,  // 2MB threshold
    maxFileSize = 1024 * 1024 * 10,       // 10MB max file size
    maxRequestSize = 1024 * 1024 * 50     // 50MB max request size
)
public class SaveLeaveAppServlet extends HttpServlet {

    private static final String UPLOAD_DIR = "uploadFiles";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Session check
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = user.getUserID();

        try {
            // Extract form fields
            String leaveType = request.getParameter("leaveType");
            String startDateStr = request.getParameter("startDate");
            String endDateStr = request.getParameter("endDate");
            String reason = request.getParameter("reason");

            if (startDateStr == null || startDateStr.isEmpty() || endDateStr == null || endDateStr.isEmpty()) {
                response.getWriter().println("Please select both start and end dates.");
                return;
            }

            Date startDate = Date.valueOf(startDateStr);
            Date endDate = Date.valueOf(endDateStr);

            // Handle file upload
            Part filePart = request.getPart("reasonFile");
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

            // Set upload path inside your webapp directory
            String applicationPath = request.getServletContext().getRealPath("");
            String uploadPath = applicationPath + File.separator + UPLOAD_DIR;

            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            String filePath = uploadPath + File.separator + fileName;
            filePart.write(filePath);

            // Insert into database (using your DAO)
            boolean result = LeaveApplicationDAO.insertLeave(
                    userId, leaveType, startDate, endDate, reason, "Pending", fileName
            );

            if (result) {
                response.sendRedirect("viewLeaveApp.jsp");
            } else {
                response.getWriter().println("Failed to submit leave application.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("An error occurred: " + e.getMessage());
        }
    }
}
