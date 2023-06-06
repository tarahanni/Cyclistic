# Google Data Analytics Capstone: Cyclistic Case study
This is my project after completing the Google Analytics course on Coursera. In order to end the course, we are advised to complete the case studies provided by the course and upload it to create our portfolio. In this case study I used **MySQL** in the cleaning and analysis process and for the visualization process used **Tableau**.

## Scenario
I'm playing the role of a junior data analyst working on the marketing analyst team at Cyclistic, a fictional bike-sharing company in Chicago. The director of marketing believes the company’s future success depends on maximizing the number of annual memberships. Therefore, your team wants to understand how casual riders and annual members use Cyclistic bikes differently. From these insights, your team will design a new marketing strategy to convert casual riders into annual members.

## company background
In 2016, Cyclistic launched a successful bike-share offering. Since then, the program has grown to a fleet of 5,824 bicycles that are geotracked and locked into a network of 692 stations across Chicago. The bikes can be unlocked from one station and returned to any other station in the system anytime. Cyclistic offers flexible pricing plans: single-ride passes, full-day passes, and annual memberships. Customers who purchase single-ride or full-day passes are referred to as casual riders. Customers who purchase annual memberships are Cyclistic members.

The director of marketing has set a clear goal: Design marketing strategies aimed at converting casual riders into annual members.
There are three questions will guide the future marketing program:
1. How do annual members and casual riders use Cyclistic bikes differently?
2. Why would casual riders buy Cyclistic annual memberships?
3. How can Cyclistic use digital media to influence casual riders to become members?

The director of marketing has assigned me the first question to answer: How do annual members and casual riders use Cyclistic bikes differently?

## 1. Data sources:
I will use Cyclistic’s historical trip data to analyze and identify trends from January 2022 to December 2022. (Note: The data has been made available by Motivate International Inc. under this [license](https://www.divvybikes.com/data-license-agreement).) 
Each files consist of 13 column names: *ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng and member_casual.* 

## 2. Process:
for large data using MySQL is the right choice rather than using worksheets. From 12 CSV files I imported each of them and combined them into one file under the name year_2022. 
In cleaning up the data, the thing I did was to remove all the missing rows and delete them. so that it doesn't cause any possible bad insights. Then I created new tables such as duration_minute (meaning the duration of each rider in minutes), day_of_week, and month. if there is a duration where the user uses the bike for more than one day, it should be removed. 

## 3. Visualization:
After doing some analysis using a query, I visualized it using Tableau Public. The first step I did was upload the cleaned data under the name cleaned_data_cyclistic and the next steps in visualizing it are as follows: 

### 1. total members and casual riders
![Screen Shot 2023-06-05 at 18 53 42](https://github.com/tarahanni/Cyclistic/assets/135048214/b03874e1-4a2b-4c70-bc9a-f19a82473ecb)

It can be clearly shown that with a total of 4.2 million riders, the number of member riders is greater than casual riders. 

### 2. Percentage of bike users
![% Bike Users](https://github.com/tarahanni/Cyclistic/assets/135048214/3a190d30-2349-4075-939c-cde1bc1b55c7)

From the 3 types of bikes available, the classic bike is the most widely used bike by all users is the classic bike with 59.61%. 

### 3. Types of Bikes most used by members and casual riders
![Types of Bikes Most Used By Members And Casual Riders](https://github.com/tarahanni/Cyclistic/assets/135048214/dc2ee317-32b8-4072-846c-a6bed7bd78e7)

Classic bikes are the most popular bikes from both users and member riders contribute the most to the use of classic bikes, but they don't use docked bikes at all. 

### 4. total riders by day of all type riders
![Number of Rides by Day (Overall)](https://github.com/tarahanni/Cyclistic/assets/135048214/2fda5fd9-59cf-4dc8-97ee-873477c4b026)

The highest number of trips per day is Saturday with more than 650K total trips. 

### 5. Number of rides by day
![Number of Rides by Day](https://github.com/tarahanni/Cyclistic/assets/135048214/81a1fd3c-cbd6-45e3-b930-e3485a8c8f76)

Based on the line chart above, casual riders lead with the highest number on Saturday, but on weekdays the number decreases dramatically and there is a highly significant difference between members and casual riders.

### 6. Number of rides by hour
![Number of rides by Hour-2](https://github.com/tarahanni/Cyclistic/assets/135048214/6ad9b3f1-4be7-4f15-9427-dbe58c8b3bcf)

For member riders, there are two peaks in the morning at 8am and in the afternoon at 5pm while for casual riders the peak is only at 5pm, the trend in the morning is only a gradual increase. 

### 7. Number of rides by month
![Number of Rides by Month](https://github.com/tarahanni/Cyclistic/assets/135048214/5d1a701f-0b48-4832-b991-946c0331a24b)

The trend is obvious that both members and casual riders are at their peak during the summer, which starts in June. After the summer season changes, there is a slow decline until the lowest point is December, which is the winter season.

### 8. Top 10 Start and End station names by casual riders
![Top 10 Start Station Names by Casual Riders](https://github.com/tarahanni/Cyclistic/assets/135048214/00d0aa8c-b02f-4143-ba1a-07af6255420b)
![Top 10 End Station Names by Casual Riders-2](https://github.com/tarahanni/Cyclistic/assets/135048214/65b22401-c3d5-49d6-8d06-a17771f790f8)

In the graph, it can be clearly seen that the order of popularity for picking up the bike as well as dropping the bike is the same for regular riders. However, the gap in the number of trips between the number in first and second place is almost half of the number in first place.


## Summary: 

The difference between members and casual riders is the days on which the bikes are used, member riders tend to use them on busy weekdays in contrast to casual riders who use them only on weekends which are used for leisure or visiting attractions.

Casual riders are most likely to ride bikes on weekends during the afternoon and evening hours. With this information, the marketing team can try to offer some promos to convert them into annual members.

According to the information we have obtained, bikes are widely used in the summer which is the most suitable for cycling. The marketing team can start using ads on social media or placing advertisements at stations that have the most traffic of casual riders starting from May (one month before the summer season starts) to attract the attention of casual riders and offer discounts to use the member riders price only for weekends.










