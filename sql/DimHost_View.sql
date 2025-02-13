CREATE OR REPLACE VIEW dim.DimHost AS
WITH unique_hosts AS (
    SELECT DISTINCT
        host_location,
        host_response_time,
        host_acceptance_rate_pct,
        host_experience_years,
        superhost,
        host_total_listings_count,
        host_listings_ratio,
        host_verifications_count
    FROM public.listings
)
SELECT 
    ROW_NUMBER() OVER (ORDER BY host_location, host_response_time) as host_id,
    host_experience_years,
    superhost,
    host_total_listings_count,
    host_listings_ratio,
    CASE 
        WHEN host_total_listings_count <= 1 THEN 'Small'
        WHEN host_total_listings_count <= 5 THEN 'Medium'
        ELSE 'Large'
    END as portfolio_size_category,
    host_location,
    host_verifications_count,
    host_response_time,
    host_acceptance_rate_pct
FROM unique_hosts 


