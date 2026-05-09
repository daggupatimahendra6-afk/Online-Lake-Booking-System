<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us — Vasota Lake Camping</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }

        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(160deg, #f0f7f3 0%, #e8f5e9 40%, #f5f9ff 100%);
            min-height: 100vh;
            color: #1a1a2e;
        }

        /* ── PAGE HERO ── */
        .page-hero {
            background: linear-gradient(135deg, #0d2a4e 0%, #1a3a2a 50%, #28a745 100%);
            text-align: center;
            padding: 72px 20px 56px;
            position: relative;
            overflow: hidden;
        }
        .page-hero::before {
            content: '';
            position: absolute;
            inset: 0;
            background: url("data:image/svg+xml,%3Csvg width='60' height='60' viewBox='0 0 60 60' xmlns='http://www.w3.org/2000/svg'%3E%3Cg fill='none' fill-rule='evenodd'%3E%3Cg fill='%23ffffff' fill-opacity='0.04'%3E%3Ccircle cx='30' cy='30' r='4'/%3E%3C/g%3E%3C/g%3E%3C/svg%3E");
        }
        .page-hero-badge {
            display: inline-block;
            background: rgba(255,255,255,0.15);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255,255,255,0.25);
            color: #fff;
            font-size: 12px;
            font-weight: 700;
            letter-spacing: 2px;
            text-transform: uppercase;
            padding: 7px 18px;
            border-radius: 30px;
            margin-bottom: 18px;
        }
        .page-hero h1 {
            font-size: clamp(26px, 5vw, 44px);
            font-weight: 800;
            color: #fff;
            text-shadow: 0 2px 20px rgba(0,0,0,0.3);
            margin-bottom: 12px;
        }
        .page-hero p {
            font-size: 16px;
            color: rgba(255,255,255,0.82);
            max-width: 480px;
            margin: 0 auto;
            line-height: 1.7;
        }
        .hero-wave {
            position: absolute;
            bottom: -1px;
            left: 0; right: 0;
            height: 60px;
        }

        /* ── MAIN LAYOUT ── */
        .main-wrap {
            max-width: 1100px;
            margin: 0 auto;
            padding: 60px 20px 80px;
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 40px;
            align-items: start;
        }

        /* ── CONTACT FORM ── */
        .form-card {
            background: #fff;
            border-radius: 24px;
            box-shadow: 0 8px 32px rgba(0,0,0,0.09);
            padding: 40px 36px;
        }
        .form-card h2 {
            font-size: 22px;
            font-weight: 800;
            color: #1a3a2a;
            margin-bottom: 6px;
        }
        .form-card .sub {
            font-size: 13px;
            color: #888;
            margin-bottom: 28px;
        }
        .form-group {
            margin-bottom: 18px;
        }
        .form-group label {
            display: block;
            font-size: 13px;
            font-weight: 700;
            color: #444;
            margin-bottom: 7px;
        }
        .form-group input,
        .form-group textarea {
            width: 100%;
            padding: 12px 15px;
            border: 1.5px solid #e0e0e0;
            border-radius: 10px;
            font-size: 14px;
            font-family: 'Inter', sans-serif;
            color: #333;
            transition: border-color 0.2s, box-shadow 0.2s;
            outline: none;
        }
        .form-group input:focus,
        .form-group textarea:focus {
            border-color: #28a745;
            box-shadow: 0 0 0 3px rgba(40,167,69,0.12);
        }
        .form-group textarea {
            resize: vertical;
            min-height: 120px;
        }
        .btn-send {
            width: 100%;
            padding: 14px;
            background: linear-gradient(135deg, #1a3a2a, #28a745);
            color: #fff;
            border: none;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 700;
            font-family: 'Inter', sans-serif;
            cursor: pointer;
            transition: all 0.25s;
            box-shadow: 0 4px 14px rgba(40,167,69,0.3);
            margin-top: 4px;
        }
        .btn-send:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 24px rgba(40,167,69,0.4);
        }
        .success-msg {
            color: #1a7a3c;
            font-size: 13px;
            font-weight: 600;
            text-align: center;
            margin-top: 12px;
            min-height: 20px;
        }

        /* ── INFO SIDE ── */
        .info-col {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        /* Info card */
        .info-card {
            background: #fff;
            border-radius: 20px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.07);
            padding: 28px;
        }
        .info-card h3 {
            font-size: 17px;
            font-weight: 800;
            color: #1a3a2a;
            margin-bottom: 18px;
        }
        .info-item {
            display: flex;
            align-items: flex-start;
            gap: 14px;
            margin-bottom: 16px;
        }
        .info-item:last-child { margin-bottom: 0; }
        .info-icon {
            width: 44px;
            height: 44px;
            border-radius: 12px;
            background: linear-gradient(135deg, #e6f9ee, #c8edd6);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
            flex-shrink: 0;
        }
        .info-text label {
            font-size: 11px;
            font-weight: 700;
            color: #aaa;
            text-transform: uppercase;
            letter-spacing: 0.8px;
            display: block;
            margin-bottom: 3px;
        }
        .info-text span {
            font-size: 14px;
            font-weight: 600;
            color: #333;
        }

        /* Hours card */
        .hours-list {
            list-style: none;
            padding: 0;
        }
        .hours-list li {
            display: flex;
            justify-content: space-between;
            padding: 9px 0;
            border-bottom: 1px dashed #eee;
            font-size: 13px;
            color: #555;
        }
        .hours-list li:last-child { border-bottom: none; }
        .hours-list .time { font-weight: 700; color: #1a3a2a; }
        .hours-list .open { color: #28a745; font-weight: 700; font-size: 11px; }

        /* Map */
        .map-card {
            background: #fff;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 4px 20px rgba(0,0,0,0.07);
        }
        .map-card iframe {
            width: 100%;
            height: 220px;
            border: none;
            display: block;
        }

        @media (max-width: 800px) {
            .main-wrap { grid-template-columns: 1fr; }
        }
    </style>
</head>
<body>
<%@ include file="Header.jsp" %>

<!-- ── HERO BANNER ── -->
<div class="page-hero">
    <div class="page-hero-badge">✉️ Get In Touch</div>
    <h1>Contact Us</h1>
    <p>Have questions or need help planning your trip? We're here to help you every step of the way.</p>
    <svg class="hero-wave" viewBox="0 0 1200 60" preserveAspectRatio="none" xmlns="http://www.w3.org/2000/svg">
        <path d="M0,30 C300,60 900,0 1200,30 L1200,60 L0,60 Z" fill="#f0f7f3"/>
    </svg>
</div>

<!-- ── MAIN CONTENT ── -->
<div class="main-wrap">

    <!-- Contact Form -->
    <div class="form-card">
        <h2>✉️ Send Us a Message</h2>
        <p class="sub">We typically respond within 24 hours.</p>

        <form id="contactForm" method="POST" action="./Contact">
            <div class="form-group">
                <label for="name">👤 Full Name</label>
                <input type="text" id="name" name="uname" placeholder="Enter your full name" required>
            </div>
            <div class="form-group">
                <label for="email">📧 Email Address</label>
                <input type="email" id="email" name="email" placeholder="your@email.com" required>
            </div>
            <div class="form-group">
                <label for="message">💬 Your Message</label>
                <textarea id="message" name="msg" placeholder="Tell us what you need help with…" required></textarea>
            </div>
            <button type="submit" class="btn-send">🚀 Send Message</button>
            <p class="success-msg">${msg}</p>
        </form>
    </div>

    <!-- Info Side -->
    <div class="info-col">

        <!-- Contact Details -->
        <div class="info-card">
            <h3>📍 Our Contact Details</h3>
            <div class="info-item">
                <div class="info-icon">📍</div>
                <div class="info-text">
                    <label>Location</label>
                    <span>Vasota Fort, Koyna Backwaters, Maharashtra, India</span>
                </div>
            </div>
            <div class="info-item">
                <div class="info-icon">📞</div>
                <div class="info-text">
                    <label>Phone</label>
                    <span>+91 9579350747</span>
                </div>
            </div>
            <div class="info-item">
                <div class="info-icon">✉️</div>
                <div class="info-text">
                    <label>Email</label>
                    <span>info@vasotalakecamping.com</span>
                </div>
            </div>
        </div>

        <!-- Camp Hours -->
        <div class="info-card">
            <h3>🕐 Camp Hours</h3>
            <ul class="hours-list">
                <li><span>Check-In</span><span class="time">3:00 PM <span class="open">OPEN</span></span></li>
                <li><span>Check-Out</span><span class="time">11:00 AM</span></li>
                <li><span>Office Hours</span><span class="time">9 AM – 6 PM</span></li>
                <li><span>Days Open</span><span class="time">All Days ✅</span></li>
            </ul>
        </div>

        <!-- Map -->
        <div class="map-card">
            <iframe
                src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3156.617032504961!2d73.7696871!3d17.6666735!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0x7e0b5c5eb7b7d1e1!2sVasota%20Lake!5e0!3m2!1sen!2sin!4v1614256139072!5m2!1sen!2sin"
                allowfullscreen="" loading="lazy" title="Vasota Lake Location">
            </iframe>
        </div>

    </div>
</div>

<%@ include file="Footer.jsp" %>
</body>
</html>