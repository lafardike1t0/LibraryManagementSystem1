package com.library.model;

import java.io.Serializable;

// Model class for Book entity
public class Book implements Serializable {
    private static final long serialVersionUID = 1L;
    
    // Private fields for encapsulation
    private int bookId;
    private String isbn;
    private String title;
    private String author;
    private String category;
    private int quantity;
    private int availableQuantity;
    private String publisher;
    private int yearPublished;
    private String coverImage;
    
    // Default constructor
    public Book() {
    }
    
    // Parameterized constructor
    public Book(int bookId, String isbn, String title, String author, String category, 
                int quantity, int availableQuantity, String publisher, int yearPublished) {
        this.bookId = bookId;
        this.isbn = isbn;
        this.title = title;
        this.author = author;
        this.category = category;
        this.quantity = quantity;
        this.availableQuantity = availableQuantity;
        this.publisher = publisher;
        this.yearPublished = yearPublished;
    }
    
    // Getters and setters for encapsulation
    public int getBookId() {
        return bookId;
    }
    
    public void setBookId(int bookId) {
        this.bookId = bookId;
    }
    
    public String getIsbn() {
        return isbn;
    }
    
    public void setIsbn(String isbn) {
        this.isbn = isbn;
    }
    
    public String getTitle() {
        return title;
    }
    
    public void setTitle(String title) {
        this.title = title;
    }
    
    public String getAuthor() {
        return author;
    }
    
    public void setAuthor(String author) {
        this.author = author;
    }
    
    public String getCategory() {
        return category;
    }
    
    public void setCategory(String category) {
        this.category = category;
    }
    
    public int getQuantity() {
        return quantity;
    }
    
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    
    public int getAvailableQuantity() {
        return availableQuantity;
    }
    
    public void setAvailableQuantity(int availableQuantity) {
        this.availableQuantity = availableQuantity;
    }
    
    public String getPublisher() {
        return publisher;
    }
    
    public void setPublisher(String publisher) {
        this.publisher = publisher;
    }
    
    public int getYearPublished() {
        return yearPublished;
    }
    
    public void setYearPublished(int yearPublished) {
        this.yearPublished = yearPublished;
    }
    
    public String getCoverImage() {
        return coverImage;
    }
    
    public void setCoverImage(String coverImage) {
        this.coverImage = coverImage;
    }
    
    // Check if book is available for borrowing
    public boolean isAvailable() {
        return availableQuantity > 0;
    }
}
