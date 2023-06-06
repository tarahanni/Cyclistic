-- create a table for each data 
-- for example this is for the table in January 2022
CREATE TABLE jan_2022 (
	ride_id varchar(255),
    rideable_type varchar(255),
    started_at datetime,
    ended_at datetime,
    start_station_name varchar(255),
    start_station_id varchar(255),
    end_station_name varchar(255),
    end_station_id varchar(255),
    start_lat float,
    start_lng float,
    end_lat float,
    end_lng float,
    member_casual varchar(255));

-- import csv for january 2022
-- This is an example if the CSV data delimiter is " ; " 
load data local infile '/Users/tarahanni/Desktop/cyclistic/202201-divvy-tripdata.csv'
into table jan_2022
fields terminated by ';'
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

-- and for the CSV data delimiter " , " is
load data local infile '/Users/tarahanni/Desktop/cyclistic/202212-divvy-tripdata.csv'
into table dec_2022
fields terminated by ','
enclosed by '"'
lines terminated by '\r\n'
ignore 1 rows;

-- Merge the table data from January 2022 to December 2022 into one table
CREATE TABLE year_2022 AS (
SELECT * FROM jan_2022
UNION
SELECT * FROM feb_2022
UNION
SELECT * FROM mar_2022
UNION
SELECT * FROM apr_2022
UNION
SELECT * FROM may_2022
UNION
SELECT * FROM june_2022
UNION
SELECT * FROM july_2022
UNION
SELECT * FROM aug_2022
UNION
SELECT * FROM sep_2022
UNION
SELECT * FROM okt_2022
UNION
SELECT * FROM nov_2022
UNION
SELECT * FROM dec_2022);



-- DATA EXPLORATION AND CLEANING--

-- check if the ride_id column is empty
SELECT COUNT(ride_id) as empty_ride_id
FROM Cyclistic.year_2022
WHERE ride_id  = ''; -- no empty rows

-- check if there is duplicate ride_id
SELECT ride_id, COUNT(ride_id) as num_duplicate
FROM cyclistic.year_2022 
GROUP BY ride_id
ORDER BY num_duplicate desc; -- no duplicate in ride_id column

-- check that the rideable_type column contains three values
SELECT DISTINCT rideable_type AS type_of_bikes,
COUNT(rideable_type) AS num_of_riders
FROM Cyclistic.year_2022
GROUP BY type_of_bikes; -- it contains classic bikes, electric bikes, and docked bikes

-- check if there are null values in columns started_at and ended_at
SELECT COUNT(started_at) AS started_at_empty , COUNT(ended_at) AS ended_at_empty
FROM Cyclistic.year
WHERE started_at IS NULL OR ended_at IS NULL; -- There are no null values.

-- check if there are missing values in columns start_station_name, start_station_id,end_station_name,end_station_id
SELECT COUNT(start_station_name)
FROM Cyclistic.year_2022
WHERE start_station_name  = ''; -- total 833,064 rows are missing 
        
SELECT  COUNT(start_station_id) 
FROM Cyclistic.year_2022
WHERE start_station_id = ''; -- total 833,064 rows are missing 

SELECT  COUNT(end_station_name)
FROM Cyclistic.year_2022
WHERE end_station_name = ''; -- total 892,742 rows are missing 

SELECT  COUNT(end_station_id)
FROM Cyclistic.year_2022
WHERE  end_station_id = ''; -- total 892,742 rows are missing

-- check if the start_lat, start_lng, end_lat, end_lng columns have missing values
SELECT  COUNT(start_lat)
FROM Cyclistic.year_2022
WHERE  start_lat IS NULL ; -- 0

SELECT  COUNT(start_lng)
FROM Cyclistic.year_2022
WHERE  start_lng IS NULL ; -- 0

SELECT  COUNT(end_lat)
FROM Cyclistic.year_2022
WHERE  end_lat IS NULL ; -- 0

SELECT  COUNT(end_lng)
FROM Cyclistic.year_2022
WHERE  end_lng IS NULL ; -- 0
-- no missing values from each column

-- first check if there are missing values in column member_casual
SELECT  COUNT(member_casual)
FROM Cyclistic.year_2022
WHERE  member_casual = ''; -- there is no missing values in column member_casual

