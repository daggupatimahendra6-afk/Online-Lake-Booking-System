package com.lake.camping;

import com.lake.util.DBConnection;
import com.lake.entities.Contact;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/DisplayContact")
public class DisplayContact extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Contact> contacts = new ArrayList<>();

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(
                 "SELECT name, email, message FROM contact ORDER BY submitted_at DESC");
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                contacts.add(new Contact(
                    rs.getString("name"),
                    rs.getString("email"),
                    rs.getString("message")
                ));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("Contact", contacts);
        RequestDispatcher rd = request.getRequestDispatcher("DisplayContact.jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
