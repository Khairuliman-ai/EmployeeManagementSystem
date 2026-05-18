<%@ page import="model.User, model.UserDao" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    // ✅ Handle current session user
    User currentSessionUser = (User) session.getAttribute("user");
    if (currentSessionUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // ✅ Determine which user profile to edit
    User user;
    String paramUserID = request.getParameter("userID");

    if (paramUserID != null) {
        int targetUserID = Integer.parseInt(paramUserID);
        UserDao dao = new UserDao();
        user = dao.getUserById(targetUserID);
    } else {
        user = currentSessionUser;
    }

    if (user == null) {
        out.println("<div class='alert alert-danger text-center'>User not found.</div>");
        return;
    }

    String message = (String) request.getAttribute("message");
%>

<%-- ✅ Dynamically include correct header based on role --%>
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


<style>
    .profile-img {
        border-radius: 50%;
        border: 3px solid #ddd;
        width: 170px;
        height: 170px;
        object-fit: cover;
        cursor: pointer;
        transition: transform 0.3s ease;
    }
    .profile-img:hover {
        transform: scale(1.08);
    }
    .modal-img {
        max-width: 100%;
        max-height: 80vh;
    }
</style>


<div class="main-content"> <!-- ✅ VERY IMPORTANT WRAPPER -->

    <div class="container py-5">
        <div class="card shadow-lg border-0">
            <div class="card-body p-5">
                <h2 class="text-center mb-4 text-primary">Update Profile</h2>

                <% if (message != null) { %>
                    <div class="alert alert-success text-center"><%= message %></div>
                <% } %>

                <form action="ProfileServletUser" method="post" enctype="multipart/form-data" class="row g-4">
                    <input type="hidden" name="userID" value="<%= user.getUserID() %>">

                    <!-- Profile Picture -->
                    <div class="col-12 text-center mb-4">
                        <img id="previewImage"
                             src="<%= user.getProfilePic() != null ? user.getProfilePic() : "default-profile.png" %>"
                             class="profile-img"
                             onclick="openModal();">
                        <input type="file" id="fileInput" name="profilePic" accept="image/*" style="display:none;" onchange="previewFile(this)">
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Username</label>
                        <input type="text" name="username" value="<%= user.getUsername() %>" class="form-control" required>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Full Name</label>
                        <input type="text" name="fullName" value="<%= user.getFullName() %>" class="form-control" required>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Gender</label>
                        <select name="gender" class="form-select" required>
                            <option value="male" <%= "male".equalsIgnoreCase(user.getGender()) ? "selected" : "" %>>Male</option>
                            <option value="female" <%= "female".equalsIgnoreCase(user.getGender()) ? "selected" : "" %>>Female</option>
                            <option value="other" <%= "other".equalsIgnoreCase(user.getGender()) ? "selected" : "" %>>Other</option>
                        </select>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Email</label>
                        <input type="email" name="email" value="<%= user.getEmail() %>" class="form-control" required>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Phone</label>
                        <input type="text" name="phone" value="<%= user.getPhone() %>" class="form-control" required>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Password</label>
                        <input type="password" name="password" value="<%= user.getPassword() %>" class="form-control" required>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Address</label>
                        <input type="text" name="address" value="<%= user.getAddress() != null ? user.getAddress() : "" %>" class="form-control">
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Department</label>
                        <input type="text" name="department" value="<%= user.getDepartment() != null ? user.getDepartment() : "" %>" class="form-control">
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Date of Birth</label>
                        <input type="date" name="dob" value="<%= user.getDob() != null ? user.getDob() : "" %>" class="form-control">
                    </div>

                    <div class="col-12">
                        <button type="submit" class="btn btn-success w-100 py-3 fs-5">
                            <i class="bi bi-save"></i> Save Changes
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

</div>

<!-- ✅ Bootstrap already loaded in headers -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<!-- ✅ Profile picture modal -->
<div id="imageModal" class="modal fade" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content bg-dark text-white text-center">
            <div class="modal-body">
                <img id="modalImage" src="<%= user.getProfilePic() != null ? user.getProfilePic() : "default-profile.png" %>" class="modal-img">
                <br><br>
                <button class="btn btn-warning" onclick="triggerFileInput()">Change Photo</button>
                <button class="btn btn-light" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<!-- ✅ Profile image preview script -->
<script>
    const imageModal = new bootstrap.Modal(document.getElementById('imageModal'));

    function openModal() {
        imageModal.show();
    }

    function triggerFileInput() {
        document.getElementById('fileInput').click();
        imageModal.hide();
    }

    function previewFile(input) {
        const file = input.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function(e) {
                document.getElementById("previewImage").src = e.target.result;
                document.getElementById("modalImage").src = e.target.result;
            };
            reader.readAsDataURL(file);
        }
    }
</script>
