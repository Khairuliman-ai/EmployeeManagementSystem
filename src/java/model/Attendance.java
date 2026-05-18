package model;

import java.util.Date;

public class Attendance {
    private int attendanceID;
    private int userID;
    private String name;
    private String role;
    private Date date;
    private String clockIn;
    private String clockOut;
    private String attendanceStatus;

    // Getters and Setters
    public int getAttendanceID() { return attendanceID; }
    public void setAttendanceID(int attendanceID) { this.attendanceID = attendanceID; }

    public int getUserID() { return userID; }
    public void setUserID(int userID) { this.userID = userID; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }

    public Date getDate() { return date; }
    public void setDate(Date date) { this.date = date; }

    public String getClockIn() { return clockIn; }
    public void setClockIn(String clockIn) { this.clockIn = clockIn; }

    public String getClockOut() { return clockOut; }
    public void setClockOut(String clockOut) { this.clockOut = clockOut; }

    public String getAttendanceStatus() { return attendanceStatus; }
    public void setAttendanceStatus(String attendanceStatus) { this.attendanceStatus = attendanceStatus; }
}
