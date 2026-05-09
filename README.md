# Onlinecamp — Vasota Lake Camping 🏕️

A full-stack Java Servlet web application for booking camping experiences at **Vasota Lake, Maharashtra**.

![Java](https://img.shields.io/badge/Java-17-orange?logo=java)
![Tomcat](https://img.shields.io/badge/Tomcat-10.1-green?logo=apache-tomcat)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-15-blue?logo=postgresql)
![Gemini AI](https://img.shields.io/badge/Gemini-AI%20Chatbot-purple?logo=google)

---

## ✨ Features

- 🏕️ Browse 6 tent/cottage accommodation options with pricing
- 📅 Online booking system with arrival/departure date selection
- 💳 UPI & pay-on-arrival payment support
- 🤖 AI-powered chatbot (Google Gemini 1.5 Flash)
- 👤 User accounts with booking history
- 🔐 Admin dashboard with live booking statistics
- 📧 Email booking confirmation
- 📸 Gallery & offers pages

---

## 🛠️ Tech Stack

| Layer | Technology |
|---|---|
| Backend | Java 17 + Jakarta Servlets |
| Server | Apache Tomcat 10.1 |
| Database | PostgreSQL 15 |
| Frontend | JSP + Vanilla CSS + JavaScript |
| AI Chatbot | Google Gemini 1.5 Flash API |
| Auth | PostgreSQL `pgcrypto` bcrypt hashing |

---

## 🚀 Local Setup

### Prerequisites
- Java 17+
- Apache Tomcat 10.1+
- PostgreSQL 15+
- Eclipse IDE (or any Java IDE)

### 1. Clone the Repo
```bash
git clone https://github.com/YOUR_USERNAME/onlinecamp.git
cd onlinecamp
```

### 2. Setup PostgreSQL Database
```bash
psql -U postgres
\i sql/schema.sql
```

### 3. Set Environment Variables
```bash
export DB_URL=jdbc:postgresql://localhost/onlinecamp
export DB_USER=postgres
export DB_PWD=yourpassword
```

### 4. Deploy to Tomcat
- Import project into Eclipse as **Dynamic Web Project**
- Add to Tomcat server
- Start Tomcat → visit `http://localhost:8080/Online-Camping-Portal/home`

---

## ☁️ Deploy to Railway (Free)

1. Push this repo to GitHub
2. Go to [railway.app](https://railway.app) → **Deploy from GitHub**
3. Add **PostgreSQL** service in Railway
4. Set environment variables:
   - `DB_URL` → from Railway PostgreSQL
   - `DB_USER` → from Railway PostgreSQL
   - `DB_PWD` → from Railway PostgreSQL
5. Import schema: `psql $DATABASE_URL < sql/schema.sql`

---

## 🔐 Environment Variables

| Variable | Description | Example |
|---|---|---|
| `DB_URL` | JDBC connection URL | `jdbc:postgresql://host/onlinecamp` |
| `DB_USER` | Database username | `postgres` |
| `DB_PWD` | Database password | `yourpassword` |
| `SMTP_USER` | Gmail for email confirmations | `yourmail@gmail.com` |
| `SMTP_PWD` | Gmail App Password | `xxxx xxxx xxxx xxxx` |

---

## 👤 Default Admin Login

After running `schema.sql`, the default admin is created:
- **Username**: `admin`
- **Password**: `admin123`

> ⚠️ Change the admin password immediately after first login!

---

## 🗄️ Database Schema

The complete PostgreSQL schema is available in `sql/schema.sql`. It includes the following core tables:

### 1. `users` (Authentication)
Manages both customer and administrator accounts.
- **Fields:** `user_id`, `username`, `password` (bcrypt hashed), `email`, `role` (user/admin)

### 2. `tents` (Accommodations)
Master catalog of available tents, cottages, and their pricing.
- **Fields:** `tent_id`, `tent_name`, `tent_price` (INR per person/night), `capacity`

### 3. `bookings` (Reservations)
Tracks all camping bookings and calculates costs automatically via triggers.
- **Fields:** `id`, `booking_ref`, `tent_id` (FK), `username` (FK), `arrival_date`, `departure_date`, `payment_status`, `total_cost`

### 4. `contact` (Inquiries)
Stores support and contact messages from visitors.
- **Fields:** `id`, `name`, `email`, `message`, `created_at`

---

## 📁 Project Structure

```
src/
├── main/
│   ├── java/com/lake/
│   │   ├── camping/        ← Servlets (Login, Bookings, etc.)
│   │   ├── entities/       ← Java entity classes
│   │   └── util/           ← DBConnection utility
│   └── webapp/
│       ├── images/         ← Site images & QR codes
│       ├── WEB-INF/
│       │   └── web.xml     ← Servlet mappings
│       ├── Header.jsp
│       ├── Footer.jsp
│       ├── Chatbot.jsp     ← AI chatbot widget
│       └── *.jsp           ← All pages
sql/
└── schema.sql              ← Full database schema + seed data
Dockerfile                  ← Docker deployment config
```

---

## 📞 Contact

Vasota Lake Camping — **+91 9579350747**
📧 vasotalakecamping@gmail.com
📍 Vasota Fort, Koyna Backwaters, Maharashtra, India
# Online-Lake-Booking-System
