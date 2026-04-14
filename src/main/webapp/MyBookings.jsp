<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ include file="Header.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Bookings — Vasota Lake Camping</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: Arial, sans-serif; background: #f0f7f3; }

        .page { max-width: 1050px; margin: 0 auto; padding: 30px 16px 70px; }

        /* ── Welcome Banner ── */
        .welcome {
            background: linear-gradient(135deg, #1a3a2a, #28a745);
            color: white;
            border-radius: 16px;
            padding: 24px 30px;
            margin-bottom: 24px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 14px;
            box-shadow: 0 6px 20px rgba(40,167,69,0.25);
        }
        .welcome h2 { font-size: 22px; }
        .welcome p  { font-size: 13px; opacity: 0.85; margin-top: 5px; }
        .btn-newbooking {
            padding: 11px 26px;
            background: white;
            color: #1a3a2a;
            border-radius: 30px;
            text-decoration: none;
            font-size: 14px;
            font-weight: bold;
            white-space: nowrap;
            transition: transform 0.2s, box-shadow 0.2s;
            box-shadow: 0 2px 8px rgba(0,0,0,0.12);
        }
        .btn-newbooking:hover { transform: translateY(-2px); box-shadow: 0 4px 14px rgba(0,0,0,0.18); }

        /* ── Stat cards ── */
        .stats-row {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 14px;
            margin-bottom: 24px;
        }
        .stat-card {
            background: white;
            border-radius: 14px;
            padding: 18px 20px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.07);
            display: flex;
            align-items: center;
            gap: 14px;
            transition: transform 0.2s;
        }
        .stat-card:hover { transform: translateY(-2px); }
        .si {
            font-size: 24px;
            width: 52px; height: 52px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
        }
        .si-blue   { background: #e8f0fe; }
        .si-green  { background: #e6f9ee; }
        .si-orange { background: #fff4e5; }
        .stat-info label {
            font-size: 11px; color: #999;
            text-transform: uppercase; letter-spacing: 0.5px;
        }
        .stat-info .val { font-size: 26px; font-weight: bold; color: #333; margin-top: 2px; }
        .stat-info .sub { font-size: 12px; color: #aaa; margin-top: 2px; }

        /* ── Panel ── */
        .panel {
            background: white;
            border-radius: 16px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.07);
            overflow: hidden;
        }
        .panel-head {
            padding: 16px 24px;
            border-bottom: 1px solid #eee;
            display: flex;
            align-items: center;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 10px;
        }
        .panel-head h4 { font-size: 16px; color: #333; }
        #searchInput {
            padding: 8px 14px;
            border: 1.5px solid #ddd;
            border-radius: 8px;
            font-size: 13px;
            width: 220px;
        }
        #searchInput:focus { outline: none; border-color: #28a745; }

        /* ── Booking Cards ── */
        .booking-list { padding: 18px; display: flex; flex-direction: column; gap: 16px; }

        .booking-card {
            border: 1.5px solid #e5e5e5;
            border-radius: 14px;
            overflow: hidden;
            transition: box-shadow 0.2s, transform 0.2s;
        }
        .booking-card:hover {
            box-shadow: 0 6px 20px rgba(0,0,0,0.10);
            transform: translateY(-1px);
        }

        /* Card top bar */
        .bc-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 13px 20px;
            background: linear-gradient(135deg, #f8fffe, #f0fbf4);
            border-bottom: 1px solid #e8e8e8;
            flex-wrap: wrap;
            gap: 8px;
        }
        .bc-id-wrap { display: flex; align-items: center; gap: 10px; }
        .bc-id {
            font-weight: bold;
            font-size: 15px;
            color: #1a3a2a;
        }
        .bc-tent-name {
            font-size: 14px;
            color: #555;
            font-weight: 600;
        }
        .bc-booked-on { font-size: 12px; color: #aaa; }

        /* Badge */
        .badge {
            display: inline-flex;
            align-items: center;
            gap: 4px;
            padding: 5px 13px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
        }
        .b-paid      { background: #e6f9ee; color: #1a7a3c; }
        .b-pending   { background: #fff8e1; color: #b45309; }
        .b-confirmed { background: #e8f0fe; color: #1a56db; }
        .b-cancelled { background: #fdecea; color: #c0392b; }
        .b-completed { background: #f3eeff; color: #5b21b6; }

        /* Card body grid */
        .bc-body { padding: 16px 20px; }
        .bc-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 14px;
            margin-bottom: 14px;
        }
        .bc-item label {
            font-size: 10px;
            color: #999;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            display: block;
            margin-bottom: 3px;
        }
        .bc-item .val { font-size: 14px; font-weight: bold; color: #333; }
        .bc-item .val.highlight { color: #1a7a3c; font-size: 16px; }

        /* Divider between grid sections */
        .section-divider {
            width: 100%;
            border: none;
            border-top: 1px dashed #eee;
            margin: 12px 0;
        }

        /* Second grid row */
        .bc-grid-2 {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 14px;
        }

        /* Card footer */
        .bc-footer {
            padding: 12px 20px;
            background: #fafafa;
            border-top: 1px solid #eee;
            display: flex;
            align-items: center;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 8px;
        }
        .total-cost {
            font-size: 20px;
            font-weight: bold;
            color: #28a745;
        }
        .total-cost span { font-size: 13px; color: #aaa; margin-right: 4px; }
        .payment-pill {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 5px 14px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
            background: #f0f0f0;
            color: #555;
        }

        /* Empty state */
        .no-bookings {
            text-align: center;
            padding: 70px 20px;
            color: #bbb;
        }
        .no-bookings .nb-icon { font-size: 64px; display: block; margin-bottom: 16px; }
        .no-bookings h3 { font-size: 20px; color: #aaa; margin-bottom: 8px; }
        .no-bookings p  { font-size: 14px; }
        .no-bookings a {
            display: inline-block;
            margin-top: 20px;
            padding: 12px 30px;
            background: linear-gradient(135deg, #1a3a2a, #28a745);
            color: white;
            border-radius: 30px;
            text-decoration: none;
            font-weight: bold;
            transition: opacity 0.2s;
        }
        .no-bookings a:hover { opacity: 0.88; }

        /* Footer logout link */
        .logout-link {
            text-align: center;
            margin-top: 24px;
            font-size: 14px;
        }
        .logout-link a {
            color: #c0392b;
            text-decoration: none;
            font-weight: bold;
        }
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

<%
    // Session guard
    String loggedUser = (session != null) ? (String)session.getAttribute("username") : null;
    if (loggedUser == null) { response.sendRedirect("Login.jsp"); return; }

    String  fullName    = (String)  request.getAttribute("fullName");
    if (fullName == null || fullName.isEmpty()) fullName = loggedUser;

    List<String[]> bookings    = (List<String[]>) request.getAttribute("bookings");
    int totalSpent   = request.getAttribute("totalSpent")   != null ? (Integer)request.getAttribute("totalSpent")   : 0;
    int totalCount   = request.getAttribute("totalCount")   != null ? (Integer)request.getAttribute("totalCount")   : 0;
    int pendingCount = request.getAttribute("pendingCount") != null ? (Integer)request.getAttribute("pendingCount") : 0;
    if (bookings == null) bookings = new java.util.ArrayList<>();
%>

<div class="page">

    <!-- Cancellation flash message -->
    <%
        String cancelMsg = (String) request.getAttribute("cancelMsg");
        if (cancelMsg != null && !cancelMsg.isEmpty()) {
    %>
    <div id="cancelAlert" style="background:#e6f9ee;color:#1a7a3c;border:1px solid #b7eacb;border-radius:10px;padding:14px 20px;margin-bottom:18px;font-weight:bold;display:flex;align-items:center;justify-content:space-between;">
        <span><%= cancelMsg %></span>
        <button onclick="document.getElementById('cancelAlert').style.display='none'" style="background:none;border:none;font-size:18px;cursor:pointer;color:#1a7a3c;">✕</button>
    </div>
    <% } %>

    <!-- Welcome Banner -->
    <div class="welcome">
        <div>
            <h2>👋 Welcome, <%= fullName %>!</h2>
            <p>Here are all your bookings at Vasota Lake Camping.</p>
        </div>
        <a href="Bookings.jsp" class="btn-newbooking">📅 New Booking</a>
    </div>

    <!-- Stat Cards -->
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
                <div class="sub">Awaiting payment</div>
            </div>
        </div>
    </div>

    <!-- Bookings Panel -->
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
            <a href="Bookings.jsp">📅 Book a Campsite</a>
        </div>

        <% } else { %>

        <div class="booking-list" id="bookingList">
        <%
            /* bookings columns:
               [0]=id  [1]=tent_name  [2]=arrival_date  [3]=departure_date
               [4]=no_of_persons  [5]=no_of_kids  [6]=total_cost
               [7]=payment_method  [8]=payment_status  [9]=status  [10]=created_at
            */
            for (String[] b : bookings) {
                String statusBadge = "b-confirmed";
                String statusIcon  = "✅";
                if ("pending".equalsIgnoreCase(b[9]))   { statusBadge = "b-pending";   statusIcon = "⏳"; }
                if ("cancelled".equalsIgnoreCase(b[9])) { statusBadge = "b-cancelled"; statusIcon = "❌"; }
                if ("completed".equalsIgnoreCase(b[9])) { statusBadge = "b-completed"; statusIcon = "🏆"; }

                String payBadge = "b-pending";
                String payIcon  = "⏳";
                if ("PAID".equalsIgnoreCase(b[8]))      { payBadge = "b-paid"; payIcon = "✅"; }

                // Compute nights
                int nights = 1;
                try {
                    java.time.LocalDate arr = java.time.LocalDate.parse(b[2]);
                    java.time.LocalDate dep = java.time.LocalDate.parse(b[3]);
                    nights = (int) java.time.temporal.ChronoUnit.DAYS.between(arr, dep);
                    if (nights <= 0) nights = 1;
                } catch(Exception _e) {}
        %>
            <div class="booking-card" data-search="<%= (b[0]+b[1]+b[2]+b[3]+b[9]).toLowerCase() %>">

                <!-- Card Header -->
                <div class="bc-header">
                    <div class="bc-id-wrap">
                        <span class="bc-id">📋 #<%= b[0] %></span>
                        <span class="bc-tent-name">⛺ <%= b[1] %></span>
                    </div>
                    <div style="display:flex;align-items:center;gap:10px;flex-wrap:wrap;">
                        <span class="bc-booked-on">Booked: <%= b[10] %></span>
                        <span class="badge <%= statusBadge %>"><%= statusIcon %> <%= b[9] %></span>
                    </div>
                </div>

                <!-- Card Body -->
                <div class="bc-body">

                    <!-- Row 1: Date & Guests -->
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

                    <!-- Row 2: Payment Details -->
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
                            <label>⛺ Tent</label>
                            <div class="val"><%= b[1] %></div>
                        </div>
                    </div>

                </div>

                <!-- Card Footer -->
                <div class="bc-footer">
                    <div>
                        <div class="total-cost">
                            <span>Total Cost</span>
                            ₹<%= String.format("%,d", Integer.parseInt(b[6])) %>
                        </div>
                    </div>
                    <div style="display:flex;gap:8px;align-items:center;flex-wrap:wrap;">
                        <span class="payment-pill"><%= payIcon %> <%= b[8] %></span>
                        <% if (!"cancelled".equalsIgnoreCase(b[9])) { %>
                        <form method="post" action="MyBookings"
                              onsubmit="return confirm('Cancel booking #<%= b[0] %>? This cannot be undone.');">
                            <input type="hidden" name="bookingId" value="<%= b[0] %>">
                            <button type="submit"
                                    style="background:#fdecea;color:#c0392b;border:1.5px solid #fbc9c5;padding:5px 14px;border-radius:20px;font-size:12px;font-weight:bold;cursor:pointer;transition:background 0.2s;"
                                    onmouseover="this.style.background='#fbc9c5'"
                                    onmouseout="this.style.background='#fdecea'">❌ Cancel Booking</button>
                        </form>
                        <% } %>
                    </div>
                </div>

            </div>
        <% } %>
        </div>

        <% } %>
    </div>

    <div class="logout-link">
        <a href="Logout.jsp">🚪 Logout</a>
    </div>
</div>

<script>
function filterBookings() {
    var q = document.getElementById('searchInput').value.toLowerCase();
    var cards = document.querySelectorAll('#bookingList .booking-card');
    cards.forEach(function(card) {
        var data = card.getAttribute('data-search') || '';
        card.style.display = data.includes(q) ? '' : 'none';
    });
}
</script>

</body>
</html>
