



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
    <div class="container mt-4">
        <div class="text-center mb-4">
            <h2>Welcome, <%= user.getFullName() %></h2>
            <p class="lead">Use the dashboard to manage your profile, attendance, overtime, or leave application.</p>
        </div>

        <!-- ? Dashboard Navigation Cards -->
        <div class="card shadow mb-5">
            <div class="card-header bg-primary text-white">
                <h4 class="mb-0"><i class="bi bi-grid-fill"></i> Dashboard</h4>
            </div>
            <div class="card-body">
                <div class="row g-3">

                    <!-- My Profile -->
                    <div class="col-md-3">
                        <a href="updateProfileUser.jsp?userID=<%= user.getUserID() %>" class="btn btn-primary w-100 py-3">
                            <i class="bi bi-person"></i> My Profile
                        </a>
                    </div>

                    <!-- Attendance -->
                    <div class="col-md-3">
                        <a href="employeeAttendance.jsp" class="btn btn-success w-100 py-3">
                            <i class="bi bi-calendar-check"></i> Attendance
                        </a>
                    </div>

                    <!-- Overtime -->
                    <div class="col-md-3">
                        <a href="overtime.jsp" class="btn btn-warning w-100 py-3">
                            <i class="bi bi-clock-history"></i> Overtime
                        </a>
                    </div>

                    <!-- Leave -->
                    <div class="col-md-3">
                        <a href="leaveApplicationForm.jsp" class="btn btn-info w-100 py-3">
                            <i class="bi bi-door-open"></i> Leave
                        </a>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>

<!-- No more Bootstrap JS here because it's already included inside ssHeader.jsp -->
