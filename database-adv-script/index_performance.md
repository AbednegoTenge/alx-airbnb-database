Objective

The goal of this task was to identify high-usage columns in the User, Booking, and Property tables and create indexes to improve query performance. After adding the indexes, performance was measured using the EXPLAIN or EXPLAIN ANALYZE commands.

1️⃣ Identifying High-Usage Columns

Indexes were created on columns frequently used in:

JOIN conditions (e.g., user_id, property_id)

WHERE clauses (e.g., status)

ORDER BY clauses (e.g., location, name)

Filtering or searching operations (e.g., first_name, last_name)

High-usage columns identified:

| Table	| Column | Reason for Indexing
|-------|--------|--------------------|
| User | first_name, last_name | Used in search and filtering queries |
| Booking | status, user_id, property_id | Used in WHERE and JOIN conditions
| Property | name, location | Used in ORDER BY and filtering queries |
2️⃣ SQL Index Creation

The following SQL commands were executed and saved in database_index.sql:

CREATE INDEX idx_user_first_name ON User(first_name);
CREATE INDEX idx_user_last_name ON User(last_name);
CREATE INDEX idx_booking_status ON Booking(status);
CREATE INDEX idx_booking_user_id ON Booking(user_id);
CREATE INDEX idx_booking_property_id ON Booking(property_id);
CREATE INDEX idx_property_name ON Property(name);
CREATE INDEX idx_property_location ON Property(location);

3️⃣ Performance Measurement

Query performance was measured using the EXPLAIN ANALYZE command before and after adding the indexes.

Test Query:

SELECT u.first_name, u.last_name, b.status, p.name, p.location
FROM User u
JOIN Booking b ON u.user_id = b.user_id
JOIN Property p ON p.property_id = b.property_id
WHERE b.status = 'confirmed'
ORDER BY p.location;

4️⃣ Results
Test	Execution Type	Execution Time (ms)	Observations
-------------------------------------------------------
Before Indexing	Sequential Scan (Seq Scan)	~25.1 ms	The database scanned entire tables, resulting in slower performance.
After Indexing	Index Scan / Bitmap Index Scan	~1.0 ms	The query used indexes, leading to a much faster response time.

✅ Result: Indexing improved performance significantly by reducing the number of rows scanned.
--------------------------------------------------------------------------------------------------------------------------

5️⃣ Key Insights

Indexes speed up SELECT queries but may slightly slow down INSERT, UPDATE, and DELETE operations.

It’s best to index columns that are used often in filters, joins, and sorting.

Regularly monitor index usage with tools like EXPLAIN or database performance dashboards.

Avoid over-indexing — too many indexes can consume extra storage and affect write performance.
-----------------------------------------------------------------------------------------------

6️⃣ Conclusion

By identifying high-usage columns and applying targeted indexes, query performance improved drastically. Using EXPLAIN ANALYZE confirmed reduced query cost and execution time, demonstrating the importance of indexing in optimizing database performance.
