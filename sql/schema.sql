-- ═══════════════════════════════════════════════════════════════════════
--  Vasota Lake Camping — Complete Database Schema
--  PostgreSQL 15+
--
--  Run with:  psql -U postgres -d onlinecamp -f schema.sql
--  Or:        psql $DATABASE_URL < schema.sql
-- ═══════════════════════════════════════════════════════════════════════

-- ── 0. Extensions ────────────────────────────────────────────────────────
-- pgcrypto is required for bcrypt password hashing (crypt / gen_salt)
CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- ── 1. Create database (run once, skip if already exists) ────────────────
-- CREATE DATABASE onlinecamp;
-- \c onlinecamp

-- ════════════════════════════════════════════════════════════════════════
--  TABLE: users
--  Stores registered user accounts (both users and admins)
-- ════════════════════════════════════════════════════════════════════════
CREATE TABLE IF NOT EXISTS users (
    user_id    SERIAL       PRIMARY KEY,
    username   VARCHAR(50)  NOT NULL UNIQUE,
    password   TEXT         NOT NULL,          -- bcrypt hash via pgcrypto
    email      VARCHAR(120) NOT NULL UNIQUE,
    full_name  VARCHAR(120) NOT NULL,
    phone      BIGINT,                          -- 10-digit Indian phone number
    role       VARCHAR(10)  NOT NULL DEFAULT 'user'
                            CHECK (role IN ('user', 'admin')),
    created_at TIMESTAMP    NOT NULL DEFAULT NOW()
);

-- ════════════════════════════════════════════════════════════════════════
--  TABLE: tents
--  Master list of accommodation types and their prices
-- ════════════════════════════════════════════════════════════════════════
CREATE TABLE IF NOT EXISTS tents (
    tent_id    INT          PRIMARY KEY,
    tent_name  VARCHAR(80)  NOT NULL,
    tent_price INT          NOT NULL,   -- price per person per night (INR)
    capacity   INT          NOT NULL    -- max persons
);

-- ════════════════════════════════════════════════════════════════════════
--  TABLE: bookings
--  Each row is one booking made by a guest (registered or guest)
-- ════════════════════════════════════════════════════════════════════════
CREATE TABLE IF NOT EXISTS bookings (
    id               SERIAL       PRIMARY KEY,
    name             VARCHAR(120) NOT NULL,
    email            VARCHAR(120) NOT NULL,
    phone            BIGINT       NOT NULL
                                  CONSTRAINT phone_check CHECK (phone BETWEEN 1000000000 AND 9999999999),
    no_of_persons    SMALLINT     NOT NULL DEFAULT 1 CHECK (no_of_persons >= 1),
    no_of_kids       SMALLINT     NOT NULL DEFAULT 0 CHECK (no_of_kids >= 0),
    arrival_date     DATE         NOT NULL,
    departure_date   DATE         NOT NULL,
    tent_id          INT          NOT NULL REFERENCES tents(tent_id),
    username         VARCHAR(50)  REFERENCES users(username) ON DELETE SET NULL,
    payment_method   VARCHAR(10)  NOT NULL DEFAULT 'OFFLINE'
                                  CHECK (payment_method IN ('ONLINE', 'OFFLINE')),
    payment_status   VARCHAR(10)  NOT NULL DEFAULT 'PENDING'
                                  CHECK (payment_status IN ('PAID', 'PENDING')),
    status           VARCHAR(15)  NOT NULL DEFAULT 'confirmed'
                                  CHECK (status IN ('confirmed', 'cancelled')),
    booking_ref      VARCHAR(20)  UNIQUE,
    total_cost       INT          GENERATED ALWAYS AS (0) STORED, -- overridden by trigger
    paid_at          TIMESTAMP,
    created_at       TIMESTAMP    NOT NULL DEFAULT NOW(),

    CONSTRAINT chk_dates CHECK (departure_date > arrival_date)
);

-- ════════════════════════════════════════════════════════════════════════
--  TABLE: contact
--  Stores messages submitted via the Contact Us form
-- ════════════════════════════════════════════════════════════════════════
CREATE TABLE IF NOT EXISTS contact (
    id         SERIAL       PRIMARY KEY,
    name       VARCHAR(120) NOT NULL,
    email      VARCHAR(120) NOT NULL,
    message    TEXT         NOT NULL,
    created_at TIMESTAMP    NOT NULL DEFAULT NOW()
);

