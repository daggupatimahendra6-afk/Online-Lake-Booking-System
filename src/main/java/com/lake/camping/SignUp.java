package com.lake.camping;

import com.lake.util.DBConnection;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.*;

@WebServlet("/SignUp")
public class SignUp extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String fullName = request.getParameter("fullname").trim();
        String username = request.getParameter("username").trim();
        String email    = request.getParameter("email").trim();
        String phone    = request.getParameter("phone").trim();
        String password = request.getParameter("password");
        String confirm  = request.getParameter("confirm_password");

        if (!password.equals(confirm)) {
            request.setAttribute("error", "Passwords do not match.");
            request.getRequestDispatcher("SignUp.jsp").forward(request, response);
            return;
        }

        try (Connection con = DBConnection.getConnection()) {

            // Check duplicate username
            try (PreparedStatement chk = con.prepareStatement(
                    "SELECT user_id FROM users WHERE username = ?")) {
                chk.setString(1, username);
                if (chk.executeQuery().next()) {
                    request.setAttribute("error", "Username already taken.");
                    request.getRequestDispatcher("SignUp.jsp").forward(request, response);
                    return;
                }
            }

            // Check duplicate email
            try (PreparedStatement chk2 = con.prepareStatement(
                    "SELECT user_id FROM users WHERE email = ?")) {
                chk2.setString(1, email);
                if (chk2.executeQuery().next()) {
                    request.setAttribute("error", "Email already registered.");
                    request.getRequestDispatcher("SignUp.jsp").forward(request, response);
                    return;
                }
            }

            // Insert with bcrypt hash
            try (PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO users (username, password, email, full_name, phone) " +
                    "VALUES (?, crypt(?, gen_salt('bf')), ?, ?, ?)")) {
                ps.setString(1, username);
                ps.setString(2, password);
                ps.setString(3, email);
                ps.setString(4, fullName);
                ps.setString(5, phone);
                ps.executeUpdate();
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Registration failed. Try again.");
            request.getRequestDispatcher("SignUp.jsp").forward(request, response);
            return;
        }

        // Auto-login after signup
        HttpSession session = request.getSession(true);
        session.setAttribute("username", username);
        session.setAttribute("fullName", fullName);
        session.setAttribute("role",     "user");
        response.sendRedirect("MyBookings.jsp");
    }
}
