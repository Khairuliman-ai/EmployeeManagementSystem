<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Register</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body class="container mt-5">
        <h2 class="text-center text-primary">Register</h2>

        <!-- ✅ Error Message Block -->
        <%
            String error = request.getParameter("error");
            if (error != null) {
        %>
            <div class="alert alert-danger" role="alert">
                <% if ("missing".equals(error)) { %>
                    ⚠️ Please fill in all required fields.
                <% } else if ("database".equals(error)) { %>
                    ❌ Registration failed. Please try again later.
                <% } else if ("server".equals(error)) { %>
                    🚫 Internal server error. Please contact the administrator.
                <% } else if ("duplicate".equals(error)) { %>
                    ⚠️ Username already exists. Please choose another.
                <% } else { %>
                    ⚠️ An unknown error occurred.
                <% } %>
            </div>
        <%
            }
        %>

        <!-- ✅ Registration Form -->
        <form action="RegisterServlet" method="post" class="mt-3 mx-auto" style="max-width: 600px;">

            <div class="mb-3">
                <label>Username:</label>
                <input type="text" name="username" class="form-control" required />
            </div>

            <div class="mb-3">
                <label>Full Name:</label>
                <input type="text" name="fullName" class="form-control" required />
            </div>

            <div class="mb-3">
                <label>Gender:</label>
                <select name="gender" class="form-control" required>
                    <option value="">-- Select Gender --</option>
                    <option value="Male">Male</option>
                    <option value="Female">Female</option>
                    <option value="Other">Other</option>
                </select>
            </div>

            <div class="mb-3">
                <label>Date of Birth:</label>
                <input type="date" name="dob" class="form-control" required />
            </div>

            <div class="mb-3">
                <label>Email:</label>
                <input type="email" name="email" class="form-control" required />
            </div>

            <div class="mb-3">
                <label>Phone Number:</label>
                <input type="text" name="phone" class="form-control" required />
            </div>

            <div class="mb-3">
                <label>Address:</label>
                <textarea name="address" class="form-control" rows="2" required></textarea>
            </div>

            <div class="mb-3">
                <label>Department:</label>
                <input type="text" name="department" class="form-control" required />
            </div>

            <div class="mb-3">
                <label>Role:</label>
                <select name="role" class="form-control" required>
                    <option value="">-- Select Role --</option>
                    <option value="Supporting Staff">Supporting Staff</option>
                    <option value="Academician">Academician</option>
                </select>
            </div>

            <div class="mb-3">
                <label>Password:</label>
                <input type="password" name="password" class="form-control" required />
            </div>

            <button type="submit" class="btn btn-primary w-100">Register</button>
        </form>

        <!-- ✅ Link to Login -->
        <div class="text-center mt-3">
            Already have an account? <a href="login.jsp">Login here</a>
        </div>
    </body>
</html>
