-- Create tables first
CREATE TABLE IF NOT EXISTS calendar (
    listing_id INTEGER,
    date DATE,
    available BOOLEAN,
    price NUMERIC,
    adjusted_price NUMERIC,
    minimum_nights INTEGER,
    maximum_nights INTEGER
);

CREATE TABLE IF NOT EXISTS listings (
    id INTEGER PRIMARY KEY,
    name TEXT,
    host_id INTEGER,
    host_name TEXT,
    neighbourhood TEXT,
    latitude NUMERIC,
    longitude NUMERIC,
    room_type TEXT,
    price NUMERIC,
    minimum_nights INTEGER,
    number_of_reviews INTEGER,
    reviews_per_month NUMERIC,
    calculated_host_listings_count INTEGER,
    availability_365 INTEGER
);

CREATE TABLE IF NOT EXISTS reviews (
    listing_id INTEGER,
    id INTEGER PRIMARY KEY,
    date DATE,
    reviewer_id INTEGER,
    reviewer_name TEXT,
    comments TEXT
);

-- Use COPY commands to load the data
-- Note: You'll need to export the parquet files to CSV first
-- Example using the Python script to convert:
/*
import pandas as pd

# Convert parquet to CSV
pd.read_parquet('data/processed/03_calendar.parquet').to_csv('data/processed/03_calendar.csv', index=False)
pd.read_parquet('data/processed/03_listings.parquet').to_csv('data/processed/03_listings.csv', index=False)
pd.read_parquet('data/processed/03_reviews.parquet').to_csv('data/processed/03_reviews.csv', index=False)
*/

\COPY calendar FROM 'data/processed/03_calendar.csv' WITH (FORMAT csv, HEADER true);
\COPY listings FROM 'data/processed/03_listings.csv' WITH (FORMAT csv, HEADER true);
\COPY reviews FROM 'data/processed/03_reviews.csv' WITH (FORMAT csv, HEADER true);
