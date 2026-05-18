package dao;

import model.Attendance;
import util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AttendanceDAO {

    public void addAttendance(Attendance attendance) throws SQLException {
        String sql = "INSERT INTO attendance (userID, name, role, date, clockIn, clockOut, attendanceStatus) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, attendance.getUserID());
            ps.setString(2, attendance.getName());
            ps.setString(3, attendance.getRole());
            ps.setDate(4, new java.sql.Date(attendance.getDate().getTime()));
            ps.setString(5, attendance.getClockIn());
            ps.setString(6, attendance.getClockOut());
            ps.setString(7, attendance.getAttendanceStatus());

            ps.executeUpdate();
        }
    }

    public List<Attendance> getAllAttendance() throws SQLException {
        List<Attendance> list = new ArrayList<>();
        String sql = "SELECT * FROM attendance ORDER BY date DESC, attendanceID DESC";
        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Attendance a = mapAttendance(rs);
                list.add(a);
            }
        }
        return list;
    }

    public List<Attendance> searchAttendance(String keyword) throws SQLException {
        List<Attendance> list = new ArrayList<>();
        String sql = "SELECT * FROM attendance WHERE userID LIKE ? OR name LIKE ? ORDER BY date DESC";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, "%" + keyword + "%");
            ps.setString(2, "%" + keyword + "%");

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Attendance a = mapAttendance(rs);
                    list.add(a);
                }
            }
        }
        return list;
    }

    public void updateAttendance(Attendance attendance) throws SQLException {
        String sql = "UPDATE attendance SET date=?, clockIn=?, clockOut=?, attendanceStatus=? WHERE attendanceID=?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setDate(1, new java.sql.Date(attendance.getDate().getTime()));
            ps.setString(2, attendance.getClockIn());
            ps.setString(3, attendance.getClockOut());
            ps.setString(4, attendance.getAttendanceStatus());
            ps.setInt(5, attendance.getAttendanceID());

            ps.executeUpdate();
        }
    }

    public void deleteAttendance(int id) throws SQLException {
        String sql = "DELETE FROM attendance WHERE attendanceID=?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }

    // ✅ NEW METHOD: load specific attendance by ID (for edit)
    public Attendance getAttendanceById(int attendanceID) throws SQLException {
        Attendance attendance = null;
        String sql = "SELECT * FROM attendance WHERE attendanceID = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, attendanceID);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    attendance = mapAttendance(rs);
                }
            }
        }
        return attendance;
    }

    private Attendance mapAttendance(ResultSet rs) throws SQLException {
        Attendance a = new Attendance();
        a.setAttendanceID(rs.getInt("attendanceID"));
        a.setUserID(rs.getInt("userID"));
        a.setName(rs.getString("name"));
        a.setRole(rs.getString("role"));
        a.setDate(rs.getDate("date"));
        a.setClockIn(rs.getString("clockIn"));
        a.setClockOut(rs.getString("clockOut"));
        a.setAttendanceStatus(rs.getString("attendanceStatus"));
        return a;
    }
    
    public List<Attendance> getAttendanceByDateFilter(Integer day, Integer month, Integer year) throws SQLException {
    List<Attendance> list = new ArrayList<>();

    StringBuilder sql = new StringBuilder("SELECT * FROM attendance WHERE 1=1");
    List<Object> params = new ArrayList<>();

    if (day != null) {
        sql.append(" AND DAY(date) = ?");
        params.add(day);
    }
    if (month != null) {
        sql.append(" AND MONTH(date) = ?");
        params.add(month);
    }
    if (year != null) {
        sql.append(" AND YEAR(date) = ?");
        params.add(year);
    }

    sql.append(" ORDER BY date DESC");

    try (Connection conn = DBUtil.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql.toString())) {

        for (int i = 0; i < params.size(); i++) {
            ps.setObject(i + 1, params.get(i));
        }

        try (ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Attendance a = mapAttendance(rs);
                list.add(a);
            }
        }
    }
    return list;
}

}
