<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="Header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Vasota Camping Portal</title>

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
    body {
        background-color: #f8f9fa;
    }
    .welcome-box {
        margin-top: 100px;
        padding: 40px;
        background: #ffffff;
        border-radius: 10px;
        box-shadow: 0 4px 10px rgba(0,0,0,0.1);
    }
    footer {
        margin-top: 100px;
        padding: 15px;
        background: #212529;
        color: white;
        text-align: center;
    }
</style>

</head>
<body>

<!-- NAVBAR -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="#">Vasota Camping</a>

        <button class="navbar-toggler" data-bs-toggle="collapse" data-bs-target="#nav">
            <span class="navbar-toggler-icon"></span>
        </button>
</nav>

<!-- MAIN CONTENT -->
<div class="container text-center">
    <div class="welcome-box mx-auto col-md-8">

        <h1 class="fw-bold text-primary">
            Welcome to Vasota Camping Portal
        </h1>

        <p class="lead mt-3">
            Discover nature, plan your camping trip, and enjoy peaceful adventures.
        </p>

        <div class="mt-4">
            <a href="Bookings.jsp" class="btn btn-primary me-2 px-4">Book Now</a>
            <a href="Login.jsp" class="btn btn-outline-secondary px-4">Login</a>
        </div>

    </div>
</div>

<!-- FOOTER -->
<footer>
    <p>© 2026 Vasota Camping Portal | All Rights Reserved</p>
</footer>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>