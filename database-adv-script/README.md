# 🗂 SQL JOIN Queries

## 📘 Project Overview
This project demonstrates the use of different SQL join operations to retrieve data from multiple related tables in a relational database.

The focus is on understanding and implementing:
- `INNER JOIN`
- `LEFT JOIN`
- `RIGHT JOIN`
- `FULL OUTER JOIN`
- Aggregations with joins (`COUNT`, `AVG`, etc.)

---

## 🧠 Learning Objectives
By completing this project, I learned how to:
- Combine data from multiple tables using joins.
- Use table relationships effectively.
- Handle cases where some records may not have related entries.
- Write queries that include aggregation and filtering after joining tables.

---

## 🗃 Database Schema

**Tables used:**

### `User`
| Column        | Type        | Description                  |
|----------------|-------------|-------------------------------|
| `user_id`      | INT (PK)    | Unique identifier for users   |
| `first_name`   | VARCHAR     | User’s first name             |
| `last_name`    | VARCHAR     | User’s last name              |
| `email`        | VARCHAR     | User’s email address          |

### `Property`
| Column         | Type        | Description                     |
|----------------|-------------|----------------------------------|
| `property_id`  | INT (PK)    | Unique property identifier       |
| `user_id`      | INT (FK)    | References `User.user_id`        |
| `name`         | VARCHAR     | Property name                    |
| `location`     | VARCHAR     | Property location                |

### `Review`
| Column         | Type        | Description                        |
|----------------|-------------|-------------------------------------|
| `review_id`    | INT (PK)    | Unique review identifier            |
| `property_id`  | INT (FK)    | References `Property.property_id`   |
| `rating`       | INT         | Review rating (1–5)                |
| `comment`      | TEXT        | Reviewer’s comment                 |

### `Booking`
| Column         | Type        | Description                        |
|----------------|-------------|-------------------------------------|
| `booking_id`   | INT (PK)    | Unique booking identifier           |
| `user_id`      | INT (FK)    | References `User.user_id`           |
| `status`       | VARCHAR     | Booking status (confirmed/pending)  |

---

## 🔍 Example Queries

### 1️⃣ INNER JOIN — Retrieve all bookings and the respective users who made them
```sql
SELECT 
  User.first_name, 
  User.last_name, 
  Booking.status
FROM User
INNER JOIN Booking 
ON User.user_id = Booking.user_id;
✅ This query only returns users who have at least one booking.

2️⃣ LEFT JOIN — Retrieve all properties and their reviews, including properties with no reviews
SELECT 
  Property.property_id, 
  Property.name, 
  Review.rating, 
  Review.comment
FROM Property
LEFT JOIN Review 
ON Property.property_id = Review.property_id;
✅ Shows all users and bookings — even unmatched ones.
