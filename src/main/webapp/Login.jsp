<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login - Vasota Lake Camping</title>
        <style>
            * {
                box-sizing: border-box;
                margin: 0;
                padding: 0;
            }

            body {
                font-family: Arial, sans-serif;
                min-height: 100vh;
                background: linear-gradient(135deg, #0d4a7a, #1a6b3c);
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 30px 15px;
            }

            .card {
                background: white;
                border-radius: 14px;
                box-shadow: 0 8px 32px rgba(0, 0, 0, 0.25);
                width: 100%;
                max-width: 400px;
                overflow: hidden;
            }

            .card-header {
                background: linear-gradient(135deg, #0d4a7a, #007bff);
                color: white;
                text-align: center;
                padding: 32px 20px;
            }

            .card-header h2 {
                font-size: 22px;
                margin-top: 10px;
            }

            .card-header p {
                font-size: 13px;
                opacity: 0.85;
                margin-top: 5px;
            }

            .card-body {
                padding: 28px;
            }

            .form-group {
                margin-bottom: 18px;
            }

            .form-group label {
                display: block;
                font-size: 13px;
                font-weight: bold;
                color: #444;
                margin-bottom: 6px;
            }

            .form-group input {
                width: 100%;
                padding: 11px 13px;
                border: 1.5px solid #ddd;
                border-radius: 7px;
                font-size: 14px;
                transition: border-color 0.2s;
            }

            .form-group input:focus {
                outline: none;
                border-color: #007bff;
            }

            .error-box {
                background: #fff0f0;
                border: 1px solid #ffcccc;
                color: #c0392b;
                padding: 10px 14px;
                border-radius: 7px;
                font-size: 13px;
                margin-bottom: 16px;
            }

            .btn-submit {
                width: 100%;
                padding: 12px;
                background: linear-gradient(135deg, #0d4a7a, #007bff);
                color: white;
                border: none;
                border-radius: 7px;
                font-size: 16px;
                font-weight: bold;
                cursor: pointer;
                transition: opacity 0.2s;
            }

            .btn-submit:hover {
                opacity: 0.9;
            }

            .card-footer {
                text-align: center;
                padding: 16px;
                background: #f9f9f9;
                font-size: 14px;
                color: #555;
                border-top: 1px solid #eee;
            }

            .card-footer a {
                color: #007bff;
                font-weight: bold;
                text-decoration: none;
            }

            .card-footer a:hover {
                text-decoration: underline;
            }

            .admin-hint {
                font-size: 11px;
                color: #aaa;
                text-align: center;
                margin-top: 10px;
            }

            /* ── Demo Credentials Box ── */
            .demo-box {
                background: linear-gradient(135deg, #f0f9ff, #e8f5e9);
                border: 1.5px dashed #a0c4e8;
                border-radius: 12px;
                padding: 18px 20px;
                margin-top: 20px;
                width: 100%;
                max-width: 400px;
            }

            .demo-box h4 {
                font-size: 13px;
                font-weight: bold;
                color: #444;
                margin-bottom: 12px;
                text-align: center;
                letter-spacing: 0.5px;
                text-transform: uppercase;
            }

            .demo-creds {
                display: flex;
                gap: 12px;
            }

            .demo-card {
                flex: 1;
                border-radius: 10px;
                padding: 12px 14px;
                cursor: pointer;
                border: 1.5px solid transparent;
                transition: transform 0.15s, box-shadow 0.15s;
                position: relative;
            }

            .demo-card:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 14px rgba(0, 0, 0, 0.12);
            }

            .demo-card.admin-card {
                background: linear-gradient(135deg, #e8f0fe, #d2e3fc);
                border-color: #aac4f5;
            }

            .demo-card.user-card {
                background: linear-gradient(135deg, #e6f9ee, #c8edd6);
                border-color: #8fceaa;
            }

            .demo-card .role-icon {
                font-size: 22px;
                display: block;
                margin-bottom: 4px;
            }

            .demo-card .role-label {
                font-size: 11px;
                font-weight: bold;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                margin-bottom: 8px;
            }

            .admin-card .role-label {
                color: #1a56db;
            }

            .user-card .role-label {
                color: #1a7a3c;
            }

            .demo-card .cred-row {
                display: flex;
                align-items: center;
                gap: 6px;
                font-size: 12px;
                color: #555;
                margin-bottom: 3px;
            }

            .demo-card .cred-row strong {
                color: #222;
            }

            .demo-card .fill-hint {
                font-size: 10px;
                color: #888;
                margin-top: 6px;
                text-align: center;
            }

            .demo-card .click-badge {
                position: absolute;
                top: -8px;
                right: -8px;
                background: #007bff;
                color: white;
                font-size: 9px;
                padding: 2px 7px;
                border-radius: 10px;
                font-weight: bold;
            }

            .user-card .click-badge {
                background: #28a745;
            }
        </style>
    </head>

    <body>

        <div class="card">
            <div class="card-header">
                <div style="font-size:42px;">🏕️</div>
                <h2>Welcome Back!</h2>
                <p>Login to Vasota Lake Camping</p>
            </div>

            <div class="card-body">

                <%-- Show error from servlet --%>
                    <% String err=(String) request.getAttribute("error"); if (err !=null && !err.isEmpty()) { %>
                        <div class="error-box">⚠️ <%= err %>
                        </div>
                        <% } %>

                            <form method="POST" action="./Login">
                                <div class="form-group">
                                    <label>Username</label>
                                    <input type="text" name="username" placeholder="Enter your username" required
                                        autofocus>
                                </div>
                                <div class="form-group">
                                    <label>Password</label>
                                    <input type="password" name="password" placeholder="Enter your password" required>
                                </div>
                                <button type="submit" class="btn-submit">🔐 Login</button>
                                <p class="admin-hint">Admin? Use your admin credentials to access the dashboard.</p>
                            </form>
            </div>

            <div class="card-footer">
                Don't have an account? <a href="signup">Register here</a>
            </div>
        </div>

        <!-- ── Demo Credentials ── -->
        <div class="demo-box">
            <h4>🔑 Demo Credentials — Click to Auto-fill</h4>
            <div class="demo-creds">

                <!-- Admin Card -->
                <div class="demo-card admin-card" onclick="fillCreds('admin','admin123')">
                    <span class="click-badge">CLICK</span>
                    <span class="role-icon">🛡️</span>
                    <div class="role-label">Admin</div>
                    <div class="cred-row">👤 <strong>admin</strong></div>
                    <div class="cred-row">🔒 <strong>admin123</strong></div>
                    <div class="fill-hint">Full dashboard access</div>
                </div>

                <!-- User Card -->
                <div class="demo-card user-card" onclick="fillCreds('user1','user123')">
                    <span class="click-badge">CLICK</span>
                    <span class="role-icon">🏕️</span>
                    <div class="role-label">User</div>
                    <div class="cred-row">👤 <strong>user1</strong></div>
                    <div class="cred-row">🔒 <strong>user123</strong></div>
                    <div class="fill-hint">View your bookings</div>
                </div>

            </div>
        </div>

        <script>
            function fillCreds(username, password) {
                document.querySelector('input[name="username"]').value = username;
                document.querySelector('input[name="password"]').value = password;
                // Visual feedback
                document.querySelector('input[name="username"]').style.borderColor = '#28a745';
                document.querySelector('input[name="password"]').style.borderColor = '#28a745';
                setTimeout(function () {
                    document.querySelector('input[name="username"]').style.borderColor = '';
                    document.querySelector('input[name="password"]').style.borderColor = '';
                }, 1500);
            }
        </script>

    </body>

    </html>