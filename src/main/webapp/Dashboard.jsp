<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ include file="AdminHeader.jsp" %>
<%
    /* ── Admin session guard (belt-and-suspenders; AuthFilter is primary) ── */
    String _role = (session != null) ? (String) session.getAttribute("role") : null;
    if (!"admin".equals(_role)) {
        response.sendRedirect(request.getContextPath() + "/Login.jsp");
        return;
    }

    /* ── Read request attributes set by Dashboard.java servlet ───────────── */
    int totalBookings  = (request.getAttribute("totalBookings")  != null) ? (Integer)request.getAttribute("totalBookings")  : 0;
    int totalUsers     = (request.getAttribute("totalUsers")     != null) ? (Integer)request.getAttribute("totalUsers")     : 0;
    int totalEnquiries = (request.getAttribute("totalEnquiries") != null) ? (Integer)request.getAttribute("totalEnquiries") : 0;
    int totalRevenue   = (request.getAttribute("totalRevenue")   != null) ? (Integer)request.getAttribute("totalRevenue")   : 0;
    int confirmed      = (request.getAttribute("confirmed")      != null) ? (Integer)request.getAttribute("confirmed")      : 0;
    int cancelled      = (request.getAttribute("cancelled")      != null) ? (Integer)request.getAttribute("cancelled")      : 0;
    String today       = (String) request.getAttribute("today");
    if (today == null) today = new java.util.Date().toString().substring(0, 10);

    @SuppressWarnings("unchecked")
    List<String[]> recent = (List<String[]>) request.getAttribute("recent");
    if (recent == null) recent = new java.util.ArrayList<>();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard — Vasota Lake Camping</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }

        body {
            font-family: Arial, sans-serif;
            background: #f0f2f5;
            padding-top: 70px;
        }

        .page { padding: 28px 32px; }

        /* ── Welcome bar ── */
        .welcome-bar {
            background: linear-gradient(135deg, #1a3a6b, #007bff);
            color: white;
            border-radius: 14px;
            padding: 24px 28px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 28px;
            box-shadow: 0 4px 16px rgba(0,123,255,0.25);
        }
        .welcome-bar h2 { font-size: 22px; }
        .welcome-bar p  { font-size: 13px; opacity: 0.85; margin-top: 4px; }
        .welcome-bar .date-badge {
            background: rgba(255,255,255,0.18);
            padding: 8px 18px;
            border-radius: 30px;
            font-size: 13px;
        }

        /* ── Stat cards ── */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 18px;
            margin-bottom: 28px;
        }
        .stat-card {
            background: white;
            border-radius: 14px;
            padding: 22px 20px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.07);
            display: flex;
            align-items: center;
            gap: 16px;
            transition: transform 0.2s;
        }
        .stat-card:hover { transform: translateY(-3px); }
        .stat-icon {
            width: 58px; height: 58px;
            border-radius: 14px;
            display: flex; align-items: center; justify-content: center;
            font-size: 26px; flex-shrink: 0;
        }
        .ic-blue   { background: #e8f0fe; }
        .ic-green  { background: #e6f9ee; }
        .ic-orange { background: #fff4e5; }
        .ic-purple { background: #f3eeff; }
        .ic-teal   { background: #e0f7fa; }
        .ic-red    { background: #fdecea; }

        .stat-info label {
            font-size: 12px; color: #999;
            text-transform: uppercase; letter-spacing: 0.5px;
        }
        .stat-info .val {
            font-size: 28px; font-weight: bold; color: #222;
            margin-top: 2px;
        }
        .stat-info .sub {
            font-size: 12px; color: #aaa; margin-top: 2px;
        }

        /* ── Bottom row ── */
        .bottom-row {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 20px;
        }

        /* ── Panel ── */
        .panel {
            background: white;
            border-radius: 14px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.07);
            overflow: hidden;
        }
        .panel-head {
            padding: 16px 22px;
            border-bottom: 1px solid #f0f0f0;
            display: flex; align-items: center; justify-content: space-between;
        }
        .panel-head h4 { font-size: 15px; color: #333; }
        .panel-head a  { font-size: 13px; color: #007bff; text-decoration: none; }
        .panel-head a:hover { text-decoration: underline; }

        /* ── Recent bookings table ── */
        table { width: 100%; border-collapse: collapse; }
        thead th {
            background: #f8f9fa;
            padding: 11px 14px;
            font-size: 12px;
            text-transform: uppercase;
            color: #888;
            text-align: left;
            border-bottom: 2px solid #eee;
        }
        tbody tr { border-bottom: 1px solid #f5f5f5; }
        tbody tr:hover { background: #fafcff; }
        tbody td { padding: 11px 14px; font-size: 13px; color: #444; }

        .badge {
            display: inline-block;
            padding: 3px 10px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: bold;
        }
        .b-confirmed { background: #e6f9ee; color: #1a7a3c; }
        .b-cancelled { background: #fdecea; color: #c0392b; }
        .b-completed { background: #e8f0fe; color: #1a56db; }

        /* ── Quick Actions ── */
        .quick-actions { padding: 20px; display: flex; flex-direction: column; gap: 12px; }
        .qa-btn {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 14px 16px;
            border-radius: 10px;
            text-decoration: none;
            font-size: 14px;
            font-weight: bold;
            transition: opacity 0.2s, transform 0.15s;
        }
        .qa-btn:hover { opacity: 0.88; transform: translateX(3px); }
        .qa-btn .qa-icon {
            width: 36px; height: 36px;
            border-radius: 8px;
            display: flex; align-items: center; justify-content: center;
            font-size: 18px; flex-shrink: 0;
        }
        .qa-blue   { background: #e8f0fe; color: #1a56db; }
        .qa-blue   .qa-icon { background: #c7d9fb; }
        .qa-green  { background: #e6f9ee; color: #1a7a3c; }
        .qa-green  .qa-icon { background: #b8f0d0; }
        .qa-orange { background: #fff4e5; color: #b45309; }
        .qa-orange .qa-icon { background: #fde9c0; }
        .qa-red    { background: #fdecea; color: #c0392b; }
        .qa-red    .qa-icon { background: #fbc9c5; }

        @media (max-width: 900px) {
            .stats-grid { grid-template-columns: 1fr 1fr; }
            .bottom-row { grid-template-columns: 1fr; }
        }
    </style>
</head>
<body>

<div class="page">

    <!-- Welcome Bar -->
    <div class="welcome-bar">
        <div>
            <h2>🏕️ Welcome back, Admin!</h2>
            <p>Here's what's happening at Vasota Lake Camping today.</p>
        </div>
        <div class="date-badge">📅 <%= today %></div>
    </div>

    <!-- Stat Cards -->
    <div class="stats-grid">
        <div class="stat-card">
            <div class="stat-icon ic-blue">📋</div>
            <div class="stat-info">
                <label>Total Bookings</label>
                <div class="val"><%= totalBookings %></div>
                <div class="sub">All time</div>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon ic-green">💰</div>
            <div class="stat-info">
                <label>Total Revenue</label>
                <div class="val">₹<%= String.format("%,d", totalRevenue) %></div>
                <div class="sub">Confirmed bookings</div>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon ic-purple">👥</div>
            <div class="stat-info">
                <label>Registered Users</label>
                <div class="val"><%= totalUsers %></div>
                <div class="sub">Total signups</div>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon ic-orange">✉️</div>
            <div class="stat-info">
                <label>Enquiries</label>
                <div class="val"><%= totalEnquiries %></div>
                <div class="sub">Contact messages</div>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon ic-teal">✅</div>
            <div class="stat-info">
                <label>Confirmed</label>
                <div class="val"><%= confirmed %></div>
                <div class="sub">Active bookings</div>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon ic-red">❌</div>
            <div class="stat-info">
                <label>Cancelled</label>
                <div class="val"><%= cancelled %></div>
                <div class="sub">Cancelled bookings</div>
            </div>
        </div>
    </div>

    <!-- Bottom Row -->
    <div class="bottom-row">

        <!-- Recent Bookings Table -->
        <div class="panel">
            <div class="panel-head">
                <h4>📋 Recent Bookings</h4>
                <a href="./DisplayBooking">View All →</a>
            </div>
            <table>
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Guest</th>
                        <th>Arrival</th>
                        <th>Departure</th>
                        <th>Tent</th>
                        <th>Amount</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    if (recent.isEmpty()) {
                %>
                    <tr><td colspan="7" style="text-align:center;padding:30px;color:#aaa;">No bookings yet</td></tr>
                <%
                    } else {
                        for (String[] row : recent) {
                            String badgeClass = "b-confirmed";
                            if ("cancelled".equals(row[6])) badgeClass = "b-cancelled";
                            if ("completed".equals(row[6])) badgeClass = "b-completed";
                %>
                    <tr>
                        <td><strong>#<%= row[0] %></strong></td>
                        <td><%= row[1] %></td>
                        <td><%= row[2] %></td>
                        <td><%= row[3] %></td>
                        <td><%= row[4] %></td>
                        <td><strong>₹<%= String.format("%,d", Integer.parseInt(row[5])) %></strong></td>
                        <td><span class="badge <%= badgeClass %>"><%= row[6] %></span></td>
                    </tr>
                <%
                        }
                    }
                %>
                </tbody>
            </table>
        </div>

        <!-- Quick Actions -->
        <div class="panel">
            <div class="panel-head">
                <h4>⚡ Quick Actions</h4>
            </div>
            <div class="quick-actions">
                <a href="./DisplayBooking" class="qa-btn qa-blue">
                    <div class="qa-icon">📋</div>
                    View All Bookings
                </a>
                <a href="./DisplayContact" class="qa-btn qa-green">
                    <div class="qa-icon">✉️</div>
                    View Enquiries
                </a>
                <a href="./Offers.jsp" class="qa-btn qa-orange">
                    <div class="qa-icon">🏷️</div>
                    Manage Offers
                </a>
                <a href="./Logout.jsp" class="qa-btn qa-red">
                    <div class="qa-icon">🚪</div>
                    Logout
                </a>
            </div>
        </div>

    </div>
</div>

</body>
</html>