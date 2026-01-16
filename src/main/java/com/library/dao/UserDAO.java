package com.library.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.library.model.Admin;
import com.library.model.Member;
import com.library.model.User;
import com.library.util.DBConnection;

// Data Access Object for User operations
public class UserDAO {
    
    // Get database connection from singleton
    private Connection getConnection() {
        return DBConnection.getInstance().getConnection();
    }
    
    // Authenticate user login (supports both username and email)
    public User authenticateUser(String usernameOrEmail, String password) {
        String query = "SELECT * FROM users WHERE (username = ? OR email = ?) AND password = ?";
        
        try (PreparedStatement pstmt = getConnection().prepareStatement(query)) {
            pstmt.setString(1, usernameOrEmail);
            pstmt.setString(2, usernameOrEmail);
            pstmt.setString(3, password);
            
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                // Create appropriate user object based on type
                String userType = rs.getString("user_type");
                
                if ("ADMIN".equals(userType)) {
                    Admin admin = new Admin();
                    admin.setUserId(rs.getInt("user_id"));
                    admin.setUsername(rs.getString("username"));
                    admin.setPassword(rs.getString("password"));
                    admin.setFullName(rs.getString("full_name"));
                    admin.setEmail(rs.getString("email"));
                    admin.setDepartment(rs.getString("department"));
                    return admin;
                } else {
                    Member member = new Member();
                    member.setUserId(rs.getInt("user_id"));
                    member.setUsername(rs.getString("username"));
                    member.setPassword(rs.getString("password"));
                    member.setFullName(rs.getString("full_name"));
                    member.setEmail(rs.getString("email"));
                    member.setMembershipId(rs.getString("membership_id"));
                    return member;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error authenticating user: " + e.getMessage());
            e.printStackTrace();
        }
        
        return null;
    }
    
    // Get user by ID
    public User getUserById(int userId) {
        String query = "SELECT * FROM users WHERE user_id = ?";
        
        try (PreparedStatement pstmt = getConnection().prepareStatement(query)) {
            pstmt.setInt(1, userId);
            
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                String userType = rs.getString("user_type");
                
                if ("ADMIN".equals(userType)) {
                    Admin admin = new Admin();
                    admin.setUserId(rs.getInt("user_id"));
                    admin.setUsername(rs.getString("username"));
                    admin.setFullName(rs.getString("full_name"));
                    admin.setEmail(rs.getString("email"));
                    admin.setDepartment(rs.getString("department"));
                    return admin;
                } else {
                    Member member = new Member();
                    member.setUserId(rs.getInt("user_id"));
                    member.setUsername(rs.getString("username"));
                    member.setFullName(rs.getString("full_name"));
                    member.setEmail(rs.getString("email"));
                    member.setMembershipId(rs.getString("membership_id"));
                    return member;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error getting user: " + e.getMessage());
            e.printStackTrace();
        }
        
        return null;
    }
    
    // Create new user
    public boolean createUser(User user) {
        String query = "INSERT INTO users (username, password, full_name, email, user_type, membership_id, department) " +
                      "VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        try (PreparedStatement pstmt = getConnection().prepareStatement(query)) {
            pstmt.setString(1, user.getUsername());
            pstmt.setString(2, user.getPassword());
            pstmt.setString(3, user.getFullName());
            pstmt.setString(4, user.getEmail());
            pstmt.setString(5, user.getUserType());
            
            if (user instanceof Member) {
                pstmt.setString(6, ((Member) user).getMembershipId());
                pstmt.setString(7, null);
            } else if (user instanceof Admin) {
                pstmt.setString(6, null);
                pstmt.setString(7, ((Admin) user).getDepartment());
            }
            
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.err.println("Error creating user: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    // Update user information
    public boolean updateUser(User user) {
        String query = "UPDATE users SET full_name = ?, email = ? WHERE user_id = ?";
        
        try (PreparedStatement pstmt = getConnection().prepareStatement(query)) {
            pstmt.setString(1, user.getFullName());
            pstmt.setString(2, user.getEmail());
            pstmt.setInt(3, user.getUserId());
            
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.err.println("Error updating user: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    // Check if username exists
    public boolean usernameExists(String username) {
        String query = "SELECT COUNT(*) FROM users WHERE username = ?";
        
        try (PreparedStatement pstmt = getConnection().prepareStatement(query)) {
            pstmt.setString(1, username);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            System.err.println("Error checking username: " + e.getMessage());
            e.printStackTrace();
        }
        
        return false;
    }
    
    // Register new member
    public boolean registerMember(String username, String password, String fullName, String email) {
        // Check if username already exists
        if (usernameExists(username)) {
            return false;
        }
        
        // Generate membership ID
        String membershipId = "MEM" + System.currentTimeMillis();
        
        // Create new member
        Member member = new Member();
        member.setUsername(username);
        member.setPassword(password);
        member.setFullName(fullName);
        member.setEmail(email);
        member.setMembershipId(membershipId);
        
        return createUser(member);
    }
    
    // Get all admins
    public java.util.List<Admin> getAllAdmins() {
        java.util.List<Admin> admins = new java.util.ArrayList<>();
        String query = "SELECT * FROM users WHERE user_type = 'ADMIN'";
        
        try (PreparedStatement pstmt = getConnection().prepareStatement(query)) {
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Admin admin = new Admin();
                admin.setUserId(rs.getInt("user_id"));
                admin.setUsername(rs.getString("username"));
                admin.setFullName(rs.getString("full_name"));
                admin.setEmail(rs.getString("email"));
                admin.setDepartment(rs.getString("department"));
                admins.add(admin);
            }
        } catch (SQLException e) {
            System.err.println("Error getting admins: " + e.getMessage());
            e.printStackTrace();
        }
        
        return admins;
    }
    
    // Delete user by ID
    public boolean deleteUser(int userId) {
        String query = "DELETE FROM users WHERE user_id = ?";
        
        try (PreparedStatement pstmt = getConnection().prepareStatement(query)) {
            pstmt.setInt(1, userId);
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Error deleting user: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    // Delete member by ID (alias for deleteUser)
    public boolean deleteMember(int userId) {
        return deleteUser(userId);
    }
    
    // Update member profile
    public boolean updateMemberProfile(int userId, String fullName, String email, String password) {
        String query;
        if (password != null && !password.trim().isEmpty()) {
            query = "UPDATE users SET full_name = ?, email = ?, password = ? WHERE user_id = ?";
        } else {
            query = "UPDATE users SET full_name = ?, email = ? WHERE user_id = ?";
        }
        
        try (PreparedStatement pstmt = getConnection().prepareStatement(query)) {
            pstmt.setString(1, fullName);
            pstmt.setString(2, email);
            
            if (password != null && !password.trim().isEmpty()) {
                pstmt.setString(3, password);
                pstmt.setInt(4, userId);
            } else {
                pstmt.setInt(3, userId);
            }
            
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Error updating profile: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    // Get active members count
    public int getActiveMembersCount() {
        String query = "SELECT COUNT(*) FROM users WHERE user_type = 'MEMBER'";
        
        try (PreparedStatement pstmt = getConnection().prepareStatement(query);
             ResultSet rs = pstmt.executeQuery()) {
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("Error getting active members count: " + e.getMessage());
            e.printStackTrace();
        }
        
        return 0;
    }
    
    // Get all members
    public java.util.List<Member> getAllMembers() {
        java.util.List<Member> members = new java.util.ArrayList<>();
        String query = "SELECT * FROM users WHERE user_type = 'MEMBER' ORDER BY full_name ASC";
        
        try (PreparedStatement pstmt = getConnection().prepareStatement(query);
             ResultSet rs = pstmt.executeQuery()) {
            
            while (rs.next()) {
                Member member = new Member();
                member.setUserId(rs.getInt("user_id"));
                member.setUsername(rs.getString("username"));
                member.setFullName(rs.getString("full_name"));
                member.setEmail(rs.getString("email"));
                member.setMembershipId(rs.getString("membership_id"));
                members.add(member);
            }
        } catch (SQLException e) {
            System.err.println("Error getting all members: " + e.getMessage());
            e.printStackTrace();
        }
        
        return members;
    }
}
