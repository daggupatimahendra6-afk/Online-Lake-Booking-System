<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Book Your Camp — Vasota Lake Camping</title>
<style>
* { box-sizing: border-box; margin: 0; padding: 0; }
body { 
    font-family: 'Outfit', sans-serif; 
    background: linear-gradient(135deg, rgba(10, 46, 31, 0.03), rgba(18, 138, 66, 0.05)), url('./images/vasota.jpg') fixed center/cover;
    position: relative;
}
/* Overlay for the background image to make the form pop */
body::before {
    content: ''; position: fixed; top: 0; left: 0; right: 0; bottom: 0;
    background: rgba(240, 247, 243, 0.85); /* Light green-white tint */
    backdrop-filter: blur(10px);
    z-index: -1;
}

.page-wrap { max-width: 600px; margin: 50px auto; padding: 0 16px 80px; position: relative; z-index: 1; }
.card { 
    background: rgba(255, 255, 255, 0.95); 
    border-radius: 20px; 
    box-shadow: 0 15px 40px rgba(0,0,0,0.1); 
    overflow: hidden; 
    border: 1px solid rgba(255,255,255,0.6);
}
.card-header {
    background: linear-gradient(135deg, #0A2E1F, #128a42);
    color: white; padding: 32px 28px; text-align: center;
    position: relative;
}
/* Subtle glow inside header */
.card-header::after {
    content: ''; position: absolute; bottom: -10px; left: 0; right: 0; height: 10px;
    box-shadow: 0 -10px 20px rgba(18,138,66,0.3); border-radius: 50%;
}
.card-header h2 { font-size: 26px; font-weight: 700; margin-top: 10px; }
.card-header p  { font-size: 15px; opacity: 0.85; margin-top: 5px; font-weight: 300;}
.card-body { padding: 34px; }

.form-group { margin-bottom: 20px; }
.form-group label {
    display: block; font-size: 14px;
    font-weight: 600; color: #333; margin-bottom: 8px;
}
.form-group input,
.form-group select {
    width: 100%; padding: 13px 16px;
    border: 1.5px solid #e1e8e4; border-radius: 12px;
    font-size: 15px; background: #fafdfb; color: #222;
    transition: all 0.2s ease;
    font-family: inherit;
}
.form-group input:focus,
.form-group select:focus { 
    outline: none; 
    border-color: #1aa356; 
    background: #fff;
    box-shadow: 0 0 0 4px rgba(26, 163, 86, 0.1);
}
.form-row { display: grid; grid-template-columns: 1fr 1fr; gap: 16px; }

/* Account section separator */
.section-divider {
    display: flex; align-items: center; gap: 12px;
    margin: 30px 0 20px;
}
.section-divider span {
    font-size: 14px; font-weight: 700;
    color: #0A2E1F; white-space: nowrap;
    background: #e9f7ef; padding: 6px 16px;
    border-radius: 20px;
}
.section-divider::before,
.section-divider::after {
    content: ''; flex: 1;
    height: 1.5px; background: #e1e8e4;
}

.hint { font-size: 12px; color: #888; margin-top: 6px; }

/* Password strength bar */
.strength-wrap { margin-top: 8px; }
.strength-bar {
    height: 5px; background: #eee;
    border-radius: 3px; overflow: hidden;
}
.strength-fill {
    height: 100%; width: 0%;
    border-radius: 3px;
    transition: width 0.3s ease, background 0.3s ease;
}
.strength-label { font-size: 12px; color: #999; margin-top: 4px; font-weight: 500;}

/* ── Show/Hide password wrapper ── */
.pw-wrap { position: relative; }
.pw-wrap input { padding-right: 46px !important; }
.pw-toggle {
    position: absolute;
    right: 14px; top: 50%;
    transform: translateY(-50%);
    background: none; border: none;
    cursor: pointer; font-size: 18px;
    color: #aaa; line-height: 1; padding: 0;
    transition: color 0.2s;
}
.pw-toggle:hover { color: #1aa356; }

.price-preview {
    background: #f4fbf7; border: 2px solid rgba(26, 163, 86, 0.3);
    border-radius: 12px; padding: 18px 20px; margin-bottom: 24px;
    display: flex; justify-content: space-between; align-items: center;
    box-shadow: inset 0 2px 10px rgba(0,0,0,0.02);
}
.price-label { font-size: 15px; color: #0A2E1F; font-weight: 700; }
.price-val   { font-size: 28px; font-weight: 700; color: #1aa356; }

.error-msg {
    background: #fff5f5; border: 1px solid #ffd6d6;
    color: #d63031; padding: 14px 18px; border-radius: 12px;
    font-size: 14px; margin-bottom: 20px; font-weight: 500;
}

/* Step indicator */
.step-indicator {
    display: flex; align-items: center; justify-content: center;
    gap: 10px; margin-bottom: 30px; font-size: 14px; color: #aaa; font-weight: 600;
}
.step { padding: 8px 18px; border-radius: 24px; background: #f0f2f1; transition: all 0.3s; }
.step.active { background: #1aa356; color: white; box-shadow: 0 4px 10px rgba(26,163,86,0.2); }
.step-line { width: 40px; height: 2px; background: #e1e8e4; }

#step1 { display: block; }
#step2 { display: none; }

/* Payment step */
.payment-card {
    border: 2px solid #e1e8e4; border-radius: 16px;
    padding: 20px; margin-bottom: 14px; cursor: pointer;
    transition: all 0.2s ease;
    display: flex; align-items: center; gap: 20px;
    background: #fff;
}
.payment-card:hover { border-color: #1aa356; background: #f4fbf7; transform: translateY(-2px); box-shadow: 0 4px 15px rgba(0,0,0,0.05); }
.payment-card .pay-icon { font-size: 40px; }
.payment-card h4 { font-size: 16px; font-weight: 700; color: #222; margin-bottom: 4px; }
.payment-card p  { font-size: 13px; color: #777; }

.btn-pay {
    width: 100%; padding: 16px; border-radius: 12px;
    font-size: 17px; font-weight: 700; cursor: pointer;
    border: none; margin-bottom: 12px; transition: all 0.2s;
}
.btn-confirm  { background: linear-gradient(135deg, #1aa356, #128a42); color: white; box-shadow: 0 4px 15px rgba(26, 163, 86, 0.3); }
.btn-confirm:hover { background: linear-gradient(135deg, #1cc164, #159f4d); transform: translateY(-2px); box-shadow: 0 6px 20px rgba(26, 163, 86, 0.4); }

.btn-pay-online  { background: linear-gradient(135deg, #2D9CDB, #2980b9); color: white; box-shadow: 0 4px 15px rgba(45, 156, 219, 0.3); }
.btn-pay-online:hover { background: linear-gradient(135deg, #34aadc, #2c8cce); transform: translateY(-2px); box-shadow: 0 6px 20px rgba(45, 156, 219, 0.4); }

.btn-pay-offline { background: linear-gradient(135deg, #0A2E1F, #128a42); color: white; box-shadow: 0 4px 15px rgba(10, 46, 31, 0.3); }
.btn-pay-offline:hover { background: linear-gradient(135deg, #0c3b28, #159f4d); transform: translateY(-2px); box-shadow: 0 6px 20px rgba(10, 46, 31, 0.4); }

.btn-back {
    width: 100%; padding: 14px; border-radius: 12px;
    font-size: 15px; font-weight: 600; cursor: pointer; background: white;
    border: 1.5px solid #ccc; color: #666; margin-top: 6px; transition: all 0.2s;
}
.btn-back:hover { background: #f9f9f9; transform: translateY(-1px); }

.summary-box {
    background: #f8faf9; border-radius: 16px;
    padding: 24px; margin-bottom: 24px; border: 1px solid #e1e8e4;
}
.summary-box h4 { font-size: 16px; color: #0A2E1F; margin-bottom: 14px; font-weight: 700; display: flex; align-items: center; gap: 8px;}
.summary-row {
    display: flex; justify-content: space-between;
    font-size: 14px; color: #555; margin-bottom: 10px;
}
.summary-row.total {
    border-top: 1px dashed #ccc; padding-top: 12px; margin-top: 8px;
    font-size: 18px; font-weight: 700; color: #1aa356;
}

.login-hint { text-align: center; margin-top: 24px; font-size: 14px; color: #777; }
.login-hint a { color: #1aa356; font-weight: 700; text-decoration: none; transition: color 0.2s;}
.login-hint a:hover { color: #128a42; text-decoration: underline; }
</style>
</head>
<body>
<%@ include file="Header.jsp"%>

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
                    <input type="date" id="f_departure" onchange="updateCost()">
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
                    <div class="pw-wrap">
                        <input type="password" id="f_password" placeholder="Min 6 characters"
                               oninput="checkStrength(this.value)">
                        <button type="button" class="pw-toggle" onclick="togglePw('f_password', this)" title="Show password">👁️</button>
                    </div>
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
            <a href="login">Login to track your bookings</a>
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
        updateCost();
    }

    function updateCost() {
        var tentId  = parseInt(document.getElementById('f_tent').value);
        var persons = parseInt(document.getElementById('f_persons').value) || 1;
        
        var arrival = document.getElementById('f_arrival').value;
        var departure = document.getElementById('f_departure').value;
        var nights = 1;
        if (arrival && departure) {
            var arr = new Date(arrival);
            var dep = new Date(departure);
            var diff = Math.floor((dep - arr) / (1000 * 60 * 60 * 24));
            if (diff > 0) nights = diff;
        }

        var price = PRICES[tentId] || 800;
        // User requested custom pricing: (persons * price) + (nights * price)
        var total = (persons * price) + (nights * price);

        document.getElementById('costDisplay').textContent =
            '\u20B9' + total.toLocaleString('en-IN') + ' (' + persons + ' guests + ' + nights + ' days)';
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
        var arrDate = new Date(arrival);
        var depDate = new Date(departure);
        var nights = Math.max(1, Math.floor((depDate - arrDate) / (1000 * 60 * 60 * 24)));
        var price = PRICES[parseInt(tentId)] || 800;
        
        // User requested custom pricing: (persons * price) + (nights * price)
        var total = (persons * price) + (nights * price);
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

    function togglePw(inputId, btn) {
        var inp  = document.getElementById(inputId);
        var show = inp.type === 'password';
        inp.type        = show ? 'text' : 'password';
        btn.textContent = show ? '🙈' : '👁️';
        btn.title       = show ? 'Hide password' : 'Show password';
    }
</script>
<%@ include file="Footer.jsp"%>
</body>
</html>
