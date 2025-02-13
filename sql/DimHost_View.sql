CREATE OR REPLACE VIEW dim_host_view AS
SELECT
    host_key as "Host Key",
    host_id as "Host ID",
    host_has_profile_pic as "Has Profile Picture",
    host_experience_years as "Experience Years",
    host_response_rate as "Response Rate",
    is_superhost as "Is Superhost",
    host_identity_verified as "Identity Verified",
    host_total_listings_count as "Total Listings",
    host_verifications_count as "Verifications Count",
    host_response_time as "Response Time"
FROM dim.dimhost;