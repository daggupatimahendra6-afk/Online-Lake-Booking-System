package com.lake.camping;

import com.lake.util.DBConnection;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

// URL mapped in web.xml
public class AddAdmin extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher rd = request.getRequestDispatcher("AddAdmin.jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Extra layer of security: Ensure only admins can post to this endpoint
        HttpSession session = request.getSession(false);
        String role = (session != null) ? (String) session.getAttribute("role") : null;
        if (!"admin".equals(role)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String fullName = request.getParameter("fullname").trim();
        String username = request.getParameter("username").trim();
        String email    = request.getParameter("email").trim();
        String phone    = request.getParameter("phone").trim();
        String password = request.getParameter("password");
        String confirm  = request.getParameter("confirm_password");

        if (!password.equals(confirm)) {
            request.setAttribute("error", "Passwords do not match.");
            doGet(request, response);
            return;
        }

        try (Connection con = DBConnection.getConnection()) {

            // Check duplicate username
            try (PreparedStatement chk = con.prepareStatement(
                    "SELECT user_id FROM users WHERE username = ?")) {
                chk.setString(1, username);
                if (chk.executeQuery().next()) {
                    request.setAttribute("error", "Username already taken.");
                    doGet(request, response);
                    return;
                }
            }

            // Check duplicate email
            try (PreparedStatement chk2 = con.prepareStatement(
                    "SELECT user_id FROM users WHERE email = ?")) {
                chk2.setString(1, email);
                if (chk2.executeQuery().next()) {
                    request.setAttribute("error", "Email already registered.");
                    doGet(request, response);
                    return;
                }
            }

            // Insert new admin
            try (PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO users (username, password, email, full_name, phone, role) " +
                    "VALUES (?, crypt(?, gen_salt('bf')), ?, ?, ?, 'admin')")) {
                ps.setString(1, username);
                ps.setString(2, password);
                ps.setString(3, email);
                ps.setString(4, fullName);
                ps.setString(5, phone);
                ps.executeUpdate();
            }

            request.setAttribute("msg", "Admin '" + username + "' successfully created!");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error occurred while adding admin.");
        }

        doGet(request, response);
    }
}
