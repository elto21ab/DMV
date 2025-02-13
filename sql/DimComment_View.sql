CREATE OR REPLACE VIEW dim.DimComment AS
SELECT DISTINCT
    r.id AS comment_id,   -- the original primary key from reviews
    r.reviewer_id,
    r.date AS comment_date,
    r.sentiment_score_1_5 AS sentiment_score
FROM public.reviews r
JOIN public.listings l ON r.listing_id = l.id