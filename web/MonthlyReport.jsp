<%@ page import="model.User" %>
<%@ page import="model.OvertimeDAO" %>
<%@ page import="model.userAttendance" %>
<%@ page import="java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%-- ✅ Session check and load user --%>
<%
    User currentSessionUser = (User) session.getAttribute("user");
    if (currentSessionUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    User user = currentSessionUser;
%>

<%-- ✅ Include correct sidebar based on role --%>
<%
    if ("HRD".equals(currentSessionUser.getRole())) {
%>
    <%@ include file="includes/hrdHeader.jsp" %>
<%
    } else if ("Head of PTJ".equals(currentSessionUser.getRole())) {
%>
    <%@ include file="includes/ptjHeader.jsp" %>
<%
    } else if ("Academician".equals(currentSessionUser.getRole())) {
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
<html>
<head>
    <meta charset="UTF-8">
    <title>Monthly Attendance Report</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<div class="main-content">
    <div class="container py-5">
        <div class="card shadow border-0">
            <div class="card-body">
                <h2 class="text-center text-primary mb-4">
                    <i class="bi bi-bar-chart-fill"></i> Monthly Attendance Report
                </h2>

                <table class="table table-bordered table-striped table-hover">
                    <thead class="table-dark text-center">
                        <tr>
                            <th>Employee ID</th>
                            <th>Name</th>
                            <th>Role</th>
                            <th>Department</th>
                            <th>Month</th>
                            <th>Days Present</th>
                            <th>Attendance %</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                    <%
                        String department = request.getParameter("department");
                        int year = Integer.parseInt(request.getParameter("year"));
                        int month = Integer.parseInt(request.getParameter("month"));

                        List<userAttendance> list = OvertimeDAO.getMonthlyAttendanceReport(department, year, month);

                        for (userAttendance e : list) {
                            String warning = e.getAttendancePercentage() < 60 ? "table-danger" : "";
                    %>
                        <tr class="<%= warning %> text-center align-middle">
                        <form action="generate" method="post">
                            <input type="hidden" name="userId" value="<%= e.getUserID() %>">
                            <input type="hidden" name="userName" value="<%= e.getFullName() %>">
                            <input type="hidden" name="role" value="<%= e.getRole() %>">
                            <input type="hidden" name="department" value="<%= e.getDepartment() %>">
                            <input type="hidden" name="month" value="<%= e.getMonth() %>">
                            <input type="hidden" name="attendedDays" value="<%= e.getAttendedDays() %>">
                            <input type="hidden" name="attendancePercentage" value="<%= e.getAttendancePercentage() %>">

                            <td><%= e.getUserID() %></td>
                            <td><%= e.getFullName() %></td>
                            <td><%= e.getRole() %></td>
                            <td><%= e.getDepartment() %></td>
                            <td><%= e.getMonth() %></td>
                            <td><%= e.getAttendedDays() %></td>
                            <td><%= e.getAttendancePercentage() %> %</td>
                            <% if (!warning.equals("")) { %>
                            <td>
                                <button type="submit" class="btn btn-sm btn-warning">Generate Report</button>
                            </td>
                            <% } else { %>
                            <td>-</td>
                            <% } %>
                        </form>
                        </tr>
                    <%
                        }
                    %>
                    </tbody>
                </table>

            </div>
        </div>
    </div>
</div>

</body>
</html>
