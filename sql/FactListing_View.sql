CREATE OR REPLACE VIEW fact.fact_listing_view AS
SELECT
    accommodation_key as "Accommodation Key",
    host_key as "Host Key",
    review_key as "Review Key",
    listing_id as "Listing ID",
    price_dkk as "Price (DKK)",
    instant_bookable as "Instant Booking Available",
    avg_sentiment as "Average Sentiment Score",
    active_period_years as "Booking Activity Period (Years)",
    number_of_bookings as "Total Bookings",
    review_scores_rating as "Overall Rating",
    number_of_reviews as "Total Amount of Reviews",
    reviews_per_month as "Reviews per Month",
    yearly_reviews as "Yearly Reviews"
FROM fact.factlisting;