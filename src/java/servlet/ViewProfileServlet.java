package servlet;

import model.User;
import model.UserDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class ViewProfileServlet extends HttpServlet {

    private UserDao userDao;

    @Override
    public void init() {
        userDao = new UserDao();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String searchTerm = request.getParameter("searchTerm");
            System.out.println("Search term :" + searchTerm);
            List<User> userList = userDao.getAllUsers();

            // Apply filtering if searchTerm provided
            if (searchTerm != null && !searchTerm.trim().isEmpty()) {
                String lowerCaseSearch = searchTerm.trim().toLowerCase();
                List<User> filteredList = new ArrayList<>();

                for (User user : userList) {
                    boolean match = false;

                    if (String.valueOf(user.getUserID()).contains(lowerCaseSearch)) {
                        match = true;
                    }
                    if (!match && user.getFullName() != null && user.getFullName().toLowerCase().contains(lowerCaseSearch)) {
                        match = true;
                    }
                    if (!match && user.getRole() != null && user.getRole().toLowerCase().contains(lowerCaseSearch)) {
                        match = true;
                    }
                    if (!match && user.getDepartment() != null && user.getDepartment().toLowerCase().contains(lowerCaseSearch)) {
                        match = true;
                    }

                    if (match) {
                        filteredList.add(user);
                    }
                }

                userList = filteredList;
            }

            // Send result to JSP
            request.setAttribute("userList", userList);
            request.getRequestDispatcher("viewProfile.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "Error retrieving user list: " + e.getMessage());
            request.getRequestDispatcher("viewProfile.jsp").forward(request, response);
        }
    }
}
