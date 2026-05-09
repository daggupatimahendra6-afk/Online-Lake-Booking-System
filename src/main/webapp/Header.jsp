<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!-- Bootstrap 5 CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Google Fonts: Pacifico & Outfit -->
<link href="https://fonts.googleapis.com/css2?family=Pacifico&family=Outfit:wght@300;400;500;600;700&display=swap" rel="stylesheet">

<style>
    /* ── Global Typography & Aesthetic ────────────────────────────────────── */
    body {
        font-family: 'Outfit', sans-serif;
        padding-top: 80px; /* Space for thicker navbar */
    }

    /* ── Navbar overrides (Glassmorphism & Deep Forest Theme) ───────────── */
    .navbar {
        background: rgba(10, 46, 31, 0.85); /* Deep Forest Green with transparency */
        backdrop-filter: blur(12px); /* Glassmorphism blur effect */
        -webkit-backdrop-filter: blur(12px);
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.15);
        padding: 12px 24px;
        transition: all 0.3s ease;
        border-bottom: 1px solid rgba(255, 255, 255, 0.05);
    }

    .navbar-brand {
        display: flex;
        align-items: center;
        gap: 14px;
        text-decoration: none;
    }
    .navbar-brand img {
        height: 52px;
        width:  52px;
        object-fit: contain;
        border-radius: 12px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.2);
    }
    .navbar-brand .site-name {
        font-family: 'Pacifico', cursive;
        font-size: 24px;
        color: #ffffff;
        text-shadow: 1px 2px 4px rgba(0,0,0,0.5);
        line-height: 1;
        letter-spacing: 0.5px;
    }

    /* Nav links */
    .navbar-nav .nav-link {
        color: rgba(255, 255, 255, 0.7) !important;
        font-size: 16px;
        font-weight: 500;
        padding: 10px 18px !important;
        border-radius: 8px;
        margin: 0 2px;
        transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
        position: relative;
    }
    .navbar-nav .nav-link:hover,
    .navbar-nav .nav-link.active {
        color: #ffffff !important;
        background: rgba(255, 255, 255, 0.1);
        transform: translateY(-2px);
    }

    /* Vibrant Login button */
    .btn-login {
        background: linear-gradient(135deg, #1aa356, #128a42);
        color: #fff !important;
        border-radius: 20px; /* Pill shape */
        padding: 10px 24px !important;
        font-weight: 600;
        box-shadow: 0 4px 15px rgba(26, 163, 86, 0.3);
        transition: all 0.3s ease;
        border: 1px solid rgba(255,255,255,0.1);
    }
    .btn-login:hover {
        background: linear-gradient(135deg, #1cc164, #159f4d);
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(26, 163, 86, 0.4);
    }

    /* Hamburger icon colour on dark bg */
    .navbar-toggler {
        border-color: rgba(255, 255, 255, 0.2);
        padding: 8px;
        border-radius: 8px;
    }
    .navbar-toggler:focus {
        box-shadow: 0 0 0 0.1rem rgba(255,255,255,0.25);
    }
    .navbar-toggler-icon {
        background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 30 30'%3e%3cpath stroke='rgba(255,255,255,0.9)' stroke-width='2' stroke-linecap='round' stroke-miterlimit='10' d='M4 7h22M4 15h22M4 23h22'/%3e%3c/svg%3e");
    }
    
    @media (max-width: 991px) {
        .navbar-nav {
            padding-top: 15px;
            gap: 8px;
        }
        .navbar-nav .nav-link {
            text-align: center;
        }
    }
</style>

    <!-- Bootstrap 5 Navbar -->
    <nav class="navbar navbar-expand-lg fixed-top">

        <!-- Brand: logo + site title -->
        <a class="navbar-brand" href="./home">
            <img src="./images/vlogo.png" alt="Vasota Logo">
            <span class="site-name">Vasota Lake Camping</span>
        </a>

        <!-- Hamburger toggle (visible on mobile) -->
        <button class="navbar-toggler" type="button"
                data-bs-toggle="collapse"
                data-bs-target="#navbarLinks"
                aria-controls="navbarLinks"
                aria-expanded="false"
                aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <!-- Collapsible link group -->
        <div class="collapse navbar-collapse" id="navbarLinks">
            <ul class="navbar-nav ms-auto align-items-lg-center gap-lg-1">
                <li class="nav-item">
                    <a class="nav-link" href="./home">🏠 Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="./offers">🏷️ Offers</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="./gallery">🖼️ Gallery</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="./book">📅 Bookings</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="./contact">✉️ Contact</a>
                </li>
                <li class="nav-item ms-lg-3 mt-2 mt-lg-0">
                    <a class="nav-link btn-login" href="login">🔐 Login</a>
                </li>
            </ul>
        </div>
    </nav>

    <!-- Bootstrap 5 JS (for collapse toggle) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
