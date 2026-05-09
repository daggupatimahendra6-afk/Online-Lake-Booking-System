<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Confirmed — Vasota Lake Camping</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #e0f7fa, #f0f7f3);
            min-height: 100vh;
            display: flex; align-items: center; justify-content: center;
            padding: 30px 15px;
        }
        .card {
            background: white; border-radius: 16px;
            box-shadow: 0 6px 28px rgba(0,0,0,0.12);
            max-width: 780px; width: 100%; overflow: hidden;
        }
        .card-header {
            text-align: center; padding: 30px 20px; color: white;
        }
        .header-paid    { background: linear-gradient(135deg, #007bff, #00c6ff); }
        .header-pending { background: linear-gradient(135deg, #f39c12, #f1c40f); }
        .card-header .icon { font-size: 52px; }
        .card-header h2   { font-size: 24px; margin-top: 8px; }
        .card-header p    { font-size: 14px; opacity: 0.9; margin-top: 4px; }

        .booking-ref {
            text-align: center; padding: 12px;
            background: #f8f9fa; border-bottom: 1px solid #eee;
            font-size: 14px; color: #666;
        }
        .booking-ref strong { color: #007bff; font-size: 17px; }

        /* Payment status badge */
        .pay-badge {
            display: flex; align-items: center; justify-content: center;
            gap: 8px; padding: 10px 20px;
            margin: 16px 28px 0;
            border-radius: 30px; font-size: 14px; font-weight: bold;
        }
        .badge-paid    { background: #e6f9ee; color: #1a7a3c; border: 1.5px solid #b8f0d0; }
        .badge-pending { background: #fff8e1; color: #b45309; border: 1.5px solid #ffe082; }

        .section { padding: 20px 28px; }
        .section h3 {
            font-size: 14px; color: #333; margin-bottom: 14px;
            border-left: 4px solid #28a745; padding-left: 10px;
            text-transform: uppercase; letter-spacing: 0.5px;
        }
        .detail-grid {
            display: grid; grid-template-columns: 1fr 1fr; gap: 14px;
        }
        .detail-item label {
            display: block; font-size: 11px; text-transform: uppercase;
            color: #999; letter-spacing: 0.5px;
        }
        .detail-item p { font-size: 15px; font-weight: bold; color: #333; margin-top: 3px; }

        .cost-box {
            background: #f9f9f9; border: 1px solid #e0e0e0;
            border-radius: 10px; padding: 16px 20px; margin: 0 28px 16px;
        }
        .cost-row {
            display: flex; justify-content: space-between;
            font-size: 14px; color: #555; margin-bottom: 8px;
        }
        .cost-row.total {
            border-top: 1px dashed #ccc; padding-top: 10px;
            font-size: 18px; font-weight: bold; color: #28a745;
        }

        /* QR for offline payment */
        .payment-section { padding: 0 28px 24px; }
        .payment-section h3 {
            font-size: 16px; color: #333; margin-bottom: 16px;
            border-left: 5px solid #f39c12; padding-left: 12px;
            text-transform: uppercase; letter-spacing: 0.5px;
            font-weight: 700;
        }
        .payment-inner {
            display: flex; align-items: center; gap: 28px;
            background: #fff8f0; border: 2px solid #ffe0b2;
            border-radius: 14px; padding: 24px;
        }
        .qr-code {
            width: 200px; height: 200px; border-radius: 12px;
            border: 4px solid #f39c12; flex-shrink: 0;
            object-fit: cover;
        }
        .payment-text { font-size: 16px; color: #555; line-height: 1.9; }
        .payment-text strong { color: #e65100; font-size: 18px; }
        .payment-text .pay-num {
            font-size: 22px; font-weight: 700; color: #e65100;
            display: block; margin-top: 6px;
        }
        .payment-text .pay-email {
            font-size: 15px; color: #555;
            display: block; margin-top: 4px;
        }

        .online-success {
            background: #e6f9ee; border: 1px solid #b8f0d0;
            border-radius: 10px; padding: 18px 20px;
            margin: 0 28px 20px; text-align: center;
            color: #1a7a3c; font-size: 14px; line-height: 1.7;
        }
        .online-success .big-tick { font-size: 36px; display: block; margin-bottom: 8px; }

        .card-footer {
            padding: 16px 28px 28px; display: flex; gap: 12px;
        }
        .btn {
            flex: 1; padding: 11px; border-radius: 8px; text-align: center;
            font-size: 14px; font-weight: bold; text-decoration: none;
            border: none; cursor: pointer; display: block;
        }
        .btn-primary  { background: #28a745; color: white; }
        .btn-primary:hover  { background: #1e7e34; }
        .btn-outline  { background: white; color: #28a745; border: 2px solid #28a745; }
        .btn-outline:hover  { background: #f0f7f3; }
        .btn-mybookings { background: #007bff; color: white; }
        .btn-mybookings:hover { background: #0056b3; }
    </style>
</head>
<body>
<%
    int    bookingId     = session.getAttribute("bookingId")     != null ? (Integer)session.getAttribute("bookingId")     : 0;
    String guestName     = session.getAttribute("guestName")     != null ? (String) session.getAttribute("guestName")     : "Guest";
    String guestEmail    = session.getAttribute("guestEmail")    != null ? (String) session.getAttribute("guestEmail")    : "";
    long   guestPhone    = session.getAttribute("guestPhone")    != null ? (Long)   session.getAttribute("guestPhone")    : 0L;
    int    noPersons     = session.getAttribute("noPersons")     != null ? (Integer)session.getAttribute("noPersons")     : 0;
    int    noKids        = session.getAttribute("noKids")        != null ? (Integer)session.getAttribute("noKids")        : 0;
    String arrivalDate   = session.getAttribute("arrivalDate")   != null ? (String) session.getAttribute("arrivalDate")   : "";
    String departureDate = session.getAttribute("departureDate") != null ? (String) session.getAttribute("departureDate") : "";
    String tentName      = session.getAttribute("tentName")      != null ? (String) session.getAttribute("tentName")      : "";
    int    tentPrice     = session.getAttribute("tentPrice")     != null ? (Integer)session.getAttribute("tentPrice")     : 0;
    int    totalCost     = session.getAttribute("totalCost")     != null ? (Integer)session.getAttribute("totalCost")     : 0;
    String payMethod     = session.getAttribute("paymentMethod") != null ? (String) session.getAttribute("paymentMethod") : "OFFLINE";
    String payStatus     = session.getAttribute("paymentStatus") != null ? (String) session.getAttribute("paymentStatus") : "PENDING";
    boolean isPaid       = "PAID".equals(payStatus);
    boolean isLoggedIn   = session != null && session.getAttribute("username") != null;

    // Clear flash attributes
    session.removeAttribute("bookingId");
    session.removeAttribute("guestName");
    session.removeAttribute("guestEmail");
    session.removeAttribute("guestPhone");
    session.removeAttribute("noPersons");
    session.removeAttribute("noKids");
    session.removeAttribute("arrivalDate");
    session.removeAttribute("departureDate");
    session.removeAttribute("tentName");
    session.removeAttribute("tentPrice");
    session.removeAttribute("totalCost");
    session.removeAttribute("paymentMethod");
    session.removeAttribute("paymentStatus");
    session.removeAttribute("savedUsername");
%>

<div class="card">

    <!-- Header -->
    <div class="card-header <%= isPaid ? "header-paid" : "header-pending" %>">
        <div class="icon"><%= isPaid ? "✅" : "🏕️" %></div>
        <h2><%= isPaid ? "Payment Successful!" : "Booking Confirmed!" %></h2>
        <p>Thank you, <strong><%= guestName %></strong>.
           <%= isPaid ? "Your payment is received." : "Pay on arrival at the campsite." %></p>
    </div>

    <!-- Booking Ref -->
    <div class="booking-ref">
        Booking Reference: &nbsp;<strong>#<%= bookingId %></strong>
    </div>

    <!-- Payment Badge -->
    <div class="pay-badge <%= isPaid ? "badge-paid" : "badge-pending" %>">
        <%= isPaid ? "💳 PAID — Online Payment" : "⏳ PENDING — Pay on Arrival" %>
    </div>

    <!-- Details -->
    <div class="section">
        <h3>Booking Summary</h3>
        <div class="detail-grid">
            <div class="detail-item"><label>Guest Name</label><p><%= guestName %></p></div>
            <div class="detail-item"><label>Email</label><p><%= guestEmail %></p></div>
            <div class="detail-item"><label>Phone</label><p><%= guestPhone %></p></div>
            <div class="detail-item"><label>Accommodation</label><p><%= tentName %></p></div>
            <div class="detail-item"><label>Arrival</label><p><%= arrivalDate %></p></div>
            <div class="detail-item"><label>Departure</label><p><%= departureDate %></p></div>
            <div class="detail-item"><label>Adults</label><p><%= noPersons %></p></div>
            <div class="detail-item"><label>Kids</label><p><%= noKids %></p></div>
        </div>
    </div>

    <!-- Cost -->
    <div class="cost-box">
        <div class="cost-row"><span>Price/person (<%= tentName %>)</span><span>₹<%= String.format("%,d",tentPrice) %></span></div>
        <div class="cost-row"><span>Adults</span><span>× <%= noPersons %></span></div>
        <% if (noKids > 0) { %><div class="cost-row"><span>Kids</span><span><%= noKids %> (free)</span></div><% } %>
        <div class="cost-row total"><span>Total Amount</span><span>₹<%= String.format("%,d",totalCost) %></span></div>
    </div>

    <!-- Payment section -->
    <% if (isPaid) { %>
    <div class="online-success">
        <span class="big-tick">🎉</span>
        Payment of <strong>₹<%= String.format("%,d",totalCost) %></strong> received successfully!<br>
        A confirmation has been sent to <strong><%= guestEmail %></strong>.
    </div>
    <% } else { %>
    <div class="payment-section">
        <h3>Complete Payment at Camp</h3>
        <div class="payment-inner">
            <img src="./images/paytm_qr.jpeg" alt="Paytm UPI QR" class="qr-code">
            <div class="payment-text">
                Pay <strong>₹<%= String.format("%,d",totalCost) %></strong> via UPI on arrival.<br><br>
                Or send payment screenshot to:<br>
                <span class="pay-num">📱 9579350747</span>
                <span class="pay-email">📧 vasotalakecamping@gmail.com</span>
            </div>
        </div>
    </div>
    <% } %>

    <!-- Footer Buttons -->
    <div class="card-footer">
        <a href="home"     class="btn btn-primary">🏕️ Home</a>
        <% if (isLoggedIn) { %>
        <a href="./MyBookings" class="btn btn-mybookings">📋 My Bookings</a>
        <% } else { %>
        <a href="login"    class="btn btn-mybookings">🔐 Login to Track</a>
        <% } %>
        <a href="book" class="btn btn-outline">📅 New Booking</a>
    </div>

</div>
</body>
</html>


