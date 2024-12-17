------------------preview Data

SELECT * FROM bike_share_yr_0;
SELECT * FROM bike_share_yr_1;
SELECT * FROM cost_table;


--================================

-- change the data type price , riders coulmn to number
-- the purpose is making it easy to calclation

Alter Table cost_table 
Alter Column price float;
Alter Table cost_table 
Alter Column COGS float;


Alter Table bike_share_yr_0
Alter Column riders int

Alter Table bike_share_yr_1
Alter Column riders int


--================================

-- do left join between bike_share_yr_0 and cost_table
-- the purpose is calclating the revnue value

SELECT 
bike.dteday, bike.season, bike.mnth, bike.holiday,bike.riders,bike.windspeed,bike.hum,bike.rider_type,bike.weekday,
cost.price,cost.COGS,
cost.price * bike.riders as revnue,
cost.price * bike.riders - cost.COGS as profits
From bike_share_yr_0 as bike
LEFT JOIN cost_table as cost
ON bike.yr = cost.yr ;


--================================

--############################### THE TASK ############################################

-- do left join between bike_share_yr_1 and cost_table
-- the purpose is calclating the revnue value

SELECT 
bike.dteday, bike.season, bike.mnth, bike.holiday,bike.riders,bike.windspeed,bike.hum,bike.rider_type,bike.weekday,
cost.price,cost.COGS,
cost.price * bike.riders as revnue,
cost.price * bike.riders - cost.COGS as profits
From bike_share_yr_1 as bike
LEFT JOIN cost_table as cost
ON bike.yr = cost.yr ;



--================================

--############################### THE TASK ############################################


-- merge bike_share_0 and bike_share_1 in temp table

WITH bike_share AS
(
SELECT * FROM bike_share_yr_0
UNION
SELECT * FROM bike_share_yr_1
)

SELECT bike.season,bike.riders,bike.rider_type,bike.temp,bike.windspeed,
bike.riders * cost.price as revenue ,bike.riders * cost.price - cost.COGS as profits
From bike_share as bike
LEFT JOIN cost_table as cost
ON bike.yr = cost.yr



-- 1\ riders number by windspeed

WITH bike_share AS
(
SELECT * FROM bike_share_yr_0
UNION
SELECT * FROM bike_share_yr_1
)

SELECT bike.windspeed,COUNT(bike.riders) as Riders_Count
From bike_share as bike
LEFT JOIN cost_table as cost
ON bike.yr = cost.yr
Group By bike.windspeed ;

-- 2\ riders number by weekday

WITH bike_share AS
(
SELECT * FROM bike_share_yr_0
UNION
SELECT * FROM bike_share_yr_1
)

SELECT bike.weekday,COUNT(bike.riders) as Riders_Count
From bike_share as bike
LEFT JOIN cost_table as cost
ON bike.yr = cost.yr
Group By bike.weekday
ORder By weekday

-- 3\ riders number by weekday

WITH bike_share AS
(
SELECT * FROM bike_share_yr_0
UNION
SELECT * FROM bike_share_yr_1
)

SELECT bike.holiday,COUNT(bike.riders) as Riders_Counte
From bike_share as bike
LEFT JOIN cost_table as cost
ON bike.yr = cost.yr
Group By bike.holiday
ORder By holiday


-- 4\ riders number where riders_type is not registerd

WITH bike_share AS
(
SELECT * FROM bike_share_yr_0
UNION
SELECT * FROM bike_share_yr_1
)

SELECT bike.rider_type,COUNT(bike.riders) as Riders_Counte
From bike_share as bike
LEFT JOIN cost_table as cost
ON bike.yr = cost.yr
Group By bike.rider_type
Having rider_type = 'casual'

-- 5\ revenue of casual riders
-- the revnue for the new price is 13525.04
-- the revnue for the old price is 10719.8

WITH bike_share AS
(
SELECT * FROM bike_share_yr_0
UNION
SELECT * FROM bike_share_yr_1
)

SELECT bike.rider_type, COUNT(bike.rider_type) * cost.COGS as Casual_Riders_Revenue 
From bike_share as bike
LEFT JOIN cost_table as cost
ON bike.yr = cost.yr
Group By bike.rider_type , cost.COGS
Having rider_type = 'casual';

-- 6\ revenue of registered riders
-- the revnue for the new price is 13525.04
-- the revnue for the old price is 10719.8

WITH bike_share AS
(
SELECT * FROM bike_share_yr_0
UNION
SELECT * FROM bike_share_yr_1
)

SELECT bike.rider_type, COUNT(bike.rider_type) * cost.COGS as Casual_Riders_Revenue 
From bike_share as bike
LEFT JOIN cost_table as cost
ON bike.yr = cost.yr
Group By bike.rider_type , cost.COGS
Having rider_type = 'registered'


--  =====   انس ما تتجرس 😁    ========  --
