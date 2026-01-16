package com.library.model;

// Member class extends User (Inheritance)
public class Member extends User {
    private static final long serialVersionUID = 1L;
    
    private String membershipId;
    private int borrowedBooksCount;
    
    // Default constructor
    public Member() {
        super();
        this.setUserType("MEMBER");
        this.borrowedBooksCount = 0;
    }
    
    // Parameterized constructor
    public Member(int userId, String username, String password, String fullName, String email, String membershipId) {
        super(userId, username, password, fullName, email, "MEMBER");
        this.membershipId = membershipId;
        this.borrowedBooksCount = 0;
    }
    
    // Getters and setters
    public String getMembershipId() {
        return membershipId;
    }
    
    public void setMembershipId(String membershipId) {
        this.membershipId = membershipId;
    }
    
    public int getBorrowedBooksCount() {
        return borrowedBooksCount;
    }
    
    public void setBorrowedBooksCount(int borrowedBooksCount) {
        this.borrowedBooksCount = borrowedBooksCount;
    }
    
    // Override method (Polymorphism)
    @Override
    public String displayInfo() {
        return "Member: " + getFullName() + " - Books Borrowed: " + borrowedBooksCount;
    }
    
    // Method to check if member can borrow more books
    public boolean canBorrow() {
        return borrowedBooksCount < 5;
    }
}
