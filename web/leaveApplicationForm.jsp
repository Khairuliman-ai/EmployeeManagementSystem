<%@ page import="model.User" %>
<%@ page import="java.time.LocalDate" %>


<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    int userId = user.getUserID();
    String today = LocalDate.now().toString();  // Get today?s date in yyyy-MM-dd format
%>

<%-- ? Dynamically include correct header based on role --%>
<% 
    if ("HRD".equals(user.getRole())) { 
%>
    <%@ include file="includes/hrdHeader.jsp" %>
<% 
    } else if ("Head of PTJ".equals(user.getRole())) { 
%>
    <%@ include file="includes/ptjHeader.jsp" %>
<% 
    } else if ("Academician".equals(user.getRole())) { 
%>
    <%@ include file="includes/aHeader.jsp" %>
<% 
    } else { 
%>
    <%@ include file="includes/ssHeader.jsp" %>
<% 
    } 
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Leave Application Form</title>

    <!-- Bootstrap 5.3 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap">

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f8f9fa;
        }
        .main-content {
            margin-left: 240px;
            padding: 20px;
        }
        .form-container {
            max-width: 700px;
            margin: auto;
            background: #fff;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        }
        .form-title {
            font-weight: 600;
        }
        @media (max-width: 768px) {
            .main-content {
                margin-left: 0;
                padding: 20px;
            }
        }
    </style>
</head>

<body>

<div class="main-content">
    <div class="container">
        <div class="form-container">
            <h2 class="mb-4 text-primary text-center form-title">Leave Application Form</h2>

            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-danger text-center">
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>

            <form action="SaveLeaveAppServlet" method="post" enctype="multipart/form-data" onsubmit="return confirmUpload()">
                <input type="hidden" name="userId" value="<%= userId %>">

                <div class="mb-3">
                    <label class="form-label">Leave Type:</label>
                    <select name="leaveType" class="form-select" required>
                        <option value="">Select Leave Type</option>
                        <option>Annual Leave (AL)</option>
                        <option>Sick Leave (SL)</option>
                        <option>Maternity Leave (ML)</option>
                        <option>Paternity Leave (PL)</option>
                        <option>Unpaid Leave (UL)</option>
                    </select>
                </div>

                <div class="mb-3">
                    <label class="form-label">Date From:</label>
                    <input type="date" id="startDate" name="startDate" class="form-control" min="<%= today %>" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Date To:</label>
                    <input type="date" id="endDate" name="endDate" class="form-control" min="<%= today %>" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Reason:</label>
                    <input type="text" name="reason" class="form-control" required>
                </div>

                <div class="mb-4">
                    <label class="form-label">Attach file:</label>
                    <input type="file" id="reasonFile" name="reasonFile" class="form-control" accept=".jpg,.jpeg,.png,.pdf" required>
                </div>

                <div class="text-center">
                    <button type="submit" class="btn btn-success px-5 py-2 me-3">
                        <i class="bi bi-send-check"></i> Apply
                    </button>
                    <button type="reset" class="btn btn-secondary px-5 py-2 me-3">
                        <i class="bi bi-x-circle"></i> Cancel
                    </button>
                    
                    <br><br>
                    <a href="viewLeaveApp.jsp" class="btn btn-info px-5 py-2">
                        <i class="bi bi-journal-text"></i> My Applications
                    </a>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        const startDateInput = document.getElementById("startDate");
        const endDateInput = document.getElementById("endDate");

        startDateInput.addEventListener("change", function () {
            endDateInput.min = startDateInput.value;
        });

        endDateInput.addEventListener("change", function () {
            if (endDateInput.value < startDateInput.value) {
                alert("End date cannot be before start date.");
                endDateInput.value = "";
            }
        });
    });

    function confirmUpload() {
        const fileInput = document.getElementById("reasonFile");
        if (fileInput.files.length === 0) {
            alert("Please choose a file before submitting.");
            return false;
        }
        const fileName = fileInput.files[0].name;
        return confirm("Are you sure you want to upload this file?\n\n" + fileName);
    }
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
