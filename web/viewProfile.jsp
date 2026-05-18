<%@ page import="java.util.*, model.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!-- ✅ Sidebar + Styling from ptjHeader.jsp -->
<%@ include file="includes/ptjHeader.jsp" %>

<!-- ✅ Main content starts after the sidebar -->
<div class="main-content container py-4">
    <h2 class="mb-4 text-primary text-center">
        <i class="bi bi-person-lines-fill"></i> View Profiles (Head of PTJ)
    </h2>

    <!-- ✅ Search Form -->
    <form action="ViewProfileServlet" method="get" class="mb-4 d-flex gap-2">
        <input type="text" name="searchTerm" class="form-control" placeholder="Search by ID, Name, Role, Department"
               value="<%= request.getParameter("searchTerm") != null ? request.getParameter("searchTerm") : "" %>">
        <button type="submit" class="btn btn-primary"><i class="bi bi-search"></i> Search</button>
    </form>

    <%
        List<User> userList = (List<User>) request.getAttribute("userList");
        if (userList == null) {
            userList = new ArrayList<User>();  // prevent null pointer if servlet fails
        }
    %>

    <div class="table-responsive mx-auto" style="max-width: 1200px;">

        <table class="table table-bordered table-hover text-center align-middle">
            <thead class="table-dark">
                <tr>
                    <th>ID</th>
                    <th>Username</th>
                    <th>Full Name</th>
                    <th>Gender</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>Department</th>
                    <th>DOB</th>
                    <th>Role</th>
                </tr>
            </thead>
            <tbody>
                <% for (User u : userList) { %>
                <tr>
                    <td><%= u.getUserID() %></td>
                    <td><%= u.getUsername() %></td>
                    <td><%= u.getFullName() %></td>
                    <td><%= u.getGender() %></td>
                    <td><%= u.getEmail() %></td>
                    <td><%= u.getPhone() %></td>
                    <td><%= u.getDepartment() %></td>
                    <td><%= u.getDob() %></td>
                    <td><%= u.getRole() %></td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</div>

<!-- ✅ Bootstrap JS already included in ptjHeader.jsp -->
