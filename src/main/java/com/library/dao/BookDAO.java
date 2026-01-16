package com.library.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.library.model.Book;
import com.library.util.DBConnection;

// Data Access Object for Book operations
public class BookDAO {
    
    // Get database connection from singleton
    private Connection getConnection() {
        return DBConnection.getInstance().getConnection();
    }
    
    // Create new book (Admin only)
    public boolean createBook(Book book) {
        String query = "INSERT INTO books (isbn, title, author, category, quantity, available_quantity, publisher, year_published, cover_image) " +
                      "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (PreparedStatement pstmt = getConnection().prepareStatement(query)) {
            pstmt.setString(1, book.getIsbn());
            pstmt.setString(2, book.getTitle());
            pstmt.setString(3, book.getAuthor());
            pstmt.setString(4, book.getCategory());
            pstmt.setInt(5, book.getQuantity());
            pstmt.setInt(6, book.getAvailableQuantity());
            pstmt.setString(7, book.getPublisher());
            pstmt.setInt(8, book.getYearPublished());
            pstmt.setString(9, book.getCoverImage());
            
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.err.println("Error creating book: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    // Get all books
    public List<Book> getAllBooks() {
        List<Book> books = new ArrayList<>();
        String query = "SELECT * FROM books ORDER BY title";
        
        try (Statement stmt = getConnection().createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            
            while (rs.next()) {
                Book book = new Book();
                book.setBookId(rs.getInt("book_id"));
                book.setIsbn(rs.getString("isbn"));
                book.setTitle(rs.getString("title"));
                book.setAuthor(rs.getString("author"));
                book.setCategory(rs.getString("category"));
                book.setQuantity(rs.getInt("quantity"));
                book.setAvailableQuantity(rs.getInt("available_quantity"));
                book.setPublisher(rs.getString("publisher"));
                book.setYearPublished(rs.getInt("year_published"));
                book.setCoverImage(rs.getString("cover_image"));
                books.add(book);
            }
        } catch (SQLException e) {
            System.err.println("Error getting all books: " + e.getMessage());
            e.printStackTrace();
        }
        
        return books;
    }
    
    // Get book by ID
    public Book getBookById(int bookId) {
        String query = "SELECT * FROM books WHERE book_id = ?";
        
        try (PreparedStatement pstmt = getConnection().prepareStatement(query)) {
            pstmt.setInt(1, bookId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                Book book = new Book();
                book.setBookId(rs.getInt("book_id"));
                book.setIsbn(rs.getString("isbn"));
                book.setTitle(rs.getString("title"));
                book.setAuthor(rs.getString("author"));
                book.setCategory(rs.getString("category"));
                book.setQuantity(rs.getInt("quantity"));
                book.setAvailableQuantity(rs.getInt("available_quantity"));
                book.setPublisher(rs.getString("publisher"));
                book.setYearPublished(rs.getInt("year_published"));
                book.setCoverImage(rs.getString("cover_image"));
                return book;
            }
        } catch (SQLException e) {
            System.err.println("Error getting book: " + e.getMessage());
            e.printStackTrace();
        }
        
        return null;
    }
    
    // Update book information
    public boolean updateBook(Book book) {
        String query = "UPDATE books SET isbn = ?, title = ?, author = ?, category = ?, " +
                      "quantity = ?, available_quantity = ?, publisher = ?, year_published = ?, cover_image = ? " +
                      "WHERE book_id = ?";
        
        try (PreparedStatement pstmt = getConnection().prepareStatement(query)) {
            pstmt.setString(1, book.getIsbn());
            pstmt.setString(2, book.getTitle());
            pstmt.setString(3, book.getAuthor());
            pstmt.setString(4, book.getCategory());
            pstmt.setInt(5, book.getQuantity());
            pstmt.setInt(6, book.getAvailableQuantity());
            pstmt.setString(7, book.getPublisher());
            pstmt.setInt(8, book.getYearPublished());
            pstmt.setString(9, book.getCoverImage());
            pstmt.setInt(10, book.getBookId());
            
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.err.println("Error updating book: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    // Delete book
    public boolean deleteBook(int bookId) {
        String query = "DELETE FROM books WHERE book_id = ?";
        
        try (PreparedStatement pstmt = getConnection().prepareStatement(query)) {
            pstmt.setInt(1, bookId);
            
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.err.println("Error deleting book: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    // Check if book is currently borrowed (has active borrow records)
    public boolean isBookCurrentlyBorrowed(int bookId) {
        String query = "SELECT COUNT(*) as count FROM borrow_records WHERE book_id = ? AND status = 'BORROWED'";
        
        try (PreparedStatement pstmt = getConnection().prepareStatement(query)) {
            pstmt.setInt(1, bookId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt("count") > 0;
            }
            
        } catch (SQLException e) {
            System.err.println("Error checking if book is borrowed: " + e.getMessage());
            e.printStackTrace();
        }
        
        return false;
    }
    
    // Get count of active borrows for a book
    public int getActiveBorrowCount(int bookId) {
        String query = "SELECT COUNT(*) as count FROM borrow_records WHERE book_id = ? AND status = 'BORROWED'";
        
        try (PreparedStatement pstmt = getConnection().prepareStatement(query)) {
            pstmt.setInt(1, bookId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt("count");
            }
            
        } catch (SQLException e) {
            System.err.println("Error getting active borrow count: " + e.getMessage());
            e.printStackTrace();
        }
        
        return 0;
    }
    
    // Search books by title or author
    public List<Book> searchBooks(String keyword) {
        List<Book> books = new ArrayList<>();
        String query = "SELECT * FROM books WHERE LOWER(title) LIKE ? OR LOWER(author) LIKE ? ORDER BY title";
        
        try (PreparedStatement pstmt = getConnection().prepareStatement(query)) {
            String searchPattern = "%" + keyword.toLowerCase() + "%";
            pstmt.setString(1, searchPattern);
            pstmt.setString(2, searchPattern);
            
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Book book = new Book();
                book.setBookId(rs.getInt("book_id"));
                book.setIsbn(rs.getString("isbn"));
                book.setTitle(rs.getString("title"));
                book.setAuthor(rs.getString("author"));
                book.setCategory(rs.getString("category"));
                book.setQuantity(rs.getInt("quantity"));
                book.setAvailableQuantity(rs.getInt("available_quantity"));
                book.setPublisher(rs.getString("publisher"));
                book.setYearPublished(rs.getInt("year_published"));
                book.setCoverImage(rs.getString("cover_image"));
                books.add(book);
            }
        } catch (SQLException e) {
            System.err.println("Error searching books: " + e.getMessage());
            e.printStackTrace();
        }
        
        return books;
    }
    
    // Update available quantity when book is borrowed or returned
    public boolean updateAvailableQuantity(int bookId, int change) {
        String query = "UPDATE books SET available_quantity = available_quantity + ? WHERE book_id = ?";
        
        try (PreparedStatement pstmt = getConnection().prepareStatement(query)) {
            pstmt.setInt(1, change);
            pstmt.setInt(2, bookId);
            
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.err.println("Error updating quantity: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}
