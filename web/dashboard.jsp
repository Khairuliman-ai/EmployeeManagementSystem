<%@ page import="model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<%@ include file="includes/hrdHeader.jsp" %>

<div class="main-content">
    <div class="container py-5">

        <!-- Welcome Header -->
        <div class="text-center mb-5">
            <h2 class="fw-bold text-primary">Welcome, <%= user.getFullName() %></h2>
            <p class="text-muted fs-5">Use the dashboard to manage your HRD tasks quickly.</p>
        </div>

        <!-- Navigation Cards -->
        <div class="row g-4">
            <!-- My Profile -->
            <div class="col-md-3">
                <a href="updateProfileUser.jsp?userID=<%= user.getUserID() %>" class="text-decoration-none">
                    <div class="card shadow-sm text-center border-0 h-100">
                        <div class="card-body py-4">
                            <i class="bi bi-person display-5 text-primary mb-3"></i>
                            <h5 class="fw-semibold">My Profile</h5>
                        </div>
                    </div>
                </a>
            </div>

            <!-- Manage Profiles -->
            <div class="col-md-3">
                <a href="manageProfile.jsp" class="text-decoration-none">
                    <div class="card shadow-sm text-center border-0 h-100">
                        <div class="card-body py-4">
                            <i class="bi bi-person-lines-fill display-5 text-success mb-3"></i>
                            <h5 class="fw-semibold">Manage Profiles</h5>
                        </div>
                    </div>
                </a>
            </div>

            <!-- Manage Attendance -->
            <div class="col-md-3">
                <a href="manageAttendance.jsp" class="text-decoration-none">
                    <div class="card shadow-sm text-center border-0 h-100">
                        <div class="card-body py-4">
                            <i class="bi bi-calendar-check display-5 text-warning mb-3"></i>
                            <h5 class="fw-semibold">Manage Attendance</h5>
                        </div>
                    </div>
                </a>
            </div>

            <!-- View Attendance Record -->
            <div class="col-md-3">
                <a href="MonthlyReportForm.jsp" class="text-decoration-none">
                    <div class="card shadow-sm text-center border-0 h-100">
                        <div class="card-body py-4">
                            <i class="bi bi-clipboard-data-fill display-5 text-info mb-3"></i>
                            <h5 class="fw-semibold">View Attendance Record</h5>
                        </div>
                    </div>
                </a>
            </div>
        </div>

    </div>
</div>
