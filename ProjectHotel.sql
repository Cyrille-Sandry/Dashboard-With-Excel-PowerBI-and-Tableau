
/*     PROJECT       */

/* 

The following tasks will be covered in this project:

1. Build a data base using SQL server

2. Analyse data using SQL queries

3. Connecte Power BI to the data base

4. Visualize data in power BI



BUSINESS CASE:

A. Is our hotel revenues growing by year?
   We have two hotel types, so it would be good to segment revenue by hotel type.


B. Should we increase our parking lot size?
    We want to understand is there is a trend in guest with personal cars.

C. What trends can we see in the data?
   Focus on average daily rate and guests to explore seasonality.





 The aim:   Build a visual data story or dashboard using power BI to present to stakeholders
 
 
 */


 -- Visualize the table

 select *
 from HotelsProject.dbo.[2018];

 select *
 from HotelsProject.dbo.[2019];

  select *
 from HotelsProject.dbo.[2020];


-- Let us make one table with the date as the colum name are the same each year

select *
from HotelsProject.dbo.[2018]
union
select *
from HotelsProject.dbo.[2019]
union
select *
from HotelsProject.dbo.[2020];

--- create  a temporate table with the above union of table using the statement WITH

with Hotel as
(
select *
from HotelsProject.dbo.[2018]
union
select *
from HotelsProject.dbo.[2019]
union
select *
from HotelsProject.dbo.[2020]
)

-- visualize the table Hotel
select *
from Hotel;


-- Display the names of the Hotels in the group

with Hotel as
(
select *
from HotelsProject.dbo.[2018]
union
select *
from HotelsProject.dbo.[2019]
union
select *
from HotelsProject.dbo.[2020]
)
select distinct hotel as 'List of Group hotels'
from Hotel;




-- Display the number of rows of the table Hotel
with Hotel as
(
select *
from HotelsProject.dbo.[2018]
union
select *
from HotelsProject.dbo.[2019]
union
select *
from HotelsProject.dbo.[2020]
)
select count(*) as 'Number of rows'
from Hotel;



-- Compute the revenue by year 

with Hotel as
(
select *
from HotelsProject.dbo.[2018]
union
select *
from HotelsProject.dbo.[2019]
union
select *
from HotelsProject.dbo.[2020]
)
select arrival_date_year,
       hotel,
       round(sum((stays_in_week_nights + stays_in_weekend_nights)*adr),2) as revenue
from Hotel
group by arrival_date_year, hotel;



--- Visualize the table of the market segment

select * 
from HotelsProject.dbo.market_segment;



--- Visualize the meal_cost table

select *
from HotelsProject.dbo.meal_cost;

--  Join the Hotel table with market_segment table and meal_cost table

with Hotel as
(
select *
from HotelsProject.dbo.[2018]
union
select *
from HotelsProject.dbo.[2019]
union
select *
from HotelsProject.dbo.[2020]
)
select *
from Hotel h
left join HotelsProject.dbo.market_segment ms
     on ms.market_segment=h.market_segment
left join HotelsProject.dbo.meal_cost mc
     on h.meal=mc.meal;


--- get the revenue by hotels


with Hotel as
(
select *
from HotelsProject.dbo.[2018]
union
select *
from HotelsProject.dbo.[2019]
union
select *
from HotelsProject.dbo.[2020]
)
select h.arrival_date_year,
       h.hotel,
       round(sum((h.stays_in_week_nights + h.stays_in_weekend_nights)*h.adr*(1- ms.Discount)),2) as revenue
from Hotel h
left join HotelsProject.dbo.market_segment ms
     on ms.market_segment=h.market_segment
left join HotelsProject.dbo.meal_cost mc
     on h.meal=mc.meal
group by arrival_date_year, hotel;



--- Visualize monthly cancelation and monthly booking changes and monthy occupation by hotel



with Hotel as
(
select *
from HotelsProject.dbo.[2018]
union
select *
from HotelsProject.dbo.[2019]
union
select *
from HotelsProject.dbo.[2020]
)
select  hotel,
        arrival_date_year,
		arrival_date_month,
		sum(stays_in_week_nights+stays_in_weekend_nights) as 'Monthly_stays_in_hotel_number',
        sum(is_canceled) as 'Total_of_mothly_cancelation',
		sum(booking_changes) as 'Monthly_booking_changes'
from Hotel
group by hotel, arrival_date_year, arrival_date_month;












