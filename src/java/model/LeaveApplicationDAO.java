package model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import util.DBUtil;

public class LeaveApplicationDAO {

    // Insert new leave application
    public boolean insertLeave(int userID, String leaveType, Date startDate, Date endDate,
            String reason, String status, String reasonFile) {

        String query = "INSERT INTO leaveapplication (userID, leaveType, startDate, endDate, reason, status, reasonFile) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBUtil.getConnection(); 
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, userID);
            ps.setString(2, leaveType);
            ps.setDate(3, startDate);
            ps.setDate(4, endDate);
            ps.setString(5, reason);
            ps.setString(6, status);
            ps.setString(7, reasonFile);

            return ps.executeUpdate() > 0;

        } catch (Exception ex) {
            ex.printStackTrace();
            return false;
        }
    }

    // Update leave status (Approved/Rejected)
    public boolean updateLeaveStatus(int leaveId, String status) {
        String query = "UPDATE leaveapplication SET status = ? WHERE leaveId = ?";
        try (Connection conn = DBUtil.getConnection(); 
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, status);
            ps.setInt(2, leaveId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Delete leave application by leaveId
    public boolean deleteLeave(int leaveId) {
        String query = "DELETE FROM leaveapplication WHERE leaveId = ?";
        try (Connection conn = DBUtil.getConnection(); 
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, leaveId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Get leave status by leaveId (for viewing individual application status)
    public String getLeaveStatusById(int leaveId) {
        String status = null;
        String query = "SELECT status FROM leaveapplication WHERE leaveId = ?";
        try (Connection conn = DBUtil.getConnection(); 
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, leaveId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    status = rs.getString("status");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }

    // Get leave applications by userID (for student/staff view)
    public List<LeaveApplication> getLeavesByUserID(String userID) {
        List<LeaveApplication> list = new ArrayList<>();
        String query = "SELECT * FROM leaveapplication WHERE userID = ? ORDER BY leaveId DESC";

        try (Connection conn = DBUtil.getConnection(); 
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, userID);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    LeaveApplication app = new LeaveApplication(
                        rs.getInt("leaveId"),
                        rs.getInt("userID"),
                        rs.getString("leaveType"),
                        rs.getDate("startDate"),
                        rs.getDate("endDate"),
                        rs.getString("reason"),
                        rs.getString("status"),
                        rs.getString("reasonFile")
                    );
                    list.add(app);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Get all leave applications (for admin/head view)
    public List<LeaveApplication> getAllLeaveApp() {
        List<LeaveApplication> list = new ArrayList<>();
        String query = "SELECT * FROM leaveapplication ORDER BY leaveId DESC";

        try (Connection conn = DBUtil.getConnection(); 
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                LeaveApplication app = new LeaveApplication(
                    rs.getInt("leaveId"),
                    rs.getInt("userID"),
                    rs.getString("leaveType"),
                    rs.getDate("startDate"),
                    rs.getDate("endDate"),
                    rs.getString("reason"),
                    rs.getString("status"),
                    rs.getString("reasonFile")
                );
                list.add(app);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
