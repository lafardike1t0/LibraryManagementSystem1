package com.library.servlet;

import java.io.IOException;

import com.library.dao.UserDAO;
import com.library.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

// Login servlet controller
@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    
    private UserDAO userDAO;
    
    @Override
    public void init() throws ServletException {
        // Initialize DAO
        userDAO = new UserDAO();
    }
    
    // Display login page
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("/jsp/login.jsp").forward(request, response);
    }
    
    // Handle login form submission
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        // Validate input
        if (username == null || username.trim().isEmpty() || 
            password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Please enter both username/email and password");
            request.getRequestDispatcher("/jsp/login.jsp").forward(request, response);
            return;
        }
        
        // Trim inputs
        username = username.trim();
        password = password.trim();
        
        // Authenticate user (support both username and email)
        User user = userDAO.authenticateUser(username, password);
        
        if (user != null) {
            // Create session for logged in user
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("userId", user.getUserId());
            session.setAttribute("userType", user.getUserType());
            session.setAttribute("username", user.getUsername());
            
            // Redirect based on user type
            if ("ADMIN".equals(user.getUserType())) {
                response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            } else {
                response.sendRedirect(request.getContextPath() + "/member/dashboard");
            }
        } else {
            // Authentication failed
            request.setAttribute("error", "Invalid username or password");
            request.getRequestDispatcher("/jsp/login.jsp").forward(request, response);
        }
    }
}
