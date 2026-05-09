<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Camping Packages — Vasota Lake Camping</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&family=Pacifico&display=swap" rel="stylesheet">
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
            font-size: clamp(28px, 5vw, 48px);
            font-weight: 800;
            color: #fff;
            text-shadow: 0 2px 20px rgba(0,0,0,0.3);
            margin-bottom: 14px;
        }
        .page-hero p {
            font-size: 16px;
            color: rgba(255,255,255,0.85);
            max-width: 520px;
            margin: 0 auto;
            line-height: 1.7;
        }
        .hero-wave {
            position: absolute;
            bottom: -1px;
            left: 0; right: 0;
            height: 60px;
        }

        /* ── MAIN CONTENT ── */
        .main-wrap {
            max-width: 1200px;
            margin: 0 auto;
            padding: 60px 20px 80px;
        }

        /* ── SECTION LABEL ── */
        .section-label {
            text-align: center;
            margin-bottom: 48px;
        }
        .section-label h2 {
            font-size: 28px;
            font-weight: 800;
            color: #1a3a2a;
            margin-bottom: 8px;
        }
        .section-label p {
            color: #666;
            font-size: 15px;
        }
        .section-label .accent-line {
            width: 56px;
            height: 4px;
            background: linear-gradient(135deg, #28a745, #1a5276);
            border-radius: 2px;
            margin: 14px auto 0;
        }

        /* ── CARDS GRID ── */
        .cards-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 28px;
        }

        /* ── OFFER CARD ── */
        .offer-card {
            background: #fff;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 4px 24px rgba(0,0,0,0.08);
            display: flex;
            flex-direction: column;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            position: relative;
        }
        .offer-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 20px 48px rgba(0,0,0,0.15);
        }

        /* Popular badge */
        .offer-card.popular::before {
            content: '⭐ Most Popular';
            position: absolute;
            top: 16px; right: 16px;
            background: linear-gradient(135deg, #f39c12, #e74c3c);
            color: #fff;
            font-size: 10px;
            font-weight: 800;
            letter-spacing: 0.5px;
            padding: 5px 12px;
            border-radius: 20px;
            z-index: 2;
            text-transform: uppercase;
        }
        .offer-card.luxury::before {
            content: '👑 Premium';
            position: absolute;
            top: 16px; right: 16px;
            background: linear-gradient(135deg, #7b2ff7, #a855f7);
            color: #fff;
            font-size: 10px;
            font-weight: 800;
            letter-spacing: 0.5px;
            padding: 5px 12px;
            border-radius: 20px;
            z-index: 2;
            text-transform: uppercase;
        }

        /* Card image */
        .card-img-wrap {
            position: relative;
            overflow: hidden;
            height: 200px;
            flex-shrink: 0;
        }
        .card-img-wrap img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.5s ease;
        }
        .offer-card:hover .card-img-wrap img {
            transform: scale(1.07);
        }
        .card-img-overlay {
            position: absolute;
            bottom: 0; left: 0; right: 0;
            background: linear-gradient(transparent, rgba(0,0,0,0.55));
            padding: 24px 16px 12px;
        }
        .card-emoji {
            font-size: 28px;
            display: block;
            line-height: 1;
        }

        /* Card body */
        .card-body {
            padding: 22px;
            display: flex;
            flex-direction: column;
            flex: 1;
        }
        .card-title {
            font-size: 18px;
            font-weight: 800;
            color: #1a3a2a;
            margin-bottom: 10px;
        }

        /* Amenities tags */
        .amenities {
            display: flex;
            flex-wrap: wrap;
            gap: 6px;
            margin-bottom: 16px;
        }
        .tag {
            background: #f0f7f3;
            color: #1a7a3c;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 600;
            padding: 4px 10px;
            border: 1px solid #c8e6c9;
        }

        /* Check-in info */
        .checkin-info {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 10px 14px;
            margin-bottom: 18px;
            display: flex;
            gap: 16px;
        }
        .ci-item {
            display: flex;
            align-items: center;
            gap: 6px;
            font-size: 12px;
            color: #555;
        }
        .ci-item .ci-icon { font-size: 14px; }
        .ci-item strong { color: #1a3a2a; }

        /* Price & CTA */
        .card-footer-row {
            margin-top: auto;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 12px;
        }
        .price-block .price-amt {
            font-size: 24px;
            font-weight: 800;
            color: #1a7a3c;
            line-height: 1;
        }
        .price-block .price-label {
            font-size: 11px;
            color: #aaa;
            margin-top: 2px;
        }
        .btn-book {
            display: inline-block;
            padding: 11px 22px;
            background: linear-gradient(135deg, #1a3a2a, #28a745);
            color: #fff;
            border-radius: 30px;
            text-decoration: none;
            font-size: 13px;
            font-weight: 700;
            white-space: nowrap;
            transition: all 0.25s;
            box-shadow: 0 4px 12px rgba(40,167,69,0.30);
        }
        .btn-book:hover {
            background: linear-gradient(135deg, #0f2518, #1d8236);
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(40,167,69,0.4);
            color: #fff;
            text-decoration: none;
        }

        /* ── DIVIDER ── */
        .section-divider {
            text-align: center;
            margin: 60px 0 48px;
            position: relative;
        }
        .section-divider::before {
            content: '';
            position: absolute;
            top: 50%; left: 0; right: 0;
            height: 1px;
            background: linear-gradient(135deg, transparent, #c8e6c9, transparent);
        }
        .section-divider span {
            background: linear-gradient(160deg, #f0f7f3 0%, #e8f5e9 40%, #f5f9ff 100%);
            padding: 0 20px;
            position: relative;
            font-size: 22px;
            font-weight: 800;
            color: #1a3a2a;
        }

        /* ── CTA BANNER ── */
        .cta-banner {
            margin-top: 70px;
            background: linear-gradient(135deg, #1a3a2a, #28a745);
            border-radius: 24px;
            padding: 50px 40px;
            text-align: center;
            position: relative;
            overflow: hidden;
        }
        .cta-banner::after {
            content: '🏕️';
            position: absolute;
            font-size: 200px;
            right: -30px;
            bottom: -40px;
            opacity: 0.07;
            line-height: 1;
        }
        .cta-banner h3 {
            font-size: 28px;
            font-weight: 800;
            color: #fff;
            margin-bottom: 10px;
        }
        .cta-banner p {
            color: rgba(255,255,255,0.8);
            margin-bottom: 24px;
            font-size: 15px;
        }
        .btn-cta-white {
            display: inline-block;
            padding: 14px 40px;
            background: #fff;
            color: #1a3a2a;
            border-radius: 40px;
            font-size: 16px;
            font-weight: 800;
            text-decoration: none;
            transition: all 0.25s;
            box-shadow: 0 6px 20px rgba(0,0,0,0.2);
        }
        .btn-cta-white:hover {
            transform: scale(1.05);
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
            text-decoration: none;
            color: #1a3a2a;
        }

        /* ── FOOTER STYLE ── */
        .footer {
            background: #1a2a1a;
            color: rgba(255,255,255,0.7);
            text-align: center;
            padding: 32px 20px;
            font-size: 13px;
            line-height: 2;
        }
        .footer .quick-links a {
            color: rgba(255,255,255,0.6);
            text-decoration: none;
            margin: 0 6px;
            transition: color 0.2s;
        }
        .footer .quick-links a:hover { color: #5dde8b; }

        /* ── RESPONSIVE ── */
        @media (max-width: 900px) {
            .cards-grid { grid-template-columns: repeat(2, 1fr); }
        }
        @media (max-width: 560px) {
            .cards-grid { grid-template-columns: 1fr; }
            .cta-banner { padding: 36px 22px; }
        }
    </style>
</head>
<body>
<%@ include file="Header.jsp" %>

<!-- ── HERO BANNER ── -->
<div class="page-hero">
    <div class="page-hero-badge">🏷️ Exclusive Packages</div>
    <h1>🏕️ Choose Your Perfect Stay</h1>
    <p>From budget-friendly tents to ultra-luxury cottages — we have an experience crafted just for you.</p>
    <svg class="hero-wave" viewBox="0 0 1200 60" preserveAspectRatio="none" xmlns="http://www.w3.org/2000/svg">
        <path d="M0,30 C300,60 900,0 1200,30 L1200,60 L0,60 Z" fill="#f0f7f3"/>
    </svg>
</div>

<!-- ── MAIN CONTENT ── -->
<div class="main-wrap">

    <!-- Row 1 Header -->
    <div class="section-label">
        <h2>🌿 Standard Packages</h2>
        <p>Perfect for solo travellers, couples, and small families</p>
        <div class="accent-line"></div>
    </div>

    <!-- Row 1: 3 Cards -->
    <div class="cards-grid">

        <!-- Card 1: Regular Tent -->
        <div class="offer-card">
            <div class="card-img-wrap">
                <img src="./images/regtent.jpg" alt="Regular Tent">
                <div class="card-img-overlay">
                    <span class="card-emoji">⛺</span>
                </div>
            </div>
            <div class="card-body">
                <div class="card-title">Regular Tent</div>
                <div class="amenities">
                    <span class="tag">🍖 BBQ</span>
                    <span class="tag">🔥 Campfire</span>
                    <span class="tag">🎸 Live Guitar</span>
                    <span class="tag">🌊 Lake View</span>
                    <span class="tag">🏏 Cricket Screen</span>
                    <span class="tag">☕ Tea & Coffee</span>
                </div>
                <div class="checkin-info">
                    <div class="ci-item"><span class="ci-icon">🟢</span><span><strong>Check-In:</strong> 3:00 PM</span></div>
                    <div class="ci-item"><span class="ci-icon">🔴</span><span><strong>Check-Out:</strong> 11:00 AM</span></div>
                </div>
                <div class="card-footer-row">
                    <div class="price-block">
                        <div class="price-amt">₹999</div>
                        <div class="price-label">per person / night</div>
                    </div>
                    <a href="book" class="btn-book">📅 Book Now</a>
                </div>
            </div>
        </div>

        <!-- Card 2: Triangle Tent -->
        <div class="offer-card popular">
            <div class="card-img-wrap">
                <img src="./images/tritent.jpg" alt="Triangle Tent">
                <div class="card-img-overlay">
                    <span class="card-emoji">🔺</span>
                </div>
            </div>
            <div class="card-body">
                <div class="card-title">Triangle Tent</div>
                <div class="amenities">
                    <span class="tag">🍖 BBQ</span>
                    <span class="tag">🔥 Campfire</span>
                    <span class="tag">🎶 Music Speaker</span>
                    <span class="tag">🌊 Lake View</span>
                    <span class="tag">🥗 Veg/Non-Veg</span>
                    <span class="tag">🌿 Garden</span>
                </div>
                <div class="checkin-info">
                    <div class="ci-item"><span class="ci-icon">🟢</span><span><strong>Check-In:</strong> 3:00 PM</span></div>
                    <div class="ci-item"><span class="ci-icon">🔴</span><span><strong>Check-Out:</strong> 11:00 AM</span></div>
                </div>
                <div class="card-footer-row">
                    <div class="price-block">
                        <div class="price-amt">₹1,499</div>
                        <div class="price-label">per person / night</div>
                    </div>
                    <a href="book" class="btn-book">📅 Book Now</a>
                </div>
            </div>
        </div>

        <!-- Card 3: Glamping -->
        <div class="offer-card">
            <div class="card-img-wrap">
                <img src="./images/glamping.jpg" alt="Glamping">
                <div class="card-img-overlay">
                    <span class="card-emoji">✨</span>
                </div>
            </div>
            <div class="card-body">
                <div class="card-title">Glamping</div>
                <div class="amenities">
                    <span class="tag">🍖 BBQ</span>
                    <span class="tag">🔥 Campfire</span>
                    <span class="tag">🎸 Live Guitar</span>
                    <span class="tag">🌟 Stargazing</span>
                    <span class="tag">🌊 Lake View</span>
                    <span class="tag">🎶 Speaker</span>
                </div>
                <div class="checkin-info">
                    <div class="ci-item"><span class="ci-icon">🟢</span><span><strong>Check-In:</strong> 3:00 PM</span></div>
                    <div class="ci-item"><span class="ci-icon">🔴</span><span><strong>Check-Out:</strong> 11:00 AM</span></div>
                </div>
                <div class="card-footer-row">
                    <div class="price-block">
                        <div class="price-amt">₹2,499</div>
                        <div class="price-label">per person / night</div>
                    </div>
                    <a href="book" class="btn-book">📅 Book Now</a>
                </div>
            </div>
        </div>

    </div>

    <!-- Section Divider -->
    <div class="section-divider">
        <span>🏡 Premium Cottages</span>
    </div>

    <!-- Premium label -->
    <div class="section-label" style="margin-bottom: 40px;">
        <h2>🪵 Luxury & Cottage Options</h2>
        <p>Elevated stays with panoramic views and full amenities</p>
        <div class="accent-line"></div>
    </div>

    <!-- Row 2: 3 Cards -->
    <div class="cards-grid">

        <!-- Card 4: Machan Cottage -->
        <div class="offer-card">
            <div class="card-img-wrap">
                <img src="./images/machtent.jpg" alt="Machan Cottage">
                <div class="card-img-overlay">
                    <span class="card-emoji">🌲</span>
                </div>
            </div>
            <div class="card-body">
                <div class="card-title">Machan Cottage</div>
                <div class="amenities">
                    <span class="tag">🍖 BBQ</span>
                    <span class="tag">🔥 Campfire</span>
                    <span class="tag">🌲 Forest View</span>
                    <span class="tag">🎸 Live Guitar</span>
                    <span class="tag">🌿 Eco Stay</span>
                    <span class="tag">☕ Tea & Coffee</span>
                </div>
                <div class="checkin-info">
                    <div class="ci-item"><span class="ci-icon">🟢</span><span><strong>Check-In:</strong> 3:00 PM</span></div>
                    <div class="ci-item"><span class="ci-icon">🔴</span><span><strong>Check-Out:</strong> 11:00 AM</span></div>
                </div>
                <div class="card-footer-row">
                    <div class="price-block">
                        <div class="price-amt">₹2,999</div>
                        <div class="price-label">per person / night</div>
                    </div>
                    <a href="book" class="btn-book">📅 Book Now</a>
                </div>
            </div>
        </div>

        <!-- Card 5: Elevator Cottage -->
        <div class="offer-card">
            <div class="card-img-wrap">
                <img src="./images/elevtent.jpg" alt="Elevator Cottage">
                <div class="card-img-overlay">
                    <span class="card-emoji">🏠</span>
                </div>
            </div>
            <div class="card-body">
                <div class="card-title">Elevator Cottage</div>
                <div class="amenities">
                    <span class="tag">🔥 Campfire</span>
                    <span class="tag">🌄 Hilltop View</span>
                    <span class="tag">🎶 Speaker</span>
                    <span class="tag">🥗 Full Meals</span>
                    <span class="tag">🏕️ Indoor Games</span>
                    <span class="tag">🛗 Private Lift</span>
                </div>
                <div class="checkin-info">
                    <div class="ci-item"><span class="ci-icon">🟢</span><span><strong>Check-In:</strong> 3:00 PM</span></div>
                    <div class="ci-item"><span class="ci-icon">🔴</span><span><strong>Check-Out:</strong> 11:00 AM</span></div>
                </div>
                <div class="card-footer-row">
                    <div class="price-block">
                        <div class="price-amt">₹3,499</div>
                        <div class="price-label">per person / night</div>
                    </div>
                    <a href="book" class="btn-book">📅 Book Now</a>
                </div>
            </div>
        </div>

        <!-- Card 6: Ultra Luxury -->
        <div class="offer-card luxury">
            <div class="card-img-wrap">
                <img src="./images/luxtent.jpg" alt="Ultra Luxury Cottage">
                <div class="card-img-overlay">
                    <span class="card-emoji">👑</span>
                </div>
            </div>
            <div class="card-body">
                <div class="card-title">Ultra Luxury Cottage</div>
                <div class="amenities">
                    <span class="tag">🍖 BBQ & Grill</span>
                    <span class="tag">🔥 Campfire</span>
                    <span class="tag">🌊 Lake View</span>
                    <span class="tag">👑 All Amenities</span>
                    <span class="tag">🎸 Live Guitar</span>
                    <span class="tag">🌟 Stargazing</span>
                </div>
                <div class="checkin-info">
                    <div class="ci-item"><span class="ci-icon">🟢</span><span><strong>Check-In:</strong> 3:00 PM</span></div>
                    <div class="ci-item"><span class="ci-icon">🔴</span><span><strong>Check-Out:</strong> 11:00 AM</span></div>
                </div>
                <div class="card-footer-row">
                    <div class="price-block">
                        <div class="price-amt">₹3,999</div>
                        <div class="price-label">per person / night</div>
                    </div>
                    <a href="book" class="btn-book">📅 Book Now</a>
                </div>
            </div>
        </div>

    </div>

    <!-- ── CTA BANNER ── -->
    <div class="cta-banner">
        <h3>🏔️ Ready to Escape into the Wild?</h3>
        <p>Spots fill up fast — secure your campsite before it's gone!</p>
        <a href="book" class="btn-cta-white">📅 Book Your Package Now</a>
    </div>

</div>

<%@ include file="Footer.jsp" %>
</body>
</html>