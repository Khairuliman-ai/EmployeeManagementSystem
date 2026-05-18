package model;

public class User {

    private int userID;
    private String username;
    private String fullName;
    private String gender;
    private String email;
    private String phone;
    private String password;
    private String address;
    private String department;
    private String dob;
    private String role;
    private String profilePic;  // ✅ New field for profile picture

    // Updated constructor including profilePic
    public User(int userID, String username, String fullName, String gender, String email, String phone,
            String password, String address, String department, String dob, String role, String profilePic) {
        this.userID = userID;
        this.username = username;
        this.fullName = fullName;
        this.gender = gender;
        this.email = email;
        this.phone = phone;
        this.password = password;
        this.address = address;
        this.department = department;
        this.dob = dob;
        this.role = role;
        this.profilePic = profilePic;
    }

    // Old constructor (optional, for backward compatibility)
    public User(int userID, String username, String fullName, String gender, String email, String phone,
            String password, String address, String department, String dob, String role) {
        this(userID, username, fullName, gender, email, phone, password, address, department, dob, role, null);
    }

    // Getters and setters
    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    public String getDob() {
        return dob;
    }

    public void setDob(String dob) {
        this.dob = dob;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    // ✅ New getter & setter for profilePic
    public String getProfilePic() {
        return profilePic;
    }

    public void setProfilePic(String profilePic) {
        this.profilePic = profilePic;
    }
}
