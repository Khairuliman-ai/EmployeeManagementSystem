<%@ page import="java.util.List" %>
<%@ page import="model.LeaveApplicationDAO" %>
<%@ page import="model.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<%-- ✅ Dynamically include correct header based on role --%>
<% 
    if ("HRD".equals(user.getRole())) { 
%>
    <%@ include file="includes/hrdHeader.jsp" %>
<% 
    } else if ("Head of PTJ".equals(user.getRole())) { 
%>
    <%@ include file="includes/ptjHeader.jsp" %>
<% 
    } else if ("Academician".equals(user.getRole())) { 
%>
    <%@ include file="includes/aHeader.jsp" %>
<% 
    } else { 
%>
    <%@ include file="includes/ssHeader.jsp" %>
<% 
    } 
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Leave Applications</title>

    <!-- Bootstrap 5.3 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f8f9fa;
        }
        .main-content {
            margin-left: 240px;
            padding: 20px;
        }
        .table-container {
            background: #fff;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        }
        .table th, .table td {
            vertical-align: middle;
        }
        @media (max-width: 768px) {
            .main-content {
                margin-left: 0;
                padding: 20px;
            }
        }
    </style>
</head>

<body>

<div class="main-content">
    <div class="container">
        <div class="table-container">
            <h2 class="text-center mb-4 text-primary">My Leave Applications</h2>

            <%
                List<String[]> applications = LeaveApplicationDAO.getLeavesByUserID(String.valueOf(user.getUserID()));

                if (applications.isEmpty()) {
            %>
                <div class="alert alert-info text-center">
                    No leave applications found.
                </div>
            <% } else { %>

                <div class="table-responsive">
                    <table class="table table-bordered table-hover text-center align-middle">
                        <thead class="table-light">
                            <tr>
                                <th>Leave ID</th>
                                <th>Leave Type</th>
                                <th>Start Date</th>
                                <th>End Date</th>
                                <th>Reason</th>
                                <th>Status</th>
                                <th>Attachment</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                        <% for (String[] app : applications) { %>
                            <tr>
                                <td><%= app[0] %></td>
                                <td><%= app[2] %></td>
                                <td><%= app[3] %></td>
                                <td><%= app[4] %></td>
                                <td><%= app[5] %></td>
                                <td>
                                    <% 
                                        String status = app[6];
                                        String badgeClass = "secondary";
                                        if ("Pending".equalsIgnoreCase(status)) badgeClass = "warning";
                                        else if ("Approved".equalsIgnoreCase(status)) badgeClass = "success";
                                        else if ("Rejected".equalsIgnoreCase(status)) badgeClass = "danger";
                                    %>
                                    <span class="badge bg-<%= badgeClass %>"><%= status %></span>
                                </td>
                                <td>
                                    <% if (app[7] != null && !app[7].isEmpty()) { %>
                                        <a href="uploadFiles/<%= app[7] %>" target="_blank" class="btn btn-sm btn-outline-primary">
                                            <i class="bi bi-file-earmark-text"></i> View
                                        </a>
                                    <% } else { %>
                                        <span class="text-muted">N/A</span>
                                    <% } %>
                                </td>
                                <td>
                    <% if ("Pending".equalsIgnoreCase(status)) {%>
                    <form action="deleteLeaveAppServlet" method="post" onsubmit="return confirm('Are you sure you want to delete this leave application?');">
                        <input type="hidden" name="leaveId" value="<%= app[0]%>">
                        <input type="hidden" name="userId" value="<%= app[1]%>">
                        <input type="submit" value="Delete">
                    </form>
                    <% } else { %>
                    Can't be deleted
                    <% } %>
                </td>
                            </tr>
                        <% } %>
                        </tbody>
                    </table>
                </div>

            <% } %>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
