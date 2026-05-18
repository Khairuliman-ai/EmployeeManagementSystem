<%@ page import="model.User" %>
<%@ page import="model.OvertimeDAO" %>
<%@ page import="java.util.*, model.Overtime" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    int userID = user.getUserID();

    OvertimeDAO dao = new OvertimeDAO();
    List<Overtime> list = dao.getAllOvertime();

    String actionResult = request.getParameter("result");
%>

<%@ include file="includes/ptjHeader.jsp" %>

<div class="main-content">
    <div class="container mt-4">
        <h2 class="mb-4 text-primary text-center">
            <i class="bi bi-clock-history"></i> Overtime Requests
        </h2>

        <% if ("success".equals(actionResult)) { %>
            <div class="alert alert-success text-center">Action performed successfully!</div>
        <% } else if ("fail".equals(actionResult)) { %>
            <div class="alert alert-danger text-center">Action failed!</div>
        <% } %>

        <div class="table-responsive">
            <table class="table table-bordered table-hover text-center align-middle">
                <thead class="table-dark">
                    <tr>
                        <th>Overtime ID</th>
                        <th>User ID</th>
                        <th>Date</th>
                        <th>Start</th>
                        <th>End</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                <% for (Overtime overtime : list) { %>
                    <tr>
                        <td><%= overtime.getOvertimeID() %></td>
                        <td><%= overtime.getUserID() %></td>
                        <td><%= overtime.getDateOvertime() %></td>
                        <td><%= overtime.getStartTime() %></td>
                        <td><%= overtime.getEndTime() %></td>
                        <td><%= overtime.getVerification() %></td>
                        <td>
                            <% if ("Pending".equals(overtime.getVerification())) { %>
                                <a href="#" class="btn btn-success btn-sm" 
                                   onclick="confirmAction(<%=overtime.getOvertimeID()%>, 'Approved')">
                                   Approve</a>
                                <a href="#" class="btn btn-danger btn-sm"
                                   onclick="confirmAction(<%=overtime.getOvertimeID()%>, 'Rejected')">
                                   Reject</a>
                            <% } else { %>
                                -
                            <% } %>
                        </td>
                    </tr>
                <% } %>
                </tbody>
            </table>
        </div>

        <div class="text-end mt-4">
            <a href="viewHistoryApprove.jsp" class="btn btn-outline-secondary">
                <i class="bi bi-clipboard2-check"></i> View Approved/Rejected History
            </a>
        </div>
    </div>
</div>
                

<!-- Confirmation Script -->
<script>
    function confirmAction(overtimeID, status) {
        let textMsg = (status === 'Approved') ? 'approve' : 'reject';
        if (confirm("Are you sure you want to " + textMsg + " this request?")) {
            window.location.href = "OvertimeApprovalServlet?overtimeID=" + overtimeID + "&status=" + status;
        }
    }
    
    
    
</script>


