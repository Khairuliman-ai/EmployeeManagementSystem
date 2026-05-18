package model;

import java.sql.Date;

public class LeaveApplication {
    private int leaveId;
    private int userID;
    private String leaveType;
    private Date startDate;
    private Date endDate;
    private String reason;
    private String status;
    private String reasonFile;

    public LeaveApplication() {}

    public LeaveApplication(int leaveId, int userID, String leaveType, Date startDate, Date endDate, String reason, String status, String reasonFile) {
        this.leaveId = leaveId;
        this.userID = userID;
        this.leaveType = leaveType;
        this.startDate = startDate;
        this.endDate = endDate;
        this.reason = reason;
        this.status = status;
        this.reasonFile = reasonFile;
    }

    public int getLeaveId() { 
        return leaveId; 
    }
    
    public void setLeaveId(int leaveId) { 
        this.leaveId = leaveId; 
    }

    public int getUserID() { 
        return userID; 
    }
    
    public void setUserID(int userID) { 
        this.userID = userID; 
    }

    public String getLeaveType() { 
        return leaveType; 
    }
    
    public void setLeaveType(String leaveType) { 
        this.leaveType = leaveType; 
    }

    public Date getStartDate() { 
        return startDate; 
    }
    
    public void setStartDate(Date startDate) { 
        this.startDate = startDate; 
    }

    public Date getEndDate() { 
        return endDate; 
    }
    
    public void setEndDate(Date endDate) { 
        this.endDate = endDate; 
    }

    public String getReason() { 
        return reason; 
    }
    
    public void setReason(String reason) { 
        this.reason = reason; 
    }

    public String getStatus() { 
        return status; 
    }
    
    public void setStatus(String status) { 
        this.status = status; 
    }

    public String getReasonFile() { 
        return reasonFile; 
    }
    
    public void setReasonFile(String reasonFile) { 
        this.reasonFile = reasonFile; 
    }
}
