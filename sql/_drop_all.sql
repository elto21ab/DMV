drop table if exists 
    dim.DimAccommodation,
    dim.DimReview,
    dim.DimHost, 
    dim.DimLocation,
    dim.DimPropertyType,
    dim.DimRoomType,

drop table if exists 
    fact.FactBooking,
    fact.FactReview,
    fact.FactHost;

drop view if exists
    dim.vw_DimAccommodation,
    dim.vw_DimReview,
    dim.vw_DimHost,
    dim.vw_DimLocation,
    dim.vw_DimPropertyType,
    dim.vw_DimRoomType;
