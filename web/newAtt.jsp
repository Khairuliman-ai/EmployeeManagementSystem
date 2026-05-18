<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Attendance</title>
    <style>
        body { font-family: Arial, sans-serif; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { padding: 10px; text-align: center; border: 1px solid #ccc; }
        .search-bar { margin-top: 20px; }
        .filters { margin: 10px 0; }
        .legend span { margin-right: 15px; }
        .P { color: blue; cursor: pointer; }
        .A { color: red; cursor: pointer; }
        .L { color: gray; cursor: pointer; }
        .H { color: goldenrod; cursor: pointer; }
    </style>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>

<h2>Attendance</h2>

<!-- Search Bar -->
<div class="search-bar">
    <form method="get">
        <input type="text" name="search" placeholder="Search by ID or Name" value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>">
        <button type="submit">Search</button>
    </form>
</div>

<!-- Filters -->
<div class="filters">
    <label for="week">Week:</label>
    <select id="week">
        <option>Week 1</option>
        <option>Week 2</option>
        <!-- Add more weeks dynamically -->
    </select>

    <label for="date">Date:</label>
    <select id="date">
        <option>May 2022</option>
        <option>June 2022</option>
        <!-- Add more months dynamically -->
    </select>
</div>

<!-- Legend -->
<div class="legend">
    <span class="P">P = Present</span>
    <span class="A">A = Absent</span>
    <span class="L">L = Leave</span>
    <span class="H">H = Holiday</span>
</div>

<!-- Attendance Table -->
<table>
    <thead>
        <tr>
            <th>Student</th>
            <% for (int i = 1; i <= 7; i++) { %>
                <th><%= i %></th>
            <% } %>
        </tr>
    </thead>
    <tbody>
        <%
            String[][] students = {
                {"1", "Amarjyoti"},
                {"2", "Puja Bhnadari"},
                {"3", "Jamshed"},
                {"4", "Birbal"},
                {"5", "Neha"},
                {"6", "Pulak"},
                {"7", "Samreen"},
                {"8", "Ezaz"},
                {"9", "Mushtaq"},
                {"10", "Rahil"}
            };

            String[][] marks = {
                {"H", "A", "A", "P", "P", "P", "P"},
                {"H", "P", "P", "P", "P", "P", "P"},
                {"H", "P", "P", "P", "P", "P", "P"},
                {"H", "P", "P", "P", "P", "P", "P"},
                {"H", "P", "P", "P", "P", "P", "P"},
                {"H", "P", "P", "P", "P", "A", "P"},
                {"H", "P", "P", "P", "P", "P", "P"},
                {"H", "P", "P", "P", "P", "P", "P"},
                {"H", "P", "P", "L", "P", "P", "P"},
                {"H", "L", "P", "P", "P", "P", "P"}
            };

            String search = request.getParameter("search");
            for (int i = 0; i < students.length; i++) {
                if (search != null && !search.isEmpty()) {
                    if (!students[i][0].contains(search) && !students[i][1].toLowerCase().contains(search.toLowerCase())) {
                        continue;
                    }
                }
        %>
        <tr>
            <td><%= students[i][1] %></td>
            <% for (int j = 0; j < 7; j++) { 
                String mark = marks[i][j];
            %>
                <td class="<%= mark %>" onclick="showDetails('<%= students[i][1] %>', '<%= mark %>', '<%= j+1 %>')"><%= mark %></td>
            <% } %>
        </tr>
        <% } %>
    </tbody>
</table>

<!-- Clock In/Out Pop-up -->
<script>
    function showDetails(name, status, day) {
        let clockIn = "9:00 AM";
        let clockOut = "3:00 PM";
        alert("Name: " + name + "\nDay: " + day + "\nStatus: " + status + "\nClock In: " + clockIn + "\nClock Out: " + clockOut);
    }
</script>

</body>
</html>
