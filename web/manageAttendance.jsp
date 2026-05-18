<%@ page import="java.util.*, model.Attendance, dao.AttendanceDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User" %>

<%
  User user = (User) session.getAttribute("user");
  if (user == null) {
      response.sendRedirect("login.jsp");
      return;
  }
%>

<%@ include file="includes/hrdHeader.jsp" %>

<div class="main-content">
    <div class="container py-4">

        <h2 class="mb-4 text-center text-primary">Manage Attendance</h2>

        <!-- ✅ Feedback Alert -->
        <%
            String msg = request.getParameter("message");
            if ("update_success".equals(msg)) {
        %>
            <div class="alert alert-success alert-dismissible fade show text-center" role="alert">
                ✅ Attendance record updated successfully.
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        <% } else if ("delete_success".equals(msg)) { %>
            <div class="alert alert-success alert-dismissible fade show text-center" role="alert">
                🗑️ Record deleted successfully.
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        <% } else if ("error".equals(msg)) { %>
            <div class="alert alert-danger alert-dismissible fade show text-center" role="alert">
                ❌ Something went wrong. Please try again.
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        <% } %>

        <!-- ✅ Search Form -->
        <form action="AdminAttendanceServlet" method="get" class="mb-4 d-flex gap-2">
            <input type="hidden" name="action" value="search">
            <input type="text" name="keyword" class="form-control" placeholder="Search by Name or Date">
            <button type="submit" class="btn btn-primary"><i class="bi bi-search"></i> Search</button>
        </form>

        <!-- ✅ Attendance Table -->
        <div class="table-responsive">
            <table class="table table-bordered table-hover align-middle">
                <thead class="table-dark text-center">
                    <tr>
                        <th>ID</th><th>Name</th><th>Date</th><th>Clock In</th><th>Clock Out</th><th>Status</th><th>Action</th>
                    </tr>
                </thead>

                <tbody>
                <%
                    List<Attendance> list = (List<Attendance>) request.getAttribute("attendanceList");
                    if (list == null) {
                        AttendanceDAO dao = new AttendanceDAO();
                        list = dao.getAllAttendance();
                    }

                    if (list != null && !list.isEmpty()) {
                        for (Attendance a : list) {
                %>
                    <tr>
                        <form action="AdminAttendanceServlet" method="post" class="d-flex flex-wrap" onsubmit="return confirmUpdate(this)">
                            <td><%=a.getAttendanceID()%>
                                <input type="hidden" name="attendanceID" value="<%=a.getAttendanceID()%>">
                            </td>
                            <td><%=a.getName()%></td>
                            <td><input type="date" name="date" value="<%=a.getDate()%>" class="form-control" required></td>
                            <td><input type="time" name="clockIn" value="<%=a.getClockIn()%>" class="form-control" required></td>
                            <td><input type="time" name="clockOut" value="<%=a.getClockOut()%>" class="form-control" required></td>
                            <td>
                                <select name="status" class="form-select" required>
                                    <option value="Present" <%= "Present".equals(a.getAttendanceStatus()) ? "selected" : "" %>>Present</option>
                                    <option value="Late" <%= "Late".equals(a.getAttendanceStatus()) ? "selected" : "" %>>Late</option>
                                    <option value="Absent" <%= "Absent".equals(a.getAttendanceStatus()) ? "selected" : "" %>>Absent</option>
                                </select>
                            </td>
                            <td class="text-center">
                                <button type="submit" class="btn btn-sm btn-success mb-1">Update</button>
                                <a href="AdminAttendanceServlet?action=delete&id=<%=a.getAttendanceID()%>" 
                                   class="btn btn-sm btn-danger"
                                   onclick="return confirm('⚠ Are you sure you want to delete this record?');">
                                   Delete</a>
                            </td>
                        </form>
                    </tr>
                <%
                        }
                    } else {
                %>
                    <tr>
                        <td colspan="7" class="text-center text-muted">No attendance records found.</td>
                    </tr>
                <%
                    }
                %>
                </tbody>
            </table>
        </div>

    </div>
</div>

<!-- ✅ JS Confirmation for Update -->
<script>
function confirmUpdate(form) {
    const date = form.querySelector('input[name="date"]').value;
    const clockIn = form.querySelector('input[name="clockIn"]').value;
    const clockOut = form.querySelector('input[name="clockOut"]').value;

    if (!date || !clockIn || !clockOut) {
        alert("⚠ Please fill in Date, Clock In, and Clock Out.");
        return false;
    }

    return confirm("Are you sure you want to update this attendance record?");
}
</script>

<!-- ✅ Bootstrap 5 JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
