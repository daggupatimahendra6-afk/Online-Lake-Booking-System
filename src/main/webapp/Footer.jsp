<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
/* ── Premium Footer ── */
.footer {
    background: linear-gradient(160deg, #0d1f12 0%, #1a2a1a 60%, #0d2a4e 100%);
    color: rgba(255,255,255,0.65);
    font-family: 'Inter', 'Segoe UI', Arial, sans-serif;
    padding: 0;
    margin-top: 0;
}
.footer-inner {
    max-width: 1100px;
    margin: 0 auto;
    padding: 56px 24px 32px;
    display: grid;
    grid-template-columns: 2fr 1fr 1fr;
    gap: 48px;
}
.footer-brand .brand-name {
    font-family: 'Pacifico', cursive;
    font-size: 22px;
    color: #5dde8b;
    margin-bottom: 12px;
    display: block;
}
.footer-brand p {
    font-size: 13px;
    line-height: 1.8;
    color: rgba(255,255,255,0.55);
    max-width: 280px;
}
.footer-contact-list {
    list-style: none;
    padding: 0;
    margin-top: 18px;
    display: flex;
    flex-direction: column;
    gap: 8px;
}
.footer-contact-list li {
    font-size: 13px;
    color: rgba(255,255,255,0.6);
    display: flex;
    align-items: flex-start;
    gap: 8px;
}
.footer-contact-list li .icon { font-size: 15px; flex-shrink: 0; margin-top: 1px; }

.footer-col h4 {
    font-size: 13px;
    font-weight: 700;
    letter-spacing: 1.5px;
    text-transform: uppercase;
    color: rgba(255,255,255,0.4);
    margin-bottom: 18px;
}
.footer-links {
    list-style: none;
    padding: 0;
    display: flex;
    flex-direction: column;
    gap: 10px;
}
.footer-links a {
    color: rgba(255,255,255,0.6);
    text-decoration: none;
    font-size: 14px;
    transition: color 0.2s, padding-left 0.2s;
    display: inline-block;
}
.footer-links a:hover {
    color: #5dde8b;
    padding-left: 4px;
}

.footer-divider {
    height: 1px;
    background: rgba(255,255,255,0.07);
    max-width: 1100px;
    margin: 0 auto;
}
.footer-bottom {
    max-width: 1100px;
    margin: 0 auto;
    padding: 20px 24px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    flex-wrap: wrap;
    gap: 10px;
}
.footer-bottom .copy {
    font-size: 12px;
    color: rgba(255,255,255,0.35);
}
.footer-bottom .tagline {
    font-size: 12px;
    color: #5dde8b;
    font-style: italic;
}

.footer-activities {
    display: flex;
    flex-wrap: wrap;
    gap: 6px;
    margin-top: 16px;
}
.act-chip {
    background: rgba(93,222,139,0.12);
    color: #5dde8b;
    border: 1px solid rgba(93,222,139,0.2);
    border-radius: 20px;
    padding: 3px 10px;
    font-size: 11px;
    font-weight: 600;
}

@media (max-width: 750px) {
    .footer-inner { grid-template-columns: 1fr; gap: 32px; padding: 40px 20px 24px; }
    .footer-bottom { flex-direction: column; align-items: flex-start; }
}
</style>

<footer class="footer">
    <div class="footer-inner">
        <!-- Brand Col -->
        <div class="footer-brand">
            <span class="brand-name">🏕️ Vasota Lake Camping</span>
            <p>Nestled in the heart of the Sahyadri ranges, offering unforgettable camping experiences amidst nature's finest.</p>
            <ul class="footer-contact-list">
                <li><span class="icon">📍</span> Vasota Fort, Koyna Backwaters, Maharashtra</li>
                <li><span class="icon">📞</span> +91 9579350747</li>
                <li><span class="icon">✉️</span> info@vasotalakecamping.com</li>
            </ul>
            <div class="footer-activities">
                <span class="act-chip">🥾 Trekking</span>
                <span class="act-chip">🚣 Boating</span>
                <span class="act-chip">🔥 Campfire</span>
                <span class="act-chip">🌟 Stargazing</span>
            </div>
        </div>

        <!-- Quick Links -->
        <div class="footer-col">
            <h4>Quick Links</h4>
            <ul class="footer-links">
                <li><a href="home">🏠 Home</a></li>
                <li><a href="offers">🏷️ Offers</a></li>
                <li><a href="gallery">🖼️ Gallery</a></li>
                <li><a href="book">📅 Book Now</a></li>
                <li><a href="contact">✉️ Contact</a></li>
            </ul>
        </div>

        <!-- Account Links -->
        <div class="footer-col">
            <h4>Account</h4>
            <ul class="footer-links">
                <li><a href="login">🔐 Login</a></li>
                <li><a href="signup">📝 Register</a></li>
                <li><a href="MyBookings">📋 My Bookings</a></li>
                <li><a href="logout">🚪 Logout</a></li>
            </ul>
        </div>
    </div>

    <div class="footer-divider"></div>
    <div class="footer-bottom">
        <span class="copy">© 2026 Vasota Lake Camping. All rights reserved.</span>
        <span class="tagline">"Escape the ordinary, camp under the stars!"</span>
    </div>
</footer>

<%-- ── AI Chatbot Widget (appears on every page via footer) ── --%>
<%@ include file="Chatbot.jsp" %>