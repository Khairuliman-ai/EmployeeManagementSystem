package servlet;

import model.User;
import model.UserDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import javax.servlet.http.Part;

@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
                 maxFileSize = 1024 * 1024 * 10,      // 10MB
                 maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class ProfileServletUser extends HttpServlet {

    private UserDao userDao;

    @Override
    public void init() {
        userDao = new UserDao();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int userID = Integer.parseInt(request.getParameter("userID"));
            User existingUser = userDao.getUserById(userID);
            if (existingUser == null) {
                request.setAttribute("message", "User not found.");
                request.getRequestDispatcher("updateProfileUser.jsp").forward(request, response);
                return;
            }

            // Read form data
            String username = request.getParameter("username");
            String fullName = request.getParameter("fullName");
            String gender = request.getParameter("gender");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String password = request.getParameter("password");
            String address = request.getParameter("address");
            String department = request.getParameter("department");
            String dob = request.getParameter("dob");

            // Handle file upload
            String profilePicFilename = existingUser.getProfilePic();  // keep existing by default

            Part filePart = request.getPart("profilePic");
            if (filePart != null && filePart.getSize() > 0) {
                
                // ✅ Save directly inside web/uploads folder (safe for NetBeans)
                String relativePath = "uploads";
                String absolutePath = getServletContext().getRealPath("/") + relativePath;

                File uploadDir = new File(absolutePath);
                if (!uploadDir.exists()) uploadDir.mkdirs();

                String fileName = extractFileName(filePart);
                String fullPath = absolutePath + File.separator + fileName;

                // Optional: delete old file if needed
                if (profilePicFilename != null) {
                    File oldFile = new File(getServletContext().getRealPath("/") + profilePicFilename);
                    if (oldFile.exists()) oldFile.delete();
                }

                filePart.write(fullPath);
                profilePicFilename = relativePath + "/" + fileName;
            }

            User updatedUser = new User(userID, username, fullName, gender, email, phone,
                                        password, address, department, dob, existingUser.getRole(), profilePicFilename);

            boolean success = userDao.updateUser(updatedUser);

            if (success) {
                request.setAttribute("message", "✅ Profile updated successfully.");
            } else {
                request.setAttribute("message", "❌ Failed to update profile.");
            }

            request.setAttribute("user", updatedUser);
            request.getRequestDispatcher("updateProfileUser.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "❌ Error occurred: " + e.getMessage());
            request.getRequestDispatcher("updateProfileUser.jsp").forward(request, response);
        }
    }

    // Helper method to extract file name from HTTP header content-disposition
    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        for (String token : contentDisp.split(";")) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf("=") + 2, token.length() - 1);
            }
        }
        return "";
    }
}
