CREATE OR REPLACE PROCEDURE dim.DimReviews_load()
LANGUAGE plpgsql
AS $$
BEGIN 
    TRUNCATE TABLE dim.DimReviews;
    
    INSERT INTO dim.DimReviews (
        review_id,
        review_scores_accuracy,
        review_scores_cleanliness,
        review_scores_checkin,
        review_scores_communication,
        review_scores_location,
        review_scores_value
    )
    SELECT DISTINCT
        id as review_id,  
        review_scores_accuracy,
        review_scores_cleanliness,
        review_scores_checkin,
        review_scores_communication,
        review_scores_location,
        review_scores_value
    FROM public.listings;
END;
$$;

CALL dim.DimReviews_load();