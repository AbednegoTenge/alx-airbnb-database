# Optimization Report

## Objective
The goal of this optimization task was to improve query performance in retrieving all bookings along with user, property, and payment details from multiple joined tables. The initial query performed full table scans and lacked filtering conditions or indexes, which led to slower execution.

---

## Initial Query
```sql
SELECT
    User.user_id,
    CONCAT(User.first_name, ' ', User.last_name) AS username,
    User.email AS user_email,
    Property.property_id,
    Property.name AS property_name,
    Property.location AS property_location,
    Booking.booking_id,
    Booking.start_date,
    Booking.end_date,
    Booking.total_price,
    Payment.payment_id,
    Payment.amount AS payment_amount,
    Payment.payment_date
FROM User
JOIN Property ON User.user_id = Property.host_id
JOIN Booking ON Property.property_id = Booking.property_id
JOIN Payment ON Booking.booking_id = Payment.booking_id
WHERE User.user_id IS NOT NULL
AND Payment.amount > 0
ORDER BY User.user_id;
```

---

## Identified Performance Issues
1. **No filtering or indexing** in the original query, leading to full table scans.  
2. **Multiple joins** without indexed foreign keys slowed down lookups.  
3. **Sorting** using `ORDER BY` on a non-indexed column (`user_id`) increased query cost.  
4. **No selective WHERE conditions**, meaning all data was fetched unnecessarily.

---

## Optimization Steps
1. **Added Filtering Conditions**
   - Introduced `WHERE` and `AND` clauses to limit returned results:
     ```sql
     WHERE User.user_id IS NOT NULL
     AND Payment.amount > 0
     ```
   - This reduced the number of scanned rows.

2. **Created Indexes**
   - Added indexes to frequently used columns in `JOIN`, `WHERE`, and `ORDER BY` clauses:
     ```sql
     CREATE INDEX idx_user_id ON User(user_id);
     CREATE INDEX idx_property_host_id ON Property(host_id);
     CREATE INDEX idx_booking_property_id ON Booking(property_id);
     CREATE INDEX idx_payment_booking_id ON Payment(booking_id);
     CREATE INDEX idx_payment_amount ON Payment(amount);
     ```
   - These indexes improved lookup and join performance.

3. **Used `EXPLAIN` for Analysis**
   - Executed `EXPLAIN` before and after optimization to observe query cost and access type.
   - Before optimization: multiple **ALL** scans (full table scans).
   - After optimization: joins changed to **ref** or **eq_ref**, indicating indexed lookups.

---

## Results
| Metric | Before Optimization | After Optimization |
|---------|---------------------|--------------------|
| Query Execution Time | High (slow) | Significantly reduced |
| Access Type | ALL (full table scans) | ref / eq_ref (indexed lookups) |
| Rows Scanned | Large number of rows | Limited to relevant rows only |
| Overall Performance | Poor | Improved and efficient |

---

## Conclusion
By adding appropriate `WHERE` conditions and creating indexes on high-usage columns, the query performance improved significantly.  
The database now retrieves relevant booking, property, and payment details efficiently with optimized join operations and faster sorting.

**Next Steps:**
- Continue monitoring query performance as data grows.
- Analyze query execution plans periodically using `EXPLAIN`.
- Consider using **composite indexes** if filtering commonly involves multiple columns together.

---
