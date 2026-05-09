<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ include file="AdminHeader.jsp" %>
<%
    String _role = (session != null) ? (String) session.getAttribute("role") : null;
    if (!"admin".equals(_role)) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
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
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }

        body {
            font-family: 'Inter', Arial, sans-serif;
            background: #0f1923;
            padding-top: 70px;
            min-height: 100vh;
        }

        .page { padding: 28px 30px; }

        /* ── Welcome Bar ── */
        .welcome-bar {
            background: linear-gradient(135deg, #1a1f4e 0%, #1e3a8a 40%, #0369a1 100%);
            color: white;
            border-radius: 20px;
            padding: 26px 32px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 28px;
            box-shadow: 0 8px 32px rgba(3,105,161,0.35);
            position: relative;
            overflow: hidden;
            border: 1px solid rgba(255,255,255,0.08);
        }
        .welcome-bar::before {
            content: '🏕️';
            position: absolute;
            right: 200px; top: 50%;
            transform: translateY(-50%);
            font-size: 90px;
            opacity: 0.06;
        }
        .welcome-bar::after {
            content: '';
            position: absolute;
            top: -40px; right: -40px;
            width: 160px; height: 160px;
            background: radial-gradient(circle, rgba(255,255,255,0.06), transparent 70%);
            border-radius: 50%;
        }
        .welcome-bar h2 { font-size: 22px; font-weight: 800; letter-spacing: -0.3px; }
        .welcome-bar p  { font-size: 13px; opacity: 0.75; margin-top: 5px; }
        .date-badge {
            background: rgba(255,255,255,0.12);
            backdrop-filter: blur(8px);
            border: 1px solid rgba(255,255,255,0.15);
            padding: 10px 22px;
            border-radius: 30px;
            font-size: 13px;
            font-weight: 600;
            letter-spacing: 0.3px;
        }

        /* ── Stats Grid ── */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(6, 1fr);
            gap: 16px;
            margin-bottom: 24px;
        }
        .stat-card {
            background: #1a2332;
            border-radius: 16px;
            padding: 20px 18px;
            border: 1px solid rgba(255,255,255,0.06);
            display: flex;
            flex-direction: column;
            gap: 10px;
            transition: transform 0.25s, box-shadow 0.25s;
            position: relative;
            overflow: hidden;
        }
        .stat-card::before {
            content: '';
            position: absolute;
            top: 0; left: 0; right: 0;
            height: 3px;
            border-radius: 16px 16px 0 0;
        }
        .sc-blue::before   { background: linear-gradient(90deg,#3b82f6,#60a5fa); }
        .sc-green::before  { background: linear-gradient(90deg,#10b981,#34d399); }
        .sc-purple::before { background: linear-gradient(90deg,#8b5cf6,#a78bfa); }
        .sc-orange::before { background: linear-gradient(90deg,#f59e0b,#fbbf24); }
        .sc-teal::before   { background: linear-gradient(90deg,#06b6d4,#22d3ee); }
        .sc-red::before    { background: linear-gradient(90deg,#ef4444,#f87171); }

        .stat-card:hover { transform: translateY(-4px); box-shadow: 0 12px 32px rgba(0,0,0,0.3); }
        .stat-icon {
            width: 46px; height: 46px;
            border-radius: 12px;
            display: flex; align-items: center; justify-content: center;
            font-size: 22px; flex-shrink: 0;
        }
        .ic-blue   { background: rgba(59,130,246,0.15); }
        .ic-green  { background: rgba(16,185,129,0.15); }
        .ic-purple { background: rgba(139,92,246,0.15); }
        .ic-orange { background: rgba(245,158,11,0.15); }
        .ic-teal   { background: rgba(6,182,212,0.15); }
        .ic-red    { background: rgba(239,68,68,0.15); }

        .stat-info label {
            font-size: 10px; color: rgba(255,255,255,0.4);
            text-transform: uppercase; letter-spacing: 0.8px; font-weight: 600;
        }
        .stat-info .val {
            font-size: 26px; font-weight: 800; color: #fff;
            margin-top: 2px; letter-spacing: -0.5px;
        }
        .stat-info .sub { font-size: 11px; color: rgba(255,255,255,0.3); margin-top: 2px; }

        /* ── Bottom Row ── */
        .bottom-row {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 20px;
        }

        /* ── Panel ── */
        .panel {
            background: #1a2332;
            border-radius: 18px;
            border: 1px solid rgba(255,255,255,0.06);
            overflow: hidden;
            box-shadow: 0 4px 20px rgba(0,0,0,0.2);
        }
        .panel-head {
            padding: 18px 24px;
            background: rgba(255,255,255,0.03);
            border-bottom: 1px solid rgba(255,255,255,0.06);
            display: flex; align-items: center; justify-content: space-between;
        }
        .panel-head h4 { font-size: 15px; color: rgba(255,255,255,0.85); font-weight: 700; }
        .panel-head a  { font-size: 13px; color: #60a5fa; text-decoration: none; font-weight: 600; }
        .panel-head a:hover { color: #93c5fd; }

        /* ── Table ── */
        table { width: 100%; border-collapse: collapse; }
        thead th {
            background: rgba(255,255,255,0.04);
            padding: 12px 16px;
            font-size: 11px; text-transform: uppercase;
            color: rgba(255,255,255,0.35); letter-spacing: 0.7px;
            text-align: left; font-weight: 600;
            border-bottom: 1px solid rgba(255,255,255,0.06);
        }
        tbody tr { border-bottom: 1px solid rgba(255,255,255,0.04); transition: background 0.15s; }
        tbody tr:hover { background: rgba(255,255,255,0.04); }
        tbody td { padding: 12px 16px; font-size: 13px; color: rgba(255,255,255,0.7); }
        tbody td strong { color: rgba(255,255,255,0.9); }

        .badge {
            display: inline-block; padding: 4px 11px;
            border-radius: 20px; font-size: 11px; font-weight: 700;
        }
        .b-confirmed { background: rgba(16,185,129,0.15); color: #34d399; }
        .b-cancelled { background: rgba(239,68,68,0.15);  color: #f87171; }
        .b-completed { background: rgba(99,102,241,0.15); color: #a5b4fc; }

        /* ── Quick Actions ── */
        .quick-actions { padding: 18px; display: flex; flex-direction: column; gap: 12px; }
        .qa-btn {
            display: flex; align-items: center; gap: 14px;
            padding: 14px 18px; border-radius: 12px; text-decoration: none;
            font-size: 14px; font-weight: 700;
            transition: transform 0.2s, box-shadow 0.2s;
            border: 1px solid transparent;
        }
        .qa-btn:hover { transform: translateX(5px); }
        .qa-btn .qa-icon {
            width: 38px; height: 38px; border-radius: 10px;
            display: flex; align-items: center; justify-content: center;
            font-size: 18px; flex-shrink: 0;
        }
        .qa-blue   { background: rgba(59,130,246,0.1);  color: #60a5fa;  border-color: rgba(59,130,246,0.15); }
        .qa-blue   .qa-icon { background: rgba(59,130,246,0.2); }
        .qa-green  { background: rgba(16,185,129,0.1);  color: #34d399;  border-color: rgba(16,185,129,0.15); }
        .qa-green  .qa-icon { background: rgba(16,185,129,0.2); }
        .qa-orange { background: rgba(245,158,11,0.1);  color: #fbbf24;  border-color: rgba(245,158,11,0.15); }
        .qa-orange .qa-icon { background: rgba(245,158,11,0.2); }
        .qa-red    { background: rgba(239,68,68,0.1);   color: #f87171;  border-color: rgba(239,68,68,0.15);  }
        .qa-red    .qa-icon { background: rgba(239,68,68,0.2); }

        @media (max-width: 1100px) { .stats-grid { grid-template-columns: repeat(3,1fr); } }
        @media (max-width: 900px)  { .stats-grid { grid-template-columns: 1fr 1fr; } .bottom-row { grid-template-columns: 1fr; } }
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
        <div class="stat-card sc-blue">
            <div class="stat-icon ic-blue">📋</div>
            <div class="stat-info">
                <label>Total Bookings</label>
                <div class="val"><%= totalBookings %></div>
                <div class="sub">All time</div>
            </div>
        </div>
        <div class="stat-card sc-green">
            <div class="stat-icon ic-green">💰</div>
            <div class="stat-info">
                <label>Revenue</label>
                <div class="val">₹<%= String.format("%,d", totalRevenue) %></div>
                <div class="sub">Confirmed bookings</div>
            </div>
        </div>
        <div class="stat-card sc-purple">
            <div class="stat-icon ic-purple">👥</div>
            <div class="stat-info">
                <label>Users</label>
                <div class="val"><%= totalUsers %></div>
                <div class="sub">Registered</div>
            </div>
        </div>
        <div class="stat-card sc-orange">
            <div class="stat-icon ic-orange">✉️</div>
            <div class="stat-info">
                <label>Enquiries</label>
                <div class="val"><%= totalEnquiries %></div>
                <div class="sub">Contact messages</div>
            </div>
        </div>
        <div class="stat-card sc-teal">
            <div class="stat-icon ic-teal">✅</div>
            <div class="stat-info">
                <label>Confirmed</label>
                <div class="val"><%= confirmed %></div>
                <div class="sub">Active bookings</div>
            </div>
        </div>
        <div class="stat-card sc-red">
            <div class="stat-icon ic-red">❌</div>
            <div class="stat-info">
                <label>Cancelled</label>
                <div class="val"><%= cancelled %></div>
                <div class="sub">Cancelled</div>
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
                    <tr><td colspan="7" style="text-align:center;padding:36px;color:rgba(255,255,255,0.25);">No bookings yet</td></tr>
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
                <a href="./offers" class="qa-btn qa-orange">
                    <div class="qa-icon">🏷️</div>
                    Manage Offers
                </a>
                <a href="./logout" class="qa-btn qa-red">
                    <div class="qa-icon">🚪</div>
                    Logout
                </a>
            </div>
        </div>

    </div>
</div>

</body>
</html>