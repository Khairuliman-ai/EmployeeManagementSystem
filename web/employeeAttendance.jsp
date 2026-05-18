<%@ page import="model.User" %>

<%
  User user = (User) session.getAttribute("user");
  if (user == null) {
      response.sendRedirect("login.jsp");
      return;
  }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Employee Attendance</title>

    <!-- Bootstrap 5.3 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f8f9fa;
        }
        .attendance-container {
            max-width: 600px;
            margin: 80px auto;
            padding: 30px;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        }
        .btn-lg {
            padding: 15px;
            font-size: 1.2rem;
        }
    </style>
</head>

<body>

<%-- ? Dynamically include correct header based on role --%>
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

<div class="main-content">
    <div class="attendance-container text-center">
        <h2 class="mb-4 text-primary">Attendance Panel</h2>

        <h5>Welcome, <%= user.getFullName() %> (ID: <%= user.getUserID() %>)</h5>

        <div class="d-grid gap-3 mt-5">

            <form action="EmployeeAttendanceServlet" method="get" 
                  onsubmit="return confirm('Are you sure you want to Clock In?');">
                <input type="hidden" name="action" value="clockin">
                <button type="submit" class="btn btn-success btn-lg w-100">
                    <i class="bi bi-box-arrow-in-right"></i> Clock In
                </button>
            </form>

            <form action="EmployeeAttendanceServlet" method="get" 
                  onsubmit="return confirm('Are you sure you want to Clock Out?');">
                <input type="hidden" name="action" value="clockout">
                <button type="submit" class="btn btn-warning btn-lg w-100">
                    <i class="bi bi-box-arrow-left"></i> Clock Out
                </button>
            </form>

            <form action="EmployeeAttendanceServlet" method="get">
                <input type="hidden" name="action" value="history">
                <button type="submit" class="btn btn-info btn-lg w-100">
                    <i class="bi bi-clock-history"></i> View Attendance History
                </button>
            </form>

            <% if (request.getAttribute("msg") != null) { %>
                <div class="alert alert-success mt-3">
                    <%= request.getAttribute("msg") %>
                </div>
            <% } %>

        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
