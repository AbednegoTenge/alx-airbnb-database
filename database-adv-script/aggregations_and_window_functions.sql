SELECT u.first_name, u.last_name, COUNT(b.booking_id) AS total_booking
FROM User u
JOIN Booking b
ON u.user_id = b.user_id
GROUP BY u.user_id, u.first_name, u.last_name;


##Using RANK() function
SELECT p.name, p.location, COUNT(b.booking_id) AS total_booking, RANK() OVER (ORDER BY COUNT(b.booking_id) DESC) AS booking_rank
FROM Property p
JOIN Booking b
ON p.property_id = b.property_id
GROUP BY p.property_id, p.name, p.location;


###Using ROW_NUMBER() function
SELECT p.name, p.location, COUNT(b.booking_id) AS total_bookings, ROW_NUMBER() OVER (ORDER BY COUNT(b.booking_id) DESC) AS booking_rank
FROM Property p
JOIN Booking b
  ON p.property_id = b.property_id
GROUP BY p.property_id, p.name, p.location;

