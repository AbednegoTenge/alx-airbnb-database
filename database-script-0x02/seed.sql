INSERT INTO User (user_id, first_name, last_name, email, password_hash, phone_number, role)
VALUES
(UUID(), 'Abednego', 'Tenge', 'abednego@example.com', 'hashed_pw1', '+233540000001', 'admin'),
(UUID(), 'John', 'Smith', 'johnsmith@example.com', 'hashed_pw2', '+233540000002', 'host'),
(UUID(), 'Sarah', 'Williams', 'sarahw@example.com', 'hashed_pw3', '+233540000003', 'guest'),
(UUID(), 'Michael', 'Brown', 'michaelb@example.com', 'hashed_pw4', '+233540000004', 'guest'),
(UUID(), 'Linda', 'Johnson', 'lindaj@example.com', 'hashed_pw5', '+233540000005', 'host');


INSERT INTO Property (property_id, host_id, name, description, location, price_per_night)
VALUES
(UUID(), (SELECT user_id FROM User WHERE email = 'johnsmith@example.com'),
 'Beachfront Villa', 'A beautiful villa with ocean view.', 'Accra', 300.00),
(UUID(), (SELECT user_id FROM User WHERE email = 'lindaj@example.com'),
 'City Apartment', 'Modern apartment in the heart of the city.', 'Kumasi', 150.00);


INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, total_price, status)
VALUES
(UUID(), (SELECT property_id FROM Property WHERE name = 'Beachfront Villa'),
 (SELECT user_id FROM User WHERE email = 'sarahw@example.com'),
 '2025-11-10', '2025-11-15', 1500.00, 'confirmed'),

(UUID(), (SELECT property_id FROM Property WHERE name = 'City Apartment'),
 (SELECT user_id FROM User WHERE email = 'michaelb@example.com'),
 '2025-12-01', '2025-12-03', 300.00, 'pending');


INSERT INTO Payment (payment_id, booking_id, amount, payment_method)
VALUES
(UUID(), (SELECT booking_id FROM Booking WHERE status = 'confirmed'), 1500.00, 'credit_card'),
(UUID(), (SELECT booking_id FROM Booking WHERE status = 'pending'), 300.00, 'PayPal');


INSERT INTO Review (review_id, property_id, user_id, rating, comment)
VALUES
(UUID(),
 (SELECT property_id FROM Property WHERE name = 'Beachfront Villa'),
 (SELECT user_id FROM User WHERE email = 'sarahw@example.com'),
 5, 'Amazing stay! Beautiful view and clean rooms.'),
(UUID(),
 (SELECT property_id FROM Property WHERE name = 'City Apartment'),
 (SELECT user_id FROM User WHERE email = 'michaelb@example.com'),
 4, 'Nice and convenient, but a bit noisy.');


INSERT INTO Message (message_id, sender_id, recipient_id, message_body)
VALUES
(UUID(),
 (SELECT user_id FROM User WHERE email = 'sarahw@example.com'),
 (SELECT user_id FROM User WHERE email = 'johnsmith@example.com'),
 'Hi John, I had a great time at your villa!'),
(UUID(),
 (SELECT user_id FROM User WHERE email = 'johnsmith@example.com'),
 (SELECT user_id FROM User WHERE email = 'sarahw@example.com'),
 'Thanks, Sarah! You’re welcome anytime.');

