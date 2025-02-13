CREATE OR REPLACE VIEW dim.DimAccommodation AS
SELECT DISTINCT
    ROW_NUMBER() OVER (ORDER BY room_type, property_type, neighborhood, latitude, longitude) as accommodation_id,
    room_type,
    property_type,
    amenities_count,
    accommodates,
    baths,
    beds,
    bedrooms,
    neighborhood,
    latitude,
    longitude,
    distance_to_center
FROM public.listings