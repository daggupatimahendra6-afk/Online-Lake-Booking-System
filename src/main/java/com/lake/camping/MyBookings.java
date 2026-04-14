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
import java.util.ArrayList;
import java.util.List;

@WebServlet("/MyBookings")
public class MyBookings extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // ── GET: display bookings for the logged-in user ──────────────────────────
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Session guard
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect("login");
            return;
        }

        String username = (String) session.getAttribute("username");
        String fullName = (String) session.getAttribute("fullName");
        if (fullName == null) fullName = username;

        List<String[]> bookings = new ArrayList<>();
        int totalSpent   = 0;
        int totalCount   = 0;
        int pendingCount = 0;

        String sql =
            "SELECT b.id, t.tent_name, b.arrival_date, b.departure_date, " +
            "       b.no_of_persons, b.no_of_kids, b.total_cost, " +
            "       b.payment_method, b.payment_status, b.status, b.created_at " +
            "FROM   bookings b " +
            "JOIN   tents    t ON b.tent_id = t.tent_id " +
            "WHERE  b.username = ? " +
            "ORDER  BY b.created_at DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    int    cost      = rs.getInt("total_cost");
                    String payStatus = rs.getString("payment_status");
                    String createdAt = rs.getString("created_at");
                    String status    = rs.getString("status");

                    if ("PAID".equals(payStatus)) totalSpent += cost;
                    else                          pendingCount++;

                    String dateOnly = (createdAt != null && createdAt.length() >= 10)
                                      ? createdAt.substring(0, 10) : "";

                    bookings.add(new String[]{
                        String.valueOf(rs.getInt("id")),
                        rs.getString("tent_name"),
                        rs.getString("arrival_date"),
                        rs.getString("departure_date"),
                        String.valueOf(rs.getInt("no_of_persons")),
                        String.valueOf(rs.getInt("no_of_kids")),
                        String.valueOf(cost),
                        rs.getString("payment_method"),
                        payStatus,
                        status,
                        dateOnly
                    });
                }
            }
            totalCount = bookings.size();

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("bookings",     bookings);
        request.setAttribute("totalSpent",   totalSpent);
        request.setAttribute("totalCount",   totalCount);
        request.setAttribute("pendingCount", pendingCount);
        request.setAttribute("fullName",     fullName);

        RequestDispatcher rd = request.getRequestDispatcher("MyBookings.jsp");
        rd.forward(request, response);
    }

    // ── POST: cancel a booking that belongs to the logged-in user ─────────────
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect("login");
            return;
        }

        String username  = (String) session.getAttribute("username");
        String bookingId = request.getParameter("bookingId");

        String cancelMsg = "Booking cancellation failed. Please try again.";

        if (bookingId != null && !bookingId.isBlank()) {
            try (Connection con = DBConnection.getConnection()) {

                // Security: verify the booking belongs to this user before cancelling
                boolean isOwner = false;
                try (PreparedStatement chk = con.prepareStatement(
                        "SELECT id FROM bookings WHERE id = ? AND username = ?")) {
                    chk.setInt(1, Integer.parseInt(bookingId.trim()));
                    chk.setString(2, username);
                    isOwner = chk.executeQuery().next();
                }

                if (isOwner) {
                    try (PreparedStatement ps = con.prepareStatement(
                            "UPDATE bookings SET status = 'cancelled' WHERE id = ? AND username = ?")) {
                        ps.setInt(1, Integer.parseInt(bookingId.trim()));
                        ps.setString(2, username);
                        int rows = ps.executeUpdate();
                        if (rows > 0) {
                            cancelMsg = "✅ Booking #" + bookingId + " has been cancelled successfully.";
                        }
                    }
                } else {
                    cancelMsg = "⚠️ You are not authorised to cancel this booking.";
                }

            } catch (Exception e) {
                e.printStackTrace();
                cancelMsg = "Error cancelling booking: " + e.getMessage();
            }
        }

        request.setAttribute("cancelMsg", cancelMsg);
        doGet(request, response);   // refresh booking list
    }
}