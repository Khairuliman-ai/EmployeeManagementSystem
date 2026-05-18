<%@ page import="java.util.*, model.Attendance" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head><title>Admin Attendance View</title></head>
<body>
<h2>Attendance List</h2>
<form action="AdminAttendanceServlet" method="get">
    <input type="hidden" name="action" value="search">
    Search: <input type="text" name="keyword">
    <input type="submit" value="Search">
</form>
<table border="1">
    <tr><th>ID</th><th>Name</th><th>Date</th><th>ClockIn</th><th>ClockOut</th><th>Status</th><th>Action</th></tr>
<% 
    List<Attendance> list = (List<Attendance>) request.getAttribute("attendanceList");
    for(Attendance a : list) {
%>
<tr>
    <td><%=a.getAttendanceID()%></td>
    <td><%=a.getName()%></td>
    <td><%=a.getDate()%></td>
    <td><%=a.getClockIn()%></td>
    <td><%=a.getClockOut()%></td>
    <td><%=a.getAttendanceStatus()%></td>
    <td>
        <a href="AdminAttendanceServlet?action=edit&id=<%=a.getAttendanceID()%>">Edit</a> |
        <a href="AdminAttendanceServlet?action=delete&id=<%=a.getAttendanceID()%>">Delete</a>
    </td>
</tr>
<% } %>
</table>
</body>
</html>
