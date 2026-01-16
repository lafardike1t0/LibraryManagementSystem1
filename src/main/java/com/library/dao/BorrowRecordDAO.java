package com.library.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import com.library.model.BorrowRecord;
import com.library.model.BorrowRecordDetails;
import com.library.util.DBConnection;

// Data Access Object for Borrow Record operations
public class BorrowRecordDAO {
    
    // Get database connection from singleton
    private Connection getConnection() {
        return DBConnection.getInstance().getConnection();
    }
    
    // Create borrow record when member borrows a book
    public boolean createBorrowRecord(int userId, int bookId) {
        String query = "INSERT INTO borrow_records (user_id, book_id, borrow_date, due_date, status) " +
                      "VALUES (?, ?, ?, ?, ?)";
        
        try (PreparedStatement pstmt = getConnection().prepareStatement(query)) {
            LocalDate borrowDate = LocalDate.now();
            LocalDate dueDate = borrowDate.plusDays(7);  // 7 days borrowing period
            
            pstmt.setInt(1, userId);
            pstmt.setInt(2, bookId);
            pstmt.setString(3, borrowDate.toString());
            pstmt.setString(4, dueDate.toString());
            pstmt.setString(5, "BORROWED");
            
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.err.println("Error creating borrow record: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    // Get all borrow records for a specific user
    public List<BorrowRecord> getBorrowRecordsByUserId(int userId) {
        List<BorrowRecord> records = new ArrayList<>();
        String query = "SELECT * FROM borrow_records WHERE user_id = ? ORDER BY borrow_date DESC";
        
        try (PreparedStatement pstmt = getConnection().prepareStatement(query)) {
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                BorrowRecord record = new BorrowRecord();
                record.setRecordId(rs.getInt("record_id"));
                record.setUserId(rs.getInt("user_id"));
                record.setBookId(rs.getInt("book_id"));
                record.setBorrowDate(LocalDate.parse(rs.getString("borrow_date")));
                record.setDueDate(LocalDate.parse(rs.getString("due_date")));
                
                String returnDateStr = rs.getString("return_date");
                if (returnDateStr != null) {
                    record.setReturnDate(LocalDate.parse(returnDateStr));
                }
                
                record.setStatus(rs.getString("status"));
                records.add(record);
            }
        } catch (SQLException e) {
            System.err.println("Error getting borrow records: " + e.getMessage());
            e.printStackTrace();
        }
        
        return records;
    }
    
    // Get all active borrowed books for a user
    public List<BorrowRecord> getActiveBorrowedBooks(int userId) {
        List<BorrowRecord> records = new ArrayList<>();
        String query = "SELECT * FROM borrow_records WHERE user_id = ? AND status = 'BORROWED'";
        
        try (PreparedStatement pstmt = getConnection().prepareStatement(query)) {
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                BorrowRecord record = new BorrowRecord();
                record.setRecordId(rs.getInt("record_id"));
                record.setUserId(rs.getInt("user_id"));
                record.setBookId(rs.getInt("book_id"));
                record.setBorrowDate(LocalDate.parse(rs.getString("borrow_date")));
                record.setDueDate(LocalDate.parse(rs.getString("due_date")));
                record.setStatus(rs.getString("status"));
                records.add(record);
            }
        } catch (SQLException e) {
            System.err.println("Error getting active borrowed books: " + e.getMessage());
            e.printStackTrace();
        }
        
        return records;
    }
    
    // Return book
    public boolean returnBook(int recordId) {
        String query = "UPDATE borrow_records SET return_date = ?, status = 'RETURNED' WHERE record_id = ?";
        
        try (PreparedStatement pstmt = getConnection().prepareStatement(query)) {
            pstmt.setString(1, LocalDate.now().toString());
            pstmt.setInt(2, recordId);
            
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.err.println("Error returning book: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    // Get borrow record by ID
    public BorrowRecord getBorrowRecordById(int recordId) {
        String query = "SELECT * FROM borrow_records WHERE record_id = ?";
        
        try (PreparedStatement pstmt = getConnection().prepareStatement(query)) {
            pstmt.setInt(1, recordId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                BorrowRecord record = new BorrowRecord();
                record.setRecordId(rs.getInt("record_id"));
                record.setUserId(rs.getInt("user_id"));
                record.setBookId(rs.getInt("book_id"));
                record.setBorrowDate(LocalDate.parse(rs.getString("borrow_date")));
                record.setDueDate(LocalDate.parse(rs.getString("due_date")));
                
                String returnDateStr = rs.getString("return_date");
                if (returnDateStr != null) {
                    record.setReturnDate(LocalDate.parse(returnDateStr));
                }
                
                record.setStatus(rs.getString("status"));
                return record;
            }
        } catch (SQLException e) {
            System.err.println("Error getting borrow record by ID: " + e.getMessage());
            e.printStackTrace();
        }
        
        return null;
    }
    
    // Get all borrow records (Admin view)
    public List<BorrowRecord> getAllBorrowRecords() {
        List<BorrowRecord> records = new ArrayList<>();
        String query = "SELECT * FROM borrow_records ORDER BY borrow_date DESC";
        
        try (Statement stmt = getConnection().createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            
            while (rs.next()) {
                BorrowRecord record = new BorrowRecord();
                record.setRecordId(rs.getInt("record_id"));
                record.setUserId(rs.getInt("user_id"));
                record.setBookId(rs.getInt("book_id"));
                record.setBorrowDate(LocalDate.parse(rs.getString("borrow_date")));
                record.setDueDate(LocalDate.parse(rs.getString("due_date")));
                
                String returnDateStr = rs.getString("return_date");
                if (returnDateStr != null) {
                    record.setReturnDate(LocalDate.parse(returnDateStr));
                }
                
                record.setStatus(rs.getString("status"));
                records.add(record);
            }
        } catch (SQLException e) {
            System.err.println("Error getting all borrow records: " + e.getMessage());
            e.printStackTrace();
        }
        
        return records;
    }
    
    // Count active borrowed books for a user
    public int countActiveBorrowedBooks(int userId) {
        String query = "SELECT COUNT(*) FROM borrow_records WHERE user_id = ? AND status = 'BORROWED'";
        
        try (PreparedStatement pstmt = getConnection().prepareStatement(query)) {
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("Error counting borrowed books: " + e.getMessage());
            e.printStackTrace();
        }
        
        return 0;
    }
    
    // Clear borrow history for a user (only returned books, not currently borrowed)
    public boolean clearBorrowHistory(int userId) {
        String query = "DELETE FROM borrow_records WHERE user_id = ? AND status = 'RETURNED'";
        
        try (PreparedStatement pstmt = getConnection().prepareStatement(query)) {
            pstmt.setInt(1, userId);
            
            int rowsAffected = pstmt.executeUpdate();
            System.out.println("Cleared " + rowsAffected + " history records for user ID: " + userId);
            return true;
            
        } catch (SQLException e) {
            System.err.println("Error clearing borrow history: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    // Get all currently borrowed books with details (Admin Report)
    public List<BorrowRecordDetails> getAllBorrowedBooks() {
        List<BorrowRecordDetails> records = new ArrayList<>();
        String query = "SELECT br.record_id, br.user_id, br.book_id, br.borrow_date, br.due_date, " +
                      "br.return_date, br.status, u.full_name, u.email, " +
                      "CASE WHEN m.membership_id IS NOT NULL THEN m.membership_id ELSE '' END as membership_id, " +
                      "b.title, b.author, b.isbn " +
                      "FROM borrow_records br " +
                      "JOIN users u ON br.user_id = u.user_id " +
                      "LEFT JOIN users m ON br.user_id = m.user_id AND m.user_type = 'MEMBER' " +
                      "JOIN books b ON br.book_id = b.book_id " +
                      "WHERE br.status = 'BORROWED' " +
                      "ORDER BY br.borrow_date DESC";
        
        try (PreparedStatement pstmt = getConnection().prepareStatement(query);
             ResultSet rs = pstmt.executeQuery()) {
            
            while (rs.next()) {
                BorrowRecordDetails record = new BorrowRecordDetails();
                record.setRecordId(rs.getInt("record_id"));
                record.setUserId(rs.getInt("user_id"));
                record.setBookId(rs.getInt("book_id"));
                record.setBorrowDate(LocalDate.parse(rs.getString("borrow_date")));
                record.setDueDate(LocalDate.parse(rs.getString("due_date")));
                
                String returnDateStr = rs.getString("return_date");
                if (returnDateStr != null) {
                    record.setReturnDate(LocalDate.parse(returnDateStr));
                }
                
                record.setStatus(rs.getString("status"));
                record.setBorrowerName(rs.getString("full_name"));
                record.setBorrowerEmail(rs.getString("email"));
                record.setMembershipId(rs.getString("membership_id"));
                record.setBookTitle(rs.getString("title"));
                record.setBookAuthor(rs.getString("author"));
                record.setBookIsbn(rs.getString("isbn"));
                
                records.add(record);
            }
        } catch (SQLException e) {
            System.err.println("Error getting all borrowed books: " + e.getMessage());
            e.printStackTrace();
        }
        
        return records;
    }
}
