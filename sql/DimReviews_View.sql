CREATE OR REPLACE VIEW dim.DimReviews AS
WITH review_metrics AS (
    SELECT 
        l.id as listing_id,
        AVG(r.sentiment_score_1_5) as avg_sentiment_score,
        l.review_scores_rating,
        l.review_score_variance,
        l.first_review,
        l.last_review,
        l.number_of_reviews,
        l.reviews_per_month,
        l.yearly_reviews
    FROM public.listings l
    LEFT JOIN public.reviews r ON l.id = r.listing_id
    GROUP BY 
        l.id,
        l.review_scores_rating,
        l.review_scores_location,
        l.review_score_variance,
        l.first_review,
        l.last_review,
        l.number_of_reviews,
        l.reviews_per_month,
        l.yearly_reviews
)
SELECT 
    ROW_NUMBER() OVER (ORDER BY listing_id) as review_id,
    avg_sentiment_score,
    review_scores_rating,
    review_score_variance,
    first_review,
    last_review,
    number_of_reviews,
    reviews_per_month,
    yearly_reviews
FROM review_metrics