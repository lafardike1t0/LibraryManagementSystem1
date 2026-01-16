package com.library.servlet;

import java.io.IOException;
import java.util.List;

import com.library.dao.UserDAO;
import com.library.model.Admin;
import com.library.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet({"/adminManagement", "/admin/adminManagement", "/admin/management"})
public class AdminManagementServlet extends HttpServlet {
    
    private UserDAO userDAO;
    
    @Override
    public void init() {
        userDAO = new UserDAO();
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
        if (!"ADMIN".equals(user.getUserType())) {
            response.sendRedirect("login");
            return;
        }
        
        // Get all admins
        List<Admin> admins = userDAO.getAllAdmins();
        request.setAttribute("admins", admins);
        request.getRequestDispatcher("/jsp/adminManagement.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }
        
        String action = request.getParameter("action");
        
        if ("add".equals(action)) {
            // Add new admin
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String fullName = request.getParameter("fullName");
            String email = request.getParameter("email");
            String department = request.getParameter("department");
            
            if (userDAO.usernameExists(username)) {
                request.setAttribute("error", "Username already exists!");
            } else {
                Admin newAdmin = new Admin();
                newAdmin.setUsername(username);
                newAdmin.setPassword(password);
                newAdmin.setFullName(fullName);
                newAdmin.setEmail(email);
                newAdmin.setDepartment(department);
                
                if (userDAO.createUser(newAdmin)) {
                    request.setAttribute("success", "Admin added successfully!");
                } else {
                    request.setAttribute("error", "Failed to add admin!");
                }
            }
        } else if ("delete".equals(action)) {
            // Delete admin
            int userId = Integer.parseInt(request.getParameter("userId"));
            
            // Prevent deleting yourself
            User currentUser = (User) session.getAttribute("user");
            if (currentUser.getUserId() == userId) {
                request.setAttribute("error", "You cannot delete your own account!");
            } else {
                if (userDAO.deleteUser(userId)) {
                    request.setAttribute("success", "Admin removed successfully!");
                } else {
                    request.setAttribute("error", "Failed to remove admin!");
                }
            }
        }
        
        // Redirect back to admin management page
        response.sendRedirect("adminManagement");
    }
}
