-- First create a mapping table to store the relationship
CREATE TABLE dim.listing_accommodation_map (
    listing_id INTEGER,
    accommodation_id INTEGER
);

-- Create DimAccommodation with surrogate key
CREATE TABLE dim.DimAccommodation (
    accommodation_id SERIAL PRIMARY KEY,
    room_type VARCHAR(50),
    property_type VARCHAR(50),
    amenities_intervals VARCHAR(50),
    accommodates INTEGER,
    bathrooms DECIMAL,
    beds INTEGER,
    bedrooms INTEGER,
    neighborhood VARCHAR(100),
    latitude DECIMAL(10,8),
    longitude DECIMAL(11,8),
    distance_to_center_interval VARCHAR(50)
)

-- Insert unique combinations and store mappings
WITH unique_accommodations AS (
    SELECT DISTINCT
        room_type,
        property_type,
        amenities as amenities_intervals,
        accommodates,
        bathrooms,
        beds,
        bedrooms,
        neighbourhood as neighborhood,
        latitude,
        longitude,
        'TBD' as distance_to_center_interval
    FROM public.listings
)
INSERT INTO dim.DimAccommodation (
    room_type,
    property_type,
    amenities_intervals,
    accommodates,
    bathrooms,
    beds,
    bedrooms,
    neighborhood,
    latitude,
    longitude,
    distance_to_center_interval
)
SELECT * FROM unique_accommodations

-- Store the mappings
INSERT INTO dim.listing_accommodation_map
SELECT 
    l.id as listing_id,
    a.accommodation_id
FROM public.listings l
JOIN dim.dimaccommodation a ON 
    l.room_type = a.room_type 
    AND l.property_type = a.property_type
    AND l.accommodates = a.accommodates
    AND l.bathrooms = a.bathrooms
    AND l.beds = a.beds
    AND l.bedrooms = a.bedrooms
    AND l.neighbourhood = a.neighborhood
    AND l.latitude = a.latitude
    AND l.longitude = a.longitude