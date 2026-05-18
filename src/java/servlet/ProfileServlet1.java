package servlet;

import model.User;
import model.UserDao;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

public class ProfileServlet1 extends HttpServlet {
    private UserDao userDao;

    @Override
    public void init() {
        userDao = new UserDao();
    }

    @Override
protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    try {
        String action = request.getParameter("action");
        List<User> userList;

        if (action == null || action.equals("list")) {
            userList = userDao.getAllUsers();

        } else if (action.equals("search")) {
            String searchTerm = request.getParameter("searchTerm");
            userList = userDao.getAllUsers();
            if (searchTerm != null && !searchTerm.trim().isEmpty()) {
                List<User> filteredList = new ArrayList<>();
                searchTerm = searchTerm.toLowerCase();
                for (User user : userList) {
                    if ((user.getUserID() != 0 && String.valueOf(user.getUserID()).contains(searchTerm)) ||
                        (user.getFullName() != null && user.getFullName().toLowerCase().contains(searchTerm)) ||
                        (user.getRole() != null && user.getRole().toLowerCase().contains(searchTerm))) {
                        filteredList.add(user);
                    }
                }
                userList = filteredList;
            }

        } else if (action.equals("sort")) {
            String sortBy = request.getParameter("sortBy");
            userList = userDao.getAllUsers();

            if (sortBy != null) {
                if (sortBy.equals("gender")) {
                    userList.sort(Comparator.comparing(User::getGender, String.CASE_INSENSITIVE_ORDER));
                } else if (sortBy.equals("department")) {
                    userList.sort(Comparator.comparing(User::getDepartment, String.CASE_INSENSITIVE_ORDER));
                } else if (sortBy.equals("role")) {
                    userList.sort(Comparator.comparing(User::getRole, String.CASE_INSENSITIVE_ORDER));
                }
            }

        } else if (action.equals("delete")) {
            String idParam = request.getParameter("userID");
            if (idParam != null && !idParam.isEmpty()) {
                int userID = Integer.parseInt(idParam);
                userDao.deleteUser(userID);
            }
            response.sendRedirect("ProfileServlet1?action=list&message=delete_success");
            return;

        } else {
            userList = userDao.getAllUsers();
        }

        request.setAttribute("userList", userList);
        request.getRequestDispatcher("manageProfile.jsp").forward(request, response);
    } catch (Exception e) {
        e.printStackTrace();
        request.setAttribute("message", "Error: " + e.getMessage());
        request.getRequestDispatcher("manageProfile.jsp").forward(request, response);
    }
}


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String idParam = request.getParameter("userID");

            // Collect form data
            String username = request.getParameter("username");
            String fullName = request.getParameter("fullName");
            String gender = request.getParameter("gender");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String department = request.getParameter("department");
            String dob = request.getParameter("dob");
            String role = request.getParameter("role");
            String password = request.getParameter("password");
            String address = request.getParameter("address");

            UserDao dao = new UserDao();

            if (idParam == null || idParam.trim().isEmpty()) {
                // INSERT new user
                User newUser = new User(0, username, fullName, gender, email, phone, password, address, department, dob, role);
                dao.registerUser(newUser);
                response.sendRedirect("ProfileServlet1?action=list&message=add_success");
                return;
            } else {
                // UPDATE existing user
                int userID = Integer.parseInt(idParam);
                User existingUser = dao.getUserById(userID);
                if (existingUser != null) {
                    User updatedUser = new User(
                        userID,
                        username != null ? username.trim() : existingUser.getUsername(),
                        fullName != null ? fullName.trim() : existingUser.getFullName(),
                        gender != null ? gender : existingUser.getGender(),
                        email != null ? email : existingUser.getEmail(),
                        phone != null ? phone : existingUser.getPhone(),
                        password != null ? password : existingUser.getPassword(),
                        address != null ? address : existingUser.getAddress(),
                        department != null ? department : existingUser.getDepartment(),
                        dob != null ? dob : existingUser.getDob(),
                        role != null ? role : existingUser.getRole()
                    );
                    dao.updateUser(updatedUser);
                }
                response.sendRedirect("ProfileServlet1?action=list&message=update_success");
                return;
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("ProfileServlet1?action=list&message=error");
        }
    }
}