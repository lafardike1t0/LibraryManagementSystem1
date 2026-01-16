package com.library.model;

import java.io.Serializable;

// Parent class for all user types
public class User implements Serializable {
    private static final long serialVersionUID = 1L;
    
    // Private fields for encapsulation
    private int userId;
    private String username;
    private String password;
    private String fullName;
    private String email;
    private String userType;
    
    // Default constructor
    public User() {
    }
    
    // Parameterized constructor
    public User(int userId, String username, String password, String fullName, String email, String userType) {
        this.userId = userId;
        this.username = username;
        this.password = password;
        this.fullName = fullName;
        this.email = email;
        this.userType = userType;
    }
    
    // Getters and setters for encapsulation
    public int getUserId() {
        return userId;
    }
    
    public void setUserId(int userId) {
        this.userId = userId;
    }
    
    public String getUsername() {
        return username;
    }
    
    public void setUsername(String username) {
        this.username = username;
    }
    
    public String getPassword() {
        return password;
    }
    
    public void setPassword(String password) {
        this.password = password;
    }
    
    public String getFullName() {
        return fullName;
    }
    
    public void setFullName(String fullName) {
        this.fullName = fullName;
    }
    
    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    public String getUserType() {
        return userType;
    }
    
    public void setUserType(String userType) {
        this.userType = userType;
    }
    
    // Method to display user information
    public String displayInfo() {
        return "User: " + fullName + " (" + userType + ")";
    }
}
