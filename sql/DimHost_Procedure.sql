CREATE OR REPLACE PROCEDURE dim.DimHost_load()
LANGUAGE plpgsql
AS $$
BEGIN 
    TRUNCATE TABLE dim.DimHost;
    
    INSERT INTO dim.DimHost (
        host_id,
        host_has_profile_pic,
        host_experience_years,
        is_superhost,
        host_identity_verified,
        host_total_listings_count,
        host_verifications_count,
        host_response_time
    )
    SELECT DISTINCT ON (host_id)
        host_id, 
        host_has_profile_pic,
        host_experience_years,
        superhost as is_superhost,
        host_identity_verified,
        host_total_listings_count,
        host_verifications_count,
        host_response_time
    FROM public.listings;
END;
$$;

call dim.DimHost_load();