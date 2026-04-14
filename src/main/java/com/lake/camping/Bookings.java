package com.lake.camping;

import com.lake.util.DBConnection;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import jakarta.mail.*;
import jakarta.mail.internet.*;
import java.io.IOException;
import java.sql.*;
import java.time.LocalDate;
import java.util.Properties;
import java.util.regex.Pattern;

@WebServlet("/Bookings")
public class Bookings extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // ── Email regex ────────────────────────────────────────────────────────────
    private static final Pattern EMAIL_PATTERN =
        Pattern.compile("^[\\w.+\\-]+@[a-zA-Z0-9.\\-]+\\.[a-zA-Z]{2,}$");

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");

        // ── Read form fields ────────────────────────────────────────────────
        String name          = getParam(request, "uname",         "Guest");
        String email         = getParam(request, "email",         "");
        String phoneStr      = getParam(request, "phoneNo",       "0");
        String personsStr    = getParam(request, "NoPersons",     "1");
        String kidsStr       = getParam(request, "NoKids",        "0");
        String arrivalStr    = getParam(request, "arrivals",      "");
        String departureStr  = getParam(request, "departure",     "");
        String tentStr       = getParam(request, "tent",          "101");
        String paymentChoice = getParam(request, "paymentMethod", "OFFLINE");
        String formUsername  = getParam(request, "username",      "");
        String formPassword  = getParam(request, "password",      "");

        // ── Server-side validation (Item 6) ────────────────────────────────
        StringBuilder errors = new StringBuilder();

        if (!EMAIL_PATTERN.matcher(email).matches()) {
            errors.append("• Invalid email address format.<br>");
        }

        String digitsOnly = phoneStr.replaceAll("[^0-9]", "");
        if (digitsOnly.length() != 10) {
            errors.append("• Phone number must be exactly 10 digits.<br>");
        }

        int noPersons = 1;
        try { noPersons = Integer.parseInt(personsStr); } catch (Exception ignored) {}
        if (noPersons < 1) {
            errors.append("• Number of persons must be at least 1.<br>");
        }

        LocalDate today    = LocalDate.now();
        LocalDate arrival  = null;
        LocalDate departure = null;

        if (arrivalStr.isEmpty() || departureStr.isEmpty()) {
            errors.append("• Please select both arrival and departure dates.<br>");
        } else {
            try {
                arrival  = LocalDate.parse(arrivalStr);
                departure = LocalDate.parse(departureStr);

                if (arrival.isBefore(today)) {
                    errors.append("• Arrival date cannot be in the past.<br>");
                }
                if (!departure.isAfter(arrival)) {
                    errors.append("• Departure date must be after arrival date.<br>");
                }
            } catch (Exception e) {
                errors.append("• Invalid date format.<br>");
            }
        }

        if (errors.length() > 0) {
            request.setAttribute("error", errors.toString());
            request.getRequestDispatcher("Bookings.jsp").forward(request, response);
            return;
        }

        // ── Parse safe values ───────────────────────────────────────────────
        String paymentMethod = "ONLINE".equals(paymentChoice) ? "ONLINE"  : "OFFLINE";
        String paymentStatus = "ONLINE".equals(paymentChoice) ? "PAID"    : "PENDING";
        boolean isPaid       = "PAID".equals(paymentStatus);

        long phone    = Long.parseLong(digitsOnly);
        int  noKids   = 0;
        int  tentType = 101;
        try { noKids   = Integer.parseInt(kidsStr); }  catch (Exception ignored) {}
        try { tentType = Integer.parseInt(tentStr); }  catch (Exception ignored) {}

        int    bookingId  = 0;
        int    totalCost  = 0;
        int    tentPrice  = 0;
        String tentName   = "";
        String bookingRef = "";

        try {
            Date sqlArrival   = Date.valueOf(arrivalStr);
            Date sqlDeparture = Date.valueOf(departureStr);

            try (Connection con = DBConnection.getConnection()) {

                // STEP 1: Save user account if credentials provided
                if (!formUsername.isEmpty() && !formPassword.isEmpty()) {
                    boolean userExists = false;
                    try (PreparedStatement chk = con.prepareStatement(
                            "SELECT user_id FROM users WHERE username = ?")) {
                        chk.setString(1, formUsername);
                        userExists = chk.executeQuery().next();
                    }
                    if (!userExists) {
                        try (PreparedStatement ins = con.prepareStatement(
                                "INSERT INTO users (username, password, email, full_name, role) " +
                                "VALUES (?, crypt(?, gen_salt('bf')), ?, ?, 'user')")) {
                            ins.setString(1, formUsername);
                            ins.setString(2, formPassword);
                            ins.setString(3, email);
                            ins.setString(4, name);
                            ins.executeUpdate();
                        }
                    }
                }

                // STEP 2: Insert booking
                String insertSQL =
                    "INSERT INTO bookings " +
                    "  (name, email, phone, no_of_persons, no_of_kids, " +
                    "   arrival_date, departure_date, tent_id, " +
                    "   username, payment_method, payment_status) " +
                    "VALUES (?,?,?,?,?,?,?,?,?,?,?) " +
                    "RETURNING id, total_cost, booking_ref";

                try (PreparedStatement ps = con.prepareStatement(insertSQL)) {
                    ps.setString(1, name);
                    ps.setString(2, email);
                    ps.setLong(3,   phone);
                    ps.setShort(4,  (short) noPersons);
                    ps.setShort(5,  (short) noKids);
                    ps.setDate(6,   sqlArrival);
                    ps.setDate(7,   sqlDeparture);
                    ps.setInt(8,    tentType);
                    ps.setString(9, formUsername.isEmpty() ? null : formUsername);
                    ps.setString(10, paymentMethod);
                    ps.setString(11, paymentStatus);

                    ResultSet rs = ps.executeQuery();
                    if (rs.next()) {
                        bookingId  = rs.getInt("id");
                        totalCost  = rs.getInt("total_cost");
                        bookingRef = rs.getString("booking_ref");
                        if (bookingRef == null) bookingRef = "BK" + bookingId;
                    }
                }

                // STEP 3: Fetch tent info
                try (PreparedStatement ps2 = con.prepareStatement(
                        "SELECT tent_name, tent_price FROM tents WHERE tent_id = ?")) {
                    ps2.setInt(1, tentType);
                    ResultSet rs2 = ps2.executeQuery();
                    if (rs2.next()) {
                        tentName  = rs2.getString("tent_name");
                        tentPrice = rs2.getInt("tent_price");
                    }
                }

                // STEP 4: Mark paid_at if online payment
                if (isPaid && bookingId > 0) {
                    try (PreparedStatement ps3 = con.prepareStatement(
                            "UPDATE bookings SET paid_at = NOW() WHERE id = ?")) {
                        ps3.setInt(1, bookingId);
                        ps3.executeUpdate();
                    }
                }
            }

            // STEP 5: Auto-login after booking
            if (!formUsername.isEmpty()) {
                HttpSession session = request.getSession(true);
                session.setAttribute("username", formUsername);
                session.setAttribute("fullName", name);
                session.setAttribute("role",     "user");
            }

            // STEP 6: Send confirmation email (Item 5)
            try {
                sendConfirmationEmail(email, name, bookingRef, tentName,
                                      arrivalStr, departureStr, totalCost, paymentStatus);
            } catch (Exception mailEx) {
                // Don't fail the booking because of email issues — just log
                System.err.println("[Email] Failed to send confirmation: " + mailEx.getMessage());
            }

        } catch (IllegalArgumentException ex) {
            request.setAttribute("error", ex.getMessage());
            request.getRequestDispatcher("Bookings.jsp").forward(request, response);
            return;

        } catch (SQLException sqlEx) {
            sqlEx.printStackTrace();
            String msg = sqlEx.getMessage();
            if (msg.contains("phone_check"))
                msg = "Phone number must be exactly 10 digits.";
            else if (msg.contains("chk_dates"))
                msg = "Departure date must be after arrival date.";
            else if (msg.contains("booking_ref"))
                msg = "Booking ref error. Please run fix_booking_ref.sql in psql.";
            request.setAttribute("error", "Booking failed: " + msg);
            request.getRequestDispatcher("Bookings.jsp").forward(request, response);
            return;

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Unexpected error: " + e.getMessage());
            request.getRequestDispatcher("Bookings.jsp").forward(request, response);
            return;
        }

        // ── Forward to Thank-you page ───────────────────────────────────────
        request.setAttribute("bookingId",     bookingId);
        request.setAttribute("bookingRef",    bookingRef);
        request.setAttribute("guestName",     name);
        request.setAttribute("guestEmail",    email);
        request.setAttribute("guestPhone",    phone);
        request.setAttribute("noPersons",     noPersons);
        request.setAttribute("noKids",        noKids);
        request.setAttribute("arrivalDate",   arrivalStr);
        request.setAttribute("departureDate", departureStr);
        request.setAttribute("tentName",      tentName);
        request.setAttribute("tentPrice",     tentPrice);
        request.setAttribute("totalCost",     totalCost);
        request.setAttribute("paymentMethod", paymentMethod);
        request.setAttribute("paymentStatus", paymentStatus);
        request.setAttribute("savedUsername", formUsername);

        request.getRequestDispatcher("Thankyou.jsp").forward(request, response);
    }

    // ── Send HTML confirmation email (Item 5) ───────────────────────────────
    private void sendConfirmationEmail(String toEmail, String guestName,
                                       String bookingRef, String tentName,
                                       String arrival, String departure,
                                       int totalCost, String paymentStatus)
            throws MessagingException {

        String smtpHost = getEnv("SMTP_HOST", "smtp.gmail.com");
        String smtpPort = getEnv("SMTP_PORT", "587");
        String smtpUser = getEnv("SMTP_USER", "");
        String smtpPwd  = getEnv("SMTP_PWD",  "");

        if (smtpUser.isEmpty() || smtpPwd.isEmpty()) {
            System.out.println("[Email] SMTP_USER/SMTP_PWD not set — skipping email.");
            return;
        }

        Properties props = new Properties();
        props.put("mail.smtp.auth",            "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host",            smtpHost);
        props.put("mail.smtp.port",            smtpPort);

        Session mailSession = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(smtpUser, smtpPwd);
            }
        });

        String htmlBody =
            "<html><body style='font-family:Arial,sans-serif;color:#333;'>" +
            "<div style='max-width:560px;margin:0 auto;border:1px solid #e0e0e0;border-radius:10px;overflow:hidden;'>" +
            "<div style='background:linear-gradient(135deg,#1a3a6b,#007bff);padding:28px 32px;color:#fff;'>" +
            "<h2 style='margin:0;'>🏕️ Booking Confirmed!</h2>" +
            "<p style='margin:6px 0 0;opacity:.85;'>Vasota Lake Camping</p>" +
            "</div>" +
            "<div style='padding:28px 32px;'>" +
            "<p>Hi <strong>" + guestName + "</strong>,</p>" +
            "<p>Your booking is confirmed! Here are your details:</p>" +
            "<table style='width:100%;border-collapse:collapse;margin-top:16px;'>" +
            "<tr style='background:#f7f9fc;'><td style='padding:10px 14px;font-weight:bold;'>Booking Ref</td><td style='padding:10px 14px;'><strong>" + bookingRef + "</strong></td></tr>" +
            "<tr><td style='padding:10px 14px;font-weight:bold;'>Tent / Accommodation</td><td style='padding:10px 14px;'>" + tentName + "</td></tr>" +
            "<tr style='background:#f7f9fc;'><td style='padding:10px 14px;font-weight:bold;'>Arrival Date</td><td style='padding:10px 14px;'>" + arrival + "</td></tr>" +
            "<tr><td style='padding:10px 14px;font-weight:bold;'>Departure Date</td><td style='padding:10px 14px;'>" + departure + "</td></tr>" +
            "<tr style='background:#f7f9fc;'><td style='padding:10px 14px;font-weight:bold;'>Total Cost</td><td style='padding:10px 14px;'><strong>₹" + String.format("%,d", totalCost) + "</strong></td></tr>" +
            "<tr><td style='padding:10px 14px;font-weight:bold;'>Payment Status</td><td style='padding:10px 14px;'>" +
            ("PAID".equals(paymentStatus) ? "<span style='color:#1a7a3c;font-weight:bold;'>✅ PAID</span>" : "<span style='color:#b45309;font-weight:bold;'>⏳ Pay on Arrival</span>") +
            "</td></tr>" +
            "</table>" +
            "<p style='margin-top:20px;'>We look forward to welcoming you to Vasota Lake! 🌿</p>" +
            "<p style='color:#888;font-size:12px;margin-top:24px;'>If you have questions, reply to this email or contact us at the campsite.</p>" +
            "</div></div></body></html>";

        Message message = new MimeMessage(mailSession);
        message.setFrom(new InternetAddress(smtpUser, "Vasota Lake Camping"));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
        message.setSubject("Booking Confirmed — " + bookingRef + " | Vasota Lake Camping");
        message.setContent(htmlBody, "text/html; charset=UTF-8");
        Transport.send(message);

        System.out.println("[Email] Confirmation sent to " + toEmail);
    }

    private String getParam(HttpServletRequest req, String name, String def) {
        String v = req.getParameter(name);
        return (v != null && !v.trim().isEmpty()) ? v.trim() : def;
    }

    private static String getEnv(String key, String defaultValue) {
        String v = System.getenv(key);
        return (v != null && !v.isBlank()) ? v : defaultValue;
    }
}