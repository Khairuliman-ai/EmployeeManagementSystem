package model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProfileDAO {
    private final String jdbcURL = "jdbc:mysql://localhost:3306/attendancesystem_db";
    private final String jdbcUsername = "root";
    private final String jdbcPassword = "";

    // Insert SQL without userID, assuming userID is auto-increment in DB
    private static final String INSERT_PROFILE_SQL =
        "INSERT INTO Profile (fullName, gender, email, phone, status) VALUES (?, ?, ?, ?, ?)";
    private static final String SELECT_ALL_PROFILES_SQL = "SELECT * FROM Profile";
    private static final String SELECT_PROFILE_BY_ID_SQL = "SELECT * FROM Profile WHERE profileID = ?";

    private Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException("MySQL Driver not found", e);
        }
        return DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
    }

    public void insertProfile(Profile profile) throws SQLException {
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(INSERT_PROFILE_SQL)) {
            ps.setString(1, profile.getFullName());
            ps.setString(2, profile.getGender());
            ps.setString(3, profile.getEmail());
            ps.setString(4, profile.getPhone());
            ps.setString(5, profile.getStatus());
            ps.executeUpdate();
        }
    }

    public List<Profile> getAllProfiles() throws SQLException {
        List<Profile> profileList = new ArrayList<>();
        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(SELECT_ALL_PROFILES_SQL)) {
            while (rs.next()) {
                int profileID = rs.getInt("profileID");
                int userID = rs.getInt("userID");  // Assuming userID still exists in DB (auto-gen)
                String fullName = rs.getString("fullName");
                String gender = rs.getString("gender");
                String email = rs.getString("email");
                String phone = rs.getString("phone");
                String status = rs.getString("status");
                profileList.add(new Profile(profileID, userID, fullName, gender, email, phone, status));
            }
        }
        return profileList;
    }

    public Profile getProfileById(int profileID) throws SQLException {
        Profile profile = null;
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(SELECT_PROFILE_BY_ID_SQL)) {
            ps.setInt(1, profileID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int userID = rs.getInt("userID");
                String fullName = rs.getString("fullName");
                String gender = rs.getString("gender");
                String email = rs.getString("email");
                String phone = rs.getString("phone");
                String status = rs.getString("status");
                profile = new Profile(profileID, userID, fullName, gender, email, phone, status);
            }
        }
        return profile;
    }

    public void updateStatus(int profileID, String status) throws SQLException {
        String sql = "UPDATE Profile SET status = ? WHERE profileID = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, profileID);
            ps.executeUpdate();
        }
    }

        public void deleteUser(int userID) throws SQLException {
        String sql = "DELETE FROM users WHERE userID = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userID);
            ps.executeUpdate();
        }
    }
    
    // Example method to authenticate a user
public boolean authenticateUser(String username, String password) throws SQLException {
    // SQL query to check if the username and password match
    String sql = "SELECT * FROM Profile WHERE username = ? AND password = ?";
    try (Connection conn = getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        // Set the username and password parameters
        ps.setString(1, username);
        ps.setString(2, password); // Note: In a real application, compare hashed passwords
        // Execute the query
        ResultSet rs = ps.executeQuery();
        // Return true if a matching record is found, false otherwise
        return rs.next();
    }
}
    
}


