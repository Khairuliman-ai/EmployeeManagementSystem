// model/Overtime.java

package model;

import java.sql.Time;
import java.sql.Date;

public class Overtime {
    private int overtimeID;
    private int userID;
    private Time startTime;
    private Time endTime;
    private Date dateOvertime;
    private String verification;

    // Constructor
    public Overtime() {}

    // Getters and Setters
    public int getOvertimeID() {
        return overtimeID;
    }

    public void setOvertimeID(int overtimeID) {
        this.overtimeID = overtimeID;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public Time getStartTime() {
        return startTime;
    }

    public void setStartTime(Time startTime) {
        this.startTime = startTime;
    }

    public Time getEndTime() {
        return endTime;
    }

    public void setEndTime(Time endTime) {
        this.endTime = endTime;
    }

    public Date getDateOvertime() {
        return dateOvertime;
    }

    public void setDateOvertime(Date dateOvertime) {
        this.dateOvertime = dateOvertime;
    }

    public String getVerification() {
        return verification;
    }

    public void setVerification(String verification) {
        this.verification = verification;
    }
}
