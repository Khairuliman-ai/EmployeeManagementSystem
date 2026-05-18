<%@ page import="java.util.*, model.LeaveApplication, model.LeaveApplicationDAO, model.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<%@ include file="includes/ptjHeader.jsp" %>

<div class="main-content">
    <div class="container mt-4">

        <div class="text-center mb-4">
            <h2>Manage Leave Applications</h2>
            <p class="lead">Hello <%= user.getFullName() %> (PTJ Panel)</p>
        </div>

        <%
            List<LeaveApplication> applications = (List<LeaveApplication>) request.getAttribute("applications");
        %>

        <div class="table-responsive">
            <table class="table table-bordered table-hover align-middle text-center">
                <thead class="table-dark">
                    <tr>
                        <th>Leave ID</th>
                        <th>User ID</th>
                        <th>Leave Type</th>
                        <th>Start Date</th>
                        <th>End Date</th>
                        <th>Reason</th>
                        <th>Status</th>
                        <th>Proof File</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        if (applications != null && !applications.isEmpty()) {
                            for (LeaveApplication app : applications) {
                    %>
                    <tr>
                        <td><%= app.getLeaveId() %></td>
                        <td><%= app.getUserID() %></td>
                        <td><%= app.getLeaveType() %></td>
                        <td><%= app.getStartDate() %></td>
                        <td><%= app.getEndDate() %></td>
                        <td><%= app.getReason() %></td>
                        <td>
                            <span class="badge <%= app.getStatus().equals("Approved") ? "bg-success" : (app.getStatus().equals("Rejected") ? "bg-danger" : "bg-warning") %>">
                                <%= app.getStatus() %>
                            </span>
                        </td>
                        <td>
                            <% if (app.getReasonFile() != null && !app.getReasonFile().isEmpty()) { %>
                                <a href="downloadFileServlet?file=<%= app.getReasonFile() %>" class="btn btn-sm btn-primary">Download</a>

                            <% } else { %>
                                <span class="text-muted">No File</span>
                            <% } %>
                        </td>
                        <td>
                            <form action="UpdateLeaveStatusServlet" method="post" class="d-inline">
                                <input type="hidden" name="leaveId" value="<%= app.getLeaveId() %>">
                                <input type="hidden" name="status" value="Approved">
                                <button type="submit" class="btn btn-success btn-sm mb-1">Approve</button>
                            </form>

                            <form action="UpdateLeaveStatusServlet" method="post" class="d-inline">
                                <input type="hidden" name="leaveId" value="<%= app.getLeaveId() %>">
                                <input type="hidden" name="status" value="Rejected">
                                <button type="submit" class="btn btn-danger btn-sm mb-1">Reject</button>
                            </form>
                        </td>
                    </tr>
                    <% 
                            } 
                        } else { 
                    %>
                    <tr><td colspan="9" class="text-center">No applications found.</td></tr>
                    <% } %>
                </tbody>
            </table>
        </div>

        <div class="mt-4 text-center">
            <a href="PTJDashboard.jsp" class="btn btn-secondary">
                <i class="bi bi-arrow-left-circle"></i> Back to PTJ Dashboard
            </a>
        </div>

    </div>
</div>
