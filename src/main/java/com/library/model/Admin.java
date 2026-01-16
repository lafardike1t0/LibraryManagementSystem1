package com.library.model;

// Admin class extends User (Inheritance)
public class Admin extends User {
    private static final long serialVersionUID = 1L;
    
    private String department;
    
    // Default constructor
    public Admin() {
        super();
        this.setUserType("ADMIN");
    }
    
    // Parameterized constructor
    public Admin(int userId, String username, String password, String fullName, String email, String department) {
        super(userId, username, password, fullName, email, "ADMIN");
        this.department = department;
    }
    
    // Getter and setter for department
    public String getDepartment() {
        return department;
    }
    
    public void setDepartment(String department) {
        this.department = department;
    }
    
    // Override method (Polymorphism)
    @Override
    public String displayInfo() {
        return "Admin: " + getFullName() + " - Department: " + department;
    }
}
