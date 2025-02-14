CREATE TABLE dim.DimHost (
    host_key SERIAL PRIMARY KEY,
    host_id VARCHAR(50) UNIQUE,  -- Add UNIQUE constraint here
    host_has_profile_pic BOOLEAN,
    host_experience_years DECIMAL,
    is_superhost BOOLEAN,
    host_identity_verified BOOLEAN,
    host_total_listings_count INTEGER,
    host_verifications_count INTEGER,
    host_response_time VARCHAR(50)
);