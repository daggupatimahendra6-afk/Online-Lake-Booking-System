package com.lake.camping;

import com.lake.util.DBConnection;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.*;

// URL mapped in web.xml u2014 @WebServlet removed to avoid duplicate mapping
public class Contact extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name  = request.getParameter("uname");
        String email = request.getParameter("email");
        String msg   = request.getParameter("msg");

        String result;

        if (name == null || email == null || msg == null ||
            name.isBlank() || email.isBlank() || msg.isBlank()) {
            result = "Please fill in all fields.";
        } else {
            try (Connection con = DBConnection.getConnection();
                 PreparedStatement ps = con.prepareStatement(
                     "INSERT INTO contact (name, email, message) VALUES (?, ?, ?)")) {

                ps.setString(1, name.trim());
                ps.setString(2, email.trim());
                ps.setString(3, msg.trim());
                ps.executeUpdate();

                result = "Thank you, " + name.trim() +
                         "! Your message has been sent. We will contact you soon.";

            } catch (Exception e) {
                e.printStackTrace();
                result = "Failed to send message. Please try again.";
            }
        }

        request.setAttribute("msg", result);
        RequestDispatcher rd = request.getRequestDispatcher("Contact.jsp");
        rd.forward(request, response);
    }
}
