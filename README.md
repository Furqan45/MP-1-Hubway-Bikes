# Hubway Bikes Case Study

![Case Study](https://github.com/user-attachments/assets/a4389948-94f5-4370-b569-76de7867eab5)


# INTRODUCTION
In this case study, we analyze a comprehensive dataset from Hubway, a bike-sharing service, to uncover patterns in urban mobility and user behavior. The dataset includes over 1.5 million recorded trips and is structured into two interconnected tables: trips and stations. The analysis begins with the trips table, which captures essential details such as trip duration, start and end timestamps, start and end stations, bike ID, and user demographics including subscription type, zip code, birth year, and gender (when available).

We then integrate information from the stations table, which provides geographic context by mapping station IDs to their names, municipalities (Boston, Brookline, Cambridge, or Somerville), and coordinates (latitude and longitude). This relational structure allows us to perform a variety of spatial and demographic analyses.

Key business questions explored in this study include identifying peak travel times, analyzing station usage patterns, and comparing ride behavior between registered and casual users. We also examine user demographics to uncover insights such as the most active age groups and gender distribution among riders.

By connecting user behavior with geographic and temporal data, this case study offers actionable insights into usage trends, infrastructure demands, and opportunities for service optimization, supporting data-driven decisions to improve urban transportation planning and customer experience.

# PROJECT AIMS

•	The project aims to analyze over 1.5 million bike-sharing trips to uncover key insights into rider behavior, trip durations, and station usage patterns across different municipalities.

•	By examining demographic attributes such as subscription type, birth year, gender, and ZIP code, the project seeks to differentiate travel behavior between registered and casual users, helping to tailor services more effectively.

•	The project will evaluate spatial data from the stations table, identifying high-traffic locations and geographic trends that inform decisions on station placement, maintenance priorities, and resource allocation.

# ABOUT THE DATA

This database consists of three tables.

•	Trips – This table is made up of 10 columns and over 1.5 million rows, recording individual bike-sharing trips with details such as trip duration, timestamps, station IDs, bike numbers, and user demographics.

•	Stations – This table contains 5 columns and around 140 rows, providing metadata for each station, including station name, municipality, and geographic coordinates (latitude and longitude).



# Entity Relationship diagram


![Relationship Diagram](https://github.com/user-attachments/assets/9804633d-fb45-46c1-9b0f-168a0a707f26)

# CASE STUDY QUESTIONS AND INSIGHTS

# 1. What was the duration of the longest trip? What was the average trip duration? What was the smallest trip duration?

The query calculates the maximum, average, and minimum values from the duration column in the trips table and returns them as "Longest_Trip", "Average_Trip", and "Shortest_Trip" respectively.

![1](https://github.com/user-attachments/assets/c9148399-6cb6-4e2c-b3f0-91e7444f023c)


# 2. How many trips were taken by 'Registered' users?

The query filters the trips table for rows where the sub_type is 'Registered' and counts the number of such trips, returning the result with the alias "Registered_Trips."


![2](https://github.com/user-attachments/assets/ed83205a-75d8-4d46-90d2-5d46d0697689)

# 3. How many trips were taken by male users in comparison to Female users? for Registered users only

The query filters the trips table to include only rows where the sub_type is 'Registered', then groups the data by the gender column and counts the number of trips for each gender, returning the results with the aliases "Gender" and "Trip_Count."

![3](https://github.com/user-attachments/assets/fccc589a-9971-4611-b746-3fc8c23a8586)

# 4. Do registered or casual users take longer trips?

The query groups the trips table by the sub_type column and calculates the average trip duration for each group, returning the results with the aliases "User_Type" and "Average_Duration" to compare which user type takes longer trips.

![4](https://github.com/user-attachments/assets/1512f978-9d6a-4bc0-aaca-8863f7e751ed)


# 5. Which bike was used for the most trips?

The query groups the trips table by the bike_number column, counts the number of trips for each bike, and sorts the result in descending order. It then limits the output to the top result, returning the bike used for the most trips with the aliases "Bike_Number" and "Trip_Count."

![5](https://github.com/user-attachments/assets/4f49ab4b-0717-4e1b-bb90-42c6330d895f)


# 6. What is the average duration of trips by users over the age of 30?

The query filters the trips table to include only rows where the user's age (calculated as YEAR(Current_Date) - birth_date) is greater than 30. It then calculates the average trip duration for these users and returns the result with the alias "Average_Duration_Over_30."

![6](https://github.com/user-attachments/assets/2398df2f-ca6f-43e8-9faa-d270762889fb)


# 7. Which stations are most frequently used for round trips?

The query filters the trips table to include only round trips, where the start_station is equal to the end_station. It then joins this filtered data with the stations table using the station ID, groups the results by station name, counts the number of round trips per station, and sorts the result in descending order. Finally, it limits the output to the top 5 stations, returning the results with the aliases "Station_Name" and "Round_Trip_Count."

![7](https://github.com/user-attachments/assets/fb231bed-bf22-41dd-8397-ce0da15319e9)


# 8. How many trips start and end in different municipalities? Station Table has the Municipality Attribute

The query joins the trips table to the stations table twice—once on the start_station column and once on the end_station column—to retrieve the municipality names for both the starting and ending stations. It then filters the results where the start and end municipalities are different and counts the number of such trips, returning the result with the alias "Different_Municipality_Trips."

![8](https://github.com/user-attachments/assets/c59f5f0c-b8a3-42f9-abe6-b87afb6a1537)


# 9.  How many trips incurred additional fees (lasted longer than 30 minutes)?

The query calculates the trip duration in minutes by dividing the duration column by 60, filters the trips table for rows where the result is greater than 30, and counts the number of such trips. The final result is returned with the alias "Trips_With_Extra_Fees."

![9](https://github.com/user-attachments/assets/b9972878-5a00-46c8-939a-c8c3d26634a1)


# 10.  Which bike was used for the longest total time? Provide the answer in Hours?

The query groups the trips table by the bike_number column, sums the duration values for each bike, converts the total duration from seconds to hours by dividing by 3600, and sorts the result in descending order. It then limits the output to the top result, returning the bike used for the longest total time with the aliases "Bike_Number" and "Total_Hours_Used."

![10](https://github.com/user-attachments/assets/db1389f8-2932-49cb-9ce5-28cf830d4f8d)


# 11.  Did registered or casual users take more round trips? A Round Trip is considered as Same Start and End Destination?

The query filters the trips table to include only round trips, where the start_station is equal to the end_station. It then groups the filtered data by the sub_type column and counts the number of round trips for each user type, returning the results with the aliases "User_Type" and "Round_Trip_Count."

![11](https://github.com/user-attachments/assets/382a3f61-0c79-487f-aa84-8163f3f81c9c)


# 12.   Which municipality had the most frequent Station End?

The query joins the trips table with the stations table on the end_station column to retrieve the municipality information. It then groups the data by the municipality field, counts the number of trips ending in each municipality, sorts the results in descending order, and returns the top result with the aliases "Municipality" and "End_Trip_Count."

![12](https://github.com/user-attachments/assets/eca48204-4702-40cc-a4da-9c79fd02b91a)

# 13.  Which From and To Routes are Frequent with Regards to Municipalities?

The query joins the trips table with the stations table twice—once on the start_station column to get the start municipality, and once on the end_station column to get the end municipality. It then groups the data by both start and end municipalities, counts the number of trips for each route, and returns the result with the aliases "Start_Municipality", "End_Municipality", and "Trip_Count."

![13](https://github.com/user-attachments/assets/5cf48419-a6c6-4627-98e0-fa4e2d2f8195)

# 14.  Which Age Band in "Registered Users" has the most Rides? Calculate Age Bands based on interval of 10 and Cut Off by 70 or Above?

The query filters the trips table to include only rows where the sub_type is 'Registered', then calculates the user's age using the birth year. It uses a CASE WHEN statement to classify ages into bands of 10-year intervals (e.g., "Under 20", "20–29", "30–39", ..., "70 or Above"). The results are then grouped by these age bands and counted, returning the output with the aliases "Age_Band" and "Ride_Count."

![14](https://github.com/user-attachments/assets/8c9d29f1-6782-44c1-b3e5-76a13c4a5371)


# 15.  What Day of the Week is most Popular for Rides? What Time (24 Hrs Format) is Popular on that Particular Date?

The query first extracts the day of the week from the start_date column using a date function, then groups the trips table by this day and counts the number of rides for each day. The result is sorted in descending order to find the most popular day, returned with the aliases "Day_of_Week" and "Ride_Count."

In the second part, a sub-query is used to filter the trips table for the most popular day identified earlier. The query then extracts the hour (in 24-hour format) from the start_date column, groups the data by hour, and counts the number of rides during each hour. It returns the most frequent hour with the aliases "Hour_of_Day" and "Ride_Count."

![15](https://github.com/user-attachments/assets/3d1a685d-8ff2-404a-97cc-db5840a88b2e)

![15 B](https://github.com/user-attachments/assets/f928ab6b-add9-4f9a-853e-367be634aeae)
