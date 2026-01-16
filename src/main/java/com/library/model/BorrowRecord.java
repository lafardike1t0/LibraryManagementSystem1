package com.library.model;

import java.io.Serializable;
import java.time.LocalDate;

// Model class for tracking book borrowing
public class BorrowRecord implements Serializable {
    private static final long serialVersionUID = 1L;
    
    private int recordId;
    private int userId;
    private int bookId;
    private LocalDate borrowDate;
    private LocalDate dueDate;
    private LocalDate returnDate;
    private String status;
    private String bookTitle;  // For display purposes
    
    // Default constructor
    public BorrowRecord() {
    }
    
    // Parameterized constructor
    public BorrowRecord(int recordId, int userId, int bookId, LocalDate borrowDate, 
                        LocalDate dueDate, LocalDate returnDate, String status) {
        this.recordId = recordId;
        this.userId = userId;
        this.bookId = bookId;
        this.borrowDate = borrowDate;
        this.dueDate = dueDate;
        this.returnDate = returnDate;
        this.status = status;
    }
    
    // Getters and setters
    public int getRecordId() {
        return recordId;
    }
    
    public void setRecordId(int recordId) {
        this.recordId = recordId;
    }
    
    public int getUserId() {
        return userId;
    }
    
    public void setUserId(int userId) {
        this.userId = userId;
    }
    
    public int getBookId() {
        return bookId;
    }
    
    public void setBookId(int bookId) {
        this.bookId = bookId;
    }
    
    public LocalDate getBorrowDate() {
        return borrowDate;
    }
    
    public void setBorrowDate(LocalDate borrowDate) {
        this.borrowDate = borrowDate;
    }
    
    public LocalDate getDueDate() {
        return dueDate;
    }
    
    public void setDueDate(LocalDate dueDate) {
        this.dueDate = dueDate;
    }
    
    public LocalDate getReturnDate() {
        return returnDate;
    }
    
    public void setReturnDate(LocalDate returnDate) {
        this.returnDate = returnDate;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    public String getBookTitle() {
        return bookTitle;
    }
    
    public void setBookTitle(String bookTitle) {
        this.bookTitle = bookTitle;
    }
    
    // Check if the book is overdue
    public boolean isOverdue() {
        if (status.equals("RETURNED")) {
            return false;
        }
        return LocalDate.now().isAfter(dueDate);
    }
}
