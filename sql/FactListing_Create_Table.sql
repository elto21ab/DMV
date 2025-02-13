CREATE TABLE fact.FactListing (
    accommodation_key INTEGER REFERENCES dim.DimAccommodation(accommodation_key),
    host_key INTEGER REFERENCES dim.DimHost(host_key),
    review_key INTEGER REFERENCES dim.DimReviews(review_key),
    listing_id VARCHAR(50),
    price_DKK DECIMAL,
    instant_bookable BOOLEAN,
    avg_sentiment DECIMAL,
    active_period_years DECIMAL,
    number_of_bookings INTEGER,
    review_scores_rating DECIMAL,
    number_of_reviews INTEGER,
    reviews_per_month DECIMAL,
    yearly_reviews INTEGER
) 
