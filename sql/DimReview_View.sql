CREATE OR REPLACE VIEW dim_review_view AS
SELECT
    review_key as "Review Key",
    review_id as "Review ID",
    review_scores_accuracy as "Accuracy Score",
    review_scores_cleanliness as "Cleanliness Score",
    review_scores_checkin as "Check-in Score",
    review_scores_communication as "Communication Score",
    review_scores_location as "Location Score",
    review_scores_value as "Value Score"
FROM dim.dimreview;

alter table dimreviews rename to DimReview;