# Database Schema Documentation

## Overview
This database schema is designed for an Airbnb clone. It manages users, properties, bookings, payments, reviews, and messaging between users.

## Database Tables

### 1. Users Table
Stores information about all users in the system (guests, hosts, and admins).

**Fields:**
- `id` (CHAR(36), Primary Key, UUID): Unique identifier for each user
- `username` (VARCHAR(50), UNIQUE, NOT NULL): User's unique username
- `email` (VARCHAR(100), UNIQUE, NOT NULL): User's email address
- `password_hash` (VARCHAR(255), NOT NULL): Encrypted password
- `first_name` (VARCHAR(50)): User's first name
- `last_name` (VARCHAR(50)): User's last name
- `phone_number` (VARCHAR(20)): Contact phone number
- `role` (ENUM: 'guest', 'host', 'admin', NOT NULL): User's role in the system
- `created_at` (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP): Account creation date

**Indexes:**
- Primary key on `id`
- Index on `email`
- Index on `username`

---

### 2. Properties Table
Stores information about rental properties listed by hosts.

**Fields:**
- `property_id` (CHAR(36), Primary Key, UUID): Unique identifier for each property
- `host_id` (CHAR(36), Foreign Key → users.id, NOT NULL): Property owner
- `name` (VARCHAR(255), NOT NULL): Property name
- `description` (TEXT, NOT NULL): Detailed property description
- `location` (VARCHAR(255), NOT NULL): Property location
- `pricepernight` (DECIMAL(15, 2), NOT NULL): Nightly rental price
- `created_at` (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP): Listing creation date
- `updated_at` (TIMESTAMP, AUTO UPDATE): Last update timestamp

**Indexes:**
- Primary key on `property_id`
- Index on `property_id`

**Foreign Keys:**
- `host_id` → `users(id)` ON DELETE CASCADE

---

### 3. Bookings Table
Stores reservation information for properties.

**Fields:**
- `booking_id` (CHAR(36), Primary Key, UUID): Unique booking identifier
- `property_id` (CHAR(36), Foreign Key → properties.id, NOT NULL): Booked property
- `user_id` (CHAR(36), Foreign Key → users.id, NOT NULL): Guest making the booking
- `start_date` (DATE, NOT NULL): Check-in date
- `end_date` (DATE, NOT NULL): Check-out date
- `total_price` (DECIMAL(15, 2), NOT NULL): Total booking cost
- `status` (ENUM: 'pending', 'confirmed', 'canceled', NOT NULL): Booking status
- `created_at` (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP): Booking creation date

**Indexes:**
- Primary key on `booking_id`
- Index on `property_id`
- Index on `user_id`
- Index on `start_date`
- Index on `status`

**Foreign Keys:**
- `property_id` → `properties(id)` ON DELETE CASCADE
- `user_id` → `users(id)` ON DELETE CASCADE

---

### 4. Payments Table
Records payment transactions for bookings.

**Fields:**
- `payment_id` (CHAR(36), Primary Key, UUID): Unique payment identifier
- `booking_id` (CHAR(36), Foreign Key → bookings.booking_id, NOT NULL): Associated booking
- `amount` (DECIMAL(15, 2), NOT NULL): Payment amount
- `payment_date` (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP): Payment timestamp
- `payment_method` (ENUM: 'credit_card', 'paypal', 'stripe', NOT NULL): Payment method used

**Indexes:**
- Primary key on `payment_id`
- Index on `booking_id`
- Index on `payment_date`

**Foreign Keys:**
- `booking_id` → `bookings(booking_id)` ON DELETE CASCADE

---

### 5. Reviews Table
Stores guest reviews and ratings for properties.

**Fields:**
- `review_id` (CHAR(36), Primary Key, UUID): Unique review identifier
- `property_id` (CHAR(36), Foreign Key → properties.id, NOT NULL): Reviewed property
- `user_id` (CHAR(36), Foreign Key → users.id, NOT NULL): Reviewer
- `rating` (INTEGER, NOT NULL, CHECK: 1-5): Star rating
- `comment` (TEXT, NOT NULL): Review text
- `created_at` (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP): Review submission date

**Indexes:**
- Primary key on `review_id`
- Index on `property_id`
- Index on `user_id`
- Index on `rating`
- Index on `created_at`

