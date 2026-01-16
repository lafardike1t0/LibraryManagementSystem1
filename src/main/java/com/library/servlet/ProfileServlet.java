package com.library.servlet;

import java.io.IOException;
import java.util.List;

import com.library.dao.BookDAO;
import com.library.dao.BorrowRecordDAO;
import com.library.dao.UserDAO;
import com.library.model.Book;
import com.library.model.BorrowRecord;
import com.library.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet({"/profile", "/member/profile"})
public class ProfileServlet extends HttpServlet {
    
    private UserDAO userDAO;
    private BorrowRecordDAO borrowRecordDAO;
    private BookDAO bookDAO;
    
    @Override
    public void init() {
        userDAO = new UserDAO();
        borrowRecordDAO = new BorrowRecordDAO();
        bookDAO = new BookDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        boolean isAdmin = "ADMIN".equals(user.getUserType());
        
        // For members, get borrowed books and history
        if (!isAdmin) {
            int userId = user.getUserId();
            List<BorrowRecord> borrowedBooks = borrowRecordDAO.getActiveBorrowedBooks(userId);
            List<BorrowRecord> borrowHistory = borrowRecordDAO.getBorrowRecordsByUserId(userId);
            
            // Fetch book details for each borrowed record
            for (BorrowRecord record : borrowedBooks) {
                Book book = bookDAO.getBookById(record.getBookId());
                if (book != null) {
                    record.setBookTitle(book.getTitle());
                }
            }
            
            // Fetch book details for history
            for (BorrowRecord record : borrowHistory) {
                Book book = bookDAO.getBookById(record.getBookId());
                if (book != null) {
                    record.setBookTitle(book.getTitle());
                }
            }
            
            request.setAttribute("borrowedBooks", borrowedBooks);
            request.setAttribute("borrowHistory", borrowHistory);
        }
        
        // Forward to profile page (works for both admin and member)
        request.getRequestDispatcher("/jsp/profile.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        String action = request.getParameter("action");
        
        // Handle clear history action
        if ("clearHistory".equals(action)) {
            int userId = user.getUserId();
            boolean success = borrowRecordDAO.clearBorrowHistory(userId);
            
            if (success) {
                session.setAttribute("toastMessage", "Borrow history cleared successfully!");
                session.setAttribute("toastType", "success");
            } else {
                session.setAttribute("toastMessage", "Failed to clear history. Please try again.");
                session.setAttribute("toastType", "error");
            }
            
            response.sendRedirect(request.getContextPath() + "/profile");
            return;
        }
        
        // Get form parameters for profile update
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        
        // Validate input
        if (fullName == null || fullName.trim().isEmpty() ||
            email == null || email.trim().isEmpty()) {
            session.setAttribute("toastMessage", "Full name and email are required!");
            session.setAttribute("toastType", "error");
            response.sendRedirect(request.getContextPath() + "/profile");
            return;
        }
        
        // Validate email format
        if (!email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
            session.setAttribute("toastMessage", "Please enter a valid email address!");
            session.setAttribute("toastType", "error");
            response.sendRedirect(request.getContextPath() + "/profile");
            return;
        }
        
        // If changing password, validate
        String passwordToUpdate = null;
        if (currentPassword != null && !currentPassword.trim().isEmpty()) {
            // Verify current password
            if (!user.getPassword().equals(currentPassword)) {
                session.setAttribute("toastMessage", "Current password is incorrect!");
                session.setAttribute("toastType", "error");
                response.sendRedirect(request.getContextPath() + "/profile");
                return;
            }
            
            // Validate new password
            if (newPassword == null || newPassword.trim().isEmpty()) {
                session.setAttribute("toastMessage", "Please enter a new password!");
                session.setAttribute("toastType", "error");
                response.sendRedirect(request.getContextPath() + "/profile");
                return;
            }
            
            if (newPassword.length() < 6) {
                session.setAttribute("toastMessage", "Password must be at least 6 characters!");
                session.setAttribute("toastType", "error");
                response.sendRedirect(request.getContextPath() + "/profile");
                return;
            }
            
            if (!newPassword.equals(confirmPassword)) {
                session.setAttribute("toastMessage", "New passwords do not match!");
                session.setAttribute("toastType", "error");
                response.sendRedirect(request.getContextPath() + "/profile");
                return;
            }
            
            passwordToUpdate = newPassword;
        }
        
        // Update profile
        boolean success = userDAO.updateMemberProfile(user.getUserId(), fullName, email, passwordToUpdate);
        
        if (success) {
            // Update session with new details
            user.setFullName(fullName);
            user.setEmail(email);
            if (passwordToUpdate != null) {
                user.setPassword(passwordToUpdate);
            }
            session.setAttribute("user", user);
            
            session.setAttribute("toastMessage", "Profile updated successfully!");
            session.setAttribute("toastType", "success");
            response.sendRedirect(request.getContextPath() + "/profile");
        } else {
            session.setAttribute("toastMessage", "Failed to update profile. Please try again.");
            session.setAttribute("toastType", "error");
            response.sendRedirect(request.getContextPath() + "/profile");
        }
    }
}
