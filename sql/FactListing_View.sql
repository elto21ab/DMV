CREATE OR REPLACE VIEW fact.FactListings AS
SELECT 
    l.id as listing_id,
    a.accommodation_id,
    l.host_id,
    r.review_id,
    l."price_DKK" as price_DKK,  -- Add quotation marks to handle case sensitivity/special characters
    l.has_availability,
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
JOIN dim.DimReviews r ON 
    r.review_scores_rating = l.review_scores_rating
    AND r.number_of_reviews = l.number_of_reviews
    AND r.reviews_per_month = l.reviews_per_month
    AND r.yearly_reviews = l.yearly_review 