<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    /* ── Admin session guard ─────────────────────────────────────────────── */
    String _role = (session != null) ? (String) session.getAttribute("role") : null;
    if (!"admin".equals(_role)) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
%>
<%@ page import="java.util.List" %>
<%@ page import="com.lake.entities.*" %>
<%@ include file="AdminHeader.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>All Bookings — Admin</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { background: #0f1923; font-family: 'Inter', Arial, sans-serif; }
        .page { margin-top: 80px; padding: 24px 28px; }

        /* Stat cards */
        .stats-grid {
            display: grid; grid-template-columns: repeat(5, 1fr);
            gap: 16px; margin-bottom: 26px;
        }
        .sc {
            background: #1a2332;
            border-radius: 16px;
            padding: 20px 18px;
            border: 1px solid rgba(255,255,255,0.06);
            display: flex; align-items: center; gap: 14px;
            transition: transform 0.25s, box-shadow 0.25s;
            position: relative; overflow: hidden;
        }
        .sc::before {
            content: ''; position: absolute;
            top: 0; left: 0; right: 0; height: 3px;
            border-radius: 16px 16px 0 0;
        }
        .sc:nth-child(1)::before { background: linear-gradient(90deg,#3b82f6,#60a5fa); }
        .sc:nth-child(2)::before { background: linear-gradient(90deg,#10b981,#34d399); }
        .sc:nth-child(3)::before { background: linear-gradient(90deg,#06b6d4,#22d3ee); }
        .sc:nth-child(4)::before { background: linear-gradient(90deg,#f59e0b,#fbbf24); }
        .sc:nth-child(5)::before { background: linear-gradient(90deg,#ef4444,#f87171); }
        .sc:hover { transform: translateY(-4px); box-shadow: 0 12px 32px rgba(0,0,0,0.3); }
        .sc-icon {
            width: 48px; height: 48px; border-radius: 12px;
            font-size: 22px; display: flex; align-items: center; justify-content: center;
        }
        .ic1{background:rgba(59,130,246,0.15);}  .ic2{background:rgba(16,185,129,0.15);}
        .ic3{background:rgba(6,182,212,0.15);}   .ic4{background:rgba(245,158,11,0.15);}
        .ic5{background:rgba(239,68,68,0.15);}
        .sc-info label { font-size: 10px; color: rgba(255,255,255,0.35); text-transform: uppercase; letter-spacing:0.8px; font-weight:600; }
        .sc-info .v    { font-size: 24px; font-weight: 800; color: #fff; margin-top:2px; }

        /* Panel */
        .panel { background: #1a2332; border-radius: 18px; border: 1px solid rgba(255,255,255,0.06); overflow: hidden; box-shadow: 0 4px 20px rgba(0,0,0,0.2); }
        .panel-head {
            padding: 16px 22px; border-bottom: 1px solid rgba(255,255,255,0.06);
            background: rgba(255,255,255,0.03);
            display: flex; align-items: center; justify-content: space-between;
        }
        .panel-head h4 { font-size: 16px; color: rgba(255,255,255,0.85); font-weight:700; }
        .controls { display: flex; gap: 10px; align-items: center; }

        #searchInput {
            padding: 8px 16px; border: 1.5px solid rgba(255,255,255,0.1);
            border-radius: 30px; font-size: 13px; width: 230px;
            background: rgba(255,255,255,0.05); color: white; font-family: inherit;
        }
        #searchInput::placeholder { color: rgba(255,255,255,0.3); }
        #searchInput:focus { outline: none; border-color: #3b82f6; box-shadow: 0 0 0 3px rgba(59,130,246,0.15); }

        .filter-btn {
            padding: 7px 16px; border-radius: 30px;
            border: 1.5px solid rgba(255,255,255,0.1);
            background: rgba(255,255,255,0.05); color: rgba(255,255,255,0.6);
            font-size: 13px; cursor: pointer; font-family: inherit; font-weight:600;
            transition: all 0.2s;
        }
        .filter-btn.active { background: #3b82f6; color: white; border-color: #3b82f6; }
        .filter-btn:hover  { border-color: #3b82f6; color: #60a5fa; }

        /* Table */
        .table-wrap { overflow-x: auto; }
        table { width: 100%; border-collapse: collapse; min-width: 900px; }
        thead th {
            background: rgba(255,255,255,0.04); padding: 13px 16px;
            font-size: 10px; text-transform: uppercase;
            letter-spacing: 0.8px; color: rgba(255,255,255,0.35);
            border-bottom: 1px solid rgba(255,255,255,0.06); text-align: left; font-weight:600;
        }
        tbody tr { border-bottom: 1px solid rgba(255,255,255,0.04); transition: background 0.15s; }
        tbody tr:hover { background: rgba(255,255,255,0.05); }
        tbody td { padding: 13px 16px; font-size: 13px; color: rgba(255,255,255,0.65); }
        tbody td strong { color: rgba(255,255,255,0.9); }

        .badge {
            display: inline-block; padding: 4px 11px;
            border-radius: 20px; font-size: 11px; font-weight: 700;
        }
        .b-paid      { background: rgba(16,185,129,0.15);  color: #34d399; }
        .b-pending   { background: rgba(245,158,11,0.15);  color: #fbbf24; }
        .b-confirmed { background: rgba(59,130,246,0.15);  color: #60a5fa; }
        .b-cancelled { background: rgba(239,68,68,0.15);   color: #f87171; }
        .b-online    { background: rgba(6,182,212,0.15);   color: #22d3ee; }
        .b-offline   { background: rgba(139,92,246,0.15);  color: #a78bfa; }

        .live-dot {
            display: inline-block; width: 8px; height: 8px;
            background: #10b981; border-radius: 50%;
            animation: pulse 1.5s infinite; margin-right: 6px;
        }
        @keyframes pulse {
            0%,100% { opacity: 1; transform: scale(1); }
            50%      { opacity: 0.4; transform: scale(1.3); }
        }

        .no-data { text-align: center; padding: 48px; color: rgba(255,255,255,0.2); font-size: 15px; }

        /* Pagination */
        .pagination {
            display: flex; align-items: center; justify-content: space-between;
            padding: 16px 22px;
            border-top: 1px solid rgba(255,255,255,0.06);
            background: rgba(255,255,255,0.02);
            flex-wrap: wrap; gap: 10px;
        }
        .pag-info { font-size: 13px; color: rgba(255,255,255,0.35); }
        .pag-btns { display: flex; gap: 6px; align-items: center; }
        .pag-btn {
            padding: 6px 14px; border-radius: 8px;
            border: 1px solid rgba(255,255,255,0.1);
            background: rgba(255,255,255,0.05);
            color: rgba(255,255,255,0.6);
            font-size: 13px; cursor: pointer; text-decoration: none;
            transition: all 0.2s; font-weight: 600; font-family: inherit;
        }
        .pag-btn:hover   { background: rgba(59,130,246,0.15); color: #60a5fa; border-color: #3b82f6; }
        .pag-btn.active  { background: #3b82f6; color: white; border-color: #3b82f6; }
        .pag-btn.disabled{ opacity: 0.3; pointer-events: none; }

        @media (max-width: 900px) { .stats-grid { grid-template-columns: 1fr 1fr; } }
    </style>
</head>
<body>
<%
    List<BookingEntities> bookings = (List<BookingEntities>) request.getAttribute("listofstudents");
    int totalBookings  = request.getAttribute("totalBookings")  != null ? (Integer)request.getAttribute("totalBookings")  : 0;
    int totalRevenue   = request.getAttribute("totalRevenue")   != null ? (Integer)request.getAttribute("totalRevenue")   : 0;
    int paidCount      = request.getAttribute("paidCount")      != null ? (Integer)request.getAttribute("paidCount")      : 0;
    int pendingCount   = request.getAttribute("pendingCount")   != null ? (Integer)request.getAttribute("pendingCount")   : 0;
    int confirmedCount = request.getAttribute("confirmedCount") != null ? (Integer)request.getAttribute("confirmedCount") : 0;
    int cancelledCount = request.getAttribute("cancelledCount") != null ? (Integer)request.getAttribute("cancelledCount") : 0;
    int currentPage    = request.getAttribute("currentPage")    != null ? (Integer)request.getAttribute("currentPage")    : 1;
    int totalPages     = request.getAttribute("totalPages")     != null ? (Integer)request.getAttribute("totalPages")     : 1;
    int totalRows      = request.getAttribute("totalRows")      != null ? (Integer)request.getAttribute("totalRows")      : 0;
    String searchQuery  = request.getAttribute("searchQuery")  != null ? (String) request.getAttribute("searchQuery")  : "";
    String statusFilter = request.getAttribute("statusFilter") != null ? (String) request.getAttribute("statusFilter") : "";
    if (bookings == null) bookings = new java.util.ArrayList<>();
    // Helper to build page URL
    String baseUrl = "DisplayBooking?q=" + java.net.URLEncoder.encode(searchQuery, "UTF-8")
                   + "&status=" + java.net.URLEncoder.encode(statusFilter, "UTF-8");
%>

<div class="page">

    <!-- Stats -->
    <div class="stats-grid">
        <div class="sc"><div class="sc-icon ic1">📋</div><div class="sc-info"><label>Total Bookings</label><div class="v"><%= totalBookings %></div></div></div>
        <div class="sc"><div class="sc-icon ic2">💰</div><div class="sc-info"><label>Revenue</label><div class="v">₹<%= String.format("%,d", totalRevenue) %></div></div></div>
        <div class="sc"><div class="sc-icon ic3">✅</div><div class="sc-info"><label>Confirmed</label><div class="v"><%= confirmedCount %></div></div></div>
        <div class="sc"><div class="sc-icon ic4">💳 PAID</div><div class="sc-info"><label>Paid Online</label><div class="v"><%= paidCount %></div></div></div>
        <div class="sc"><div class="sc-icon ic5">⏳</div><div class="sc-info"><label>Pay on Arrival</label><div class="v"><%= pendingCount %></div></div></div>
    </div>

    <!-- Table Panel -->
    <div class="panel">
        <div class="panel-head">
            <h4><span class="live-dot"></span> All Bookings (<%= totalRows %> total)</h4>
            <div class="controls">
                <form method="get" action="DisplayBooking" style="display:flex;gap:8px;align-items:center;">
                    <input type="text" id="searchInput" name="q"
                           value="<%= searchQuery %>"
                           placeholder="🔍 Search name, email, ID…">
                    <input type="hidden" name="status" id="statusHidden" value="<%= statusFilter %>">
                    <button type="submit" class="filter-btn active">Search</button>
                </form>
                <a href="DisplayBooking" class="filter-btn <%= statusFilter.isEmpty() ? "active" : "" %>">All</a>
                <a href="DisplayBooking?status=confirmed" class="filter-btn <%= "confirmed".equals(statusFilter) ? "active" : "" %>">✅ Confirmed</a>
                <a href="DisplayBooking?status=cancelled" class="filter-btn <%= "cancelled".equals(statusFilter) ? "active" : "" %>">❌ Cancelled</a>
            </div>
        </div>

        <div class="table-wrap">
        <table id="bookingTable">
            <thead>
                <tr>
                    <th>#ID</th>
                    <th>Booked By</th>
                    <th>Guest Name</th>
                    <th>Accommodation</th>
                    <th>Arrival</th>
                    <th>Departure</th>
                    <th>Adults</th>
                    <th>Amount</th>
                    <th>Payment Method</th>
                    <th>Pay Status</th>
                    <th>Booking Status</th>
                </tr>
            </thead>
            <tbody id="tableBody">
            <%
                if (bookings.isEmpty()) {
            %>
                <tr><td colspan="11" class="no-data">No bookings found.</td></tr>
            <%
                } else {
                    for (BookingEntities b : bookings) {
                        String payStatusBadge = "PAID".equals(b.getPaymentStatus())     ? "b-paid"    : "b-pending";
                        String payMethodBadge = "ONLINE".equals(b.getPaymentMethod())   ? "b-online"  : "b-offline";
                        String statusBadge    = "confirmed".equals(b.getStatus())       ? "b-confirmed": "b-cancelled";
            %>
                <tr>
                    <td><strong>#<%= b.getId() %></strong></td>
                    <td><%= b.getBookedBy() != null ? b.getBookedBy() : "—" %></td>
                    <td><%= b.getName() %></td>
                    <td><%= b.getTent_name() %></td>
                    <td><%= b.getArrival_date() %></td>
                    <td><%= b.getDeparture_date() %></td>
                    <td><%= b.getNoPerson() %></td>
                    <td><strong>₹<%= String.format("%,d", b.getTotalCost()) %></strong></td>
                    <td><span class="badge <%= payMethodBadge %>"><%= b.getPaymentMethod() %></span></td>
                    <td><span class="badge <%= payStatusBadge %>"><%= b.getPaymentStatus() %></span></td>
                    <td><span class="badge <%= statusBadge %>"><%= b.getStatus() %></span></td>
                </tr>
            <%
                    }
                }
            %>
            </tbody>
        </table>
        </div>

        <%-- Pagination Controls --%>
        <div class="pagination">
            <div class="pag-info">
                Showing page <strong style="color:rgba(255,255,255,0.7);"><%= currentPage %></strong>
                of <strong style="color:rgba(255,255,255,0.7);"><%= totalPages %></strong>
                &nbsp;·&nbsp; <%= totalRows %> bookings total
            </div>
            <div class="pag-btns">
                <a href="<%= baseUrl %>&page=1" class="pag-btn <%= currentPage==1 ? "disabled" : "" %>">&laquo; First</a>
                <a href="<%= baseUrl %>&page=<%= currentPage-1 %>" class="pag-btn <%= currentPage==1 ? "disabled" : "" %>">&lsaquo; Prev</a>
                <%
                    int startP = Math.max(1, currentPage - 2);
                    int endP   = Math.min(totalPages, startP + 4);
                    for (int pg = startP; pg <= endP; pg++) {
                %>
                <a href="<%= baseUrl %>&page=<%= pg %>" class="pag-btn <%= pg==currentPage ? "active" : "" %>"><%= pg %></a>
                <%  } %>
                <a href="<%= baseUrl %>&page=<%= currentPage+1 %>" class="pag-btn <%= currentPage>=totalPages ? "disabled" : "" %>">Next &rsaquo;</a>
                <a href="<%= baseUrl %>&page=<%= totalPages %>" class="pag-btn <%= currentPage>=totalPages ? "disabled" : "" %>">Last &raquo;</a>
            </div>
        </div>
    </div>
</div>

<script>
    // Auto-refresh every 30 seconds to keep booking list live
    setTimeout(() => location.reload(), 30000);
</script>
</body>
</html>
