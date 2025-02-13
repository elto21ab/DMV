CREATE OR REPLACE VIEW fact.FactListings AS
SELECT 
    l.id as listing_id,
    a.accommodation_id,
    l.host_id,
    rv.review_id,
    r.id as comment_id,
    l."price_DKK" as price_DKK,
    l.instant_bookable
FROM public.listings l
JOIN dim.DimAccommodation a ON 
    a.room_type = l.room_type 
    AND a.property_type = l.property_type 
    AND a.neighborhood = l.host_neighbourhood
    AND a.latitude = l.latitude
    AND a.longitude = l.longitude
JOIN dim.DimHost h ON 
    h.host_id = l.host_id
JOIN dim.DimReview rv ON 
    rv.review_scores_rating = l.review_scores_rating
    AND rv.review_scores_accuracy = l.review_scores_accuracy
    AND rv.review_scores_cleanliness = l.review_scores_cleanliness
LEFT JOIN public.reviews r ON 
    l.id = r.listing_id