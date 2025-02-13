CREATE TABLE fact.factlistings (
    listing_id INTEGER PRIMARY KEY,
    accommodation_id INTEGER REFERENCES dim.dimaccommodation(accommodation_id),
    host_id INTEGER REFERENCES dim.dimhost(host_id),
    review_id INTEGER REFERENCES dim.dimreview(review_id),
    price_DKK DECIMAL,
    instant_bookable BOOLEAN,
    avg_sentiment_score DECIMAL,
    booking_count INTEGER,
    lifespan_years DECIMAL,
    booking_freq_in_lifespan DECIMAL,
    review_scores_rating DECIMAL,
    number_of_reviews INTEGER,
    reviews_per_month DECIMAL,
    yearly_reviews INTEGER
);

INSERT INTO fact.FactListings
SELECT 
    l.id as listing_id,
    lam.accommodation_id,
    l.host_id,
    lrm.review_id,
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
JOIN dim.listing_accommodation_map lam ON l.id = lam.listing_id
JOIN dim.listing_review_map lrm ON l.id = lrm.listing_id;