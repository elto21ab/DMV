CREATE OR REPLACE PROCEDURE dim.DimAccommodation_load()
LANGUAGE plpgsql
AS $$
BEGIN 
    TRUNCATE TABLE dim.DimAccommodation;

    INSERT INTO dim.DimAccommodation (
        accommodation_id,
        room_type,
        property_type,
        amenity_category,
        accommodates,
        bathrooms,
        beds,
        bedrooms,
        neighborhood,
        latitude,
        longitude,
        location_category
    )
    SELECT DISTINCT
        id as accommodation_id,  
        room_type,
        property_type,
        amenity_category,
        accommodates,
        bathrooms,
        beds,
        bedrooms,
        host_neighbourhood as neighborhood,
        latitude,
        longitude,
        location_category
    FROM public.listings;

    COMMIT;
END;
$$;
call dim.DimAccommodation_load();