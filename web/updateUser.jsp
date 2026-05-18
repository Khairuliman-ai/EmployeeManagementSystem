<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User, model.UserDao, java.sql.SQLException" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update User</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body { font-family: Arial, sans-serif; background-color: #f0f0f0; padding: 20px; }
        .container { max-width: 600px; margin: 0 auto; background-color: #fff; padding: 20px; border-radius: 5px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
        h2 { color: #333; margin-bottom: 20px; }
        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; margin-bottom: 5px; }
        .form-group input, .form-group select { width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 5px; }
        .submit-btn { background-color: #4CAF50; color: white; padding: 10px 20px; border: none; border-radius: 5px; cursor: pointer; }
        .submit-btn:hover { background-color: #45a049; }
    </style>
</head>
<body>
<div class="container">
    <h2>Update User</h2>
    <% 
        int userID = Integer.parseInt(request.getParameter("userID"));
        UserDao userDao = new UserDao();
        User user = null;
        try {
            user = userDao.getUserById(userID);
            if (user == null) {
                out.println("<p>User not found.</p>");
                return;
            }
        } catch (SQLException e) {
            out.println("<p>Error retrieving user: " + e.getMessage() + "</p>");
            return;
        }
    %>
    <form action="ProfileServlet1" method="post">
        <input type="hidden" name="_method" value="PUT">
        <input type="hidden" name="userID" value="<%= user.getUserID() %>">
        <div class="form-group">
            <label for="username">Username:</label>
            <input type="text" name="username" id="username" value="<%= user.getUsername() %>" required>
        </div>
        <div class="form-group">
            <label for="fullName">Full Name:</label>
            <input type="text" name="fullName" id="fullName" value="<%= user.getFullName() %>" required>
        </div>
        <div class="form-group">
            <label for="gender">Gender:</label>
            <select name="gender" id="gender" required>
                <option value="male" <%= "male".equals(user.getGender()) ? "selected" : "" %>>male</option>
                <option value="female" <%= "female".equals(user.getGender()) ? "selected" : "" %>>female</option>
                <option value="other" <%= "other".equals(user.getGender()) ? "selected" : "" %>>other</option>
            </select>
        </div>
        <div class="form-group">
            <label for="email">Email:</label>
            <input type="email" name="email" id="email" value="<%= user.getEmail() %>" required>
        </div>
        <div class="form-group">
            <label for="phone">Phone:</label>
            <input type="tel" name="phone" id="phone" value="<%= user.getPhone() %>" required>
        </div>
        <div class="form-group">
            <label for="password">Password:</label>
            <input type="password" name="password" id="password" value="<%= user.getPassword() %>" required>
        </div>
        <div class="form-group">
            <label for="address">Address:</label>
            <input type="text" name="address" id="address" value="<%= user.getAddress() != null ? user.getAddress() : "" %>">
        </div>
        <div class="form-group">
            <label for="department">Department:</label>
            <input type="text" name="department" id="department" value="<%= user.getDepartment() != null ? user.getDepartment() : "" %>">
        </div>
        <div class="form-group">
            <label for="dob">Date of Birth:</label>
            <input type="date" name="dob" id="dob" value="<%= user.getDob() != null ? user.getDob() : "" %>">
        </div>
        <div class="form-group">
            <label for="role">Role:</label>
            <select name="role" id="role" required>
                <option value="Supporting Staff" <%= "Supporting Staff".equals(user.getRole()) ? "selected" : "" %>>Supporting Staff</option>
                <option value="Academician" <%= "Academician".equals(user.getRole()) ? "selected" : "" %>>Academician</option>
            </select>
        </div>
        <button type="submit" class="submit-btn">Save Changes</button>
    </form>
</div>
</body>
</html>