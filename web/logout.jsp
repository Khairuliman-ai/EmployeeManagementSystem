<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    // Handle logout confirmation
    String confirm = request.getParameter("confirm");

    if ("yes".equals(confirm)) {
        session.invalidate();  // ✅ No need to redeclare session
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Logout Confirmation</title>

    <!-- Bootstrap 5.3 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Poppins', sans-serif;
        }
        .logout-container {
            max-width: 500px;
            margin: 100px auto;
            padding: 30px;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.2);
            text-align: center;
        }
        .logout-container h2 {
            color: #dc3545;
            margin-bottom: 20px;
        }
        .btn-lg {
            padding: 12px 30px;
            font-size: 1.2rem;
        }
    </style>
</head>

<body>

<div class="logout-container">
    <h2><i class="bi bi-box-arrow-right"></i> Confirm Logout</h2>
    <p>Are you sure you want to logout?</p>

    <form method="post" action="logout.jsp">
        <input type="hidden" name="confirm" value="yes">
        <button type="submit" class="btn btn-danger btn-lg me-3">
            <i class="bi bi-check-circle"></i> Yes, Logout
        </button>
        <a href="javascript:history.back()" class="btn btn-secondary btn-lg">
            <i class="bi bi-x-circle"></i> Cancel
        </a>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
