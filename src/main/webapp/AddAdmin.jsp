<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="AdminHeader.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Admin — Vasota Lake Camping</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f0f2f5;
            padding-top: 70px;
        }
        .page-container {
            max-width: 600px;
            margin: 40px auto;
            background: white;
            padding: 30px 40px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        h2 {
            text-align: center;
            color: #1a3a6b;
            margin-bottom: 24px;
        }
        .form-group {
            margin-bottom: 18px;
        }
        .form-group label {
            font-weight: bold;
            display: block;
            margin-bottom: 6px;
            color: #444;
        }
        .form-control {
            width: 100%;
            padding: 10px 14px;
            border: 1.5px solid #ccc;
            border-radius: 8px;
            font-size: 15px;
        }
        .form-control:focus {
            outline: none;
            border-color: #007bff;
        }
        .btn-submit {
            width: 100%;
            padding: 12px;
            background: linear-gradient(135deg, #1a3a6b, #007bff);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            margin-top: 10px;
            transition: opacity 0.2s;
        }
        .btn-submit:hover {
            opacity: 0.9;
        }
        .alert {
            padding: 14px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-weight: bold;
            text-align: center;
        }
        .alert-success { background: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
        .alert-error { background: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }
    </style>
</head>
<body>

<div class="page-container">
    <h2>➕ Add New Administrator</h2>

    <% String msg = (String) request.getAttribute("msg");
       String err = (String) request.getAttribute("error");
       if (msg != null) { %>
        <div class="alert alert-success">✅ <%= msg %></div>
    <% } else if (err != null) { %>
        <div class="alert alert-error">❌ <%= err %></div>
    <% } %>

    <form method="POST" action="./AddAdmin">
        <div class="form-group">
            <label>Full Name</label>
            <input type="text" name="fullname" class="form-control" required placeholder="John Doe">
        </div>
        
        <div class="form-group">
            <label>Username</label>
            <input type="text" name="username" class="form-control" required placeholder="admin_john">
        </div>

        <div class="form-group">
            <label>Email Address</label>
            <input type="email" name="email" class="form-control" required placeholder="john@example.com">
        </div>

        <div class="form-group">
            <label>Phone Number</label>
            <input type="tel" name="phone" class="form-control" required placeholder="10-digit number" pattern="[0-9]{10}">
        </div>

        <div class="form-group">
            <label>Password</label>
            <input type="password" name="password" class="form-control" required placeholder="Secure password">
        </div>

        <div class="form-group">
            <label>Confirm Password</label>
            <input type="password" name="confirm_password" class="form-control" required placeholder="Re-enter password">
        </div>

        <button type="submit" class="btn-submit">Create Admin Account</button>
    </form>
</div>

<!-- Re-use the bootstrap script from AdminHeader, but add just in case here -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
