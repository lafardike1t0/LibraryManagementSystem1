package com.library.servlet;

import java.io.IOException;
import java.util.List;

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

// Member dashboard servlet
@WebServlet({"/memberDashboard", "/member/dashboard", "/member/memberDashboard"})
public class MemberDashboardServlet extends HttpServlet {
    
    private BookDAO bookDAO;
    private BorrowRecordDAO borrowRecordDAO;
    
    @Override
    public void init() throws ServletException {
        bookDAO = new BookDAO();
        borrowRecordDAO = new BorrowRecordDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        if (!"MEMBER".equals(user.getUserType())) {
            response.sendRedirect("login");
            return;
        }
        
        // Get search parameter if exists
        String searchKeyword = request.getParameter("search");
        List<Book> books;
        
        if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
            books = bookDAO.searchBooks(searchKeyword);
            request.setAttribute("searchKeyword", searchKeyword);
        } else {
            books = bookDAO.getAllBooks();
        }
        
        // Get borrowed books count and list
        int userId = user.getUserId();
        int borrowedCount = borrowRecordDAO.countActiveBorrowedBooks(userId);
        List<BorrowRecord> borrowedBooks = borrowRecordDAO.getActiveBorrowedBooks(userId);
        
        // Fetch book details for borrowed records
        for (BorrowRecord record : borrowedBooks) {
            Book book = bookDAO.getBookById(record.getBookId());
            if (book != null) {
                record.setBookTitle(book.getTitle());
            }
        }
        
        request.setAttribute("books", books);
        request.setAttribute("borrowedCount", borrowedCount);
        request.setAttribute("borrowedBooks", borrowedBooks);
        
        // Forward to member dashboard
        request.getRequestDispatcher("/jsp/memberDashboard.jsp").forward(request, response);
    }
}
