<%@ page import="java.util.*, model.Attendance" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    model.User user = (model.User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<%@ include file="includes/ptjHeader.jsp" %>

<div class="main-content container py-4">
    <h2 class="mb-4 text-primary text-center">
        <i class="bi bi-calendar-check"></i> Employee Attendance Records
    </h2>

    <!-- ✅ Search Form -->
    <form action="ViewAttendancePTJServlet" method="get" class="mb-4 d-flex gap-2">
        <input type="text" name="searchTerm" class="form-control" placeholder="Search by User ID or Name"
               value="<%= request.getParameter("searchTerm") != null ? request.getParameter("searchTerm") : "" %>">
        <button type="submit" class="btn btn-primary"><i class="bi bi-search"></i> Search</button>
    </form>

    <% 
        List<Attendance> attendanceList = (List<Attendance>) request.getAttribute("attendanceList");
        if (attendanceList == null) {
            attendanceList = new ArrayList<Attendance>();  // Prevent null pointer
        }
    %>
    
    <div class="main-content container py-4">



    <!-- ✅ Full Filter Form -->
    <form action="ViewAttendanceFilterServlet" method="get" class="mb-4 d-flex justify-content-center gap-2 flex-wrap">

        <!-- Day -->
        <select name="day" class="form-select w-auto">
            <option value="">Day</option>
            <% for (int d = 1; d <= 31; d++) { %>
                <option value="<%= d %>"><%= d %></option>
            <% } %>
        </select>

        <!-- Month -->
        <select name="month" class="form-select w-auto">
            <option value="">Month</option>
            <option value="1">January</option>
            <option value="2">February</option>
            <option value="3">March</option>
            <option value="4">April</option>
            <option value="5">May</option>
            <option value="6">June</option>
            <option value="7">July</option>
            <option value="8">August</option>
            <option value="9">September</option>
            <option value="10">October</option>
            <option value="11">November</option>
            <option value="12">December</option>
        </select>

        <!-- Year -->
        <select name="year" class="form-select w-auto">
            <option value="">Year</option>
            <% 
                int currentYear = java.util.Calendar.getInstance().get(java.util.Calendar.YEAR);
                for (int y = currentYear; y >= currentYear - 5; y--) {
            %>
            <option value="<%= y %>"><%= y %></option>
            <% } %>
        </select>

        <button type="submit" class="btn btn-primary">
            <i class="bi bi-search"></i> Filter
        </button>

        <a href="ViewAttendanceFilterServlet" class="btn btn-secondary">
            <i class="bi bi-arrow-clockwise"></i> Reset
        </a>

    </form>

    <!-- ✅ Your attendance table goes here -->
</div>


    <div class="table-responsive">
        <table class="table table-bordered table-hover text-center align-middle">
            <thead class="table-dark">
                <tr>
                    <th>Attendance ID</th>
                    <th>User ID</th>
                    <th>Name</th>
                    <th>Role</th>
                    <th>Date</th>
                    <th>Clock In</th>
                    <th>Clock Out</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <% for (Attendance a : attendanceList) { %>
                <tr>
                    <td><%= a.getAttendanceID() %></td>
                    <td><%= a.getUserID() %></td>
                    <td><%= a.getName() %></td>
                    <td><%= a.getRole() %></td>
                    <td><%= a.getDate() %></td>
                    <td><%= a.getClockIn() %></td>
                    <td><%= a.getClockOut() %></td>
                    <td><%= a.getAttendanceStatus() %></td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</div>

<!-- Bootstrap Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
