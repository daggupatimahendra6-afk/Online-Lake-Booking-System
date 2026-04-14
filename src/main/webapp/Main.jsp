<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="Header.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vasota Lake Camping — Home</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }

        body {
            font-family: Arial, sans-serif;
            background: #f9f9f9;
            color: #333;
        }

        /* ── Hero Section ── */
        .hero {
            background: linear-gradient(135deg, rgba(10,40,20,0.82), rgba(0,80,60,0.75)),
                        url('./images/vasota.jpg') center/cover no-repeat;
            min-height: 520px;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
            color: white;
            padding: 60px 20px 40px;
        }
        .hero-content h1 {
            font-size: 48px;
            font-weight: bold;
            text-shadow: 2px 2px 8px rgba(0,0,0,0.5);
            margin-bottom: 14px;
        }
        .hero-content p {
            font-size: 18px;
            opacity: 0.92;
            max-width: 600px;
            margin: 0 auto 28px;
            line-height: 1.6;
        }
        .hero-btns { display: flex; gap: 14px; justify-content: center; flex-wrap: wrap; }
        .btn-hero-primary {
            padding: 14px 32px;
            background: #28a745;
            color: white;
            border-radius: 30px;
            text-decoration: none;
            font-size: 16px;
            font-weight: bold;
            transition: background 0.2s, transform 0.2s;
        }
        .btn-hero-primary:hover { background: #1e7e34; transform: translateY(-2px); }
        .btn-hero-outline {
            padding: 14px 32px;
            background: transparent;
            color: white;
            border: 2px solid white;
            border-radius: 30px;
            text-decoration: none;
            font-size: 16px;
            font-weight: bold;
            transition: background 0.2s;
        }
        .btn-hero-outline:hover { background: rgba(255,255,255,0.15); }

        /* ── Stats bar ── */
        .stats-bar {
            background: #1a3a2a;
            color: white;
            display: flex;
            justify-content: center;
            gap: 0;
        }
        .stat-item {
            text-align: center;
            padding: 20px 48px;
            border-right: 1px solid rgba(255,255,255,0.15);
        }
        .stat-item:last-child { border-right: none; }
        .stat-item .num { font-size: 28px; font-weight: bold; color: #5dde8b; }
        .stat-item .lbl { font-size: 13px; opacity: 0.75; margin-top: 2px; }

        /* ── Section header ── */
        .section { padding: 60px 40px; }
        .section-header { text-align: center; margin-bottom: 40px; }
        .section-header h2 {
            font-size: 32px;
            color: #1a3a2a;
            margin-bottom: 10px;
        }
        .section-header p { font-size: 16px; color: #777; max-width: 520px; margin: 0 auto; }
        .section-header .underline {
            width: 60px; height: 4px;
            background: #28a745;
            border-radius: 2px;
            margin: 12px auto 0;
        }

        /* ── About ── */
        .about-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 40px;
            align-items: center;
            max-width: 1100px;
            margin: 0 auto;
        }
        .about-grid img {
            width: 100%;
            border-radius: 16px;
            box-shadow: 0 8px 30px rgba(0,0,0,0.15);
        }
        .about-text h3 {
            font-size: 26px;
            color: #1a3a2a;
            margin-bottom: 14px;
        }
        .about-text p {
            font-size: 15px;
            color: #555;
            line-height: 1.8;
            margin-bottom: 14px;
        }
        .about-highlights { display: flex; flex-wrap: wrap; gap: 10px; margin-top: 16px; }
        .highlight-tag {
            background: #e6f9ee;
            color: #1a7a3c;
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: bold;
        }

        /* ── Tents Grid ── */
        .tents-section { background: #f0f7f3; }
        .tents-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 22px;
            max-width: 1100px;
            margin: 0 auto;
        }
        .tent-card {
            background: white;
            border-radius: 14px;
            box-shadow: 0 3px 14px rgba(0,0,0,0.08);
            overflow: hidden;
            transition: transform 0.2s, box-shadow 0.2s;
        }
        .tent-card:hover { transform: translateY(-5px); box-shadow: 0 10px 28px rgba(0,0,0,0.13); }
        .tent-card-header {
            background: linear-gradient(135deg, #1a3a2a, #28a745);
            color: white;
            padding: 22px 18px;
            text-align: center;
            font-size: 32px;
        }
        .tent-card-body { padding: 18px; }
        .tent-card-body h4 { font-size: 16px; color: #222; margin-bottom: 6px; }
        .tent-card-body p  { font-size: 13px; color: #777; line-height: 1.6; margin-bottom: 12px; }
        .tent-price {
            font-size: 20px;
            font-weight: bold;
            color: #28a745;
        }
        .tent-price span { font-size: 13px; color: #aaa; font-weight: normal; }
        .tent-capacity { font-size: 12px; color: #999; margin-top: 4px; }

        /* ── Features ── */
        .features-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 22px;
            max-width: 1100px;
            margin: 0 auto;
        }
        .feature-card {
            background: white;
            border-radius: 14px;
            padding: 28px 20px;
            text-align: center;
            box-shadow: 0 3px 14px rgba(0,0,0,0.07);
            transition: transform 0.2s;
        }
        .feature-card:hover { transform: translateY(-4px); }
        .feature-icon { font-size: 40px; margin-bottom: 14px; }
        .feature-card h4 { font-size: 15px; color: #1a3a2a; margin-bottom: 8px; }
        .feature-card p  { font-size: 13px; color: #777; line-height: 1.6; }

        /* ── CTA ── */
        .cta-section {
            background: linear-gradient(135deg, #1a3a2a, #28a745);
            color: white;
            text-align: center;
            padding: 60px 30px;
        }
        .cta-section h2 { font-size: 32px; margin-bottom: 12px; }
        .cta-section p  { font-size: 16px; opacity: 0.88; margin-bottom: 28px; }
        .btn-cta {
            display: inline-block;
            padding: 15px 40px;
            background: white;
            color: #1a3a2a;
            border-radius: 30px;
            text-decoration: none;
            font-size: 17px;
            font-weight: bold;
            transition: transform 0.2s;
        }
        .btn-cta:hover { transform: scale(1.04); }

        /* ── Schedule ── */
        .schedule-img {
            text-align: center;
            padding: 20px 40px 60px;
        }
        .schedule-img img {
            max-width: 900px;
            width: 100%;
            border-radius: 16px;
            box-shadow: 0 8px 30px rgba(0,0,0,0.12);
            border: 3px solid #28a745;
        }

        @media (max-width: 900px) {
            .hero-content h1 { font-size: 32px; }
            .about-grid      { grid-template-columns: 1fr; }
            .tents-grid      { grid-template-columns: 1fr 1fr; }
            .features-grid   { grid-template-columns: 1fr 1fr; }
            .stats-bar       { flex-wrap: wrap; }
            .stat-item       { padding: 16px 28px; }
        }
        @media (max-width: 600px) {
            .tents-grid    { grid-template-columns: 1fr; }
            .features-grid { grid-template-columns: 1fr 1fr; }
            .section       { padding: 40px 20px; }
        }
    </style>
</head>
<body>

<!-- ── Hero ── -->
<div class="hero">
    <div class="hero-content">
        <h1>🏕️ Vasota Lake Camping</h1>
        <p>Experience the magic of nature in the heart of the Sahyadri ranges. Trekking, bonfires, stargazing — all in one unforgettable getaway.</p>
        <div class="hero-btns">
            <a href="./Bookings.jsp" class="btn-hero-primary">📅 Book Your Spot</a>
            <a href="./Offers.jsp"   class="btn-hero-outline">🏷️ View Offers</a>
        </div>
    </div>
</div>

<!-- ── Stats bar ── -->
<div class="stats-bar">
    <div class="stat-item">
        <div class="num">500+</div>
        <div class="lbl">Happy Campers</div>
    </div>
    <div class="stat-item">
        <div class="num">6</div>
        <div class="lbl">Tent Options</div>
    </div>
    <div class="stat-item">
        <div class="num">4.9★</div>
        <div class="lbl">Guest Rating</div>
    </div>
    <div class="stat-item">
        <div class="num">3 Yrs</div>
        <div class="lbl">In Business</div>
    </div>
</div>

<!-- ── About ── -->
<div class="section">
    <div class="about-grid">
        <div>
            <img src="./images/vasota.jpg" alt="Vasota Lake Camping">
        </div>
        <div class="about-text">
            <h3>About Vasota Lake Camping</h3>
            <p>Nestled amidst the breathtaking landscapes of the Sahyadri ranges and the serene backwaters of Shivsagar Lake, our campsite offers the perfect escape for nature lovers, trekkers, and thrill-seekers alike.</p>
            <p>With a passion for outdoor adventure, we provide a well-organized and safe camping experience that combines trekking, boating, bonfires, and stargazing — all under the vast open sky.</p>
            <div class="about-highlights">
                <span class="highlight-tag">🥾 Trekking</span>
                <span class="highlight-tag">🚣 Boating</span>
                <span class="highlight-tag">🔥 Bonfire</span>
                <span class="highlight-tag">🌟 Stargazing</span>
                <span class="highlight-tag">🌿 Eco-Friendly</span>
                <span class="highlight-tag">🏔️ Vasota Fort</span>
            </div>
        </div>
    </div>
</div>

<!-- ── Tents ── -->
<div class="section tents-section">
    <div class="section-header">
        <h2>🏕️ Our Accommodations</h2>
        <p>Choose from 6 unique tent and cottage options to suit every budget and style.</p>
        <div class="underline"></div>
    </div>
    <div class="tents-grid">
        <div class="tent-card">
            <div class="tent-card-header">⛺</div>
            <div class="tent-card-body">
                <h4>Regular Tent</h4>
                <p>Basic camping tent perfect for budget travellers who love the outdoors.</p>
                <div class="tent-price">₹800 <span>/ person</span></div>
                <div class="tent-capacity">👥 Up to 4 people</div>
            </div>
        </div>
        <div class="tent-card">
            <div class="tent-card-header">🔺</div>
            <div class="tent-card-body">
                <h4>Triangle Tent</h4>
                <p>A-frame triangular tent, great for couples seeking a cozy retreat.</p>
                <div class="tent-price">₹1,200 <span>/ person</span></div>
                <div class="tent-capacity">👥 Up to 2 people</div>
            </div>
        </div>
        <div class="tent-card">
            <div class="tent-card-header">🌲</div>
            <div class="tent-card-body">
                <h4>Machan Cottage</h4>
                <p>Elevated wooden cottage with stunning scenic forest views.</p>
                <div class="tent-price">₹2,500 <span>/ person</span></div>
                <div class="tent-capacity">👥 Up to 4 people</div>
            </div>
        </div>
        <div class="tent-card">
            <div class="tent-card-header">🏠</div>
            <div class="tent-card-body">
                <h4>Elevator Cottage</h4>
                <p>Hilltop cottage accessible via a private lift with panoramic views.</p>
                <div class="tent-price">₹3,500 <span>/ person</span></div>
                <div class="tent-capacity">👥 Up to 4 people</div>
            </div>
        </div>
        <div class="tent-card">
            <div class="tent-card-header">✨</div>
            <div class="tent-card-body">
                <h4>Glamping</h4>
                <p>Luxury glamping tent with premium furnishings for a lavish experience.</p>
                <div class="tent-price">₹5,000 <span>/ person</span></div>
                <div class="tent-capacity">👥 Up to 3 people</div>
            </div>
        </div>
        <div class="tent-card">
            <div class="tent-card-header">👑</div>
            <div class="tent-card-body">
                <h4>Ultra Luxury Cottage</h4>
                <p>Top-tier cottage with all modern amenities for an elite escape.</p>
                <div class="tent-price">₹8,000 <span>/ person</span></div>
                <div class="tent-capacity">👥 Up to 6 people</div>
            </div>
        </div>
    </div>
</div>

<!-- ── Features ── -->
<div class="section">
    <div class="section-header">
        <h2>Why Choose Us?</h2>
        <p>Everything you need for the perfect camping experience.</p>
        <div class="underline"></div>
    </div>
    <div class="features-grid">
        <div class="feature-card">
            <div class="feature-icon">🛡️</div>
            <h4>100% Safe</h4>
            <p>Trained guides and safety equipment at every step of your journey.</p>
        </div>
        <div class="feature-card">
            <div class="feature-icon">🌿</div>
            <h4>Eco-Friendly</h4>
            <p>We respect nature and follow strict eco-friendly camping practices.</p>
        </div>
        <div class="feature-card">
            <div class="feature-icon">🍽️</div>
            <h4>Delicious Food</h4>
            <p>Enjoy freshly prepared local meals around the campfire every evening.</p>
        </div>
        <div class="feature-card">
            <div class="feature-icon">📸</div>
            <h4>Scenic Views</h4>
            <p>Wake up to breathtaking views of Sahyadri ranges and Shivsagar Lake.</p>
        </div>
    </div>
</div>

<!-- ── Schedule ── -->
<div class="section" style="padding-top:0; padding-bottom:20px;">
    <div class="section-header">
        <h2>📅 Camp Schedule</h2>
        <p>A day-by-day breakdown of your camping adventure.</p>
        <div class="underline"></div>
    </div>
</div>
<div class="schedule-img">
    <img src="./images/schedule.jpg" alt="Camp Schedule">
</div>

<!-- ── CTA ── -->
<div class="cta-section">
    <h2>Ready for Your Adventure? 🏔️</h2>
    <p>Spots fill up fast — secure your camping experience today!</p>
    <a href="./Bookings.jsp" class="btn-cta">📅 Book Now</a>
</div>

<%@ include file="Footer.jsp" %>

</body>
</html>

