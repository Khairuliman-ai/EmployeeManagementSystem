<%@page import="model.OvertimeDAO"%>
<%@page import="model.User"%>
<%@ page import="java.util.*, model.Overtime, model.OvertimeDAO" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page session="true" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    int userID = user.getUserID();

    String success = request.getParameter("success");
    String error = request.getParameter("error");

    OvertimeDAO dao = new OvertimeDAO();
    List<Overtime> list = dao.getOvertimeByUser(userID);
%>

<%@ include file="includes/ssHeader.jsp" %>

<div class="main-content">
    <div class="container py-4">

        <h2 class="mb-4 text-primary text-center">
            <i class="bi bi-clock-history"></i> Overtime Request Form
        </h2>

        <% if ("true".equals(success)) { %>
        <div class="alert alert-success text-center">Overtime request submitted successfully!</div>
        <% } else if ("edit".equals(success)) { %>
        <div class="alert alert-success text-center">Overtime request updated successfully!</div>
        <% } else if ("false".equals(success)) { %>
        <div class="alert alert-danger text-center">Failed to submit overtime request.</div>
        <% } else if ("true".equals(error)) { %>
        <div class="alert alert-danger text-center">An error occurred.</div>
        <% }%>

        <div class="card shadow mb-5">
            <div class="card-body">
                <form action="OvertimeSubmitServlet" method="post" class="row g-4" onsubmit="return validateForm()">
                    <input type="hidden" name="userID" value="<%= userID%>">

                    <div class="col-md-4">
                        <label for="dateOvertime" class="form-label">Overtime Date:</label>
                        <input type="date" class="form-control" name="dateOvertime" id="dateOvertime" required>
                    </div>
                    <div class="col-md-4">
                        <label for="startTime" class="form-label">Start Time:</label>
                        <input type="time" class="form-control" name="startTime" id="startTime" required>
                    </div>
                    <div class="col-md-4">
                        <label for="endTime" class="form-label">End Time:</label>
                        <input type="time" class="form-control" name="endTime" id="endTime" required>
                    </div>

                    <div class="col-12 text-center">
                        <button type="submit" class="btn btn-primary px-5 py-2 fs-5">
                            Submit Overtime Request
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <h3 class="mb-3 text-center text-primary">
            <i class="bi bi-journal-text"></i> My Overtime Requests
        </h3>

        <div class="table-responsive">
            <table class="table table-bordered table-hover text-center align-middle">
                <thead class="table-dark">
                    <tr>
                        <th>Overtime Date</th>
                        <th>Start</th>
                        <th>End</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Overtime overtime : list) { %>
                    <tr>
                        <td><%= overtime.getDateOvertime()%></td>
                        <td><%= overtime.getStartTime()%></td>
                        <td><%= overtime.getEndTime()%></td>
                        <td>
                            <span class="badge 
                                <%= "Pending".equals(overtime.getVerification()) ? "bg-warning text-dark" :
                                    ("Approved".equals(overtime.getVerification()) ? "bg-success" : "bg-danger") %>">
                                <%= overtime.getVerification() %>
                            </span>
                        </td>
                        <td>
                            <% if ("Pending".equals(overtime.getVerification())) { %>
                            <a href="editOvertime.jsp?overtimeID=<%=overtime.getOvertimeID()%>" class="btn btn-sm btn-warning">Edit</a>
                            <button class="btn btn-sm btn-danger" onclick="confirmDelete(<%= overtime.getOvertimeID() %>)">Delete</button>
                            <% } else { %>
                            <span class="text-muted">-</span>
                            <% } %>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>

    </div>
</div>

<!-- Delete Confirmation Modal -->
<div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header bg-danger text-white">
        <h5 class="modal-title" id="deleteModalLabel">Confirm Deletion</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body text-center">
        Are you sure you want to delete this record?
      </div>
      <div class="modal-footer">
        <a id="confirmDeleteBtn" href="#" class="btn btn-danger">Yes, Delete</a>
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
      </div>
    </div>
  </div>
</div>

<script>
// JS Delete Popup Logic
function confirmDelete(overtimeID) {
    var link = "OvertimeDeleteServlet?overtimeID=" + overtimeID;
    document.getElementById("confirmDeleteBtn").href = link;
    var myModal = new bootstrap.Modal(document.getElementById('deleteModal'));
    myModal.show();
}

// JS Validation Logic
function validateForm() {
    const dateOvertime = document.getElementById("dateOvertime").value;
    const startTime = document.getElementById("startTime").value;
    const endTime = document.getElementById("endTime").value;

    const today = new Date().toISOString().split("T")[0];

    if (dateOvertime < today) {
        alert("Overtime date cannot be in the past.");
        return false;
    }
    if (startTime >= endTime) {
        alert("Start time must be earlier than end time.");
        return false;
    }
    return true;
}
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
