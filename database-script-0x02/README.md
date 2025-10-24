🏡 Airbnb Clone Database

This project contains the SQL schema and sample data for an Airbnb-like property rental system.
It models users, properties, bookings, payments, reviews, and messages between users (guests and hosts).

📘 Overview

The database is designed to handle the core backend functionality of a property rental platform.
It captures relationships between:

🧍‍♂️ Users (guests, hosts, admins)

🏠 Properties listed by hosts

📅 Bookings made by guests

💳 Payments linked to bookings

⭐ Reviews left by guests

💬 Messages exchanged between users

🗂️ Database Schema
Table	Description
User	Stores information about all users (guests, hosts, admins).
Property	Contains property listings owned by hosts.
Booking	Links guests to properties and defines booking periods.
Payment	Stores payment transactions related to bookings.
Review	Records guest feedback and ratings for properties.
Message	Supports direct communication between users.
🧩 Relationships

User → Property → A host can own many properties.

User → Booking → A guest can make many bookings.

Booking → Payment → Each booking can have one or more payments.

Property → Review → Each property can have multiple reviews.

User ↔ Message → Users can send messages to each other.

🧱 Database Setup

Create the database (e.g., in MySQL Workbench or CLI):

CREATE DATABASE airbnb_clone;
USE airbnb_clone;


Run the table creation script
Copy and paste the contents of schema.sql (or the provided CREATE TABLE statements) into your SQL editor.

Insert sample data
Execute the contents of sample_data.sql to populate the tables with realistic example records.

💾 Sample Data Summary

Users: 5 sample users (2 hosts, 2 guests, 1 admin)

Properties: 2 listings in Accra and Kumasi

Bookings: Guests have booked available properties

Payments: Linked payments recorded per booking

Reviews: Ratings and comments from guests

Messages: Example guest–host conversations

🧠 Example Queries

You can test your database with queries like:

-- List all properties with their hosts
SELECT p.name AS property_name, u.first_name AS host_name, p.price_per_night
FROM Property p
JOIN User u ON p.host_id = u.user_id;

-- Find all bookings for a specific user
SELECT b.booking_id, p.name AS property, b.start_date, b.end_date, b.status
FROM Booking b
JOIN Property p ON b.property_id = p.property_id
WHERE b.user_id = (SELECT user_id FROM User WHERE email = 'sarahw@example.com');

-- Show total revenue by host
SELECT u.first_name AS host, SUM(b.total_price) AS total_revenue
FROM Booking b
JOIN Property p ON b.property_id = p.property_id
JOIN User u ON p.host_id = u.user_id
WHERE b.status = 'confirmed'
GROUP BY u.first_name;

⚙️ Technologies Used

MySQL 8+

UUID for unique IDs

ENUMs for status and role constraints

Foreign Keys for referential integrity

Indexes for optimized queries

