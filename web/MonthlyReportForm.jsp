<%@ page import="model.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%-- ✅ Session check and load user --%>
<%
    User currentSessionUser = (User) session.getAttribute("user");
    if (currentSessionUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    User user = currentSessionUser;
%>

<%-- ✅ Dynamic role-based header include --%>
<% 
    if ("HRD".equals(currentSessionUser.getRole())) { 
%>
    <%@ include file="includes/hrdHeader.jsp" %>
<% 
    } else if ("Head of PTJ".equals(currentSessionUser.getRole())) { 
%>
    <%@ include file="includes/ptjHeader.jsp" %>
<% 
    } else if ("Academician".equals(currentSessionUser.getRole())) { 
%>
    <%@ include file="includes/aHeader.jsp" %>
<% 
    } else { 
%>
    <%@ include file="includes/ssHeader.jsp" %>
<% 
    } 
%>

<%
    String departname = session.getAttribute("department") != null ? (String) session.getAttribute("department") : "";
    String year = session.getAttribute("year") != null ? session.getAttribute("year").toString() : "";
    String month = session.getAttribute("month") != null ? session.getAttribute("month").toString() : "";
    String errorMonth = session.getAttribute("errorMonth") != null ? (String) session.getAttribute("errorMonth") : "";
    String errorYear = session.getAttribute("errorYear") != null ? (String) session.getAttribute("errorYear") : "";
%>

<div class="main-content">
    <div class="container py-5">
        <div class="card shadow-lg border-0">
            <div class="card-body p-5">

                <h2 class="text-center mb-4 text-primary">Monthly Attendance Report</h2>

                <form action="MonthlyReportProcessServlet" method="post" class="row g-4">
                    
                    <div class="col-md-6">
                        <label for="department" class="form-label">Department Name:</label>
                        <input type="text" class="form-control" id="department" name="department" value="<%= departname %>" required>
                    </div>

                    <div class="col-md-6">
                        <label for="year" class="form-label">Year:</label>
                        <input type="text" class="form-control" id="year" name="year" value="<%= year %>" required>
                        <% if (!errorYear.isEmpty() && errorYear.contains("Year")) { %>
                            <div class="text-danger small"><%= errorYear %></div>
                        <% } %>
                    </div>

                    <div class="col-md-6">
                        <label for="month" class="form-label">Month:</label>
                        <input type="text" class="form-control" id="month" name="month" value="<%= month %>" required>
                        <% if (!errorMonth.isEmpty() && errorMonth.contains("Month")) { %>
                            <div class="text-danger small"><%= errorMonth %></div>
                        <% } %>
                    </div>

                    <div class="col-12 d-flex justify-content-center gap-3">
                        <input type="submit" class="btn btn-primary px-4 py-2" value="Submit">
                        <input type="reset" class="btn btn-secondary px-4 py-2" value="Clear">
                    </div>

                </form>

            </div>
        </div>
    </div>
</div>