-- ════════════════════════════════════════════════════════════════════════
--  FUNCTION + TRIGGER: Auto-calculate total_cost before INSERT
-- ════════════════════════════════════════════════════════════════════════

-- Drop old version if exists
DROP TRIGGER IF EXISTS trg_calc_total ON bookings;
DROP FUNCTION IF EXISTS fn_calc_total();

-- Since GENERATED ALWAYS doesn't work well with our FK lookup,
-- we use a BEFORE INSERT trigger instead.
-- First, remove the generated column and replace with plain INT:
ALTER TABLE bookings DROP COLUMN IF EXISTS total_cost;
ALTER TABLE bookings ADD COLUMN total_cost INT NOT NULL DEFAULT 0;

CREATE OR REPLACE FUNCTION fn_calc_total()
RETURNS TRIGGER AS $$
DECLARE
    v_price   INT;
    v_nights  INT;
BEGIN
    -- Fetch price per person per night from tents table
    SELECT tent_price INTO v_price FROM tents WHERE tent_id = NEW.tent_id;

    -- Calculate number of nights
    v_nights := (NEW.departure_date - NEW.arrival_date);

    -- Total = price × persons × nights  (kids stay free)
    NEW.total_cost := COALESCE(v_price, 0) * NEW.no_of_persons * GREATEST(v_nights, 1);

    -- Auto-generate booking reference if not provided
    IF NEW.booking_ref IS NULL THEN
        NEW.booking_ref := 'VLC' || LPAD(NEXTVAL('bookings_id_seq')::TEXT, 5, '0');
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_calc_total
    BEFORE INSERT ON bookings
    FOR EACH ROW EXECUTE FUNCTION fn_calc_total();

-- ════════════════════════════════════════════════════════════════════════
--  SEED DATA: Tent types (matches Bookings.java tent IDs 101–106)
-- ════════════════════════════════════════════════════════════════════════
INSERT INTO tents (tent_id, tent_name, tent_price, capacity) VALUES
    (101, 'Regular Tent',        800,  4),
    (102, 'Triangle Tent',      1200,  2),
    (103, 'Machan Cottage',     2500,  4),
    (104, 'Elevator Cottage',   3500,  4),
    (105, 'Glamping',           5000,  3),
    (106, 'Ultra Luxury Cottage',8000, 6)
ON CONFLICT (tent_id) DO NOTHING;

-- ════════════════════════════════════════════════════════════════════════
--  SEED DATA: Default admin account
--  Username: admin  |  Password: admin123
--  ⚠️  CHANGE THE PASSWORD IMMEDIATELY AFTER FIRST LOGIN!
-- ════════════════════════════════════════════════════════════════════════
INSERT INTO users (username, password, email, full_name, phone, role)
VALUES (
    'admin',
    crypt('admin123', gen_salt('bf')),
    'admin@vasotalakecamping.com',
    'Camp Administrator',
    9579350747,
    'admin'
) ON CONFLICT (username) DO NOTHING;

-- ════════════════════════════════════════════════════════════════════════
--  INDEXES for query performance
-- ════════════════════════════════════════════════════════════════════════
CREATE INDEX IF NOT EXISTS idx_bookings_username   ON bookings(username);
CREATE INDEX IF NOT EXISTS idx_bookings_created    ON bookings(created_at DESC);
CREATE INDEX IF NOT EXISTS idx_bookings_status     ON bookings(status);
CREATE INDEX IF NOT EXISTS idx_bookings_pay_status ON bookings(payment_status);
CREATE INDEX IF NOT EXISTS idx_users_username      ON users(username);
CREATE INDEX IF NOT EXISTS idx_users_email         ON users(email);

-- ════════════════════════════════════════════════════════════════════════
--  VERIFICATION QUERIES (optional — uncomment to test)
-- ════════════════════════════════════════════════════════════════════════
-- SELECT * FROM tents;
-- SELECT user_id, username, role, full_name FROM users;
-- SELECT table_name FROM information_schema.tables WHERE table_schema = 'public';

-- ── Done ─────────────────────────────────────────────────────────────────
-- Schema setup complete!
-- Tables: users, tents, bookings, contact
-- Default admin: username=admin  password=admin123
