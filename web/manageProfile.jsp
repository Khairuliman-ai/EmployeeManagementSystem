<%@ page import="java.util.*, model.User, model.UserDao" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="model.User" %>
<%
  User user = (User) session.getAttribute("user");
  if (user == null) {
      response.sendRedirect("login.jsp");
      return;
  }
%>

<%@ include file="includes/hrdHeader.jsp" %>

<div class="main-content">
    <div class="container py-4">
        <h2 class="mb-4 text-center text-primary">Manage Profiles</h2>

        <!-- ✅ Bootstrap Alert Notification -->
        <%
            String message = request.getParameter("message");
            if (message != null) {
                String alertClass = "info";
                String alertText = "Something happened.";

                if ("add_success".equals(message)) {
                    alertClass = "success";
                    alertText = "✅ New user added successfully.";
                } else if ("update_success".equals(message)) {
                    alertClass = "primary";
                    alertText = "✅ User updated successfully.";
                } else if ("delete_success".equals(message)) {
                    alertClass = "danger";
                    alertText = "✅ User deleted successfully.";
                } else {
                    alertClass = "warning";
                    alertText = "❌ An error occurred.";
                }
        %>
            <div class="alert alert-<%= alertClass %> alert-dismissible fade show text-center" role="alert">
                <%= alertText %>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        <%
            }
        %>

        <!-- ✅ Add New Profile Form -->
        <div class="card mb-4 p-3 shadow-sm">
            <h4 class="mb-3">Add New Profile</h4>
            <form action="ProfileServlet1" method="post" class="row g-3">
                <div class="col-md-4">
                    <label>Username:</label>
                    <input type="text" name="username" class="form-control" required>
                </div>
                <div class="col-md-4">
                    <label>Full Name:</label>
                    <input type="text" name="fullName" class="form-control" required>
                </div>
                <div class="col-md-4">
                    <label>Gender:</label>
                    <select name="gender" class="form-select" required>
                        <option value="">Select</option>
                        <option value="male">Male</option>
                        <option value="female">Female</option>
                        <option value="other">Other</option>
                    </select>
                </div>
                <div class="col-md-4">
                    <label>Email:</label>
                    <input type="email" name="email" class="form-control" required>
                </div>
                <div class="col-md-4">
                    <label>Phone:</label>
                    <input type="text" name="phone" class="form-control" required>
                </div>
                <div class="col-md-4">
                    <label>Password:</label>
                    <input type="password" name="password" class="form-control" required>
                </div>
                <div class="col-md-4">
                    <label>Address:</label>
                    <input type="text" name="address" class="form-control">
                </div>
                <div class="col-md-4">
                    <label>Department:</label>
                    <input type="text" name="department" class="form-control">
                </div>
                <div class="col-md-4">
                    <label>DOB:</label>
                    <input type="date" name="dob" class="form-control">
                </div>
                <div class="col-md-4">
                    <label>Role:</label>
                    <select name="role" class="form-select" required>
                        <option value="">Select</option>
                        <option value="HRD">HRD</option>
                        <option value="Head of PTJ">Head of PTJ</option>
                        <option value="Supporting Staff">Supporting Staff</option>
                        <option value="Academician">Academician</option>
                    </select>
                </div>
                <div class="col-12 text-center mt-3">
                    <button type="submit" class="btn btn-primary px-4">Add Profile</button>
                </div>
            </form>
        </div>

        <!-- ✅ Search and Sort Forms -->
        <form action="ProfileServlet1" method="get" class="mb-4 d-flex gap-2">
            <input type="hidden" name="action" value="search">
            <input type="text" name="searchTerm" class="form-control" placeholder="Search by ID, Full Name, or Role"
                   value="<%= request.getParameter("searchTerm") != null ? request.getParameter("searchTerm") : "" %>">
            <button type="submit" class="btn btn-secondary">Search</button>
        </form>

        <form action="ProfileServlet1" method="get" class="mb-4 d-flex gap-2">
            <input type="hidden" name="action" value="sort">
            <button type="submit" name="sortBy" value="gender" class="btn btn-outline-primary">Sort by Gender</button>
            <button type="submit" name="sortBy" value="department" class="btn btn-outline-primary">Sort by Department</button>
            <button type="submit" name="sortBy" value="role" class="btn btn-outline-primary">Sort by Role</button>
        </form>

        <!-- ✅ Display Table -->
        <%
            List<User> userList = (List<User>) request.getAttribute("userList");
            if (userList == null) {
                UserDao dao = new UserDao();
                userList = dao.getAllUsers();
            }
        %>

        <div class="table-responsive">
            <table class="table table-bordered table-hover align-middle">
                <thead class="table-dark text-center">
                    <tr>
                        <th>ID</th><th>Username</th><th>Full Name</th><th>Gender</th><th>Email</th><th>Phone</th>
                        <th>Department</th><th>DOB</th><th>Password</th><th>Address</th><th>Role</th><th>Action</th>
                    </tr>
                </thead>
                <tbody>
                <% for (User u : userList) { %>
                    <tr>
                    <form action="ProfileServlet1" method="post">
                        <td><%= u.getUserID() %><input type="hidden" name="userID" value="<%= u.getUserID() %>"></td>
                        <td><input type="text" name="username" value="<%= u.getUsername() %>" class="form-control" required></td>
                        <td><input type="text" name="fullName" value="<%= u.getFullName() %>" class="form-control" required></td>
                        <td>
                            <select name="gender" class="form-select" required>
                                <option value="male" <%= "male".equalsIgnoreCase(u.getGender()) ? "selected" : "" %>>Male</option>
                                <option value="female" <%= "female".equalsIgnoreCase(u.getGender()) ? "selected" : "" %>>Female</option>
                                <option value="other" <%= "other".equalsIgnoreCase(u.getGender()) ? "selected" : "" %>>Other</option>
                            </select>
                        </td>
                        <td><input type="email" name="email" value="<%= u.getEmail() %>" class="form-control" required></td>
                        <td><input type="text" name="phone" value="<%= u.getPhone() %>" class="form-control" required></td>
                        <td><input type="text" name="department" value="<%= u.getDepartment() %>" class="form-control" required></td>
                        <td><input type="date" name="dob" value="<%= u.getDob() %>" class="form-control"></td>
                        <td><input type="password" name="password" value="<%= u.getPassword() %>" class="form-control" required></td>
                        <td><input type="text" name="address" value="<%= u.getAddress() %>" class="form-control"></td>
                        <td>
                            <select name="role" class="form-select" required>
                                <option value="HRD" <%= "HRD".equals(u.getRole()) ? "selected" : "" %>>HRD</option>
                                <option value="Head of PTJ" <%= "Head of PTJ".equals(u.getRole()) ? "selected" : "" %>>Head of PTJ</option>
                                <option value="Supporting Staff" <%= "Supporting Staff".equals(u.getRole()) ? "selected" : "" %>>Supporting Staff</option>
                                <option value="Academician" <%= "Academician".equals(u.getRole()) ? "selected" : "" %>>Academician</option>
                            </select>
                        </td>
                        <td class="text-center">
                            <button type="submit" class="btn btn-sm btn-success mb-1"
                                    onclick="return confirm('✅ Confirm update this user?');">Update</button>
                            <a href="ProfileServlet1?action=delete&userID=<%= u.getUserID() %>"
                               class="btn btn-sm btn-danger"
                               onclick="return confirm('⚠ Are you sure you want to delete this user?');">Delete</a>
                        </td>
                    </form>
                    </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
