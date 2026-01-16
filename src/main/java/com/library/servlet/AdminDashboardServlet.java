package com.library.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import com.library.dao.BookDAO;
import com.library.dao.BorrowRecordDAO;
import com.library.dao.UserDAO;
import com.library.model.Book;
import com.library.model.BorrowRecord;
import com.library.model.BorrowRecordDetails;
import com.library.model.User;
import com.library.model.Member;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

// Admin dashboard servlet
@WebServlet({"/adminDashboard", "/admin/dashboard", "/admin/adminDashboard"})
public class AdminDashboardServlet extends HttpServlet {
    
    private BookDAO bookDAO;
    private BorrowRecordDAO borrowRecordDAO;
    private UserDAO userDAO;
    
    @Override
    public void init() throws ServletException {
        bookDAO = new BookDAO();
        borrowRecordDAO = new BorrowRecordDAO();
        userDAO = new UserDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check if user is logged in and is admin
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }
        
        // Get all books
        List<Book> allBooks = bookDAO.getAllBooks();
        
        // Calculate total books quantity (sum of all books' quantity)
        int totalBooksQuantity = allBooks.stream()
                .mapToInt(Book::getQuantity)
                .sum();
        
        // Calculate available books (count of all book titles)
        long availableBooksCount = allBooks.size();
        
        // Calculate out of stock books (count of book titles with 0 available quantity)
        long outOfStockBooksCount = allBooks.stream()
                .filter(book -> book.getAvailableQuantity() == 0)
                .count();
        
        // Calculate borrowed books count
        int borrowedBooksCount = totalBooksQuantity - allBooks.stream()
                .mapToInt(Book::getAvailableQuantity)
                .sum();
        
        // Get all borrow records
        List<BorrowRecord> allBorrowRecords = borrowRecordDAO.getAllBorrowRecords();
        
        // Get active borrows (only BORROWED status)
        List<BorrowRecord> activeBorrows = allBorrowRecords.stream()
                .filter(record -> "BORROWED".equals(record.getStatus()))
                .collect(Collectors.toList());
        
        // Get unique active borrowers count
        long activeBorrowersCount = activeBorrows.stream()
                .map(BorrowRecord::getUserId)
                .distinct()
                .count();
        
        // Get count of active members (users with type 'MEMBER')
        int activeMembersCount = userDAO.getActiveMembersCount();
        
        // Create detailed borrow records with user and book information
        List<BorrowRecordDetails> activeBorrowDetails = new ArrayList<>();
        for (BorrowRecord record : activeBorrows) {
            BorrowRecordDetails details = new BorrowRecordDetails();
            details.setRecordId(record.getRecordId());
            details.setUserId(record.getUserId());
            details.setBookId(record.getBookId());
            details.setBorrowDate(record.getBorrowDate());
            details.setDueDate(record.getDueDate());
            details.setReturnDate(record.getReturnDate());
            details.setStatus(record.getStatus());
            
            // Fetch user details
            User borrower = userDAO.getUserById(record.getUserId());
            if (borrower != null) {
                details.setBorrowerName(borrower.getFullName());
                details.setBorrowerEmail(borrower.getEmail());
                if (borrower instanceof Member) {
                    details.setMembershipId(((Member) borrower).getMembershipId());
                }
            }
            
            // Fetch book details
            Book book = bookDAO.getBookById(record.getBookId());
            if (book != null) {
                details.setBookTitle(book.getTitle());
                details.setBookAuthor(book.getAuthor());
                details.setBookIsbn(book.getIsbn());
            }
            
            activeBorrowDetails.add(details);
        }
        
        // Set attributes
        request.setAttribute("totalBooks", totalBooksQuantity);
        request.setAttribute("availableBooks", availableBooksCount);
        request.setAttribute("outOfStockBooks", outOfStockBooksCount);
        request.setAttribute("borrowedBooks", borrowedBooksCount);
        request.setAttribute("activeBorrows", activeBorrowersCount);
        request.setAttribute("activeMembersCount", activeMembersCount);
        request.setAttribute("allBooks", allBooks);
        request.setAttribute("activeBorrowRecords", activeBorrowDetails);
        request.setAttribute("recentBooks", allBooks.size() > 5 ? allBooks.subList(0, 5) : allBooks);
        
        // Forward to dashboard page
        request.getRequestDispatcher("/jsp/adminDashboard.jsp").forward(request, response);
    }
}

