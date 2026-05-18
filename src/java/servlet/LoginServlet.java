package servlet;

import model.User;
import model.UserDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/loginServlet")
public class LoginServlet extends HttpServlet {

    private UserDao userDao;

    @Override
    public void init() {
        userDao = new UserDao();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        User user = new User(0, username, null, null, null, null, password, null, null, null, null, null);
        boolean validUser = userDao.validate(user);

        if (validUser) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);  // ✅ store full user object into session

            String role = user.getRole();

            // ✅ Centralized role-based redirection
            if ("Academician".equalsIgnoreCase(role)) {
                response.sendRedirect("aDashboard.jsp");
            } else if ("HRD".equalsIgnoreCase(role)) {
                response.sendRedirect("dashboard.jsp");
            } else if ("Head of PTJ".equalsIgnoreCase(role)) {
                response.sendRedirect("ptjDashboard.jsp");
            } else if ("Supporting Staff".equalsIgnoreCase(role)) {
                response.sendRedirect("ssDashboard.jsp");
            } else {
                // default fallback
                response.sendRedirect("defaultDashboard.jsp");
            }

        } else {
            request.setAttribute("error", "Invalid username or password.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
