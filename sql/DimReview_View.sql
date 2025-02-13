CREATE OR REPLACE VIEW public.DimReview AS
SELECT DISTINCT
    id AS review_id,
    review_scores_rating,
    review_scores_accuracy,
    review_scores_cleanliness,
    review_scores_checkin,
    review_scores_communication,
    review_scores_location,
    review_scores_value,
    number_of_reviews,
    reviews_per_month,
    calculated_yearly_reviews AS yearly_reviews
FROM public.listings