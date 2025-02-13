TRUNCATE TABLE fact.FactListing
INSERT INTO fact.FactListing
SELECT 
    l.id as listing_id,
    da.accommodation_key,
    dh.host_key,
    dr.review_key,
    l.price as price_DKK,
    l.instant_bookable,
    l.avg_sentiment_score,
    l.booking_count,
    l.lifespan_years,
    l.booking_freq_in_lifespan,
    l.review_scores_rating,
    l.number_of_reviews,
    l.reviews_per_month,
    l.yearly_reviews
FROM public.listings l
JOIN dim.DimAccommodation da ON l.accommodation_id = da.accommodation_id
JOIN dim.DimHost dh ON l.host_id = dh.host_id
JOIN dim.DimReview dr ON l.review_id = dr.review_id