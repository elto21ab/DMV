CREATE OR REPLACE PROCEDURE fact.FactListing_load()
LANGUAGE plpgsql
AS $$
BEGIN
    TRUNCATE TABLE fact.FactListing;
    
    INSERT INTO fact.FactListing
    SELECT 
        da.accommodation_key,
        dh.host_key,
        dr.review_key,
        l.id as listing_id,
        l."price_DKK" as price_DKK,
        l.instant_bookable,
        l.avg_sentiment,
        l.n_bookings as number_of_bookings,
        l.active_period_years,
        l.review_scores_rating,
        l.number_of_reviews,
        l.reviews_per_month,
        l.yearly_review
    FROM public.listings l
    JOIN dim.DimAccommodation da ON CAST(l.id AS VARCHAR(50)) = da.accommodation_id
    JOIN dim.DimHost dh ON CAST(l.host_id AS VARCHAR(50)) = dh.host_id
    JOIN dim.dimReview dr ON CAST(l.id AS VARCHAR(50)) = dr.review_id;
    
    COMMIT;
END;
$$;

Call fact.FactListing_load();
