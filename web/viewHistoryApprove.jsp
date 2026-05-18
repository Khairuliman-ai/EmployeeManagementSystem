<%@ page import="java.util.*, java.sql.*, model.Overtime, model.OvertimeDAO, model.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    // Session checking
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    int userID = user.getUserID();

    // Get filters
    String selectedMonth = request.getParameter("month");
    String selectedDate = request.getParameter("date");

    OvertimeDAO dao = new OvertimeDAO();
    List<Overtime> all = dao.getAllOvertime();
    List<Overtime> filtered = new ArrayList<>();

    for (Overtime ot : all) {
        if (!"Pending".equalsIgnoreCase(ot.getVerification())) {
            if ((selectedMonth == null || selectedMonth.isEmpty() || ot.getDateOvertime().toString().startsWith(selectedMonth)) &&
                (selectedDate == null || selectedDate.isEmpty() || ot.getDateOvertime().toString().equals(selectedDate))) {
                filtered.add(ot);
            }
        }
    }
%>

<%@ include file="includes/ptjHeader.jsp" %>

<div class="main-content">
    <div class="container mt-4">

        <h2 class="mb-4 text-primary text-center">
            <i class="bi bi-clock-history"></i> Overtime History (Approved / Rejected)
        </h2>

        <form method="get" class="row g-3 bg-white p-4 rounded shadow-sm mb-4">
            <div class="col-md-4">
                <label for="month" class="form-label">Filter by Month (yyyy-MM)</label>
                <input type="month" class="form-control" id="month" name="month" value="<%= selectedMonth != null ? selectedMonth : "" %>">
            </div>
            <div class="col-md-4">
                <label for="date" class="form-label">Filter by Specific Date</label>
                <input type="date" class="form-control" id="date" name="date" value="<%= selectedDate != null ? selectedDate : "" %>">
            </div>
            <div class="col-md-4 d-flex align-items-end justify-content-between">
                <button type="submit" class="btn btn-primary w-45">Filter</button>
                <a href="viewHistoryApprove.jsp" class="btn btn-secondary w-45">Reset</a>
            </div>
        </form>

        <div class="table-responsive">
            <table class="table table-bordered table-hover text-center align-middle">
                <thead class="table-dark">
                <tr>
                    <th>Overtime ID</th>
                    <th>User ID</th>
                    <th>Date</th>
                    <th>Start Time</th>
                    <th>End Time</th>
                    <th>Status</th>
                </tr>
                </thead>
                <tbody>
                <% for (Overtime ot : filtered) { %>
                    <tr>
                        <td><%= ot.getOvertimeID() %></td>
                        <td><%= ot.getUserID() %></td>
                        <td><%= ot.getDateOvertime() %></td>
                        <td><%= ot.getStartTime() %></td>
                        <td><%= ot.getEndTime() %></td>
                        <td>
                            <span class="badge <%= "Approved".equals(ot.getVerification()) ? "bg-success" : "bg-danger" %>">
                                <%= ot.getVerification() %>
                            </span>
                        </td>
                    </tr>
                <% } %>
                </tbody>
            </table>
        </div>

        <% if (filtered.size() == 0) { %>
            <div class="alert alert-info text-center">
                No overtime history records found for the selected filter.
            </div>
        <% } %>

    </div>
</div>
