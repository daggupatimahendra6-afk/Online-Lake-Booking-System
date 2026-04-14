<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - Vasota Lake Camping</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body {
            font-family: Arial, sans-serif;
            min-height: 100vh;
            background: linear-gradient(135deg, #1a6b3c, #0d4a7a);
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 30px 15px;
        }
        .card {
            background: white;
            border-radius: 14px;
            box-shadow: 0 8px 32px rgba(0,0,0,0.25);
            width: 100%;
            max-width: 460px;
            overflow: hidden;
        }
        .card-header {
            background: linear-gradient(135deg, #1a6b3c, #28a745);
            color: white;
            text-align: center;
            padding: 28px 20px;
        }
        .card-header h2 { font-size: 22px; }
        .card-header p  { font-size: 13px; opacity: 0.85; margin-top: 5px; }
        .card-body { padding: 28px; }

        .form-group { margin-bottom: 16px; }
        .form-group label {
            display: block;
            font-size: 13px;
            font-weight: bold;
            color: #444;
            margin-bottom: 5px;
        }
        .form-group input {
            width: 100%;
            padding: 10px 12px;
            border: 1.5px solid #ddd;
            border-radius: 7px;
            font-size: 14px;
            transition: border-color 0.2s;
        }
        .form-group input:focus {
            outline: none;
            border-color: #28a745;
        }
        .form-row { display: grid; grid-template-columns: 1fr 1fr; gap: 12px; }

        .error-box {
            background: #fff0f0;
            border: 1px solid #ffcccc;
            color: #c0392b;
            padding: 10px 14px;
            border-radius: 7px;
            font-size: 13px;
            margin-bottom: 16px;
        }
        .hint { font-size: 11px; color: #999; margin-top: 3px; }

        .btn-submit {
            width: 100%;
            padding: 12px;
            background: linear-gradient(135deg, #1a6b3c, #28a745);
            color: white;
            border: none;
            border-radius: 7px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            margin-top: 6px;
            transition: opacity 0.2s;
        }
        .btn-submit:hover { opacity: 0.9; }

        .card-footer {
            text-align: center;
            padding: 16px;
            background: #f9f9f9;
            font-size: 14px;
            color: #555;
            border-top: 1px solid #eee;
        }
        .card-footer a { color: #1a6b3c; font-weight: bold; text-decoration: none; }
        .card-footer a:hover { text-decoration: underline; }

        .strength-bar {
            height: 4px;
            border-radius: 2px;
            margin-top: 5px;
            background: #eee;
            overflow: hidden;
        }
        .strength-fill {
            height: 100%;
            width: 0%;
            transition: width 0.3s, background 0.3s;
            border-radius: 2px;
        }
    </style>
</head>
<body>

<div class="card">
    <div class="card-header">
        <div style="font-size:40px;">⛺</div>
        <h2>Create Your Account</h2>
        <p>Join Vasota Lake Camping today</p>
    </div>

    <div class="card-body">

        <%-- Show server-side error if any --%>
        <% String err = (String) request.getAttribute("error");
           if (err != null && !err.isEmpty()) { %>
            <div class="error-box">⚠️ <%= err %></div>
        <% } %>

        <form method="POST" action="./SignUp" onsubmit="return validateForm()">

            <div class="form-group">
                <label>Full Name *</label>
                <input type="text" name="fullname" id="fullname"
                       placeholder="e.g. Rahul Sharma" required>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label>Username *</label>
                    <input type="text" name="username" id="username"
                           placeholder="e.g. rahul123" required
                           pattern="[A-Za-z0-9_]{3,20}">
                    <div class="hint">3–20 chars, letters/numbers/_</div>
                </div>
                <div class="form-group">
                    <label>Phone Number *</label>
                    <input type="tel" name="phone" id="phone"
                           placeholder="10-digit mobile" required
                           pattern="[0-9]{10}">
                </div>
            </div>

            <div class="form-group">
                <label>Email Address *</label>
                <input type="email" name="email" id="email"
                       placeholder="rahul@example.com" required>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label>Password *</label>
                    <input type="password" name="password" id="password"
                           placeholder="Min 6 characters" required minlength="6"
                           oninput="checkStrength(this.value)">
                    <div class="strength-bar">
                        <div class="strength-fill" id="strengthFill"></div>
                    </div>
                </div>
                <div class="form-group">
                    <label>Confirm Password *</label>
                    <input type="password" name="confirm_password" id="confirm_password"
                           placeholder="Re-enter password" required>
                </div>
            </div>

            <button type="submit" class="btn-submit">🚀 Register Now</button>
        </form>
    </div>

    <div class="card-footer">
        Already have an account? <a href="login">Login here</a>
    </div>
</div>

<script>
    function checkStrength(val) {
        let fill = document.getElementById('strengthFill');
        let score = 0;
        if (val.length >= 6)  score++;
        if (val.length >= 10) score++;
        if (/[A-Z]/.test(val)) score++;
        if (/[0-9]/.test(val)) score++;
        if (/[^A-Za-z0-9]/.test(val)) score++;
        let pct = (score / 5) * 100;
        let color = score <= 2 ? '#e74c3c' : score <= 3 ? '#f39c12' : '#27ae60';
        fill.style.width = pct + '%';
        fill.style.background = color;
    }

    function validateForm() {
        let pwd  = document.getElementById('password').value;
        let conf = document.getElementById('confirm_password').value;
        let name = document.getElementById('fullname').value;

        if (!/^[A-Za-z\s]+$/.test(name)) {
            alert('Full Name should contain only letters and spaces.');
            return false;
        }
        if (pwd !== conf) {
            alert('Passwords do not match!');
            return false;
        }
        return true;
    }
</script>

</body>
</html>
