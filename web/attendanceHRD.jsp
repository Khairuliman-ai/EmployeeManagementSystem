<%@ page import="java.util.*, model.Attendance" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Attendance Records</title>
</head>
<body>
    <form method="get" action="attendanceServlet">
        <input type="text" name="search" placeholder="Search by ID, name or role">
        <button type="submit">Search</button>
        <a href="attendanceServlet?sort=asc">Sort by Date Asc</a> |
        <a href="attendanceServlet?sort=desc">Sort by Date Desc</a>
    </form>

    <table border="1">
        <tr>
            <th>ID</th>
            <th>User ID</th>
            <th>Name</th>
            <th>Role</th>
            <th>Date</th>
            <th>Clock In</th>
            <th>Clock Out</th>
            <th>Status</th>
            <th>Actions</th>
        </tr>

        <%
            // Get the attendanceList from the request attribute
            List<Attendance> list = (List<Attendance>) request.getAttribute("attendanceList");
            if (list != null && !list.isEmpty()) {
                for (Attendance a : list) {
        %>
            <tr>
                <td><%= a.getAttendanceID() %></td>
                <td><%= a.getUserID() %></td>
                <td><%= a.getName() %></td>
                <td><%= a.getRole() %></td>
                <td><%= a.getDate() %></td>
                <td><%= a.getClockIn() %></td>
                <td><%= a.getClockOut() %></td>
                <td><%= a.getAttendanceStatus() %></td>
                <td>
                    <a href="attendanceServlet?action=edit&id=<%= a.getAttendanceID() %>">Edit</a>
                    <a href="attendanceServlet?action=delete&id=<%= a.getAttendanceID() %>" onclick="return confirm('Are you sure?')">Delete</a>
                </td>
            </tr>
        <%
                }
            } else {
        %>
            <tr>
                <td colspan="9">No attendance records found.</td>
            </tr>
        <%
            }
        %>
    </table>
</body>
</html>
