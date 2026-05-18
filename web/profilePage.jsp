<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Profile</title>
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 10px;
        }
        .container {
            width: 90%;
            max-width: 800px; /* Increased to better fit desktop screens */
            background-color: #d3d3d3;
            padding: 30px;
            border-radius: 5px;
            text-align: center;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1); /* Subtle shadow for depth */
        }
        h2 {
            color: #333;
            font-size: 2rem;
            margin-bottom: 20px;
        }
        .role-btn {
            background-color: #ff4040;
            color: white;
            padding: 20px;
            margin: 15px 0;
            border: none;
            border-radius: 5px;
            font-size: 1.5rem;
            text-align: center;
            width: 100%;
            cursor: pointer;
            display: block;
            transition: background-color 0.3s ease;
        }
        .role-btn:hover {
            background-color: #e63939;
        }

        /* Responsive adjustments for tablets */
        @media (max-width: 768px) {
            .container {
                width: 95%;
                padding: 20px;
            }
            h2 {
                font-size: 1.6rem;
                margin-bottom: 15px;
            }
            .role-btn {
                padding: 15px;
                font-size: 1.2rem;
                margin: 10px 0;
            }
        }

        /* Responsive adjustments for mobile screens */
        @media (max-width: 480px) {
            .container {
                width: 100%;
                padding: 15px;
            }
            h2 {
                font-size: 1.3rem;
                margin-bottom: 10px;
            }
            .role-btn {
                padding: 12px;
                font-size: 1rem;
                margin: 8px 0;
            }
        }

        /* For larger desktop screens */
        @media (min-width: 1200px) {
            .container {
                max-width: 900px; /* Slightly wider for larger screens */
            }
            h2 {
                font-size: 2.2rem;
            }
            .role-btn {
                padding: 25px;
                font-size: 1.7rem;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Manage Profile</h2>
        <form action="ProfileServlet1" method="get">
            <button type="submit" class="role-btn">HRD</button>
        </form>
        <form action="headOfPTJ.jsp" method="get">
            <button type="submit" class="role-btn">Head of PTJ</button>
        </form>
        <form action="ProfileServlet2" method="get">
            <button type="submit" class="role-btn">Supporting Staff</button>
        </form>
        <form action="academician.jsp" method="get">
            <button type="submit" class="role-btn">Academician</button>
        </form>
    </div>
</body>
</html>