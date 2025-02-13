CREATE OR REPLACE VIEW dim_accommodation_view AS
SELECT
    accommodation_key as "Accommodation Key",
    accommodation_id as "Accommodation ID",
    room_type as "Room Type",
    property_type as "Property Type",
    amenity_category as "Amenity Category",
    accommodates as "Guest Capacity",
    bathrooms as "Bathroom Count",
    beds as "Bed Count",
    bedrooms as "Bedroom Count",
    neighborhood as "Neighborhood",
    latitude as "Latitude",
    longitude as "Longitude",
    location_category as "Location Category"
FROM dim.dimaccommodation;