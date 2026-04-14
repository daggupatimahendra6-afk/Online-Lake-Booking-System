<%@ page language="java" contentType="text/html; charset=UTF-8" isErrorPage="true"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>404 — Page Not Found | Vasota Lake Camping</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #0d2a4e, #1a5276);
            min-height: 100vh;
            display: flex; align-items: center; justify-content: center;
        }
        .card {
            background: white;
            border-radius: 20px;
            padding: 48px 52px;
            text-align: center;
            max-width: 460px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
        }
        .icon { font-size: 72px; margin-bottom: 16px; }
        h1 { font-size: 28px; color: #e67e22; margin-bottom: 10px; }
        p  { color: #666; font-size: 15px; line-height: 1.6; }
        a  {
            display: inline-block; margin-top: 28px;
            background: linear-gradient(135deg, #1a3a6b, #007bff);
            color: white; padding: 12px 32px;
            border-radius: 30px; text-decoration: none;
            font-weight: bold; transition: opacity 0.2s;
        }
        a:hover { opacity: 0.88; }
    </style>
</head>
<body>
    <div class="card">
        <div class="icon">🏕️</div>
        <h1>404 — Page Not Found</h1>
        <p>The page you're looking for doesn't exist or has been moved.<br>
           Let us guide you back to the campsite!</p>
        <a href="<%= request.getContextPath() %>/">← Back to Home</a>
    </div>
</body>
</html>
