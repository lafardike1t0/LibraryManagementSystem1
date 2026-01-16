package com.library.servlet;

import com.library.dao.UserDAO;
import com.library.model.Member;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Forward to the registration JSP page
        request.getRequestDispatcher("/jsp/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // Validate passwords match
        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match!");
            request.setAttribute("fullName", fullName);
            request.setAttribute("email", email);
            request.setAttribute("username", username);
            request.getRequestDispatcher("/jsp/register.jsp").forward(request, response);
            return;
        }

        // Create new member
        Member member = new Member();
        member.setFullName(fullName);
        member.setEmail(email);
        member.setUsername(username);
        member.setPassword(password);

        try {
            // Check if username already exists
            if (userDAO.usernameExists(username)) {
                request.setAttribute("error", "Username already exists!");
                request.setAttribute("fullName", fullName);
                request.setAttribute("email", email);
                request.setAttribute("username", username);
                request.getRequestDispatcher("/jsp/register.jsp").forward(request, response);
                return;
            }

            // Register the user using the method signature that exists in UserDAO
            boolean success = userDAO.registerMember(username, password, fullName, email);

            if (success) {
                request.setAttribute("success", "Registration successful! Please login.");
                response.sendRedirect(request.getContextPath() + "/login");
            } else {
                request.setAttribute("error", "Registration failed. Please try again.");
                request.setAttribute("fullName", fullName);
                request.setAttribute("email", email);
                request.setAttribute("username", username);
                request.getRequestDispatcher("/jsp/register.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.setAttribute("fullName", fullName);
            request.setAttribute("email", email);
            request.setAttribute("username", username);
            request.getRequestDispatcher("/jsp/register.jsp").forward(request, response);
        }
    }
}
