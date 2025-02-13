CREATE OR REPLACE VIEW dim.DimAccommodation AS
SELECT DISTINCT
    ROW_NUMBER() OVER (
        ORDER BY 
            room_type,
            property_type,
            host_neighbourhood,
            latitude,
            longitude
    ) AS accommodation_id,
    room_type,
    property_type,
    amenities_count,
    accommodates,
    bathrooms,
    beds,
    bedrooms,
    host_neighbourhood AS neighborhood,
    latitude,
    longitude,
    distance_to_center_km
FROM public.listings