**Foreign Keys:**
- `property_id` → `properties(id)` ON DELETE CASCADE
- `user_id` → `users(id)` ON DELETE CASCADE

**Constraints:**
- Rating must be between 1 and 5 (inclusive)

---

### 6. Messages Table
Facilitates communication between users (guests and hosts).

**Fields:**
- `message_id` (CHAR(36), Primary Key, UUID): Unique message identifier
- `sender_id` (CHAR(36), Foreign Key → users.id, NOT NULL): Message sender
- `recipient_id` (CHAR(36), Foreign Key → users.id, NOT NULL): Message recipient
- `message_body` (TEXT, NOT NULL): Message content
- `sent_at` (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP): Message timestamp

**Indexes:**
- Primary key on `message_id`
- Index on `sender_id`
- Index on `recipient_id`
- Index on `sent_at`

**Foreign Keys:**
- `sender_id` → `users(id)` ON DELETE CASCADE
- `recipient_id` → `users(id)` ON DELETE CASCADE

---

## Entity Relationships

```
Users (1) ──→ (M) Properties [host_id]
Users (1) ──→ (M) Bookings [user_id]
Users (1) ──→ (M) Reviews [user_id]
Users (1) ──→ (M) Messages [sender_id, recipient_id]

Properties (1) ──→ (M) Bookings [property_id]
Properties (1) ──→ (M) Reviews [property_id]

Bookings (1) ──→ (M) Payments [booking_id]
```

## Key Design Decisions

### UUID Primary Keys
All tables use UUID (CHAR(36)) as primary keys instead of auto-incrementing integers:
- **Benefits:** Globally unique, better for distributed systems, no sequential information leakage
- **Format:** Standard UUID format (e.g., `550e8400-e29b-41d4-a716-446655440000`)

### DECIMAL for Money
All monetary values use `DECIMAL(15, 2)`:
- **Precision:** 15 total digits (13 before decimal, 2 after)
- **Range:** Up to $9.99 trillion
- **Why:** Exact precision for financial calculations (avoids floating-point errors)

### Cascade Deletes
All foreign keys use `ON DELETE CASCADE`:
- When a user is deleted, all their bookings, reviews, and messages are deleted
- When a property is deleted, all its bookings and reviews are deleted
- When a booking is deleted, all its payments are deleted

### Indexes
Strategic indexes for common query patterns:
- Foreign keys are indexed for JOIN operations
- Date fields for range queries
- Status fields for filtering
- Email/username for authentication lookups

## Setup Instructions

### 1. Create Database
```sql
CREATE DATABASE airbnb_clone_db;
USE airbnb_clone_db;
```

### 2. Execute Table Creation Scripts
Run the SQL scripts in this order:
1. `users.sql`
2. `properties.sql`
3. `bookings.sql`
4. `payments.sql`
5. `reviews.sql`
6. `messages.sql`

### 3. Verify Installation
```sql
SHOW TABLES;
DESCRIBE users;
```

## Sample Queries

### Find available properties in a location
```sql
SELECT * FROM properties 
WHERE location LIKE '%Miami%' 
ORDER BY pricepernight ASC;
```

### Get all bookings for a property
```sql
SELECT b.*, u.username, u.email 
FROM bookings b
JOIN users u ON b.user_id = u.id
WHERE b.property_id = 'property-uuid-here'
ORDER BY b.start_date DESC;
```

### Calculate average rating for a property
```sql
SELECT property_id, AVG(rating) as avg_rating, COUNT(*) as review_count
FROM reviews
WHERE property_id = 'property-uuid-here'
GROUP BY property_id;
```

### Get conversation between two users
```sql
SELECT * FROM messages
WHERE (sender_id = 'user1-uuid' AND recipient_id = 'user2-uuid')
   OR (sender_id = 'user2-uuid' AND recipient_id = 'user1-uuid')
ORDER BY sent_at ASC;
```

## Technical Specifications

- **Database Engine:** MySQL 8.0+
- **Storage Engine:** InnoDB
- **Character Set:** UTF8MB4 (supports emojis and international characters)
- **Collation:** utf8mb4_unicode_ci

## Notes

- All timestamps use server timezone (consider using UTC in production)
- Password hashing should be handled at the application level (bcrypt recommended)
- UUIDs are automatically generated using MySQL's `UUID()` function
- JSON fields (amenities, images) provide flexibility for variable data structures
