package com.library.servlet;

import java.io.IOException;

import com.library.dao.BookDAO;
import com.library.dao.BorrowRecordDAO;
import com.library.model.Book;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

// Borrow book servlet
@WebServlet("/member/borrow")
public class BorrowServlet extends HttpServlet {
    
    private BookDAO bookDAO;
    private BorrowRecordDAO borrowRecordDAO;
    
    @Override
    public void init() throws ServletException {
        bookDAO = new BookDAO();
        borrowRecordDAO = new BorrowRecordDAO();
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check member authentication
        HttpSession session = request.getSession(false);
        if (session == null || !"MEMBER".equals(session.getAttribute("userType"))) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        int userId = (int) session.getAttribute("userId");
        int bookId = Integer.parseInt(request.getParameter("bookId"));
        
        // Check if member has reached borrowing limit
        int currentBorrowedCount = borrowRecordDAO.countActiveBorrowedBooks(userId);
        if (currentBorrowedCount >= 5) {
            session.setAttribute("toastMessage", "You have reached the maximum borrowing limit (5 books)");
            session.setAttribute("toastType", "error");
            response.sendRedirect(request.getContextPath() + "/memberDashboard");
            return;
        }
        
        // Check if book is available
        Book book = bookDAO.getBookById(bookId);
        if (book == null || !book.isAvailable()) {
            session.setAttribute("toastMessage", "This book is currently not available");
            session.setAttribute("toastType", "error");
            response.sendRedirect(request.getContextPath() + "/memberDashboard");
            return;
        }
        
        // Create borrow record and update book quantity
        boolean recordCreated = borrowRecordDAO.createBorrowRecord(userId, bookId);
        boolean quantityUpdated = bookDAO.updateAvailableQuantity(bookId, -1);
        
        if (recordCreated && quantityUpdated) {
            session.setAttribute("toastMessage", "📚 Book borrowed successfully! Please return within 7 days.");
            session.setAttribute("toastType", "success");
        } else {
            session.setAttribute("toastMessage", "Failed to borrow book. Please try again.");
            session.setAttribute("toastType", "error");
        }
        
        response.sendRedirect(request.getContextPath() + "/memberDashboard");
    }
}
