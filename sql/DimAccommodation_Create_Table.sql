-- Create DimAccommodation with surrogate key
CREATE TABLE dim.DimAccommodation (
    accommodation_key SERIAL PRIMARY KEY,
    accommodation_id VARCHAR(50),
    room_type VARCHAR(50),
    property_type VARCHAR(50),
    amenity_category VARCHAR(50),
    accommodates INTEGER,
    bathrooms DECIMAL,
    beds INTEGER,
    bedrooms INTEGER,
    neighborhood VARCHAR(100),
    latitude DECIMAL(10,8),
    longitude DECIMAL(11,8),
    location_category VARCHAR(50)
)

