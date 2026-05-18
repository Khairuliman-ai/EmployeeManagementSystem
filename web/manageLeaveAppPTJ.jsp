<%@ page import="java.util.*, model.LeaveApplicationDAO, model.User" %>
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
            List<String[]> applications = (List<String[]>) request.getAttribute("applications");
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
                            for (String[] app : applications) {
                    %>
                    <tr>
                        <td><%= app[0] %></td>
                        <td><%= app[1] %></td>
                        <td><%= app[2] %></td>
                        <td><%= app[3] %></td>
                        <td><%= app[4] %></td>
                        <td><%= app[5] %></td>
                        <td>
                            <span class="badge <%= app[6].equals("Approved") ? "bg-success" : (app[6].equals("Rejected") ? "bg-danger" : "bg-warning") %>">
                                <%= app[6] %>
                            </span>
                        </td>
                        <td>
                            <% if (app[7] != null && !app[7].isEmpty()) { %>
                                <a href="downloadFileServlet?file=<%= app[7] %>" class="btn btn-sm btn-primary">Download</a>

                            <% } else { %>
                                <span class="text-muted">No File</span>
                            <% } %>
                        </td>
                        <td>
                            <form action="UpdateLeaveStatusServlet" method="post" class="d-inline">
                                <input type="hidden" name="leaveId" value="<%= app[0] %>">
                                <input type="hidden" name="status" value="Approved">
                                <button type="submit" class="btn btn-success btn-sm mb-1">Approve</button>
                            </form>

                            <form action="UpdateLeaveStatusServlet" method="post" class="d-inline">
                                <input type="hidden" name="leaveId" value="<%= app[0] %>">
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
