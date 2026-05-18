<%-- 
    Document   : updateProfile_Ac
    Created on : 18 May 2025, 8:26:53 pm
    Author     : khayx
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Profile - Supporting Staff</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        .form-container {
            max-width: 600px;
            margin: 0 auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
        }
        .form-group input {
            width: 100%;
            padding: 8px;
            box-sizing: border-box;
        }
        .form-group input[type="submit"] {
            width: auto;
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
            margin-right: 10px;
        }
        .form-group input[type="submit"]:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>Update Profile - Acapdemician</h2>
        <form id="profileForm" action="UpdateProfileServlet" method="post" onsubmit="handleFormSubmit(event)">
            <div class="form-group">
                <label for="profileID">Profile ID:</label>
                <input type="text" id="profileID" name="profileID" required>
            </div>
            <div class="form-group">
                <label for="userID">User ID:</label>
                <input type="text" id="userID" name="userID" required>
            </div>
            <div class="form-group">
                <label for="fullName">Full Name:</label>
                <input type="text" id="fullName" name="fullName" required>
            </div>
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" required>
            </div>
            <div class="form-group">
                <label for="phone">Phone:</label>
                <input type="tel" id="phone" name="phone" required>
            </div>
            <div class="form-group">
                <label for="address">Address:</label>
                <input type="text" id="address" name="address" required>
            </div>
            <div class="form-group">
                <label for="department">Department:</label>
                <input type="text" id="department" name="department" required>
            </div>
            <div class="form-group">
                <input type="submit" name="action" value="Update Profile" id="updateButton">
                <input type="submit" name="action" value="Save">
            </div>
        </form>
    </div>

    <script>
        function handleFormSubmit(event) {
            const action = event.submitter.value;
            if (action === "Update Profile") {
                event.preventDefault(); // Prevent form submission for demo
                alert("Successful update the profile");
                // In a real application, you would submit the form to the server here
                // and show the alert only after a successful response, e.g.:
                // fetch('UpdateProfileServlet', { method: 'POST', body: new FormData(document.getElementById('profileForm')) })
                //     .then(response => response.json())
                //     .then(data => { if (data.success) alert("Successful update the profile"); });
                document.getElementById('profileForm').submit(); // Submit the form after alert
            }
        }
    </script>
</body>
</html>