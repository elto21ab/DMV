CREATE PROCEDURE dim.DimAccommodation_load() as
BEGIN 
TRUNCATE TABLE dim.DimAccommodation
INSERT INTO dim.DimAccommodation (
    accommodation_id,
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


SELECT DISTINCT
        id as accommodation_id,  
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
END