-- then, check this column contains only two values: casual and member
SELECT DISTINCT member_casual AS type_of_riders,
COUNT(member_casual) AS num_of_riders
FROM Cyclistic.year_2022
GROUP BY member_casual;  -- return 4 rows: casual, member and some errors with casual\r and member\r

-- fix the problem in column member_casual
UPDATE   Cyclistic.year_2022 
SET   member_casual = 'casual' 
WHERE   member_casual = 'casual\r';

UPDATE   Cyclistic.year_2022 
SET   member_casual = 'member' 
WHERE   member_casual = 'member\r'; 


-- create new column to calculate the duration in minute of bike usage

ALTER TABLE cyclistic.year_2022 
ADD COLUMN duration_minute INT;

UPDATE cyclistic.year_2022 
SET duration_minute = TIMESTAMPDIFF(minute,started_at,ended_at);

-- check if there are duration less than 0 minute and more than 1 day (1440 minutes)
SELECT COUNT(duration_minute) AS less_than_minute
FROM cyclistic.year_2022 
WHERE duration_minute <0; -- there are 74 rows that the duration less than 0 minute

SELECT COUNT(duration_minute) AS more_than_day
FROM cyclistic.year_2022 
WHERE duration_minute > 1440; -- there are 5,359 rows that the duration more than a day


-- create new columns to show the cyclist's day and month
ALTER TABLE cyclistic.year_2022 
ADD COLUMN day_of_week varchar(255),
ADD COLUMN month_ varchar(255);

ALTER TABLE cyclistic.year_2022 
DROP COLUMN day_of_week,
DROP COLUMN month_;

-- create new table for the cleaned data
CREATE TABLE cleaned_data_year AS (
SELECT ride_id, rideable_type, 
	start_station_name,
	end_station_name,
	started_at,
	ended_at, duration_minute,
	CASE DAYOFWEEK(started_at)
		WHEN 1 THEN 'SUN'
		WHEN 2 THEN 'MON'
		WHEN 3 THEN 'TUE'
		WHEN 4 THEN 'WED'
		WHEN 5 THEN 'THU'
		WHEN 6 THEN 'FRI'
		WHEN 7 THEN 'SAT'    
		END AS day_of_week,
	CASE EXTRACT(MONTH FROM started_at)
		WHEN 1 THEN 'JAN'
		WHEN 2 THEN 'FEB'
		WHEN 3 THEN 'MAR'
		WHEN 4 THEN 'APR'
		WHEN 5 THEN 'MAY'
		WHEN 6 THEN 'JUN'
		WHEN 7 THEN 'JUL'
		WHEN 8 THEN 'AUG'
		WHEN 9 THEN 'SEP'
		WHEN 10 THEN 'OCT'
		WHEN 11 THEN 'NOV'
		WHEN 12 THEN 'DEC'
		END AS month_,
	start_lat, start_lng, end_lat, end_lng, member_casual
FROM cyclistic.year_2022 
WHERE 	start_station_name = ' ' AND
		end_station_name = ' ' AND
        duration_minute > 0 AND duration_minute < 1440); -- return 4,292,553 rows


        
-- DATA ANALYSIS --


-- total members and casual riders
SELECT DISTINCT member_casual,
COUNT(*) AS total_riders
FROM Cyclistic.cleaned_data_year
GROUP BY member_casual; -- with casual: 1,731,091 and member: 2,561,462

-- type and number of bicycles used by casual and members
SELECT member_casual, rideable_type, COUNT(*) AS num_of_riders
FROM Cyclistic.cleaned_data_year
GROUP BY member_casual, rideable_type
ORDER BY num_of_riders; 

-- calculate used by bike types annually
SELECT rideable_type, COUNT(*) AS num_of_riders
FROM Cyclistic.cleaned_data_year
GROUP BY rideable_type
ORDER BY num_of_riders DESC; -- with classic bike: 2,558,850; electric bike: 1,560,462; docked bike: 173,241


-- number of rides by day
SELECT day_of_week, COUNT(*) AS num_of_riders
FROM Cyclistic.cleaned_data_year
GROUP BY day_of_week
ORDER BY num_of_riders DESC; 


