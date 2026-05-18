package model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import util.DBUtil;

public class UserDAO {

    public boolean testConnection() {
        try (Connection connection = DBUtil.getConnection()) {
            System.out.println("✅ Database connected successfully!");
            return true;
        } catch (Exception e) {
            System.out.println("❌ Failed to connect to the database:");
            e.printStackTrace();
            return false;
        }
    }

    // ✅ Register new user
    public boolean registerUser(User user) {
        boolean result = false;
        String INSERT_QUERY =
            "INSERT INTO users (username, fullName, gender, email, phone, password, address, department, dob, role, profilePic) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection connection = DBUtil.getConnection();
             PreparedStatement ps = connection.prepareStatement(INSERT_QUERY)) {
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getFullName());
            ps.setString(3, user.getGender());
            ps.setString(4, user.getEmail());
            ps.setString(5, user.getPhone());
            ps.setString(6, user.getPassword());
            ps.setString(7, user.getAddress());
            ps.setString(8, user.getDepartment());
            ps.setString(9, user.getDob());
            ps.setString(10, user.getRole());
            ps.setString(11, user.getProfilePic());

            int rows = ps.executeUpdate();
            result = rows > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    // ✅ Get all users (with profilePic)
    public List<User> getAllUsers() throws SQLException {
        List<User> users = new ArrayList<>();
        String SELECT_ALL_USERS_SQL = "SELECT * FROM users";
        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(SELECT_ALL_USERS_SQL)) {
            while (rs.next()) {
                User user = new User(
                    rs.getInt("userID"),
                    rs.getString("username"),
                    rs.getString("fullName"),
                    rs.getString("gender"),
                    rs.getString("email"),
                    rs.getString("phone"),
                    rs.getString("password"),
                    rs.getString("address"),
                    rs.getString("department"),
                    rs.getString("dob"),
                    rs.getString("role"),
                    rs.getString("profilePic")
                );
                users.add(user);
            }
        }
        return users;
    }

    // ✅ Get user by ID (with profilePic)
    public User getUserById(int userID) throws SQLException {
        User user = null;
        String SELECT_USER_BY_ID_SQL = "SELECT * FROM users WHERE userID = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(SELECT_USER_BY_ID_SQL)) {
            ps.setInt(1, userID);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    user = new User(
                        rs.getInt("userID"),
                        rs.getString("username"),
                        rs.getString("fullName"),
                        rs.getString("gender"),
                        rs.getString("email"),
                        rs.getString("phone"),
                        rs.getString("password"),
                        rs.getString("address"),
                        rs.getString("department"),
                        rs.getString("dob"),
                        rs.getString("role"),
                        rs.getString("profilePic")
                    );
                }
            }
        }
        return user;
    }

    // ✅ Update user (with profilePic)
    public boolean updateUser(User user) throws SQLException {
        boolean rowUpdated;
        String UPDATE_USER_SQL =
            "UPDATE users SET username = ?, fullName = ?, gender = ?, email = ?, phone = ?, password = ?, address = ?, department = ?, dob = ?, role = ?, profilePic = ? WHERE userID = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(UPDATE_USER_SQL)) {
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getFullName());
            ps.setString(3, user.getGender());
            ps.setString(4, user.getEmail());
            ps.setString(5, user.getPhone());
            ps.setString(6, user.getPassword());
            ps.setString(7, user.getAddress());
            ps.setString(8, user.getDepartment());
            ps.setString(9, user.getDob());
            ps.setString(10, user.getRole());
            ps.setString(11, user.getProfilePic());
            ps.setInt(12, user.getUserID());

            rowUpdated = ps.executeUpdate() > 0;
        }
        return rowUpdated;
    }
    
    public boolean validate(User user) {
        boolean status = false;
        String sql = "SELECT * FROM users WHERE username = ? AND password = ?";
        try (Connection connection = DBUtil.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword());

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    user.setUserID(rs.getInt("userID"));
                    user.setFullName(rs.getString("fullName"));
                    user.setGender(rs.getString("gender"));
                    user.setEmail(rs.getString("email"));
                    user.setPhone(rs.getString("phone"));
                    user.setAddress(rs.getString("address"));
                    user.setDepartment(rs.getString("department"));
                    user.setDob(rs.getString("dob"));
                    user.setRole(rs.getString("role"));
                    user.setProfilePic(rs.getString("profilePic"));

                    status = true;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }

    // ✅ Delete user
    public boolean deleteUser(int userID) throws SQLException {
        boolean rowDeleted;
        String DELETE_USER_SQL = "DELETE FROM users WHERE userID = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(DELETE_USER_SQL)) {
            ps.setInt(1, userID);
            rowDeleted = ps.executeUpdate() > 0;
        }
        return rowDeleted;
    }
}
