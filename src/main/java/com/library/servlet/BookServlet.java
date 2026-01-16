package com.library.servlet;

import java.io.IOException;

import com.library.dao.BookDAO;
import com.library.model.Book;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

// Book management servlet for CRUD operations
@WebServlet({"/admin/books", "/books", "/admin/manageBooks"})
public class BookServlet extends HttpServlet {
    
    private BookDAO bookDAO;
    
    @Override
    public void init() throws ServletException {
        bookDAO = new BookDAO();
    }
    
    // Get book for editing or display all books
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check admin authentication
        HttpSession session = request.getSession(false);
        if (session == null || !"ADMIN".equals(session.getAttribute("userType"))) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String action = request.getParameter("action");
        
        if ("edit".equals(action)) {
            int bookId = Integer.parseInt(request.getParameter("id"));
            Book book = bookDAO.getBookById(bookId);
            request.setAttribute("book", book);
            request.getRequestDispatcher("/jsp/manageBooks.jsp").forward(request, response);
        } else if ("delete".equals(action)) {
            int bookId = Integer.parseInt(request.getParameter("id"));
            
            // Check if book is currently borrowed
            if (bookDAO.isBookCurrentlyBorrowed(bookId)) {
                int borrowCount = bookDAO.getActiveBorrowCount(bookId);
                session.setAttribute("toastMessage", "Cannot delete book! This book is currently borrowed by " + borrowCount + " member(s). Please wait until all copies are returned.");
                session.setAttribute("toastType", "error");
            } else {
                // Book is not borrowed, safe to delete
                boolean deleted = bookDAO.deleteBook(bookId);
                
                if (deleted) {
                    session.setAttribute("toastMessage", "Book deleted successfully from the system");
                    session.setAttribute("toastType", "success");
                } else {
                    session.setAttribute("toastMessage", "Failed to delete book");
                    session.setAttribute("toastType", "error");
                }
            }
            
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
        } else {
            request.getRequestDispatcher("/jsp/manageBooks.jsp").forward(request, response);
        }
    }
    
    // Handle create and update operations
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check admin authentication
        HttpSession session = request.getSession(false);
        if (session == null || !"ADMIN".equals(session.getAttribute("userType"))) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String action = request.getParameter("action");
        
        // Extract book details from form
        String isbn = request.getParameter("isbn");
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String category = request.getParameter("category");
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        int availableQuantity = Integer.parseInt(request.getParameter("availableQuantity"));
        String publisher = request.getParameter("publisher");
        int yearPublished = Integer.parseInt(request.getParameter("yearPublished"));
        String coverImage = request.getParameter("coverImage");
        
        if ("create".equals(action)) {
            // Create new book
            Book book = new Book();
            book.setIsbn(isbn);
            book.setTitle(title);
            book.setAuthor(author);
            book.setCategory(category);
            book.setQuantity(quantity);
            book.setAvailableQuantity(availableQuantity);
            book.setPublisher(publisher);
            book.setYearPublished(yearPublished);
            book.setCoverImage(coverImage);
            
            boolean success = bookDAO.createBook(book);
            if (success) {
                session.setAttribute("toastMessage", "Book added successfully");
                session.setAttribute("toastType", "success");
            } else {
                session.setAttribute("toastMessage", "Failed to add book");
                session.setAttribute("toastType", "error");
            }
            
        } else if ("update".equals(action)) {
            // Update existing book
            int bookId = Integer.parseInt(request.getParameter("bookId"));
            Book book = new Book();
            book.setBookId(bookId);
            book.setIsbn(isbn);
            book.setTitle(title);
            book.setAuthor(author);
            book.setCategory(category);
            book.setQuantity(quantity);
            book.setAvailableQuantity(availableQuantity);
            book.setPublisher(publisher);
            book.setYearPublished(yearPublished);
            book.setCoverImage(coverImage);
            
            boolean success = bookDAO.updateBook(book);
            if (success) {
                session.setAttribute("toastMessage", "Book updated successfully");
                session.setAttribute("toastType", "success");
            } else {
                session.setAttribute("toastMessage", "Failed to update book");
                session.setAttribute("toastType", "error");
            }
        }
        
        // Redirect to dashboard
        response.sendRedirect(request.getContextPath() + "/admin/dashboard");
    }
}
