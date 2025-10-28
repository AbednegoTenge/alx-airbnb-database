-- Indexes for the User table
CREATE INDEX idx_first_name
ON User (first_name);

CREATE INDEX idx_last_name
ON User (last_name);

-- Indexes for the Property table
CREATE INDEX idx_property_name
ON Property (name);

CREATE INDEX idx_property_location
ON Property (location);

-- Index for the Booking table
CREATE INDEX idx_booking_user
ON Booking (user_id);

CREATE INDEX idx_booking_property
ON Booking (property_id);

CREATE INDEX idx_booking_status
ON Booking (status);
