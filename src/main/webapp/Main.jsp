<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vasota Lake Camping — Home</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }

        body {
            font-family: 'Outfit', sans-serif; /* Fallback will be handled by header's Outfit import */
            background: #f8faf9; /* very light green-tinted off-white */
            color: #333;
        }

        /* ── Hero Section ── */
        .hero {
            background: linear-gradient(135deg, rgba(4, 28, 16, 0.85), rgba(0, 50, 36, 0.75)),
                        url('./images/vasota.jpg') center/cover no-repeat;
            min-height: 600px;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
            color: white;
            padding: 100px 20px 60px;
            position: relative;
        }
        .hero-content {
            animation: fadeInDrop 1s ease-out forwards;
        }
        @keyframes fadeInDrop {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .hero-content h1 {
            font-size: 56px;
            font-weight: 700;
            text-shadow: 0 4px 15px rgba(0,0,0,0.4);
            margin-bottom: 18px;
            letter-spacing: -0.5px;
        }
        .hero-content p {
            font-size: 19px;
            opacity: 0.9;
            max-width: 650px;
            margin: 0 auto 34px;
            line-height: 1.6;
            text-shadow: 0 2px 8px rgba(0,0,0,0.3);
        }
        .hero-btns { display: flex; gap: 16px; justify-content: center; flex-wrap: wrap; }
        .btn-hero-primary {
            padding: 15px 36px;
            background: linear-gradient(135deg, #1aa356, #128a42);
            color: white;
            border-radius: 30px;
            text-decoration: none;
            font-size: 17px;
            font-weight: 600;
            box-shadow: 0 6px 20px rgba(26, 163, 86, 0.3);
            transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
            border: 1px solid rgba(255,255,255,0.1);
        }
        .btn-hero-primary:hover {
            background: linear-gradient(135deg, #1cc164, #159f4d);
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(26, 163, 86, 0.5);
            color: white;
        }
        .btn-hero-outline {
            padding: 15px 36px;
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(8px);
            color: white;
            border: 1px solid rgba(255,255,255,0.4);
            border-radius: 30px;
            text-decoration: none;
            font-size: 17px;
            font-weight: 600;
            transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
        }
        .btn-hero-outline:hover { 
            background: rgba(255,255,255,0.25);
            transform: translateY(-3px);
            color: white;
        }

        /* ── Overlay Stats bar (Glassmorphism) ── */
        .stats-wrapper {
            position: relative;
            max-width: 1000px;
            margin: -50px auto 40px;
            padding: 0 20px;
            z-index: 10;
        }
        .stats-bar {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(15px);
            border-radius: 16px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.1);
            display: flex;
            justify-content: center;
            overflow: hidden;
            border: 1px solid rgba(255,255,255,0.6);
        }
        .stat-item {
            flex: 1;
            text-align: center;
            padding: 26px 20px;
            border-right: 1px solid rgba(0,0,0,0.06);
            transition: transform 0.3s;
        }
        .stat-item:hover { transform: translateY(-3px); }
        .stat-item:last-child { border-right: none; }
        .stat-item .num { font-size: 32px; font-weight: 700; color: #1aa356; line-height: 1.1; }
        .stat-item .lbl { font-size: 14px; font-weight: 500; color: #666; margin-top: 6px; text-transform: uppercase; letter-spacing: 0.5px; }

        /* ── Section header ── */
        .section { padding: 80px 20px; }
        .section-header { text-align: center; margin-bottom: 50px; }
        .section-header h2 {
            font-size: 36px;
            font-weight: 700;
            color: #0A2E1F;
            margin-bottom: 12px;
        }
        .section-header p { font-size: 17px; color: #666; max-width: 580px; margin: 0 auto; line-height: 1.6; }
        .section-header .underline {
            width: 70px; height: 5px;
            background: linear-gradient(90deg, #1aa356, #0A2E1F);
            border-radius: 3px;
            margin: 16px auto 0;
        }

        /* ── About ── */
        .about-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 60px;
            align-items: center;
            max-width: 1150px;
            margin: 0 auto;
        }
        .about-img-wrap {
            position: relative;
        }
        .about-grid img {
            width: 100%;
            border-radius: 20px;
            box-shadow: 0 15px 40px rgba(0,0,0,0.15);
            transition: transform 0.3s;
        }
        .about-grid img:hover { transform: scale(1.02); }
        .about-text h3 {
            font-size: 30px;
            font-weight: 700;
            color: #0A2E1F;
            margin-bottom: 18px;
        }
        .about-text p {
            font-size: 16px;
            color: #555;
            line-height: 1.8;
            margin-bottom: 16px;
        }
        .about-highlights { display: flex; flex-wrap: wrap; gap: 12px; margin-top: 24px; }
        .highlight-tag {
            background: #e9f7ef;
            color: #128a42;
            padding: 8px 16px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 600;
            box-shadow: 0 2px 8px rgba(0,0,0,0.04);
            border: 1px solid rgba(18, 138, 66, 0.1);
            transition: transform 0.2s, background 0.2s;
        }
        .highlight-tag:hover { background: #d4f0df; transform: translateY(-2px); }

        /* ── Tents Grid ── */
        .tents-section { background: #E8F2ED; }
        .tents-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 30px;
            max-width: 1150px;
            margin: 0 auto;
        }
        .tent-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.06);
            overflow: hidden;
            transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
            border: 1px solid rgba(0,0,0,0.03);
        }
        .tent-card:hover { transform: translateY(-8px); box-shadow: 0 15px 40px rgba(0,0,0,0.12); }
        .tent-card-header {
            background: linear-gradient(135deg, #0A2E1F, #128a42);
            color: white;
            padding: 30px 20px;
            text-align: center;
            font-size: 40px;
            position: relative;
        }
        /* Curve effect at bottom of header */
        .tent-card-header::after {
            content: ''; position: absolute; bottom: 0; left: 0; right: 0; height: 16px;
            background: white; border-radius: 16px 16px 0 0;
        }
        .tent-card-body { padding: 10px 24px 28px; text-align: center; }
        .tent-card-body h4 { font-size: 19px; font-weight: 700; color: #111; margin-bottom: 8px; }
        .tent-card-body p  { font-size: 14px; color: #666; line-height: 1.6; margin-bottom: 16px; min-height: 44px; }
        .tent-price {
            font-size: 24px;
            font-weight: 700;
            color: #1aa356;
            margin-bottom: 8px;
        }
        .tent-price span { font-size: 14px; color: #999; font-weight: 500; }
        .tent-capacity {
            font-size: 13px; color: #777; font-weight: 500;
            background: #f8f9fa; display: inline-block; padding: 4px 12px; border-radius: 12px;
        }

        /* ── Features ── */
        .features-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 26px;
            max-width: 1150px;
            margin: 0 auto;
        }
        .feature-card {
            background: white;
            border-radius: 20px;
            padding: 34px 24px;
            text-align: center;
            box-shadow: 0 8px 30px rgba(0,0,0,0.05);
            transition: all 0.3s;
            border: 1px solid rgba(0,0,0,0.03);
            position: relative;
            overflow: hidden;
        }
        .feature-card::before {
            content: ''; position: absolute; top: 0; left: 0; right: 0; height: 4px;
            background: linear-gradient(90deg, #1aa356, #0A2E1F);
            transform: scaleX(0); transition: transform 0.3s; transform-origin: left;
        }
        .feature-card:hover::before { transform: scaleX(1); }
        .feature-card:hover { transform: translateY(-5px); box-shadow: 0 12px 35px rgba(0,0,0,0.08); }
        .feature-icon { font-size: 46px; margin-bottom: 18px; filter: drop-shadow(0 4px 8px rgba(0,0,0,0.1)); }
        .feature-card h4 { font-size: 18px; font-weight: 700; color: #0A2E1F; margin-bottom: 10px; }
        .feature-card p  { font-size: 14px; color: #666; line-height: 1.6; }

        /* ── Schedule ── */
        .schedule-wrap {
            background: white;
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 15px 40px rgba(0,0,0,0.08);
            max-width: 950px;
            margin: 0 auto;
        }
        .schedule-img {
            text-align: center;
        }
        .schedule-img img {
            width: 100%;
            border-radius: 12px;
        }

        /* ── CTA ── */
        .cta-section {
            background: linear-gradient(135deg, rgba(10, 46, 31, 0.95), rgba(18, 138, 66, 0.85)), url('./images/vasota.jpg') center/cover;
            background-blend-mode: overlay;
            color: white;
            text-align: center;
            padding: 80px 30px;
        }
        .cta-section h2 { font-size: 40px; font-weight: 700; margin-bottom: 18px; }
        .cta-section p  { font-size: 18px; opacity: 0.9; margin-bottom: 34px; max-width: 600px; margin-left: auto; margin-right: auto;}
        .btn-cta {
            display: inline-block;
            padding: 16px 44px;
            background: white;
            color: #0A2E1F;
            border-radius: 30px;
            text-decoration: none;
            font-size: 18px;
            font-weight: 700;
            transition: all 0.3s;
            box-shadow: 0 8px 25px rgba(0,0,0,0.2);
        }
        .btn-cta:hover { transform: scale(1.05); box-shadow: 0 12px 35px rgba(0,0,0,0.3); color: #1aa356; }

        @media (max-width: 991px) {
            .hero-content h1 { font-size: 42px; }
            .about-grid      { grid-template-columns: 1fr; gap: 40px; }
            .tents-grid      { grid-template-columns: 1fr 1fr; }
            .features-grid   { grid-template-columns: 1fr 1fr; }
            .stats-bar       { flex-wrap: wrap; }
            .stat-item       { padding: 20px; border-right: none; border-bottom: 1px solid rgba(0,0,0,0.06); min-width: 50%; }
        }
        @media (max-width: 600px) {
            .hero-content h1 { font-size: 36px; }
            .hero-btns { flex-direction: column; }
            .btn-hero-primary, .btn-hero-outline { width: 100%; }
            .tents-grid    { grid-template-columns: 1fr; }
            .features-grid { grid-template-columns: 1fr; }
            .stat-item { min-width: 100%; }
            .section       { padding: 60px 20px; }
        }
    </style>
</head>
<body>
<%@ include file="Header.jsp" %>
<!-- ── Hero ── -->
<div class="hero">
    <div class="hero-content">
        <h1>🏕️ Vasota Lake Camping</h1>
        <p>Experience the magic of nature in the heart of the Sahyadri ranges. Trekking, bonfires, stargazing — all in one unforgettable getaway.</p>
        <div class="hero-btns">
            <a href="./book" class="btn-hero-primary">📅 Book Your Spot</a>
            <a href="./offers"   class="btn-hero-outline">🏷️ View Offers</a>
        </div>
    </div>
</div>

<!-- ── Stats bar ── -->
<div class="stats-wrapper">
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
<div class="section" style="padding-top:0; padding-bottom:60px;">
    <div class="section-header">
        <h2>📅 Camp Schedule</h2>
        <p>A day-by-day breakdown of your camping adventure.</p>
        <div class="underline"></div>
    </div>
    <div class="schedule-wrap">
        <div class="schedule-img">
            <img src="./images/schedule.jpg" alt="Camp Schedule">
        </div>
    </div>
</div>

<!-- ── CTA ── -->
<div class="cta-section">
    <h2>Ready for Your Adventure? 🏔️</h2>
    <p>Spots fill up fast — secure your camping experience today!</p>
    <a href="./book" class="btn-cta">📅 Book Now</a>
</div>

<%@ include file="Footer.jsp" %>

</body>
</html>

