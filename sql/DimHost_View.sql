-- Create and populate DimHost
CREATE TABLE dim.DimHost AS
SELECT DISTINCT
    host_id,  
    COUNT(*) OVER (PARTITION BY host_id) as host_name_count,
    host_has_profile_photo,
    EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM host_since::date) as host_experience_years,
    superhost, 
    host_identity_verified,
    CASE 
        WHEN host_total_listings_count < 5 THEN 'Small'
        WHEN host_total_listings_count < 10 THEN 'Medium'
        ELSE 'Large'
    END as portfolio_size_category,
    array_length(string_to_array(host_verifications, ','), 1) as host_verifications_count,
    host_response_time
FROM public.listings

-- Add primary key constraint
ALTER TABLE dim.DimHost
ADD CONSTRAINT pk_dimhost PRIMARY KEY (host_id)