-- number of casual riders by hour 
SELECT EXTRACT(HOUR FROM started_at) AS hour, member_casual, COUNT(*) AS num_of_riders
FROM Cyclistic.cleaned_data_year
WHERE member_casual = 'casual'
GROUP BY hour, member_casual
ORDER BY num_of_riders DESC;

-- number of member riders by hour 
SELECT EXTRACT(HOUR FROM started_at) AS hour, member_casual, COUNT(*) AS num_of_riders
FROM Cyclistic.cleaned_data_year
WHERE member_casual = 'member'
GROUP BY hour, member_casual
ORDER BY num_of_riders DESC;


-- number of casual riders by day
SELECT day_of_week, member_casual, COUNT(*) AS num_of_riders
FROM Cyclistic.cleaned_data_year
WHERE member_casual = 'casual'
GROUP BY day_of_week, member_casual
ORDER BY num_of_riders DESC; -- sat, sun, fri, thu, mon, wed, tue (the most used on weekend)


-- number of member riders by day
SELECT day_of_week, member_casual, COUNT(*) AS num_of_riders
FROM Cyclistic.cleaned_data_year
WHERE member_casual = 'member'
GROUP BY day_of_week, member_casual
ORDER BY num_of_riders DESC; -- thu, wed, tue, mon, fri, sat, sun (the most used on weekday)

-- number of riders by month
SELECT month_, COUNT(*) AS num_of_riders
FROM Cyclistic.cleaned_data_year
GROUP BY month_
ORDER BY num_of_riders; -- the least number of riders in January, February, December (in winter) and 
						-- the most number of riders in August, June and July (in summer)
                        
-- number of casual riders by month
SELECT month_, member_casual, COUNT(*) AS num_of_riders
FROM Cyclistic.cleaned_data_year
WHERE member_casual = 'casual'
GROUP BY month_, member_casual
ORDER BY num_of_riders DESC; -- in july, june, august are the most number of casual riders 

-- number of member riders by month
SELECT month_, member_casual, COUNT(*) AS num_of_riders
FROM Cyclistic.cleaned_data_year
WHERE member_casual = 'member'
GROUP BY month_, member_casual
ORDER BY num_of_riders DESC; -- in august, july, june are the most number of member riders


-- most used starting locations in 2022
SELECT start_station_name, COUNT(*) num_of_riders
FROM Cyclistic.cleaned_data_year
GROUP BY start_station_name
ORDER BY num_of_riders DESC; -- Streeter Dr & Grand Ave is the most with 69,923 riders from 1,541 station names 

-- most popular starting locations by casual riders in year 2022
SELECT start_station_name, member_casual, COUNT(*) num_of_riders
FROM Cyclistic.cleaned_data_year
WHERE member_casual = 'casual'
GROUP BY start_station_name, member_casual
ORDER BY num_of_riders DESC; -- Streeter Dr & Grand Ave with 54,135 by casual riders

-- most popular ending locations by casual riders in year 2022
SELECT end_station_name, member_casual, COUNT(*) num_of_riders
FROM Cyclistic.cleaned_data_year
WHERE member_casual = 'casual'
GROUP BY end_station_name, member_casual
ORDER BY num_of_riders DESC; -- Streeter Dr & Grand Ave with 56,888 by casual riders

-- Save cleaned data into CSV format
SELECT 'ride_id', 'rideable_type','start_station_name', 'end_station_name',
'started_at', 'ended_at', 'duration_minute', 'day_of_week', 'month_', 'start_lat', 
'start_lng', 'end_lat', 'end_lng', 'member_casual'
UNION ALL
SELECT ride_id, rideable_type, start_station_name, end_station_name, started_at,
 ended_at, duration_minute, day_of_week, month_, start_lat, start_lng,
end_lat, end_lng, member_casual
	FROM Cyclistic.cleaned_data_year
	INTO OUTFILE '/tmp/cleaned_data_cyclistic.csv'
	FIELDS TERMINATED BY ';'
	ENCLOSED BY '"'
	LINES TERMINATED BY '\n';
    
   
 
