<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    /* ── Admin session guard ─────────────────────────────────────────────── */
    String _role = (session != null) ? (String) session.getAttribute("role") : null;
    if (!"admin".equals(_role)) {
        response.sendRedirect(request.getContextPath() + "/Login.jsp");
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
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { background: #f0f2f5; font-family: Arial, sans-serif; }
        .page { margin-top: 80px; padding: 24px 28px; }

        /* Stat cards */
        .stats-grid {
            display: grid; grid-template-columns: repeat(5, 1fr);
            gap: 14px; margin-bottom: 26px;
        }
        .sc {
            background: white; border-radius: 12px;
            padding: 18px; box-shadow: 0 2px 8px rgba(0,0,0,0.07);
            display: flex; align-items: center; gap: 12px;
        }
        .sc-icon {
            width: 48px; height: 48px; border-radius: 12px;
            font-size: 22px; display: flex; align-items: center; justify-content: center;
        }
        .ic1{background:#e8f0fe;} .ic2{background:#e6f9ee;}
        .ic3{background:#e0f7fa;} .ic4{background:#fff8e1;}
        .ic5{background:#fdecea;}
        .sc-info label { font-size: 11px; color: #aaa; text-transform: uppercase; }
        .sc-info .v    { font-size: 22px; font-weight: bold; color: #333; }

        /* Panel */
        .panel { background: white; border-radius: 14px; box-shadow: 0 2px 10px rgba(0,0,0,0.07); overflow: hidden; }
        .panel-head {
            padding: 16px 22px; border-bottom: 1px solid #eee;
            display: flex; align-items: center; justify-content: space-between;
        }
        .panel-head h4 { font-size: 16px; color: #333; }
        .controls { display: flex; gap: 10px; align-items: center; }

        #searchInput {
            padding: 7px 12px; border: 1.5px solid #ddd;
            border-radius: 7px; font-size: 13px; width: 220px;
        }
        #searchInput:focus { outline: none; border-color: #007bff; }

        .filter-btn {
            padding: 7px 14px; border-radius: 7px;
            border: 1.5px solid #ddd; background: white;
            font-size: 13px; cursor: pointer;
        }
        .filter-btn.active { background: #007bff; color: white; border-color: #007bff; }

        /* Table */
        .table-wrap { overflow-x: auto; }
        table { width: 100%; border-collapse: collapse; min-width: 900px; }
        thead th {
            background: #f8f9fa; padding: 12px 14px;
            font-size: 11px; text-transform: uppercase;
            letter-spacing: 0.5px; color: #888;
            border-bottom: 2px solid #eee; text-align: left;
        }
        tbody tr { border-bottom: 1px solid #f5f5f5; transition: background 0.15s; }
        tbody tr:hover { background: #fafcff; }
        tbody td { padding: 12px 14px; font-size: 13px; color: #444; }

        .badge {
            display: inline-block; padding: 3px 10px;
            border-radius: 20px; font-size: 11px; font-weight: bold;
        }
        .b-paid      { background: #e6f9ee; color: #1a7a3c; }
        .b-pending   { background: #fff8e1; color: #b45309; }
        .b-confirmed { background: #e8f0fe; color: #1a56db; }
        .b-cancelled { background: #fdecea; color: #c0392b; }
        .b-online    { background: #e0f7fa; color: #00838f; }
        .b-offline   { background: #f3e5f5; color: #7b1fa2; }

        .live-dot {
            display: inline-block; width: 8px; height: 8px;
            background: #28a745; border-radius: 50%;
            animation: pulse 1.5s infinite;
            margin-right: 6px;
        }
        @keyframes pulse {
            0%,100% { opacity: 1; transform: scale(1); }
            50%      { opacity: 0.4; transform: scale(1.3); }
        }

        .no-data { text-align: center; padding: 48px; color: #bbb; font-size: 15px; }

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
    if (bookings == null) bookings = new java.util.ArrayList<>();
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
            <h4><span class="live-dot"></span> All Bookings (Live)</h4>
            <div class="controls">
                <input type="text" id="searchInput"
                       placeholder="🔍 Search name, tent, status..."
                       onkeyup="filterTable()">
                <button class="filter-btn active" onclick="filterBy('all', this)">All</button>
                <button class="filter-btn" onclick="filterBy('PAID', this)">💳 Paid</button>
                <button class="filter-btn" onclick="filterBy('PENDING', this)">⏳ Pending</button>
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
    </div>
</div>

<script>
    function filterTable() {
        let q = document.getElementById('searchInput').value.toLowerCase();
        document.querySelectorAll('#tableBody tr').forEach(row => {
            row.style.display = row.innerText.toLowerCase().includes(q) ? '' : 'none';
        });
    }

    let currentFilter = 'all';
    function filterBy(status, btn) {
        currentFilter = status;
        document.querySelectorAll('.filter-btn').forEach(b => b.classList.remove('active'));
        btn.classList.add('active');
        document.querySelectorAll('#tableBody tr').forEach(row => {
            if (status === 'all') { row.style.display = ''; return; }
            row.style.display = row.innerText.includes(status) ? '' : 'none';
        });
    }

    setTimeout(() => location.reload(), 30000);
</script>
</body>
</html>
