<%@ page import="java.util.*, java.text.SimpleDateFormat" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Assume user is logged in and userID is in session
    Integer userID = (Integer) session.getAttribute("userID");
    if (userID == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Attendance Page</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container mt-5">
    <h2 class="mb-4">Welcome to Your Attendance Page</h2>

    <% String msg = (String) request.getAttribute("message"); %>
    <% if (msg != null) { %>
        <div class="alert alert-info"><%= msg %></div>
    <% } %>

    <form action="ClockInServlet" method="post" class="d-inline">
        <button type="submit" class="btn btn-success">Clock In</button>
    </form>

    <form action="ClockOutServlet" method="post" class="d-inline">
        <button type="submit" class="btn btn-danger">Clock Out</button>
    </form>

    <hr>

    <h4>Your Attendance History</h4>
    <table class="table table-bordered table-striped mt-3">
        <thead class="table-dark">
            <tr>
                <th>Date</th>
                <th>Clock In</th>
                <th>Clock Out</th>
                <th>Status</th>
            </tr>
        </thead>
        <tbody>
        <%
            // Load attendance history
            try {
                AttendanceDao dao = new AttendanceDao();
                List<Attendance> records = dao.getAttendanceByUser(userID);

                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

                for (Attendance a : records) {
        %>
            <tr>
                <td><%= dateFormat.format(a.getDate()) %></td>
                <td><%= a.getClockIn() %></td>
                <td><%= a.getClockOut() == null ? "-" : a.getClockOut() %></td>
                <td><%= a.getAttendanceStatus() %></td>
            </tr>
        <%
                }
            } catch (Exception e) {
                out.println("<tr><td colspan='4'>Error loading attendance history.</td></tr>");
                e.printStackTrace();
            }
        %>
        </tbody>
    </table>
</body>
</html>
