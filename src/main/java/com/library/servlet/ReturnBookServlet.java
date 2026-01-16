package com.library.servlet;

import java.io.IOException;

import com.library.dao.BookDAO;
import com.library.dao.BorrowRecordDAO;
import com.library.model.Book;
import com.library.model.BorrowRecord;
import com.library.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/member/return")
public class ReturnBookServlet extends HttpServlet {
    
    private BorrowRecordDAO borrowRecordDAO;
    private BookDAO bookDAO;
    
    @Override
    public void init() {
        borrowRecordDAO = new BorrowRecordDAO();
        bookDAO = new BookDAO();
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        if (!"MEMBER".equals(user.getUserType())) {
            session.setAttribute("error", "Unauthorized access!");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        try {
            int recordId = Integer.parseInt(request.getParameter("recordId"));
            
            // Get the borrow record
            BorrowRecord record = borrowRecordDAO.getBorrowRecordById(recordId);
            
            if (record == null) {
                session.setAttribute("toastError", "Borrow record not found!");
                response.sendRedirect(request.getContextPath() + "/profile");
                return;
            }
            
            // Verify the record belongs to the logged-in user
            if (record.getUserId() != user.getUserId()) {
                session.setAttribute("toastError", "Unauthorized access to this record!");
                response.sendRedirect(request.getContextPath() + "/profile");
                return;
            }
            
            // Check if already returned
            if (record.getReturnDate() != null) {
                session.setAttribute("toastWarning", "This book has already been returned!");
                response.sendRedirect(request.getContextPath() + "/profile");
                return;
            }
            
            // Return the book
            boolean returned = borrowRecordDAO.returnBook(recordId);
            
            if (returned) {
                // Increase available book count
                bookDAO.updateAvailableQuantity(record.getBookId(), 1);
                
                session.setAttribute("toastSuccess", "✅ Book returned successfully! Thank you.");
            } else {
                session.setAttribute("toastError", "Failed to return the book. Please try again.");
            }
            
        } catch (NumberFormatException e) {
            session.setAttribute("toastError", "Invalid record ID!");
        } catch (Exception e) {
            session.setAttribute("toastError", "An error occurred while returning the book.");
            e.printStackTrace();
        }
        
        response.sendRedirect(request.getContextPath() + "/profile");
    }
}
