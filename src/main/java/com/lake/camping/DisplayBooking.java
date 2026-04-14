package com.lake.camping;

import com.lake.util.DBConnection;
import com.lake.entities.BookingEntities;
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

@WebServlet("/DisplayBooking")
public class DisplayBooking extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<BookingEntities> list = new ArrayList<>();

        String sql =
            "SELECT b.id, b.name, b.email, b.phone, " +
            "       b.no_of_persons, b.no_of_kids, " +
            "       b.arrival_date, b.departure_date, " +
            "       b.total_cost, b.status, t.tent_name, " +
            "       b.payment_method, b.payment_status, " +
            "       COALESCE(b.username, b.name) AS booked_by " +
            "FROM   bookings b " +
            "JOIN   tents    t ON b.tent_id = t.tent_id " +
            "ORDER  BY b.created_at DESC";

        int totalBookings  = 0;
        int totalRevenue   = 0;
        int paidCount      = 0;
        int pendingCount   = 0;
        int confirmedCount = 0;
        int cancelledCount = 0;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                BookingEntities b = new BookingEntities(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("email"),
                    rs.getLong("phone"),
                    rs.getInt("no_of_persons"),
                    rs.getInt("no_of_kids"),
                    rs.getString("arrival_date"),
                    rs.getString("departure_date"),
                    rs.getString("tent_name"),
                    rs.getInt("total_cost"),
                    rs.getString("status")
                );
                b.setPaymentMethod(rs.getString("payment_method"));
                b.setPaymentStatus(rs.getString("payment_status"));
                b.setBookedBy(rs.getString("booked_by"));
                list.add(b);

                totalRevenue += rs.getInt("total_cost");
                if ("PAID".equals(rs.getString("payment_status")))    paidCount++;
                else                                                   pendingCount++;
                if ("confirmed".equals(rs.getString("status")))       confirmedCount++;
                else if ("cancelled".equals(rs.getString("status")))  cancelledCount++;
            }
            totalBookings = list.size();

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("listofstudents", list);
        request.setAttribute("totalBookings",  totalBookings);
        request.setAttribute("totalRevenue",   totalRevenue);
        request.setAttribute("paidCount",      paidCount);
        request.setAttribute("pendingCount",   pendingCount);
        request.setAttribute("confirmedCount", confirmedCount);
        request.setAttribute("cancelledCount", cancelledCount);

        request.getRequestDispatcher("DisplayBooking.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
