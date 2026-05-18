<%@ page import="model.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>PTJ Panel</title>

    <!-- Bootstrap 5.3 & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f8f9fa;
        }
        .sidebar {
            height: 100vh;
            width: 240px;
            position: fixed;
            top: 0;
            left: 0;
            background-color: #343a40;
            padding-top: 20px;
            z-index: 1000;
        }
        .sidebar h2 {
            color: #fff;
            text-align: center;
            margin-bottom: 30px;
            font-weight: 600;
        }
        .sidebar a {
            display: flex;
            align-items: center;
            gap: 10px;
            color: #fff;
            padding: 15px 20px;
            text-decoration: none;
            font-weight: 500;
            transition: 0.3s;
        }
        .sidebar a:hover, .sidebar a.active {
            background-color: #495057;
            border-left: 5px solid #0d6efd;
        }
        .main-content {
            margin-left: 240px;
            padding: 20px;
        }
        @media (max-width: 768px) {
            .sidebar {
                position: relative;
                width: 100%;
                height: auto;
            }
            .main-content {
                margin-left: 0;
            }
        }
    </style>
</head>

<body>

<!-- Sidebar Start -->
<div class="sidebar">
    <h2>PTJ Panel</h2>

    <a href="ptjDashboard.jsp">
        <i class="bi bi-house-door-fill"></i> Dashboard
    </a>

    <a href="updateProfileUser.jsp?userID=<%= user.getUserID() %>">
        <i class="bi bi-person"></i> My Profile
    </a>

    <a href="ViewProfileServlet">
        <i class="bi bi-people-fill"></i> View Profiles
    </a>

    <a href="ViewAttendancePTJServlet">
        <i class="bi bi-calendar-check"></i> View Attendance
    </a>

    <a href="adminOvertimeList.jsp">
        <i class="bi bi-clock-history"></i> Overtime
    </a>

    <a href="manageLeaveAppServlet">
        <i class="bi bi-door-open"></i> Manage Leave Application
    </a>

    <a href="MonthlyReportForm.jsp">
        <i class="bi bi-bar-chart-line"></i> View Attendance Record
    </a>

    <a href="#" class="text-danger" data-bs-toggle="modal" data-bs-target="#logoutModal">
        <i class="bi bi-box-arrow-right"></i> Logout
    </a>
</div>
<!-- Sidebar End -->

<!-- Logout Modal -->
<div class="modal fade" id="logoutModal" tabindex="-1" aria-labelledby="logoutModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header bg-danger text-white">
        <h5 class="modal-title" id="logoutModalLabel">Confirm Logout</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body text-center">Are you sure you want to logout?</div>
      <div class="modal-footer">
        <form action="logoutServlet" method="post">
            <button type="submit" class="btn btn-danger">Yes, Logout</button>
        </form>
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
      </div>
    </div>
  </div>
</div>

<!-- Bootstrap Bundle JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
