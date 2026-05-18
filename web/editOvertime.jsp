<%@page import="model.User"%>
<%@page import="model.OvertimeDAO"%>
<%@ page import="model.Overtime, model.OvertimeDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    int userID = user.getUserID();
    int overtimeID = Integer.parseInt(request.getParameter("overtimeID"));

    OvertimeDAO dao = new OvertimeDAO();
    Overtime overtime = null;
    for (Overtime ot : dao.getOvertimeByUser(userID)) {
        if (ot.getOvertimeID() == overtimeID) {
            overtime = ot;
            break;
        }
    }

    if (overtime == null || !"Pending".equals(overtime.getVerification())) {
        response.sendRedirect("overtime.jsp");
        return;
    }
%>

<%@ include file="includes/ssHeader.jsp" %>

<div class="main-content">
    <div class="container py-4">

        <h2 class="mb-4 text-primary text-center">
            <i class="bi bi-pencil-square"></i> Edit Overtime Request
        </h2>

        <div class="card shadow mb-5">
            <div class="card-body">
                <form action="updateOvertime" method="post" class="row g-4" onsubmit="return validateOvertimeForm()">
                    <input type="hidden" name="overtimeID" value="<%= overtime.getOvertimeID()%>">

                    <div class="col-md-4">
                        <label for="dateOvertime" class="form-label">Overtime Date:</label>
                        <input type="date" class="form-control" name="dateOvertime" id="dateOvertime"
                               value="<%= overtime.getDateOvertime()%>" required>
                    </div>

                    <div class="col-md-4">
                        <label for="startTime" class="form-label">Start Time:</label>
                        <input type="time" class="form-control" name="startTime" id="startTime"
                               value="<%= overtime.getStartTime().toString().substring(0, 5)%>" required>
                    </div>

                    <div class="col-md-4">
                        <label for="endTime" class="form-label">End Time:</label>
                        <input type="time" class="form-control" name="endTime" id="endTime"
                               value="<%= overtime.getEndTime().toString().substring(0, 5)%>" required>
                    </div>

                    <div class="col-12 text-center">
                        <button type="submit" class="btn btn-success px-5 py-2 fs-5">Update</button>
                        <a href="overtime.jsp" class="btn btn-secondary px-5 py-2 fs-5">Cancel</a>
                    </div>
                </form>
            </div>
        </div>

    </div>
</div>

<!-- ✅ JavaScript validation -->
<script>
    function validateOvertimeForm() {
        const dateField = document.getElementById('dateOvertime');
        const startTimeField = document.getElementById('startTime');
        const endTimeField = document.getElementById('endTime');

        const today = new Date().toISOString().split('T')[0];
        const selectedDate = dateField.value;

        if (selectedDate < today) {
            alert("Overtime date cannot be in the past.");
            return false;
        }

        const startTime = startTimeField.value;
        const endTime = endTimeField.value;

        if (endTime <= startTime) {
            alert("End time must be later than start time.");
            return false;
        }

        return true;
    }
</script>
