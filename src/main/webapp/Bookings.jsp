<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="Header.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Book Your Camp — Vasota Lake Camping</title>
<style>
* { box-sizing: border-box; margin: 0; padding: 0; }
body { font-family: Arial, sans-serif; background: #f0f7f3; }

.page-wrap { max-width: 580px; margin: 40px auto; padding: 0 16px 60px; }
.card { background: white; border-radius: 16px; box-shadow: 0 4px 20px rgba(0,0,0,0.10); overflow: hidden; }
.card-header {
    background: linear-gradient(135deg, #1a3a2a, #28a745);
    color: white; padding: 26px 28px; text-align: center;
}
.card-header h2 { font-size: 22px; }
.card-header p  { font-size: 13px; opacity: 0.85; margin-top: 5px; }
.card-body { padding: 28px; }

.form-group { margin-bottom: 16px; }
.form-group label {
    display: block; font-size: 13px;
    font-weight: bold; color: #444; margin-bottom: 6px;
}
.form-group input,
.form-group select {
    width: 100%; padding: 11px 13px;
    border: 1.5px solid #ddd; border-radius: 8px;
    font-size: 14px; background: white; color: #333;
}
.form-group input:focus,
.form-group select:focus { outline: none; border-color: #28a745; }
.form-row { display: grid; grid-template-columns: 1fr 1fr; gap: 14px; }

/* Account section separator */
.section-divider {
    display: flex; align-items: center; gap: 10px;
    margin: 20px 0 16px;
}
.section-divider span {
    font-size: 13px; font-weight: bold;
    color: #1a3a2a; white-space: nowrap;
    background: #e6f9ee; padding: 4px 12px;
    border-radius: 20px;
}
.section-divider::before,
.section-divider::after {
    content: ''; flex: 1;
    height: 1px; background: #ddd;
}

.hint { font-size: 11px; color: #999; margin-top: 4px; }

/* Password strength bar */
.strength-wrap { margin-top: 5px; }
.strength-bar {
    height: 4px; background: #eee;
    border-radius: 2px; overflow: hidden;
}
.strength-fill {
    height: 100%; width: 0%;
    border-radius: 2px;
    transition: width 0.3s, background 0.3s;
}
.strength-label { font-size: 11px; color: #aaa; margin-top: 3px; }

.price-preview {
    background: #f0f7f3; border: 2px solid #28a745;
    border-radius: 8px; padding: 14px 16px; margin-bottom: 20px;
    display: flex; justify-content: space-between; align-items: center;
}
.price-label { font-size: 14px; color: #1a3a2a; font-weight: bold; }
.price-val   { font-size: 24px; font-weight: bold; color: #28a745; }

.error-msg {
    background: #fff0f0; border: 1px solid #ffcccc;
    color: #c0392b; padding: 12px 14px; border-radius: 8px;
    font-size: 13px; margin-bottom: 16px;
}

/* Step indicator */
.step-indicator {
    display: flex; align-items: center; justify-content: center;
    gap: 8px; margin-bottom: 22px; font-size: 13px; color: #aaa;
}
.step { padding: 5px 14px; border-radius: 20px; background: #eee; }
.step.active { background: #28a745; color: white; font-weight: bold; }
.step-line { width: 30px; height: 2px; background: #ddd; }

#step1 { display: block; }
#step2 { display: none; }

/* Payment step */
.payment-card {
    border: 2px solid #eee; border-radius: 12px;
    padding: 18px; margin-bottom: 12px; cursor: pointer;
    transition: border-color 0.2s, background 0.2s;
    display: flex; align-items: center; gap: 16px;
}
.payment-card:hover { border-color: #28a745; background: #f9fff9; }
.payment-card .pay-icon { font-size: 36px; }
.payment-card h4 { font-size: 15px; color: #222; margin-bottom: 3px; }
.payment-card p  { font-size: 12px; color: #888; }

.btn-pay {
    width: 100%; padding: 14px; border-radius: 8px;
    font-size: 16px; font-weight: bold; cursor: pointer;
    border: none; margin-bottom: 10px;
}
.btn-confirm  { background: linear-gradient(135deg, #1a3a2a, #28a745); color: white; }
.btn-pay-online  { background: linear-gradient(135deg, #007bff, #00c6ff); color: white; }
.btn-pay-offline { background: linear-gradient(135deg, #1a3a2a, #28a745); color: white; }
.btn-back {
    width: 100%; padding: 11px; border-radius: 8px;
    font-size: 14px; cursor: pointer; background: white;
    border: 1.5px solid #ccc; color: #666; margin-top: 4px;
}

.summary-box {
    background: #f8f9fa; border-radius: 10px;
    padding: 16px; margin-bottom: 20px;
}
.summary-box h4 { font-size: 14px; color: #333; margin-bottom: 10px; font-weight: bold; }
.summary-row {
    display: flex; justify-content: space-between;
    font-size: 13px; color: #555; margin-bottom: 6px;
}
.summary-row.total {
    border-top: 1px dashed #ccc; padding-top: 8px; margin-top: 4px;
    font-size: 16px; font-weight: bold; color: #28a745;
}

.login-hint { text-align: center; margin-top: 16px; font-size: 13px; color: #888; }
.login-hint a { color: #28a745; font-weight: bold; text-decoration: none; }
</style>
</head>
<body>

<div class="page-wrap">
  <div class="card">
    <div class="card-header">
        <div style="font-size:36px;">⛺</div>
        <h2>Book Your Camping Experience</h2>
        <p>Vasota Lake Camping — Sahyadri Ranges</p>
    </div>
    <div class="card-body">

        <!-- Step indicator -->
        <div class="step-indicator">
            <div class="step active" id="dot1">1 Details</div>
            <div class="step-line"></div>
            <div class="step" id="dot2">2 Payment</div>
        </div>

        <!-- Server-side error -->
        <% String err = (String) request.getAttribute("error");
           if (err != null && !err.isEmpty()) { %>
            <div class="error-msg">⚠️ <%= err %></div>
        <% } %>
        <div class="error-msg" id="jsError" style="display:none;"></div>

        <!-- ══ STEP 1: Booking + Account Details ══ -->
        <div id="step1">

            <!-- Camp details -->
            <div class="form-row">
                <div class="form-group">
                    <label>Full Name *</label>
                    <input type="text" id="f_name" placeholder="Your full name">
                </div>
                <div class="form-group">
                    <label>Phone *</label>
                    <input type="tel" id="f_phone" placeholder="10-digit number" maxlength="10">
                </div>
            </div>

            <div class="form-group">
                <label>Email *</label>
                <input type="email" id="f_email" placeholder="your@email.com">
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label>Adults *</label>
                    <input type="number" id="f_persons" min="1" value="1" oninput="updateCost()">
                </div>
                <div class="form-group">
                    <label>Kids</label>
                    <input type="number" id="f_kids" min="0" value="0">
                </div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label>Arrival Date *</label>
                    <input type="date" id="f_arrival" onchange="updateDeparture()">
                </div>
                <div class="form-group">
                    <label>Departure Date *</label>
                    <input type="date" id="f_departure">
                </div>
            </div>

            <div class="form-group">
                <label>Select Accommodation *</label>
                <select id="f_tent" onchange="updateCost()">
                    <option value="101" data-price="800">⛺ Regular Tent — ₹800/person</option>
                    <option value="102" data-price="1200">🔺 Triangle Tent — ₹1,200/person</option>
                    <option value="103" data-price="2500">🌲 Machan Cottage — ₹2,500/person</option>
                    <option value="104" data-price="3500">🏠 Elevator Cottage — ₹3,500/person</option>
                    <option value="105" data-price="5000">✨ Glamping — ₹5,000/person</option>
                    <option value="106" data-price="8000">👑 Ultra Luxury Cottage — ₹8,000/person</option>
                </select>
            </div>

            <div class="price-preview">
                <span class="price-label">Estimated Total</span>
                <span class="price-val" id="costDisplay">₹800</span>
            </div>

            <!-- ── Account Section ── -->
            <div class="section-divider">
                <span>🔐 Create Login Account</span>
            </div>
            <p style="font-size:13px;color:#777;margin-bottom:14px;">
                Set a username &amp; password to track your bookings after payment.
            </p>

            <div class="form-row">
                <div class="form-group">
                    <label>Username *</label>
                    <input type="text" id="f_username" placeholder="e.g. rahul123"
                           oninput="this.value = this.value.replace(/\s/g,'')">
                    <div class="hint">Letters, numbers, _ only. No spaces.</div>
                </div>
                <div class="form-group">
                    <label>Password *</label>
                    <input type="password" id="f_password" placeholder="Min 6 characters"
                           oninput="checkStrength(this.value)">
                    <div class="strength-wrap">
                        <div class="strength-bar">
                            <div class="strength-fill" id="strengthFill"></div>
                        </div>
                        <div class="strength-label" id="strengthLabel">Enter a password</div>
                    </div>
                </div>
            </div>

            <button type="button" class="btn-pay btn-confirm" onclick="goToStep2()">
                ✅ Confirm Booking →
            </button>
        </div>

        <!-- ══ STEP 2: Payment Choice ══ -->
        <div id="step2">

            <div class="summary-box">
                <h4>📋 Booking Summary</h4>
                <div class="summary-row"><span>Name</span><span id="s_name">—</span></div>
                <div class="summary-row"><span>Username</span><span id="s_username">—</span></div>
                <div class="summary-row"><span>Tent</span><span id="s_tent">—</span></div>
                <div class="summary-row"><span>Arrival</span><span id="s_arrival">—</span></div>
                <div class="summary-row"><span>Departure</span><span id="s_departure">—</span></div>
                <div class="summary-row"><span>Guests</span><span id="s_persons">—</span></div>
                <div class="summary-row total"><span>Total</span><span id="s_cost">—</span></div>
            </div>

            <p style="font-size:14px;color:#555;margin-bottom:14px;font-weight:bold;">
                Choose how you'd like to pay:
            </p>

            <!-- PAY NOW form -->
            <form method="POST" action="Bookings" id="formOnline">
                <input type="hidden" name="paymentMethod" value="ONLINE">
                <input type="hidden" name="uname"      id="h_name">
                <input type="hidden" name="email"      id="h_email">
                <input type="hidden" name="phoneNo"    id="h_phone">
                <input type="hidden" name="NoPersons"  id="h_persons">
                <input type="hidden" name="NoKids"     id="h_kids">
                <input type="hidden" name="arrivals"   id="h_arrival">
                <input type="hidden" name="departure"  id="h_departure">
                <input type="hidden" name="tent"       id="h_tent">
                <input type="hidden" name="username"   id="h_username">
                <input type="hidden" name="password"   id="h_password">

                <div class="payment-card"
                     onclick="document.getElementById('formOnline').submit()">
                    <div class="pay-icon">💳</div>
                    <div>
                        <h4>Pay Now (Online)</h4>
                        <p>Booking marked as PAID instantly.</p>
                    </div>
                </div>
                <button type="submit" class="btn-pay btn-pay-online">
                    💳 Pay Now
                </button>
            </form>

            <!-- PAY ON ARRIVAL form -->
            <form method="POST" action="Bookings" id="formOffline" style="margin-top:8px;">
                <input type="hidden" name="paymentMethod" value="OFFLINE">
                <input type="hidden" name="uname"      id="h2_name">
                <input type="hidden" name="email"      id="h2_email">
                <input type="hidden" name="phoneNo"    id="h2_phone">
                <input type="hidden" name="NoPersons"  id="h2_persons">
                <input type="hidden" name="NoKids"     id="h2_kids">
                <input type="hidden" name="arrivals"   id="h2_arrival">
                <input type="hidden" name="departure"  id="h2_departure">
                <input type="hidden" name="tent"       id="h2_tent">
                <input type="hidden" name="username"   id="h2_username">
                <input type="hidden" name="password"   id="h2_password">

                <div class="payment-card"
                     onclick="document.getElementById('formOffline').submit()">
                    <div class="pay-icon">🏕️</div>
                    <div>
                        <h4>Pay on Arrival</h4>
                        <p>Pay cash when you arrive at the campsite.</p>
                    </div>
                </div>
                <button type="submit" class="btn-pay btn-pay-offline">
                    🏕️ Pay on Arrival
                </button>
            </form>

            <button type="button" class="btn-back" onclick="goBack()">
                ← Back to Details
            </button>
        </div>

        <p class="login-hint">
            Already have an account?
            <a href="Login.jsp">Login to track your bookings</a>
        </p>
    </div>
  </div>
</div>

<script>
    var PRICES = {101:800,102:1200,103:2500,104:3500,105:5000,106:8000};
    var TNAMES = {
        101:'Regular Tent', 102:'Triangle Tent', 103:'Machan Cottage',
        104:'Elevator Cottage', 105:'Glamping', 106:'Ultra Luxury Cottage'
    };

    window.onload = function() {
        var today = new Date().toISOString().split('T')[0];
        document.getElementById('f_arrival').min  = today;
        document.getElementById('f_departure').min = today;
        updateCost();
    };

    function updateDeparture() {
        var arr = document.getElementById('f_arrival').value;
        if (arr) document.getElementById('f_departure').min = arr;
    }

    function updateCost() {
        var tentId  = parseInt(document.getElementById('f_tent').value);
        var persons = parseInt(document.getElementById('f_persons').value) || 1;
        var total   = (PRICES[tentId] || 800) * persons;
        document.getElementById('costDisplay').textContent =
            '\u20B9' + total.toLocaleString('en-IN');
    }

    function checkStrength(val) {
        var fill  = document.getElementById('strengthFill');
        var label = document.getElementById('strengthLabel');
        var score = 0;
        if (val.length >= 6)              score++;
        if (val.length >= 10)             score++;
        if (/[A-Z]/.test(val))            score++;
        if (/[0-9]/.test(val))            score++;
        if (/[^A-Za-z0-9]/.test(val))    score++;
        var pct   = (score / 5) * 100;
        var color = score <= 2 ? '#e74c3c' : score <= 3 ? '#f39c12' : '#27ae60';
        var text  = score <= 2 ? 'Weak' : score <= 3 ? 'Medium' : 'Strong';
        fill.style.width      = pct + '%';
        fill.style.background = color;
        label.textContent     = text;
        label.style.color     = color;
    }

    function showError(msg) {
        var box = document.getElementById('jsError');
        box.textContent = '\u26A0\uFE0F ' + msg;
        box.style.display = 'block';
        window.scrollTo(0, 0);
    }

    function goToStep2() {
        document.getElementById('jsError').style.display = 'none';

        var name     = document.getElementById('f_name').value.trim();
        var phone    = document.getElementById('f_phone').value.trim();
        var email    = document.getElementById('f_email').value.trim();
        var persons  = parseInt(document.getElementById('f_persons').value);
        var kids     = document.getElementById('f_kids').value || '0';
        var arrival  = document.getElementById('f_arrival').value;
        var departure= document.getElementById('f_departure').value;
        var tentId   = document.getElementById('f_tent').value;
        var username = document.getElementById('f_username').value.trim();
        var password = document.getElementById('f_password').value;

        // Validate booking fields
        if (!name)                          { showError('Please enter your full name.');            return; }
        if (!/^[A-Za-z\s]+$/.test(name))   { showError('Name should contain letters only.');       return; }
        if (!/^[0-9]{10}$/.test(phone))     { showError('Enter a valid 10-digit phone number.');    return; }
        if (!email || !email.includes('@')) { showError('Enter a valid email address.');            return; }
        if (!persons || persons < 1)        { showError('At least 1 adult is required.');           return; }
        if (!arrival)                       { showError('Please select an arrival date.');           return; }
        if (!departure)                     { showError('Please select a departure date.');          return; }
        if (departure <= arrival)           { showError('Departure must be after arrival date.');    return; }

        // Validate account fields
        if (!username || username.length < 3) { showError('Username must be at least 3 characters.');  return; }
        if (!/^[A-Za-z0-9_]+$/.test(username)){ showError('Username: letters, numbers and _ only.');   return; }
        if (!password || password.length < 6) { showError('Password must be at least 6 characters.');  return; }

        // Compute total
        var total = (PRICES[parseInt(tentId)] || 800) * persons;
        var fmt   = '\u20B9' + total.toLocaleString('en-IN');

        // Fill summary
        document.getElementById('s_name').textContent      = name;
        document.getElementById('s_username').textContent  = username;
        document.getElementById('s_tent').textContent      = TNAMES[parseInt(tentId)] || tentId;
        document.getElementById('s_arrival').textContent   = arrival;
        document.getElementById('s_departure').textContent = departure;
        document.getElementById('s_persons').textContent   = persons + ' adult(s), ' + kids + ' kid(s)';
        document.getElementById('s_cost').textContent      = fmt;

        // Fill hidden fields — ONLINE form
        document.getElementById('h_name').value     = name;
        document.getElementById('h_email').value    = email;
        document.getElementById('h_phone').value    = phone;
        document.getElementById('h_persons').value  = persons;
        document.getElementById('h_kids').value     = kids;
        document.getElementById('h_arrival').value  = arrival;
        document.getElementById('h_departure').value= departure;
        document.getElementById('h_tent').value     = tentId;
        document.getElementById('h_username').value = username;
        document.getElementById('h_password').value = password;

        // Fill hidden fields — OFFLINE form
        document.getElementById('h2_name').value     = name;
        document.getElementById('h2_email').value    = email;
        document.getElementById('h2_phone').value    = phone;
        document.getElementById('h2_persons').value  = persons;
        document.getElementById('h2_kids').value     = kids;
        document.getElementById('h2_arrival').value  = arrival;
        document.getElementById('h2_departure').value= departure;
        document.getElementById('h2_tent').value     = tentId;
        document.getElementById('h2_username').value = username;
        document.getElementById('h2_password').value = password;

        // Show step 2
        document.getElementById('step1').style.display = 'none';
        document.getElementById('step2').style.display = 'block';
        document.getElementById('dot1').classList.remove('active');
        document.getElementById('dot2').classList.add('active');
        window.scrollTo(0, 0);
    }

    function goBack() {
        document.getElementById('step2').style.display = 'none';
        document.getElementById('step1').style.display = 'block';
        document.getElementById('dot2').classList.remove('active');
        document.getElementById('dot1').classList.add('active');
    }
</script>
</body>
</html>
