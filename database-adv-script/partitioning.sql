ALTER TABLE booking RENAME TO booking_old;

CREATE TABLE booking (
	booking_id UUID,
    user_id UUID,
    property_id UUID,
    start_date DATE NOT NULL,
    end_date DATE,
    total_price DECIMAL(10, 2),
	status VARCHAR(15) CHECK (status IN ('pending', 'confirmed', 'cancelled')) NOT NULL,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (booking_id, start_date)
) PARTITION BY RANGE (start_date);


-- Create partitions
CREATE TABLE booking_2025 PARTITION OF booking
    FOR VALUES FROM ('2025-01-01') TO ('2025-12-31');
CREATE TABLE booking_2026 PARTITION OF booking
    FOR VALUES FROM ('2026-01-01') TO ('2026-12-31');

-- Copy data into new table
INSERT INTO booking SELECT * FROM booking_old;

DROP TABLE booking_old;



