<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <!-- Bootstrap CSS for styling -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container mt-5">
    <h2 class="text-center text-primary">Login Page</h2>

    <!-- ✅ Login form sending data to LoginServlet via POST -->
    <form action="LoginServlet" method="post" class="mt-3 mx-auto" style="max-width: 400px;">
        <div class="mb-3">
            <label for="username" class="form-label">Username:</label>
            <input type="text" id="username" name="username" class="form-control" required />
        </div>

        <div class="mb-3">
            <label for="password" class="form-label">Password:</label>
            <input type="password" id="password" name="password" class="form-control" required />
        </div>

        <!-- ✅ Display error message for login failure -->
        <% if (request.getParameter("error") != null) { %>
            <div class="alert alert-danger text-center">❌ Invalid username or password.</div>
        <% } %>

        <!-- ✅ Display message if redirected from register.jsp -->
        <% if (request.getParameter("registerSuccess") != null) { %>
            <div class="alert alert-success text-center">✅ Registration successful. Please login.</div>
        <% } else if (request.getParameter("duplicate") != null) { %>
            <div class="alert alert-warning text-center">⚠ Username already exists. Please choose another.</div>
        <% } %>

        <div class="d-grid">
            <button type="submit" class="btn btn-primary">Login</button>
        </div>
    </form>

    <!-- ✅ Register link -->
    <div class="text-center mt-3">
        <p>Don't have an account? <a href="register.jsp">Register here</a>.</p>
    </div>
</body>
</html>
