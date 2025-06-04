USE data_bank

------MP-1 : Hubway Bikes Assignment

--1. What was the duration of the longest trip? What was the average trip duration? What was the smallest trip duration?

SELECT MAX (duration) AS Longest_Trip, 
                AVG (duration) AS Average_Trip, 
               MIN (duration) AS Minimum_Trip 
FROM trips_full;



--2. How many trips were taken by 'Registered' users?

SELECT COUNT(Sub_type) AS Total_Trip 
FROM trips_full 
WHERE sub_type = 'Registered';


--3. How many trips were taken by male users in comparison to Female users? for Registered users only

SELECT gender,COUNT(*) AS Total_Users_Trips
FROM trips_full 
WHERE sub_type = 'Registered' AND gender IN ('Male', 'Female') 
GROUP BY gender;

--4. Do registered or casual users take longer trips?

SELECT sub_type, AVG(duration) AS Average_Duration
FROM trips_full 
GROUP BY sub_type;


--5. Which bike was used for the most trips?

SELECT bike_number, COUNT(*) AS Number_Trips
FROM trips_full 
GROUP BY bike_number
ORDER BY Number_Trips DESC 
LIMIT 1;

--6. What is the average duration of trips by users over the age of 30?

SELECT AVG(duration) AS Average_Duration 
FROM trips_full 
WHERE (YEAR(Now()) - birth_date) > 30;


--7. Which stations are most frequently used for round trips?

SELECT Stations.municipality 
FROM trips_full 
LEFT JOIN stations ON trips_full.start_station = stations.id 
WHERE trips_full.start_station = trips_full.end_station 
GROUP BY Stations.municipality 
ORDER BY COUNT(*) DESC
LIMIT 5;


--8. How many trips start and end in different municipalities? 

SELECT COUNT(*) AS Total_trips 
FROM trips_full 
INNER Join stations s1 ON trips_full.start_station = s1.id 
INNER Join Stations s2 ON trips_full.end_station = s2.id 
WHERE s1.municipality <> s2.municipality;


--9. How many trips incurred additional fees (lasted longer than 30 minutes)?

SELECT Count(*) AS Total_Trip_Additionalfees 
FROM trips_full 
WHERE (duration / 60) > 30;

--10. Which bike was used for the longest total time? 

SELECT bike_number, Floor(SUM(duration)/3600) AS Total_hours 
FROM trips_full 
GROUP by bike_number 
ORDER by Total_hours DESC 
LIMIT 1;

--11. Did registered or casual users take more round trips?

SELECT sub_type, COUNT(*) AS Round_trips 
FROM trips_full
WHERE start_station = end_station 
GROUP BY sub_type 
ORDER BY Round_trips DESC;


--12. Which municipality had the most frequent Station End?

SELECT stations.municipality, COUNT(*) AS Frequent_station 
FROM trips_full 
INNER JOIN stations ON trips_full.end_station = stations.id 
GROUP stations.municipality 
ORDER BY Frequent_station DESC 
LIMIT 1;


--13. Which From and To Routes are Frequent with Regards to Municipalities?

SELECT SM.municipality AS Starting_Municipalities, EM.municipality AS Ending_Municipalities, COUNT(*) AS Rout_Count
FROM trips_full 
JOIN stations SM ON trips_full.start_station = SM.id 
JOIN stations EM ON trips_full.end_station = EM.id 
GROUP BY SM.municipality , EM.municipality 
ORDER BY Rout_Count DESC;


--14.  Which Age Band in "Registered Users" has the most Rides? Calculate Age Bands based on interval of 10 and Cut Off by 70 or Above 

SELECT COUNT(*) AS ride_count, 
(CASE WHEN YEAR(NOW()) - birth_date BETWEEN 0 AND 10 THEN '0-10'
WHEN YEAR(NOW()) - birth_date BETWEEN 11 AND 20 THEN '10-20' 
WHEN YEAR(NOW()) - birth_date BETWEEN 21 AND 30 THEN '20-30' 
WHEN YEAR(NOW()) - birth_date BETWEEN 31 AND 40 THEN '30-40' 
WHEN YEAR(NOW()) - birth_date BETWEEN 41 AND 50 THEN '40-50' 
WHEN YEAR(NOW()) - birth_date BETWEEN 51 AND 60 THEN '50-60' 
WHEN YEAR(NOW()) - birth_date BETWEEN 61 AND 70 THEN '60-70' ELSE 'Above 70' END) AS age_band 
FROM trips_full 
WHERE sub_type = 'Registered' 
GROUP BY age_band
ORDER BY ride_count DESC;



--15 A). What Day of the Week is most Popular for Rides? What Time (24 Hrs Format) is Popular on that Particular Date?

SELECT MOD(DATE_DIFF(Start_date, '2011-01-03', 'day'), 7) AS Day_of_week, COUNT(*) AS Ride_count 
FROM Trips_full 
GROUP BY MOD(DATE_DIFF(Start_date, '2011-01-03', 'day'), 7) 
ORDER BY Ride_count DESC 
LIMIT 1;

---B)----------------------------------------------------------------------------------

WITH Most_Popular_Date AS (SELECT CAST(Start_date AS DATE) AS Popular_Date
FROM Trips_full 
GROUP BY CAST(Start_date AS DATE)
ORDER BY COUNT(*) DESC LIMIT 1) 

SELECT CAST(Start_date AS DATE) AS Popular_Date, 
DATE_PART('hour', Start_date) AS New_time, 
COUNT(*) AS Popular_RIDE
FROM Trips_full 
WHERE CAST(Start_date AS DATE) = (SELECT Popular_Date FROM Most_Popular_Date) 
GROUP BY CAST(Start_date AS DATE), DATE_PART('hour', Start_date) 
ORDER BY Popular_RIDE DESC 
LIMIT 1;

