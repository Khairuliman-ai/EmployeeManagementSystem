<%@ page import="model.Attendance" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
Attendance attendance = (Attendance) request.getAttribute("attendance");
%>
<html>
<head><title>Edit Attendance</title></head>
<body>
<h2>Edit Attendance</h2>
<form action="AdminAttendanceServlet" method="post">
    <input type="hidden" name="attendanceID" value="<%=attendance.getAttendanceID()%>">
    Date: <input type="date" name="date" value="<%=attendance.getDate()%>"><br>
    ClockIn: <input type="text" name="clockIn" value="<%=attendance.getClockIn()%>"><br>
    ClockOut: <input type="text" name="clockOut" value="<%=attendance.getClockOut()%>"><br>
    Status: <input type="text" name="status" value="<%=attendance.getAttendanceStatus()%>"><br>
    <input type="submit" value="Update">
</form>
</body>
</html>
