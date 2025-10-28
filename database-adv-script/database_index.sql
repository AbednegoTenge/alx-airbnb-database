-- ============================================================
-- Objective: Identify and create indexes to improve query performance
-- ============================================================

-- 1️⃣ Measure performance BEFORE adding indexes
-- Run EXPLAIN or EXPLAIN ANALYZE to check current query execution plans

EXPLAIN ANALYZE
SELECT u.first_name, u.last_name, b.status, p.name, p.location
FROM User u
JOIN Booking b ON u.user_id = b.user_id
JOIN Property p ON p.property_id = b.property_id
WHERE b.status = 'confirmed'
ORDER BY p.location;

-- ============================================================
-- 2️⃣ Create indexes on high-usage columns
-- These are columns often used in WHERE, JOIN, and ORDER BY clauses
-- ============================================================

-- User table indexes
CREATE INDEX idx_user_first_name ON User(first_name);
CREATE INDEX idx_user_last_name ON User(last_name);

-- Booking table indexes
CREATE INDEX idx_booking_status ON Booking(status);
CREATE INDEX idx_booking_user_id ON Booking(user_id);
CREATE INDEX idx_booking_property_id ON Booking(property_id);

-- Property table indexes
CREATE INDEX idx_property_name ON Property(name);
CREATE INDEX idx_property_location ON Property(location);

-- ============================================================
-- 3️⃣ Measure performance AFTER adding indexes
-- Run the same query again and compare the results
-- ============================================================

EXPLAIN ANALYZE
SELECT u.first_name, u.last_name, b.status, p.name, p.location
FROM User u
JOIN Booking b ON u.user_id = b.user_id
JOIN Property p ON p.property_id = b.property_id
WHERE b.status = 'confirmed'
ORDER BY p.location;

-- ============================================================
-- Notes:
-- - Before indexing, expect Sequential Scans (Seq Scan)
-- - After indexing, the query should use Index Scans or Bitmap Index Scans
-- - Compare total "Execution Time" in both cases
-- ============================================================
