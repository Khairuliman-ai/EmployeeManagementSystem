package model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class LeaveApplicationDAO {

    // Establish database connection
    public static Connection getConnection() {
        Connection con = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/attendancesystem1_db", "root", "");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return con;
    }

    // Insert new leave application
    public static boolean insertLeave(int userID, String leaveType, Date startDate, Date endDate,
            String reason, String status, String reasonFile) {

        String query = "INSERT INTO leaveapplication (userID, leaveType, startDate, endDate, reason, status, reasonFile) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, userID);
            ps.setString(2, leaveType);
            ps.setDate(3, startDate);
            ps.setDate(4, endDate);
            ps.setString(5, reason);
            ps.setString(6, status); // status can be Pending by default or passed
            ps.setString(7, reasonFile);

            return ps.executeUpdate() > 0;

        } catch (Exception ex) {
            ex.printStackTrace();
            return false;
        }
    }

    // Update leave status (Approved/Rejected)
    public static boolean updateLeaveStatus(int leaveId, String status) {
        String query = "UPDATE leaveapplication SET status = ? WHERE leaveId = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, status);
            ps.setInt(2, leaveId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Delete leave application by leaveId
    public static boolean deleteLeave(int leaveId) {
        String query = "DELETE FROM leaveapplication WHERE leaveId = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, leaveId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Get leave status by leaveId (for viewing individual application status)
    public static String getLeaveStatusById(int leaveId) {
        String status = null;
        String query = "SELECT status FROM leaveapplication WHERE leaveId = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, leaveId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                status = rs.getString("status");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }

    // Get leave applications by userID (for student/staff view)
    public static List<String[]> getLeavesByUserID(String userID) {
        List<String[]> list = new ArrayList<>();
        String query = "SELECT * FROM leaveapplication WHERE userID = ? ORDER BY leaveId DESC";

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, userID);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(new String[]{
                    rs.getString("leaveId"),
                    rs.getString("userID"),
                    rs.getString("leaveType"),
                    rs.getString("startDate"),
                    rs.getString("endDate"),
                    rs.getString("reason"),
                    rs.getString("status"),
                    rs.getString("reasonFile")
                });
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Get all leave applications (for admin/head view)
    public static List<String[]> getAllLeaveApp() {
        List<String[]> list = new ArrayList<>();
        String query = "SELECT * FROM leaveapplication ORDER BY leaveId DESC";

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(new String[]{
                    rs.getString("leaveId"),
                    rs.getString("userID"),
                    rs.getString("leaveType"),
                    rs.getString("startDate"),
                    rs.getString("endDate"),
                    rs.getString("reason"),
                    rs.getString("status"),
                    rs.getString("reasonFile")
                });
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
