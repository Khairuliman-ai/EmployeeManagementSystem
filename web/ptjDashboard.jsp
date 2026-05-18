<%@ page import="model.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<%@ include file="includes/ptjHeader.jsp" %>

<div class="main-content">
    <div class="container mt-4">
        <div class="text-center mb-4">
            <h2>Welcome, <%= user.getFullName() %></h2>
            <p class="lead">Use the sidebar to access and manage your modules.</p>
        </div>

        <div class="row justify-content-center">
            <div class="col-md-3 mb-3">
                <a href="updateProfileUser.jsp?userID=<%= user.getUserID() %>" class="btn btn-success w-100 py-3">
                    <i class="bi bi-person"></i> My Profile
                </a>
            </div>

            <div class="col-md-3 mb-3">
                <a href="ViewProfileServlet" class="btn btn-primary w-100 py-3">
                    <i class="bi bi-person-lines-fill"></i> View Profiles
                </a>
            </div>

            <div class="col-md-3 mb-3">
                <a href="ViewAttendancePTJServlet" class="btn btn-warning w-100 py-3">
                    <i class="bi bi-calendar-check"></i> View Attendance
                </a>
            </div>

            <div class="col-md-3 mb-3">
                <a href="adminOvertimeList.jsp" class="btn btn-info w-100 py-3">
                    <i class="bi bi-clock-history"></i> Overtime
                </a>
            </div>

            <div class="col-md-3 mb-3">
                <a href="manageLeaveAppServlet" class="btn btn-secondary w-100 py-3">
                    <i class="bi bi-door-open"></i> Leave Application
                </a>
            </div>

            <div class="col-md-3 mb-3">
                <a href="MonthlyReportForm.jsp" class="btn btn-dark w-100 py-3">
                    <i class="bi bi-bar-chart-line"></i> View Attendance Report
                </a>
            </div>
        </div>
    </div>
</div>
