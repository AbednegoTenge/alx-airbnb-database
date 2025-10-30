SELECT
    User.user_id,
    concat(User.first_name, ' ',
    User.last_name ) AS username,
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
JOIN Property 
    ON User.user_id = Property.host_id
JOIN Booking 
    ON Property.property_id = Booking.property_id
JOIN Payment 
    ON Booking.booking_id = Payment.booking_id
WHERE User.user_id IS NOT NULL
ORDER BY User.user_id;


EXPLAIN
SELECT
    User.user_id,
    concat(User.first_name, ' ',
    User.last_name ) AS username,
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
JOIN Property 
    ON User.user_id = Property.host_id
JOIN Booking 
    ON Property.property_id = Booking.property_id
JOIN Payment 
    ON Booking.booking_id = Payment.booking_id
ORDER BY User.user_id;
