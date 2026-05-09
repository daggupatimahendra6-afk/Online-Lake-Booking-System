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

// URL mapped in web.xml — @WebServlet removed to avoid duplicate mapping
public class DisplayBooking extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final int PAGE_SIZE = 10; // bookings per page

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ── Pagination params ───────────────────────────────────────────────
        int page = 1;
        try { page = Integer.parseInt(request.getParameter("page")); } catch (Exception ignored) {}
        if (page < 1) page = 1;

        // ── Search / filter param ───────────────────────────────────────────
        String search = request.getParameter("q");
        if (search == null) search = "";
        search = search.trim();

        // ── Status filter ───────────────────────────────────────────────────
        String statusFilter = request.getParameter("status");
        if (statusFilter == null) statusFilter = "";

        List<BookingEntities> list = new ArrayList<>();

        int totalBookings  = 0;
        int totalRevenue   = 0;
        int paidCount      = 0;
        int pendingCount   = 0;
        int confirmedCount = 0;
        int cancelledCount = 0;
        int totalRows      = 0;  // for pagination

        // ── Build query with optional search + status filter ────────────────
        StringBuilder countSql = new StringBuilder(
            "SELECT COUNT(*) FROM bookings b JOIN tents t ON b.tent_id = t.tent_id WHERE 1=1 ");
        StringBuilder dataSql = new StringBuilder(
            "SELECT b.id, b.name, b.email, b.phone, " +
            "       b.no_of_persons, b.no_of_kids, " +
            "       b.arrival_date, b.departure_date, " +
            "       b.total_cost, b.status, t.tent_name, " +
            "       b.payment_method, b.payment_status, " +
            "       COALESCE(b.username, b.name) AS booked_by " +
            "FROM   bookings b " +
            "JOIN   tents    t ON b.tent_id = t.tent_id WHERE 1=1 ");

        List<String> params = new ArrayList<>();

        if (!search.isEmpty()) {
            String clause = " AND (LOWER(b.name) LIKE ? OR LOWER(b.email) LIKE ? OR CAST(b.id AS TEXT) LIKE ?)";
            countSql.append(clause);
            dataSql.append(clause);
            String likeVal = "%" + search.toLowerCase() + "%";
            params.add(likeVal); params.add(likeVal); params.add(likeVal);
        }
        if (!statusFilter.isEmpty()) {
            countSql.append(" AND b.status = ?");
            dataSql.append(" AND b.status = ?");
            params.add(statusFilter);
        }

        dataSql.append(" ORDER BY b.created_at DESC LIMIT ? OFFSET ?");

        try (Connection con = DBConnection.getConnection()) {

            // ── Total count for this filter (pagination) ───────────────────
            try (PreparedStatement ps = con.prepareStatement(countSql.toString())) {
                int i = 1;
                for (String p : params) ps.setString(i++, p);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) totalRows = rs.getInt(1);
            }

            // ── Full aggregates (always, unfiltered) ───────────────────────
            String aggSql =
                "SELECT COUNT(*) AS cnt, " +
                "       COALESCE(SUM(CASE WHEN payment_status='PAID' THEN total_cost ELSE 0 END),0) AS rev, " +
                "       COUNT(CASE WHEN payment_status='PAID'    THEN 1 END) AS paid_cnt, " +
                "       COUNT(CASE WHEN payment_status='PENDING' THEN 1 END) AS pend_cnt, " +
                "       COUNT(CASE WHEN status='confirmed'       THEN 1 END) AS conf_cnt, " +
                "       COUNT(CASE WHEN status='cancelled'       THEN 1 END) AS canc_cnt " +
                "FROM bookings";
            try (PreparedStatement ps2 = con.prepareStatement(aggSql);
                 ResultSet rs2 = ps2.executeQuery()) {
                if (rs2.next()) {
                    totalBookings  = rs2.getInt("cnt");
                    totalRevenue   = rs2.getInt("rev");
                    paidCount      = rs2.getInt("paid_cnt");
                    pendingCount   = rs2.getInt("pend_cnt");
                    confirmedCount = rs2.getInt("conf_cnt");
                    cancelledCount = rs2.getInt("canc_cnt");
                }
            }

            // ── Paged data ─────────────────────────────────────────────────
            try (PreparedStatement ps3 = con.prepareStatement(dataSql.toString())) {
                int i = 1;
                for (String p : params) ps3.setString(i++, p);
                ps3.setInt(i++, PAGE_SIZE);
                ps3.setInt(i,   (page - 1) * PAGE_SIZE);

                try (ResultSet rs3 = ps3.executeQuery()) {
                    while (rs3.next()) {
                        BookingEntities b = new BookingEntities(
                            rs3.getInt("id"),
                            rs3.getString("name"),
                            rs3.getString("email"),
                            rs3.getLong("phone"),
                            rs3.getInt("no_of_persons"),
                            rs3.getInt("no_of_kids"),
                            rs3.getString("arrival_date"),
                            rs3.getString("departure_date"),
                            rs3.getString("tent_name"),
                            rs3.getInt("total_cost"),
                            rs3.getString("status")
                        );
                        b.setPaymentMethod(rs3.getString("payment_method"));
                        b.setPaymentStatus(rs3.getString("payment_status"));
                        b.setBookedBy(rs3.getString("booked_by"));
                        list.add(b);
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        int totalPages = (totalRows == 0) ? 1 : (int) Math.ceil((double) totalRows / PAGE_SIZE);

        request.setAttribute("listofstudents",  list);
        request.setAttribute("totalBookings",   totalBookings);
        request.setAttribute("totalRevenue",    totalRevenue);
        request.setAttribute("paidCount",       paidCount);
        request.setAttribute("pendingCount",    pendingCount);
        request.setAttribute("confirmedCount",  confirmedCount);
        request.setAttribute("cancelledCount",  cancelledCount);
        request.setAttribute("currentPage",     page);
        request.setAttribute("totalPages",      totalPages);
        request.setAttribute("totalRows",       totalRows);
        request.setAttribute("searchQuery",     search);
        request.setAttribute("statusFilter",    statusFilter);

        request.getRequestDispatcher("DisplayBooking.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
