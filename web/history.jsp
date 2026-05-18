<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, model.Attendance, model.User" %>

<%@ page import="model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>


<%@ include file="includes/ssHeader.jsp" %>

<div class="main-content">
    <div class="container py-5">
        <div class="card shadow-lg border-0">
            <div class="card-header bg-primary text-white text-center">
                <h3><i class="bi bi-clock-history"></i> Attendance History</h3>
            </div>

            <div class="card-body">

                <div class="mb-4 text-center">
                    <h5>Welcome, <%= user.getFullName() %> (ID: <%= user.getUserID() %>)</h5>
                </div>

                <div class="table-responsive">
                    <table class="table table-bordered table-hover align-middle text-center">
                        <thead class="table-primary">
                            <tr>
                                <th>Date</th>
                                <th>Clock In</th>
                                <th>Clock Out</th>
                                <th>Status</th>
                            </tr>
                        </thead>

                        <tbody>
                        <% 
                            List<Attendance> attendanceList = (List<Attendance>) request.getAttribute("attendanceList");
                            if (attendanceList != null && !attendanceList.isEmpty()) {
                                for (Attendance att : attendanceList) {
                        %>
                            <tr>
                                <td><%= att.getDate() %></td>
                                <td><%= att.getClockIn() != null ? att.getClockIn() : "-" %></td>
                                <td><%= att.getClockOut() != null ? att.getClockOut() : "-" %></td>
                                <td><%= att.getAttendanceStatus() %></td>
                            </tr>
                        <% 
                                }
                            } else { 
                        %>
                            <tr>
                                <td colspan="4" class="text-muted">No attendance records found.</td>
                            </tr>
                        <% } %>
                        </tbody>
                    </table>
                </div>

                <div class="text-center mt-4">
                    <a href="employeeAttendance.jsp" class="btn btn-secondary px-4 py-2">
                        <i class="bi bi-arrow-left"></i> Back to Attendance
                    </a>
                </div>

            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
