    <%-- 
    Document   : addUser
    Created on : 24 May 2025, 8:06:54 am
    Author     : khayx
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Profiles</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: Arial, sans-serif; background-color: #f0f0f0; min-height: 100vh; display: flex; justify-content: center; align-items: center; padding: 10px; }
        .container { width: 90%; max-width: 1000px; background-color: #fff; padding: 30px; border-radius: 5px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
        h2 { color: #333; font-size: 2rem; margin-bottom: 20px; }
        .message { color: #d32f2f; margin-bottom: 15px; font-size: 1.1rem; }
        .form-group { margin-bottom: 15px; text-align: left; }
        .form-group label { display: block; font-size: 1.1rem; margin-bottom: 5px; }
        .form-group input, .form-group select { width: 100%; padding: 10px; font-size: 1rem; border: 1px solid #ccc; border-radius: 5px; }
        .submit-btn { background-color: #4CAF50; color: white; padding: 12px 20px; border: none; border-radius: 5px; font-size: 1.2rem; cursor: pointer; width: 100%; }
        .submit-btn:hover { background-color: #45a049; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        table, th, td { border: 1px solid #ddd; }
        th, td { padding: 12px; text-align: left; font-size: 1rem; }
        th { background-color: #4CAF50; color: white; }
        tr:nth-child(even) { background-color: #f2f2f2; }
        tr:hover { background-color: #ddd; }
        .action-btn { padding: 5px 10px; border: none; border-radius: 5px; cursor: pointer; margin-right: 5px; }
        .update-btn { background-color: #ff9800; color: white; }
        .delete-btn { background-color: #f44336; color: white; }

        @media (max-width: 768px) {
            .container { width: 95%; padding: 20px; }
            h2, .message, .form-group label, .submit-btn, th, td { font-size: 1rem; }
        }
        @media (max-width: 480px) {
            .container { width: 100%; padding: 15px; }
            h2 { font-size: 1.3rem; }
            .message, .form-group label, .submit-btn, th, td { font-size: 0.9rem; }
            table { font-size: 0.8rem; }
        }
    </style>
        <!-- Bootstrap CSS for styling -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container">
    <h2>Manage Profiles</h2>

    <% if (request.getAttribute("message") != null) { %>
        <div class="message"><%= request.getAttribute("message") %></div>
    <% } %>

    <form action="ProfileServlet1" method="post">
        <div class="form-group">
            <label for="username">Username:</label>
            <input type="text" name="username" id="username" required>
        </div>
        <div class="form-group">
            <label for="fullName">Full Name:</label>
            <input type="text" name="fullName" id="fullName" required>
        </div>
        <div class="form-group">
            <label for="gender">Gender:</label>
            <select name="gender" id="gender" required>
                <option value="male">male</option>
                <option value="female">female</option>
                <option value="other">other</option>
            </select>
        </div>
        <div class="form-group">
            <label for="email">Email:</label>
            <input type="email" name="email" id="email" required>
        </div>
        <div class="form-group">
            <label for="phone">Phone:</label>
            <input type="tel" name="phone" id="phone" required>
        </div>
        <div class="form-group">
            <label for="password">Password:</label>
            <input type="password" name="password" id="password" required>
        </div>
        <div class="form-group">
            <label for="address">Address:</label>
            <input type="text" name="address" id="address">
        </div>
        <div class="form-group">
            <label for="department">Department:</label>
            <input type="text" name="department" id="department">
        </div>
        <div class="form-group">
            <label for="dob">Date of Birth:</label>
            <input type="date" name="dob" id="dob">
        </div>
        <div class="form-group">
            <label for="role">Role:</label>
            <select name="role" id="role" required>
                <option value="">Select</option>
                <option value="Academician">HRD</option>
                <option value="Academician">Head of PTJ</option>
                <option value="Supporting Staff">Supporting Staff</option>
                <option value="Academician">Academician</option>
            </select>
        </div>
        <button type="submit" class="submit-btn">Add Profile</button>
    </form>
    </body>
</html>
