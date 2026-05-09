<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Bookings — Vasota Lake Camping</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Inter', Arial, sans-serif; background: #f0f7f3; }

        .page { max-width: 1080px; margin: 0 auto; padding: 30px 16px 80px; }

        /* ── Welcome Banner ── */
        .welcome {
            background: linear-gradient(135deg, #0A2E1F 0%, #1aa356 60%, #22c76a 100%);
            color: white;
            border-radius: 20px;
            padding: 28px 32px;
            margin-bottom: 24px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 14px;
            box-shadow: 0 8px 28px rgba(26,163,86,0.30);
            position: relative;
            overflow: hidden;
        }
        .welcome::before {
            content: '🏕️';
            position: absolute;
            right: 180px; top: 50%;
            transform: translateY(-50%);
            font-size: 80px;
            opacity: 0.07;
        }
        .welcome h2 { font-size: 24px; font-weight: 800; }
        .welcome p  { font-size: 13px; opacity: 0.85; margin-top: 6px; }
        .btn-newbooking {
            padding: 12px 28px;
            background: white;
            color: #0A2E1F;
            border-radius: 30px;
            text-decoration: none;
            font-size: 14px;
            font-weight: 700;
            white-space: nowrap;
            transition: transform 0.2s, box-shadow 0.2s;
            box-shadow: 0 4px 16px rgba(0,0,0,0.15);
        }
        .btn-newbooking:hover { transform: translateY(-3px); box-shadow: 0 8px 24px rgba(0,0,0,0.2); }

        /* ── Stat Cards ── */
        .stats-row {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 16px;
            margin-bottom: 24px;
        }
        .stat-card {
            background: white;
            border-radius: 16px;
            padding: 20px 22px;
            box-shadow: 0 4px 16px rgba(0,0,0,0.06);
            display: flex;
            align-items: center;
            gap: 16px;
            transition: transform 0.25s, box-shadow 0.25s;
            border: 1px solid rgba(0,0,0,0.04);
        }
        .stat-card:hover { transform: translateY(-4px); box-shadow: 0 10px 28px rgba(0,0,0,0.10); }
        .si {
            font-size: 22px;
            width: 54px; height: 54px;
            border-radius: 14px;
            display: flex; align-items: center; justify-content: center;
            flex-shrink: 0;
        }
        .si-blue   { background: linear-gradient(135deg,#dbeafe,#bfdbfe); }
        .si-green  { background: linear-gradient(135deg,#d1fae5,#a7f3d0); }
        .si-orange { background: linear-gradient(135deg,#fef3c7,#fde68a); }
        .stat-info label { font-size: 11px; color: #999; text-transform: uppercase; letter-spacing: 0.7px; font-weight: 600; }
        .stat-info .val  { font-size: 28px; font-weight: 800; color: #1a1a2e; margin-top: 3px; }
        .stat-info .sub  { font-size: 12px; color: #bbb; margin-top: 2px; }

        /* ── Alert ── */
        #cancelAlert {
            background: linear-gradient(135deg,#d1fae5,#a7f3d0);
            color: #065f46;
            border: 1px solid #6ee7b7;
            border-radius: 12px;
            padding: 14px 20px;
            margin-bottom: 20px;
            font-weight: 600;
            display: flex;
            align-items: center;
            justify-content: space-between;
            animation: slideIn 0.4s ease;
        }
        @keyframes slideIn { from { opacity:0; transform:translateY(-10px); } to { opacity:1; transform:translateY(0); } }
        #cancelAlert button { background: none; border: none; font-size: 20px; cursor: pointer; color: #065f46; }

        /* ── Panel ── */
        .panel {
            background: white;
            border-radius: 20px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.07);
            overflow: hidden;
            border: 1px solid rgba(0,0,0,0.04);
        }
        .panel-head {
            padding: 18px 26px;
            background: linear-gradient(135deg,#f8fffc,#f0faf5);
            border-bottom: 1px solid #e8f5ee;
            display: flex; align-items: center; justify-content: space-between; flex-wrap: wrap; gap: 10px;
        }
        .panel-head h4 { font-size: 16px; color: #0A2E1F; font-weight: 700; }
        #searchInput {
            padding: 9px 16px;
            border: 1.5px solid #d1fae5;
            border-radius: 30px;
            font-size: 13px;
            width: 230px;
            font-family: inherit;
            background: white;
        }
        #searchInput:focus { outline: none; border-color: #1aa356; box-shadow: 0 0 0 3px rgba(26,163,86,0.12); }

        /* ── Booking Cards ── */
        .booking-list { padding: 20px; display: flex; flex-direction: column; gap: 18px; }
        .booking-card {
            border: 1.5px solid #e5efe9;
            border-radius: 16px;
            overflow: hidden;
            transition: box-shadow 0.25s, transform 0.25s;
            background: white;
        }
        .booking-card:hover { box-shadow: 0 8px 28px rgba(0,0,0,0.10); transform: translateY(-2px); }

        /* Header bar with colored left accent */
        .bc-header {
            display: flex; align-items: center; justify-content: space-between;
            padding: 14px 22px;
            background: linear-gradient(135deg, #f8fffc, #f0faf5);
            border-bottom: 1px solid #e8f0ec;
            flex-wrap: wrap; gap: 10px;
            border-left: 5px solid #1aa356;
        }
        .bc-header.cancelled { border-left-color: #ef4444; background: linear-gradient(135deg,#fff5f5,#fef2f2); }
        .bc-id-wrap  { display: flex; align-items: center; gap: 10px; }
        .bc-id       { font-weight: 800; font-size: 15px; color: #0A2E1F; }
        .bc-tent-name{ font-size: 14px; color: #555; font-weight: 600; }
        .bc-booked-on{ font-size: 11px; color: #bbb; font-weight: 500; }

        /* Badges */
        .badge {
            display: inline-flex; align-items: center; gap: 4px;
            padding: 5px 13px; border-radius: 30px; font-size: 11px; font-weight: 700;
        }
        .b-paid      { background: #d1fae5; color: #065f46; }
        .b-pending   { background: #fef3c7; color: #92400e; }
        .b-confirmed { background: #dbeafe; color: #1e40af; }
        .b-cancelled { background: #fee2e2; color: #991b1b; }
        .b-completed { background: #ede9fe; color: #5b21b6; }

        /* Card Body */
        .bc-body { padding: 18px 22px; }
        .bc-grid {
            display: grid; grid-template-columns: repeat(4,1fr); gap: 16px; margin-bottom: 16px;
        }
        .bc-item label {
            font-size: 10px; color: #aaa; text-transform: uppercase;
            letter-spacing: 0.7px; display: block; margin-bottom: 4px; font-weight: 600;
        }
        .bc-item .val { font-size: 14px; font-weight: 700; color: #222; }
        .bc-item .val.highlight { color: #1aa356; font-size: 16px; }
        .section-divider { width:100%; border:none; border-top: 1px dashed #e8eeeb; margin: 14px 0; }
        .bc-grid-2 { display: grid; grid-template-columns: repeat(3,1fr); gap: 16px; }

        /* Card Footer */
        .bc-footer {
            padding: 14px 22px;
            background: linear-gradient(135deg,#fafffe,#f5fdf8);
            border-top: 1px solid #e8f0ec;
            display: flex; align-items: center; justify-content: space-between; flex-wrap: wrap; gap: 10px;
        }
        .total-cost { font-size: 22px; font-weight: 800; color: #1aa356; }
        .total-cost span { font-size: 13px; color: #aaa; margin-right: 4px; font-weight: 500; }
        .payment-pill {
            display: inline-flex; align-items: center; gap: 6px;
            padding: 5px 14px; border-radius: 20px; font-size: 12px;
            font-weight: 700; background: #f0f0f0; color: #555;
        }

        /* Cancel Button */
        .btn-cancel {
            background: linear-gradient(135deg,#fee2e2,#fecaca);
            color: #991b1b;
            border: 1.5px solid #fca5a5;
            padding: 7px 18px;
            border-radius: 30px;
            font-size: 12px;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.2s;
            font-family: inherit;
        }
        .btn-cancel:hover { background: linear-gradient(135deg,#fecaca,#fca5a5); transform: scale(1.04); }

        /* Empty state */
        .no-bookings { text-align: center; padding: 70px 20px; color: #bbb; }
        .no-bookings .nb-icon { font-size: 68px; display: block; margin-bottom: 18px; }
        .no-bookings h3 { font-size: 20px; color: #aaa; margin-bottom: 10px; }
        .no-bookings p  { font-size: 14px; }
        .no-bookings a {
            display: inline-block; margin-top: 22px; padding: 13px 32px;
            background: linear-gradient(135deg,#0A2E1F,#1aa356);
            color: white; border-radius: 30px; text-decoration: none;
            font-weight: 700; transition: opacity 0.2s, transform 0.2s;
        }
        .no-bookings a:hover { opacity: 0.9; transform: translateY(-2px); }

        .logout-link { text-align: center; margin-top: 26px; font-size: 14px; }
        .logout-link a { color: #ef4444; text-decoration: none; font-weight: 700; }
        .logout-link a:hover { text-decoration: underline; }

        @media (max-width: 700px) {
            .stats-row { grid-template-columns: 1fr 1fr; }
            .bc-grid   { grid-template-columns: 1fr 1fr; }
            .bc-grid-2 { grid-template-columns: 1fr 1fr; }
        }
        @media (max-width: 440px) {
            .stats-row { grid-template-columns: 1fr; }
        }
    </style>
</head>
<body>
<%@ include file="Header.jsp" %>

<%
    String loggedUser = (session != null) ? (String)session.getAttribute("username") : null;
    if (loggedUser == null) { response.sendRedirect("login"); return; }

    String  fullName    = (String)  request.getAttribute("fullName");
    if (fullName == null || fullName.isEmpty()) fullName = loggedUser;

    List<String[]> bookings    = (List<String[]>) request.getAttribute("bookings");
    int totalSpent   = request.getAttribute("totalSpent")   != null ? (Integer)request.getAttribute("totalSpent")   : 0;
    int totalCount   = request.getAttribute("totalCount")   != null ? (Integer)request.getAttribute("totalCount")   : 0;
    int pendingCount = request.getAttribute("pendingCount") != null ? (Integer)request.getAttribute("pendingCount") : 0;
    if (bookings == null) bookings = new java.util.ArrayList<>();
%>

<div class="page">

    <%-- Cancellation flash message --%>
    <%
        String cancelMsg = (String) request.getAttribute("cancelMsg");
        if (cancelMsg != null && !cancelMsg.isEmpty()) {
    %>
    <div id="cancelAlert">
        <span><%= cancelMsg %></span>
        <button onclick="document.getElementById('cancelAlert').style.display='none'">✕</button>
    </div>
    <% } %>

    <%-- Welcome Banner --%>
    <div class="welcome">
        <div>
            <h2>👋 Welcome, <%= fullName %>!</h2>
            <p>Here are all your bookings at Vasota Lake Camping.</p>
        </div>
        <a href="book" class="btn-newbooking">📅 New Booking</a>
    </div>

    <%-- Stat Cards --%>
    <div class="stats-row">
        <div class="stat-card">
            <div class="si si-blue">📋</div>
            <div class="stat-info">
                <label>Total Bookings</label>
                <div class="val"><%= totalCount %></div>
                <div class="sub">All time</div>
            </div>
        </div>
        <div class="stat-card">
            <div class="si si-green">💰</div>
            <div class="stat-info">
                <label>Total Spent</label>
                <div class="val">₹<%= String.format("%,d", totalSpent) %></div>
                <div class="sub">Paid bookings</div>
            </div>
        </div>
        <div class="stat-card">
            <div class="si si-orange">⏳</div>
            <div class="stat-info">
                <label>Pending Payment</label>
                <div class="val"><%= pendingCount %></div>
                <div class="sub">Pay on arrival</div>
            </div>
        </div>
    </div>

    <%-- Bookings Panel --%>
    <div class="panel">
        <div class="panel-head">
            <h4>🏕️ Your Booking History</h4>
            <input type="text" id="searchInput" placeholder="🔍 Search bookings…" onkeyup="filterBookings()" />
        </div>

        <% if (bookings.isEmpty()) { %>

        <div class="no-bookings">
            <span class="nb-icon">🏕️</span>
            <h3>No bookings yet!</h3>
            <p>You haven't made any reservations. Start your adventure today!</p>
            <a href="book">📅 Book a Campsite</a>
        </div>

        <% } else { %>

        <div class="booking-list" id="bookingList">
        <%
            for (String[] b : bookings) {
                String statusBadge = "b-confirmed";
                String statusIcon  = "✅";
                if ("pending".equalsIgnoreCase(b[9]))   { statusBadge = "b-pending";   statusIcon = "⏳"; }
                if ("cancelled".equalsIgnoreCase(b[9])) { statusBadge = "b-cancelled"; statusIcon = "❌"; }
                if ("completed".equalsIgnoreCase(b[9])) { statusBadge = "b-completed"; statusIcon = "🏆"; }

                String payBadge = "b-pending";
                String payIcon  = "⏳";
                if ("PAID".equalsIgnoreCase(b[8])) { payBadge = "b-paid"; payIcon = "✅"; }

                boolean isCancelled = "cancelled".equalsIgnoreCase(b[9]);

                int nights = 1;
                try {
                    java.time.LocalDate arr = java.time.LocalDate.parse(b[2]);
                    java.time.LocalDate dep = java.time.LocalDate.parse(b[3]);
                    nights = (int) java.time.temporal.ChronoUnit.DAYS.between(arr, dep);
                    if (nights <= 0) nights = 1;
                } catch(Exception _e) {}
        %>
            <div class="booking-card" data-search="<%= (b[0]+b[1]+b[2]+b[3]+b[9]).toLowerCase() %>">

                <div class="bc-header <%= isCancelled ? "cancelled" : "" %>">
                    <div class="bc-id-wrap">
                        <span class="bc-id">📋 #<%= b[0] %></span>
                        <span class="bc-tent-name">⛺ <%= b[1] %></span>
                    </div>
                    <div style="display:flex;align-items:center;gap:10px;flex-wrap:wrap;">
                        <span class="bc-booked-on">Booked: <%= b[10] %></span>
                        <span class="badge <%= statusBadge %>"><%= statusIcon %> <%= b[9] %></span>
                    </div>
                </div>

                <div class="bc-body">
                    <div class="bc-grid">
                        <div class="bc-item">
                            <label>📅 Check-In</label>
                            <div class="val"><%= b[2] %></div>
                        </div>
                        <div class="bc-item">
                            <label>📅 Check-Out</label>
                            <div class="val"><%= b[3] %></div>
                        </div>
                        <div class="bc-item">
                            <label>🌙 Duration</label>
                            <div class="val"><%= nights %> Night<%= nights > 1 ? "s" : "" %></div>
                        </div>
                        <div class="bc-item">
                            <label>👤 Guests</label>
                            <div class="val">
                                <%= b[4] %> Adult<%= Integer.parseInt(b[4]) > 1 ? "s" : "" %>
                                <% if (Integer.parseInt(b[5]) > 0) { %>
                                    &amp; <%= b[5] %> Kid<%= Integer.parseInt(b[5]) > 1 ? "s" : "" %>
                                <% } %>
                            </div>
                        </div>
                    </div>

                    <hr class="section-divider">

                    <div class="bc-grid-2">
                        <div class="bc-item">
                            <label>💳 Payment Method</label>
                            <div class="val"><%= b[7] != null ? b[7] : "—" %></div>
                        </div>
                        <div class="bc-item">
                            <label>🏷️ Payment Status</label>
                            <div class="val">
                                <span class="badge <%= payBadge %>"><%= payIcon %> <%= b[8] %></span>
                            </div>
                        </div>
                        <div class="bc-item">
                            <label>⛺ Accommodation</label>
                            <div class="val"><%= b[1] %></div>
                        </div>
                    </div>
                </div>

                <div class="bc-footer">
                    <div class="total-cost">
                        <span>Total Cost</span>₹<%= String.format("%,d", Integer.parseInt(b[6])) %>
                    </div>
                    <div style="display:flex;gap:10px;align-items:center;flex-wrap:wrap;">
                        <span class="payment-pill"><%= payIcon %> <%= b[8] %></span>
                        <% if (!isCancelled) { %>
                        <%-- FIX: action must match the servlet-mapping in web.xml (/MyBookings) --%>
                        <form method="post" action="MyBookings"
                              onsubmit="return confirmCancel('<%= b[0] %>')">
                            <input type="hidden" name="bookingId" value="<%= b[0] %>">
                            <button type="submit" class="btn-cancel">❌ Cancel Booking</button>
                        </form>
                        <% } %>
                    </div>
                </div>

            </div>
        <% } %>
        </div>

        <% } %>
    </div>

    <div class="logout-link"><a href="logout">🚪 Logout</a></div>
</div>

<script>
function filterBookings() {
    var q = document.getElementById('searchInput').value.toLowerCase();
    document.querySelectorAll('#bookingList .booking-card').forEach(function(card) {
        card.style.display = (card.getAttribute('data-search') || '').includes(q) ? '' : 'none';
    });
}

function confirmCancel(id) {
    return confirm('Are you sure you want to cancel Booking #' + id + '?\nThis action cannot be undone.');
}
</script>

<%@ include file="Footer.jsp" %>
</body>
</html>
