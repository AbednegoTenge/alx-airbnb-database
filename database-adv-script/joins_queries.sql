##INNER JOIN

SELECT User.first_name, User.last_name, Booking.*
FROM User
INNER JOIN Booking
ON User.user_id = Booking.user_id;


###LEFT JOIN

SELECT Property.property_id, Property.name, Review.rating, Review.comment
FROM Property
LEFT JOIN Review
ON Property.property_id = Review.property_id
ORDER BY Property.property_id;

##FULL OUTER JOIN

SELECT User.first_name, User.last_name, Booking.status
FROM User
FULL OUTER JOIN Booking
ON User.user_id = Booking.user_id;
