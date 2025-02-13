CREATE OR REPLACE VIEW public.DimHost AS
SELECT DISTINCT
    host_id,
    host_experience_years,
    superhost,
    host_identity_verified,
    host_total_listings_count,
    host_verifications_count,
    host_response_time,
    host_acceptance_rate_pct
FROM public.listings 