-- First create a mapping table to store the relationship
CREATE TABLE dim.listing_review_map (
    listing_id INTEGER,
    review_id INTEGER
);

-- Create DimReview with surrogate key
CREATE TABLE dim.DimReviews (
    review_id SERIAL PRIMARY KEY,
    review_scores_rating DECIMAL,
    review_scores_accuracy DECIMAL,
    review_scores_cleanliness DECIMAL,
    review_scores_checkin DECIMAL,
    review_scores_communication DECIMAL,
    review_scores_location DECIMAL,
    review_scores_value DECIMAL
);

-- Insert unique combinations and store mappings 
WITH unique_reviews AS (
    SELECT DISTINCT
        review_scores_rating,
        review_scores_accuracy,
        review_scores_cleanliness,
        review_scores_checkin,
        review_scores_communication,
        review_scores_location,
        review_scores_value
    FROM public.listings
)
INSERT INTO dim.DimReviews (
    review_scores_rating,
    review_scores_accuracy,
    review_scores_cleanliness,
    review_scores_checkin,
    review_scores_communication,
    review_scores_location,
    review_scores_value
)
SELECT * FROM unique_reviews;

-- Store the mappings
INSERT INTO dim.listing_review_map
SELECT 
    l.id as listing_id,
    r.review_id
FROM public.listings l
JOIN dim.dimreview r ON 
    l.review_scores_rating = r.review_scores_rating
    AND l.review_scores_accuracy = r.review_scores_accuracy
    AND l.review_scores_cleanliness = r.review_scores_cleanliness
    AND l.review_scores_checkin = r.review_scores_checkin
    AND l.review_scores_communication = r.review_scores_communication
    AND l.review_scores_location = r.review_scores_location
    AND l.review_scores_value = r.review_scores_value