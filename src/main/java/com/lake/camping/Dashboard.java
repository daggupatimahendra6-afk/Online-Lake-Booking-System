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
import java.util.ArrayList;
import java.util.List;

/**
 * Dashboard servlet — owns all DB queries for the admin dashboard.
 * The JSP (Dashboard.jsp) only renders request attributes; no Java in the view.
 */
// URL mapped in web.xml u2014 @WebServlet removed to avoid duplicate mapping
public class Dashboard extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int totalBookings  = 0;
        int totalUsers     = 0;
        int totalEnquiries = 0;
        int totalRevenue   = 0;
        int confirmed      = 0;
        int cancelled      = 0;
        List<String[]> recent = new ArrayList<>();

        try (Connection con = DBConnection.getConnection()) {

            // Total bookings
            try (PreparedStatement ps = con.prepareStatement("SELECT COUNT(*) FROM bookings");
                 ResultSet rs = ps.executeQuery()) {
                if (rs.next()) totalBookings = rs.getInt(1);
            }

            // Registered users
            try (PreparedStatement ps = con.prepareStatement(
                    "SELECT COUNT(*) FROM users WHERE role='user'");
                 ResultSet rs = ps.executeQuery()) {
                if (rs.next()) totalUsers = rs.getInt(1);
            }

            // Contact enquiries
            try (PreparedStatement ps = con.prepareStatement("SELECT COUNT(*) FROM contact");
                 ResultSet rs = ps.executeQuery()) {
                if (rs.next()) totalEnquiries = rs.getInt(1);
            }

            // Revenue (non-cancelled)
            try (PreparedStatement ps = con.prepareStatement(
                    "SELECT COALESCE(SUM(total_cost),0) FROM bookings WHERE status<>'cancelled'");
                 ResultSet rs = ps.executeQuery()) {
                if (rs.next()) totalRevenue = rs.getInt(1);
            }

            // Confirmed count
            try (PreparedStatement ps = con.prepareStatement(
                    "SELECT COUNT(*) FROM bookings WHERE status='confirmed'");
                 ResultSet rs = ps.executeQuery()) {
                if (rs.next()) confirmed = rs.getInt(1);
            }

            // Cancelled count
            try (PreparedStatement ps = con.prepareStatement(
                    "SELECT COUNT(*) FROM bookings WHERE status='cancelled'");
                 ResultSet rs = ps.executeQuery()) {
                if (rs.next()) cancelled = rs.getInt(1);
            }

            // Recent 5 bookings
            String sql =
                "SELECT b.id, b.name, b.arrival_date, b.departure_date, " +
                "       t.tent_name, b.total_cost, b.status " +
                "FROM   bookings b JOIN tents t ON b.tent_id = t.tent_id " +
                "ORDER  BY b.created_at DESC LIMIT 5";
            try (PreparedStatement ps = con.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    recent.add(new String[]{
                        rs.getString("id"),
                        rs.getString("name"),
                        rs.getString("arrival_date"),
                        rs.getString("departure_date"),
                        rs.getString("tent_name"),
                        String.valueOf(rs.getInt("total_cost")),
                        rs.getString("status")
                    });
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("dbError", "Could not load dashboard data: " + e.getMessage());
        }

        // Store all as request attributes — JSP reads these, no scriptlets needed
        request.setAttribute("totalBookings",  totalBookings);
        request.setAttribute("totalUsers",     totalUsers);
        request.setAttribute("totalEnquiries", totalEnquiries);
        request.setAttribute("totalRevenue",   totalRevenue);
        request.setAttribute("confirmed",      confirmed);
        request.setAttribute("cancelled",      cancelled);
        request.setAttribute("recent",         recent);
        request.setAttribute("today",          new java.util.Date().toString().substring(0, 10));

        RequestDispatcher rd = request.getRequestDispatcher("Dashboard.jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
