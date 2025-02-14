CREATE TABLE dim.DimReview (
    review_key SERIAL PRIMARY KEY,
    review_id VARCHAR(50),
    review_scores_accuracy DECIMAL,
    review_scores_cleanliness DECIMAL,
    review_scores_checkin DECIMAL,
    review_scores_communication DECIMAL,
    review_scores_location DECIMAL,
    review_scores_value DECIMAL
);

CALL dim.DimReview_load();
