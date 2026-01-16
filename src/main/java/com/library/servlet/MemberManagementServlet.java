package com.library.servlet;

import java.io.IOException;
import java.util.List;

import com.library.dao.BorrowRecordDAO;
import com.library.dao.UserDAO;
import com.library.model.Member;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet({"/memberManagement", "/admin/members"})
public class MemberManagementServlet extends HttpServlet {
    
    private UserDAO userDAO;
    private BorrowRecordDAO borrowRecordDAO;
    
    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
        borrowRecordDAO = new BorrowRecordDAO();
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
        
        String action = request.getParameter("action");
        
        // Handle delete action
        if ("delete".equals(action)) {
            handleDelete(request, response, session);
            return;
        }
        
        // Get all members
        List<Member> members = userDAO.getAllMembers();
        
        // Get borrow count for each member
        for (Member member : members) {
            int borrowCount = borrowRecordDAO.countActiveBorrowedBooks(member.getUserId());
            // Store in a map or add to member object if needed
            request.setAttribute("borrowCount_" + member.getUserId(), borrowCount);
        }
        
        request.setAttribute("members", members);
        
        // Forward to member management page
        request.getRequestDispatcher("/jsp/memberManagement.jsp").forward(request, response);
    }
    
    private void handleDelete(HttpServletRequest request, HttpServletResponse response, HttpSession session) 
            throws ServletException, IOException {
        
        String idParam = request.getParameter("id");
        
        if (idParam == null || idParam.isEmpty()) {
            session.setAttribute("toastMessage", "Invalid member ID");
            session.setAttribute("toastType", "error");
            response.sendRedirect("/admin/members");
            return;
        }
        
        try {
            int userId = Integer.parseInt(idParam);
            
            // Check if member has active borrowed books
            int borrowCount = borrowRecordDAO.countActiveBorrowedBooks(userId);
            if (borrowCount > 0) {
                session.setAttribute("toastMessage", "Cannot delete member with active borrowed books. Member has " + borrowCount + " book(s) borrowed.");
                session.setAttribute("toastType", "error");
                response.sendRedirect("/admin/members");
                return;
            }
            
            // Delete the member
            boolean deleted = userDAO.deleteMember(userId);
            
            if (deleted) {
                session.setAttribute("toastMessage", "Member deleted successfully");
                session.setAttribute("toastType", "success");
            } else {
                session.setAttribute("toastMessage", "Failed to delete member");
                session.setAttribute("toastType", "error");
            }
            
        } catch (NumberFormatException e) {
            session.setAttribute("toastMessage", "Invalid member ID format");
            session.setAttribute("toastType", "error");
        } catch (Exception e) {
            session.setAttribute("toastMessage", "Error deleting member: " + e.getMessage());
            session.setAttribute("toastType", "error");
        }
        
        response.sendRedirect("/admin/members");
    }
}
