use phone;
-- top 5 samsung smart phone with the biggest screen
select model, screen_size
 from smartphones 
 WHERE brand_name='samsung' 
 order by screen_size desc limit 5;

-- sort all phones in desc order of number of total cameras
SELECT model , 
num_front_cameras, 
num_rear_cameras, 
num_front_cameras + num_rear_cameras  as 'total_camera' 
FROM smartphones ORDER BY total_camera desc;

-- 3. Sort data on the basis of PPI in decreasing order.
SELECT model, 
SQRT(resolution_height*resolution_height + resolution_width*resolution_width)/screen_size AS 'PPI' 
FROM smartphones
ORDER BY PPI DESC;

-- 4. Find the phone with the 2nd largest battery.
SELECT model, battery_capacity FROM smartphones ORDER BY battery_capacity DESC LIMIT 1 OFFSET 1;
SELECT model, battery_capacity FROM smartphones ORDER BY battery_capacity DESC LIMIT 1,1;

SELECT model, battery_capacity  AS SECOND_LARGEST_BATTERY 
FROM smartphones where battery_capacity=  (select MAX(battery_capacity) 
    FROM smartphones
    WHERE battery_capacity < (
        SELECT MAX(battery_capacity)
        FROM smartphones
    )
    );
    
SELECT model, battery_capacity
FROM (
    SELECT model,
           battery_capacity,
           DENSE_RANK() OVER (ORDER BY battery_capacity DESC) AS rnk
    FROM smartphones
) t
WHERE rnk = 2;


-- 5. Find the name and rating of the worst-rated Apple phone.
SELECT model, rating  
FROM smartphones
 where brand_name='apple' 
 order by rating  limit 1;

-- 6. Sort phones alphabetically and then on the basis of rating in descending order.
SELECT model , rating 
FROM smartphones 
ORDER BY brand_name ASC , rating DESC;


-- 7. Sort phones alphabetically and then on the basis of price in ascending order.
SELECT model , price 
FROM smartphones 
ORDER BY brand_name , price ;


-- ************************************************************
-- Grouping Data
-- ************************************************************



-- 1. Group smartphones by brand and get the count, average price,
--    maximum rating, average screen size, and average battery capacity.
SELECT brand_name, 
count(*) as count, 
AVG(price) as avg, 
max(rating) as max_rating, 
round(avg(screen_size), 2) as avg_screen_size, 
round(avg(battery_capacity) , 2)as avg_capacity
FROM smartphones group by brand_name ;

-- 2. Group smartphones by whether they have NFC and get the
--    average price and average rating.
SELECT has_nfc , 
AVG(price) as avg_price , 
AVG(rating) AS avg_rating 
FROM smartphones 
group by  has_nfc;


-- 3. Group smartphones by extended memory availability and get
--    the average price.
SELECT AVG(price) AS avg_price , 
extended_memory_available 
from smartphones 
GROUP BY extended_memory_available;

-- 4. Group smartphones by brand and processor brand and get
--    the count of models and the average rear primary camera resolution.
SELECT brand_name, 
processor_brand , 
COUNT(*) AS model , 
AVG(primary_camera_rear) AS average 
from smartphones  
GROUP BY brand_name, processor_brand ;

-- 5. Find the top 5 most costly phone brands.
select brand_name ,
 avg(price) as average 
 from  smartphones 
 group by brand_name
 order by average desc limit 5;

-- 6. Find which brand makes the smallest screen smartphones.
SELECT brand_name,
 MIN(screen_size) as mini 
 FROM smartphones 
 GROUP BY brand_name 
 order by mini asc limit 1;
 
-- 7. Find the average price of 5G phones vs. the average price
--    of non-5G phones.
SELECT has_5g ,
 AVG(price) as avg_price 
 FROM smartphones 
 group by  has_5g;

-- 8. Group smartphones by brand and find the brand with the
--    highest number of models that have both NFC and an IR blaster.
select brand_name, count(model) as maxi 
from smartphones 
where has_nfc='True' and has_ir_blaster='True' 
GROUP BY brand_name 
order by maxi desc limit 1;

-- 9. Find all Samsung 5G-enabled smartphones and calculate the
--    average price for NFC and non-NFC phones.
SELECT has_nfc , AVG(price) as avg_price 
 FROM smartphones
 where brand_name='samsung' AND has_5g='True'
 GROUP BY has_nfc;
 
 
 -- *******************************
-- HAVING Clause: for filtering in groups 
-- *******************************

-- 1. Find the average rating of smartphone brands
--    that have more than 20 phones.
SELECT brand_name ,
 COUNT(*) AS CNT,
AVG(rating) as avg_rating 
FROM smartphones
GROUP BY brand_name 
HAVING CNT>20
ORDER BY avg_rating desc;

-- 2. Find the top 3 brands with the highest average RAM
--    that have a refresh rate of at least 90 Hz and fast charging available.
--    Do not consider brands that have fewer than 10 phones.
SELECT brand_name ,
 avg(ram_capacity) as avg_ram
 from smartphones 
 WHERE refresh_rate >=90  and fast_charging_available=1
 GROUP BY brand_name
 HAVING count(*) >10
 ORDER BY avg_ram DESC 
 LIMIT 3;
 
-- 3. Find the average price of all phone brands
--    with an average rating > 70 and more than 10 phones,
--    among all 5G-enabled phones.
SELECT brand_name, AVG(price) AS avg_price
FROM smartphones
WHERE has_5g='True'
GROUP BY brand_name
HAVING AVG(rating)>70 AND COUNT(*)>10;
