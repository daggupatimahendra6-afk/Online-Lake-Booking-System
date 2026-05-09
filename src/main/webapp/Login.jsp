<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login - Vasota Lake Camping</title>
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700&display=swap');
            
            * {
                box-sizing: border-box;
                margin: 0;
                padding: 0;
            }

            body {
                font-family: 'Outfit', sans-serif;
                min-height: 100vh;
                background: linear-gradient(135deg, rgba(10, 46, 31, 0.4), rgba(18, 138, 66, 0.5)), url('./images/vasota.jpg') center/cover no-repeat;
                /* Optional backdrop filter on a pseudo-element if we want to blur the whole background, but a clear background looks nice too. Let's do a soft overlay. */
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                padding: 40px 15px;
                position: relative;
            }
            body::before {
                content: ''; position: absolute; top:0; left:0; right:0; bottom:0;
                background: rgba(10, 46, 31, 0.6); /* Dark forest overlay */
                backdrop-filter: blur(8px);
                -webkit-backdrop-filter: blur(8px);
                z-index: -1;
            }

            .card {
                background: rgba(255, 255, 255, 0.95);
                backdrop-filter: blur(15px);
                border-radius: 24px;
                box-shadow: 0 20px 50px rgba(0, 0, 0, 0.2);
                width: 100%;
                max-width: 420px;
                overflow: hidden;
                border: 1px solid rgba(255, 255, 255, 0.4);
                animation: scaleUp 0.5s cubic-bezier(0.16, 1, 0.3, 1) forwards;
            }

            @keyframes scaleUp {
                from { opacity: 0; transform: translateY(30px) scale(0.95); }
                to { opacity: 1; transform: translateY(0) scale(1); }
            }

            .card-header {
                background: linear-gradient(135deg, #0A2E1F, #128a42);
                color: white;
                text-align: center;
                padding: 40px 20px 30px;
                position: relative;
            }
            .card-header::after {
                content: ''; position: absolute; bottom: -12px; left: 0; right: 0; height: 12px;
                background: white; border-radius: 12px 12px 0 0;
            }

            .card-header h2 {
                font-size: 28px;
                font-weight: 700;
                margin-top: 12px;
                letter-spacing: -0.5px;
            }

            .card-header p {
                font-size: 15px;
                opacity: 0.9;
                margin-top: 6px;
                font-weight: 300;
            }

            .card-body {
                padding: 30px 40px 40px;
            }

            .form-group {
                margin-bottom: 22px;
            }

            .form-group label {
                display: block;
                font-size: 14px;
                font-weight: 600;
                color: #444;
                margin-bottom: 8px;
            }

            .form-group input {
                width: 100%;
                padding: 14px 16px;
                border: 1.5px solid #e1e8e4;
                border-radius: 12px;
                font-size: 15px;
                transition: all 0.2s ease;
                background: #fafdfb;
                font-family: inherit;
            }

            .form-group input:focus {
                outline: none;
                border-color: #1aa356;
                background: #fff;
                box-shadow: 0 0 0 4px rgba(26, 163, 86, 0.1);
            }

            /* ── Show/Hide password wrapper ── */
            .pw-wrap { position: relative; }
            .pw-wrap input { padding-right: 46px; }
            .pw-toggle {
                position: absolute;
                right: 14px; top: 50%;
                transform: translateY(-50%);
                background: none; border: none;
                cursor: pointer; font-size: 18px;
                color: #999; line-height: 1;
                padding: 0; transition: color 0.2s;
            }
            .pw-toggle:hover { color: #1aa356; }

            .error-box {
                background: #fff5f5;
                border: 1px solid #ffd6d6;
                color: #d63031;
                padding: 14px;
                border-radius: 12px;
                font-size: 14px;
                margin-bottom: 24px;
                font-weight: 500;
                text-align: center;
            }

            .btn-submit {
                width: 100%;
                padding: 16px;
                background: linear-gradient(135deg, #1aa356, #128a42);
                color: white;
                border: none;
                border-radius: 12px;
                font-size: 17px;
                font-weight: 700;
                cursor: pointer;
                transition: all 0.3s;
                box-shadow: 0 6px 15px rgba(26, 163, 86, 0.2);
            }

            .btn-submit:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 20px rgba(26, 163, 86, 0.3);
                background: linear-gradient(135deg, #1cc164, #159f4d);
            }

            .card-footer {
                text-align: center;
                padding: 24px;
                background: #f8faf9;
                font-size: 15px;
                color: #666;
                border-top: 1px solid #e1e8e4;
            }

            .card-footer a {
                color: #1aa356;
                font-weight: 700;
                text-decoration: none;
                transition: color 0.2s;
            }

            .card-footer a:hover {
                text-decoration: underline;
                color: #128a42;
            }

            .admin-hint {
                font-size: 13px;
                color: #888;
                text-align: center;
                margin-top: 16px;
            }

            /* ── Demo Credentials Box ── */
            .demo-box {
                background: rgba(255, 255, 255, 0.95);
                backdrop-filter: blur(10px);
                border-radius: 20px;
                padding: 24px;
                margin-top: 24px;
                width: 100%;
                max-width: 420px;
                box-shadow: 0 10px 30px rgba(0,0,0,0.15);
                animation: scaleUp 0.6s cubic-bezier(0.16, 1, 0.3, 1) forwards;
                opacity: 0; /* for animation */
            }

            .demo-box h4 {
                font-size: 14px;
                font-weight: 700;
                color: #0A2E1F;
                margin-bottom: 16px;
                text-align: center;
                letter-spacing: 0.5px;
                text-transform: uppercase;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 8px;
            }

            .demo-creds {
                display: flex;
                gap: 16px;
            }

            .demo-card {
                flex: 1;
                border-radius: 16px;
                padding: 16px;
                cursor: pointer;
                border: 1.5px solid transparent;
                transition: all 0.2s;
                position: relative;
                background: #f8faf9;
            }

            .demo-card:hover {
                transform: translateY(-4px);
                box-shadow: 0 8px 20px rgba(0, 0, 0, 0.08);
            }

            .demo-card.admin-card {
                border-color: #aac4f5;
                background: linear-gradient(135deg, #f0f4ff, #e4ebfb);
            }

            .demo-card.admin-card:hover { border-color: #4285f4; }

            .demo-card.user-card {
                border-color: #a7e0c0;
                background: linear-gradient(135deg, #f0fdf5, #e0f8eb);
            }
            .demo-card.user-card:hover { border-color: #1aa356; }

            .demo-card .role-icon {
                font-size: 28px;
                display: block;
                margin-bottom: 8px;
            }

            .demo-card .role-label {
                font-size: 13px;
                font-weight: 800;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                margin-bottom: 10px;
            }

            .admin-card .role-label {
                color: #1a56db;
            }

            .user-card .role-label {
                color: #128a42;
            }

            .demo-card .cred-row {
                display: flex;
                align-items: center;
                gap: 6px;
                font-size: 13px;
                color: #555;
                margin-bottom: 4px;
            }

            .demo-card .cred-row strong {
                color: #222;
                font-family: monospace;
                font-size: 14px;
            }

            .demo-card .fill-hint {
                font-size: 11px;
                color: #888;
                margin-top: 10px;
                text-align: left;
                font-weight: 500;
            }

            .demo-card .click-badge {
                position: absolute;
                top: -10px;
                right: -10px;
                background: #4285f4;
                color: white;
                font-size: 10px;
                padding: 4px 10px;
                border-radius: 12px;
                font-weight: 700;
                box-shadow: 0 2px 8px rgba(66,133,244,0.4);
            }

            .user-card .click-badge {
                background: #1aa356;
                box-shadow: 0 2px 8px rgba(26,163,86,0.4);
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
                                    <div class="pw-wrap">
                                        <input type="password" id="loginPwd" name="password" placeholder="Enter your password" required>
                                        <button type="button" class="pw-toggle" onclick="togglePw('loginPwd', this)" title="Show/hide password">👁️</button>
                                    </div>
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
                document.querySelector('input[name="username"]').style.borderColor = '#28a745';
                document.querySelector('input[name="password"]').style.borderColor = '#28a745';
                setTimeout(function () {
                    document.querySelector('input[name="username"]').style.borderColor = '';
                    document.querySelector('input[name="password"]').style.borderColor = '';
                }, 1500);
            }

            function togglePw(inputId, btn) {
                var inp = document.getElementById(inputId);
                var show = inp.type === 'password';
                inp.type = show ? 'text' : 'password';
                btn.textContent = show ? '\uD83D\uDE48' : '\uD83D\uDC41\uFE0F';
                btn.title = show ? 'Hide password' : 'Show password';
            }
        </script>

    </body>

    </html>