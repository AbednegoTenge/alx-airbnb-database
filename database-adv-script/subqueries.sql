SELECT Property.property_id, Property.name, Property.location
FROM Property
WHERE Property.property_id IN (
  SELECT Review.property_id
  FROM Review
  GROUP BY Review.property_id
  HAVING AVG(Review.rating) > 4.0
);


SELECT u.first_name, u.last_name
FROM User u
WHERE (
  SELECT COUNT(b.booking_id)
  FROM Booking b
  WHERE u.user_id = b.user_id
) > 3;
