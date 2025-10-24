
## 🧩 Normalization.md

### 🏗️ Objective
To ensure the Airbnb Clone Database schema adheres to the **Third Normal Form (3NF)** — minimizing redundancy and ensuring data integrity.

---

### 📘 Step 1: Unnormalized Form (UNF)

In the unnormalized form, data may contain **repeating groups**, **non-atomic values**, or **redundant attributes**.  
Example (hypothetical issue):

| user_id | name | email | phone_numbers | role |
|----------|------|--------|----------------|------|
| 1 | John Doe | john@example.com | 12345, 67890 | host |

🔴 **Problem:** Multiple phone numbers in one field — violates atomicity.

✅ **Fix:** Split repeating groups into separate records or ensure one atomic value per column.  
In this schema, each attribute is already **atomic** (single value per field).

---

### 📘 Step 2: First Normal Form (1NF)

**Rule:**  
- Each cell must hold only one value.  
- Each record must be unique (have a primary key).

✅ **Compliance:**
- Every table has a **primary key** (`user_id`, `property_id`, `booking_id`, etc.).
- All attributes contain single values (no lists, sets, or repeating groups).

**Result:**  
All tables — `User`, `Property`, `Booking`, `Payment`, `Review`, and `Message` — are in **1NF**.

---

### 📘 Step 3: Second Normal Form (2NF)

**Rule:**  
- The table must be in 1NF.
- No **partial dependency** — non-key attributes must depend on the **entire primary key**, not part of it.

✅ **Analysis:**
- All tables use **single-column primary keys (UUIDs)** — meaning partial dependency cannot occur.
- For example:
  - `Booking.total_price` depends entirely on `booking_id`.
  - `Review.rating` depends entirely on `review_id`.

✅ **Result:**  
All tables satisfy **2NF**.

---

### 📘 Step 4: Third Normal Form (3NF)

**Rule:**  
- Must be in 2NF.
- No **transitive dependencies** — non-key attributes must depend only on the primary key, not other non-key attributes.

✅ **Checks:**

| Table | Analysis | Status |
|--------|-----------|--------|
| **User** | Attributes (`first_name`, `last_name`, `email`, `role`, etc.) depend only on `user_id`. No attribute depends on another non-key column. | ✅ 3NF |
| **Property** | `name`, `description`, `location`, and `price_per_night` depend only on `property_id`. No derived/transitive dependency. | ✅ 3NF |
| **Booking** | `total_price` is based on the booking (not derived from another field). All attributes depend solely on `booking_id`. | ✅ 3NF |
| **Payment** | `amount`, `payment_date`, and `payment_method` depend on `payment_id`. `booking_id` is a foreign key — not a transitive dependency. | ✅ 3NF |
| **Review** | `rating` and `comment` depend only on `review_id`. `property_id` and `user_id` are foreign keys, not determinants. | ✅ 3NF |
| **Message** | `message_body` and `sent_at` depend on `message_id`. `sender_id` and `recipient_id` are references, not determinants. | ✅ 3NF |

✅ **Result:**  
All tables are in **Third Normal Form (3NF)**.

---

### 💡 Summary of Normalization Process

| Normal Form | Description | Applied Fix |
|--------------|--------------|--------------|
| **1NF** | Ensured atomic attributes and unique primary keys | Structured columns to hold single values |
| **2NF** | Removed partial dependencies | Used single-column UUID primary keys |
| **3NF** | Eliminated transitive dependencies | Verified all non-key attributes depend only on the primary key |

---

### ✅ Final Assessment

The schema:
- Contains **no repeating groups** ✅  
- Has **atomic fields** ✅  
- Uses **unique identifiers** (UUIDs) ✅  
- Avoids **derived or transitive dependencies** ✅  
- Has clear **referential integrity** through foreign keys ✅  

**Result:**  
> 🟢 The database schema is in **Third Normal Form (3NF)**.

---

### 🧾 Recommendation

The current model is **efficient and scalable**.  
If the system grows, consider:
- Adding an **Address** table if users can have multiple locations.
- Adding a **Payment Transaction Log** table for detailed audit tracking.
- Introducing **indexes** on foreign key fields for faster joins.

---

✅ **Conclusion:**  
The Airbnb Clone database structure fully satisfies the **Third Normal Form (3NF)** — ensuring data consistency, minimal redundancy, and maintainability.
