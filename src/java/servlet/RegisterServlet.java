package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import model.User;
import model.UserDao;

public class RegisterServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String username = request.getParameter("username");
            String fullName = request.getParameter("fullName");
            String gender = request.getParameter("gender");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String password = request.getParameter("password");
            String address = request.getParameter("address");
            String department = request.getParameter("department");
            String dob = request.getParameter("dob");
            String role = request.getParameter("role");

            // ✅ Basic input validation
            if (username == null || username.trim().isEmpty() ||
                fullName == null || fullName.trim().isEmpty() ||
                password == null || password.trim().isEmpty() ||
                role == null || role.trim().isEmpty()) {

                System.out.println("❌ Validation failed: Required fields are missing.");
                response.sendRedirect("register.jsp?error=missing");
                return;
            }

            // ✅ Create User object
            User user = new User(0, username.trim(), fullName.trim(), gender, email, phone, password, address, department, dob, role);

            UserDao userDao = new UserDao();
            boolean success = userDao.registerUser(user);

            if (success) {
                System.out.println("✅ User registered successfully.");
                response.sendRedirect("login.jsp?registered=1");
            } else {
                System.out.println("❌ Registration failed in DAO.");
                response.sendRedirect("register.jsp?error=database");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("register.jsp?error=server");
        }
    }
}
