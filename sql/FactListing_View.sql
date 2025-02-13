CREATE OR REPLACE VIEW fact.FactListings AS
SELECT DISTINCT
    l.id as listing_id,
    a.accommodation_id,
    l.host_id,
    rv.review_id,
    r.id as comment_id,
    l."price_DKK" as price_DKK,
    l.instant_bookable
FROM public.listings l
LEFT JOIN dim.DimAccommodation a ON 
    l.room_type = a.room_type 
    AND l.property_type = a.property_type 
    AND l.host_neighbourhood = a.neighborhood
    AND l.latitude = a.latitude
    AND l.longitude = a.longitude
LEFT JOIN dim.DimHost h ON 
    l.host_id = h.host_id
LEFT JOIN dim.DimReview rv ON 
    l.review_scores_rating = rv.review_scores_rating
    AND l.review_scores_accuracy = rv.review_scores_accuracy
    AND l.review_scores_cleanliness = rv.review_scores_cleanliness
LEFT JOIN (
    SELECT DISTINCT listing_id, id
    FROM public.reviews
) r ON l.id = r.listing_id;