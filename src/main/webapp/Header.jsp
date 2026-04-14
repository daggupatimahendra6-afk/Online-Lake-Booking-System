<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Vasota Lake Camping</title>

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Google Font for branding -->
    <link href="https://fonts.googleapis.com/css2?family=Pacifico&display=swap" rel="stylesheet">

    <style>
        /* ── Navbar overrides ──────────────────────────────────────────────── */
        .navbar {
            background: linear-gradient(135deg, #0d2a4e, #1a5276);
            box-shadow: 0 2px 12px rgba(0,0,0,0.25);
            padding: 10px 24px;
        }

        .navbar-brand {
            display: flex;
            align-items: center;
            gap: 12px;
            text-decoration: none;
        }
        .navbar-brand img {
            height: 50px;
            width:  50px;
            object-fit: contain;
            border-radius: 8px;
        }
        .navbar-brand .site-name {
            font-family: 'Pacifico', cursive;
            font-size: 22px;
            color: #ffffff;
            text-shadow: 1px 1px 4px rgba(0,0,0,0.4);
            line-height: 1;
        }

        /* Nav links */
        .navbar-nav .nav-link {
            color: rgba(255,255,255,0.88) !important;
            font-size: 15px;
            font-weight: 500;
            padding: 8px 16px !important;
            border-radius: 6px;
            transition: background 0.2s, color 0.2s;
        }
        .navbar-nav .nav-link:hover,
        .navbar-nav .nav-link.active {
            color: #ffffff !important;
            background: rgba(255,255,255,0.15);
        }

        /* Login button */
        .btn-login {
            background: #e74c3c;
            color: #fff !important;
            border-radius: 6px;
            padding: 8px 20px !important;
            font-weight: 600;
            transition: background 0.2s, transform 0.15s;
        }
        .btn-login:hover {
            background: #c0392b;
            transform: translateY(-1px);
        }

        /* Hamburger icon colour on dark bg */
        .navbar-toggler {
            border-color: rgba(255,255,255,0.4);
        }
        .navbar-toggler-icon {
            background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 30 30'%3e%3cpath stroke='rgba(255,255,255,0.85)' stroke-width='2' stroke-linecap='round' stroke-miterlimit='10' d='M4 7h22M4 15h22M4 23h22'/%3e%3c/svg%3e");
        }

        /* Body top padding so content doesn't hide under fixed navbar */
        body { padding-top: 72px; }
    </style>
</head>

<body>
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
                <li class="nav-item ms-lg-2">
                    <a class="nav-link btn-login" href="login">🔐 Login</a>
                </li>
            </ul>
        </div>
    </nav>

    <!-- Bootstrap 5 JS (for collapse toggle) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
