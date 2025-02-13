CREATE OR REPLACE VIEW dim.DimAccommodation AS
WITH unique_accommodations AS (
    SELECT DISTINCT
        room_type,
        property_type,
        neighbourhood as neighborhood,
        latitude,
        longitude,
        distance_to_center_km as distance_to_center,
        price_per_person,
        amenities_count,
        accommodates
    FROM public.listings
)
SELECT 
    ROW_NUMBER() OVER (ORDER BY property_type, room_type, neighborhood) as accommodation_id,
    room_type,
    property_type,
    neighborhood,
    latitude,
    longitude,
    distance_to_center,
    price_per_person,
    amenities_count,
    accommodates
FROM unique_accommodations