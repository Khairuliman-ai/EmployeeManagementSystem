// dao/OvertimeDAO.java

package model;

import java.sql.*;
import java.util.*;
import model.Overtime;
import util.DBUtil;
import model.User;
import model.userAttendance;

public class OvertimeDAO {





    public boolean insertOvertime(Overtime overtime) {
        boolean result = false;
        try (Connection conn = DBUtil.getConnection()) {
            String sql = "INSERT INTO overtime (userID, startTime, endTime, dateOvertime, varification) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, overtime.getUserID());
            stmt.setTime(2, overtime.getStartTime());
            stmt.setTime(3, overtime.getEndTime());
            stmt.setDate(4, overtime.getDateOvertime());
            stmt.setString(5, overtime.getVerification());
            result = stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public List<Overtime> getOvertimeByUser(int userID) {
        List<Overtime> list = new ArrayList<>();
        try (Connection conn = DBUtil.getConnection()) {
            String sql = "SELECT * FROM overtime WHERE userID = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userID);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Overtime overtime = new Overtime();
                overtime.setOvertimeID(rs.getInt("overtimeID"));
                overtime.setUserID(rs.getInt("userID"));
                overtime.setStartTime(rs.getTime("startTime"));
                overtime.setEndTime(rs.getTime("endTime"));
                overtime.setDateOvertime(rs.getDate("dateOvertime"));
                overtime.setVerification(rs.getString("varification"));
                list.add(overtime);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Overtime> getAllOvertime() {
        List<Overtime> list = new ArrayList<>();
        try (Connection conn = DBUtil.getConnection()) {
            String sql = "SELECT * FROM overtime";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Overtime overtime = new Overtime();
                overtime.setOvertimeID(rs.getInt("overtimeID"));
                overtime.setUserID(rs.getInt("userID"));
                overtime.setStartTime(rs.getTime("startTime"));
                overtime.setEndTime(rs.getTime("endTime"));
                overtime.setDateOvertime(rs.getDate("dateOvertime"));
                overtime.setVerification(rs.getString("varification"));
                list.add(overtime);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean updateOvertime(Overtime overtime) {
        boolean result = false;
        try (Connection conn = DBUtil.getConnection()) {
            String sql = "UPDATE overtime SET startTime = ?, endTime = ?, dateOvertime = ? WHERE overtimeID = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setTime(1, overtime.getStartTime());
            stmt.setTime(2, overtime.getEndTime());
            stmt.setDate(3, overtime.getDateOvertime());
            stmt.setInt(4, overtime.getOvertimeID());
            result = stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public boolean deleteOvertime(int overtimeID) {
        boolean result = false;
        try (Connection conn = DBUtil.getConnection()) {
            String sql = "DELETE FROM overtime WHERE overtimeID = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, overtimeID);
            result = stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
    
    public static List<userAttendance> getMonthlyAttendanceReport(String departmentM, int year, int month) {
        List<userAttendance> reports = new ArrayList<>();
        String formattedMonth = String.format("%04d-%02d", year, month);

        String sql = "SELECT "
           + "  a.userID, "
           + "  u.fullName, "
           + "  u.role, "
           + "  u.department, "
           + "  DATE_FORMAT(a.date, '%Y-%m') AS month, "
           + "  SUM(CASE WHEN a.attendanceStatus IN ('Present', 'Late') THEN 1 ELSE 0 END) AS attended_days, "
           + "  ROUND( "
           + "    SUM(CASE WHEN a.attendanceStatus IN ('Present', 'Late') THEN 1 ELSE 0 END) "
           + "    / wd.total_working_days * 100, "
           + "    2 "
           + "  ) AS attendance_percentage "
           + "FROM attendance a "
           + "JOIN users u ON a.userID = u.userID "
           + "JOIN working_days wd ON DATE_FORMAT(a.date, '%Y-%m') = wd.yearMonth "
           + "WHERE DATE_FORMAT(a.date, '%Y-%m') = ? "
           + "  AND u.department = ? "
           + "GROUP BY a.userID, u.department, u.role, wd.total_working_days "
           + "ORDER BY a.userID;";

       

        try {
            Connection con = DBUtil.getConnection();

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, formattedMonth);
            ps.setString(2, departmentM);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    userAttendance userAtt = new userAttendance();
                    userAtt.setUserID(rs.getInt("userID"));
                    userAtt.setFullName(rs.getString("fullName"));
                    userAtt.setRole(rs.getString("role"));
                    userAtt.setDepartment(rs.getString("department"));
                    userAtt.setMonth(rs.getString("month"));
                    userAtt.setAttendedDays(rs.getInt("attended_days"));
                    userAtt.setAttendancePercentage(rs.getDouble("attendance_percentage"));
                    reports.add(userAtt);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return reports;
    }

    public boolean updateVerification(int overtimeID, String verification) {
        boolean result = false;
        try (Connection conn = DBUtil.getConnection()) {
            String sql = "UPDATE overtime SET varification = ? WHERE overtimeID = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, verification);
            stmt.setInt(2, overtimeID);
            result = stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
}
