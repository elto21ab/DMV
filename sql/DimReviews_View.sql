CREATE OR REPLACE VIEW dim.DimReviews AS
WITH review_metrics AS (
    SELECT 
        l.id as listing_id,
        AVG(r.sentiment_score_1_5) as avg_sentiment_score,
        l.review_scores_rating,  -- Original column name from listings table
        l.review_scores_variance,  -- Original column name from listings table
        l.number_of_reviews,
        l.reviews_per_month,
        l.yearly_review as yearly_reviews
    FROM public.listings l
    LEFT JOIN public.reviews r ON l.id = r.listing_id
    GROUP BY 
        l.id,
        l.review_scores_rating,
        l.review_scores_variance,
        l.number_of_reviews,
        l.reviews_per_month,
        l.yearly_review
)
SELECT 
    ROW_NUMBER() OVER (ORDER BY listing_id) as review_id,
    avg_sentiment_score,
    review_scores_rating as avg_review_scores_rating,  -- Rename in the final SELECT
    review_scores_variance as avg_review_scores_variance,  -- Rename in the final SELECT
    number_of_reviews,
    reviews_per_month,
    yearly_reviews
FROM review_metrics 