create database behavior;
use behavior;
select * from user_behavior_dataset;
-- 1) Retrieve all details of users who use iOS devices.
select * from user_behavior_dataset where Operating_System = 'IOS';

-- 2) Find the average screen-on time for users aged over 30
select User_ID,avg(Screen_On_Time) as avg_screen_time,age from user_behavior_dataset where Age>30 group by User_ID,age ;

-- 3) Select the top 5 users based on the highest app usage time (in minutes per day).
select * from user_behavior_dataset order by App_Usage_Time desc limit 5;

-- 4) Retrieve users with more than 50 apps installed and a battery drain of over 1000 mAh per day.
select * from user_behavior_dataset where Number_of_Apps_Installed > 50 and Battery_Drain > 1000;

-- 5) Calculate the average data usage (MB per day) by gender.
select gender , avg(Data_Usage) as avg_data from user_behavior_dataset group by gender;

-- 6) Group by operating system to find the average app usage time
select Operating_System,avg(App_Usage_Time) avg_time from user_behavior_dataset GROUP BY Operating_System;

-- 7) Get the maximum battery drain for each "User Behavior Class" group
select User_Behavior_Class ,max(Battery_Drain) from user_behavior_dataset group by User_Behavior_Class;
select * from user_behavior_dataset;

-- 8) List the top 10 users by data usage.
select * from user_behavior_dataset order by Data_Usage desc limit 10;

-- 9) Show users in descending order of the number of apps installed.
select * from user_behavior_dataset ORDER BY Number_of_Apps_Installed desc;
select * from user_behavior_dataset;

-- 10) Calculate the average Battery Drain (mAh/day) and App Usage Time (min/day) for users with Android vs. iOS.
select Operating_System,avg(Battery_Drain) avg_batter_drain,avg(App_Usage_Time) avg_app_usage_time from user_behavior_dataset group by Operating_System;

-- 11) Identify devices with a Battery_Drain above the average for any Operating_System.
select Device_Model,Operating_System,Battery_Drain from user_behavior_dataset 
where Battery_Drain > any 
(select avg(Battery_Drain) from user_behavior_dataset) 
order by Battery_Drain desc;

-- 12) Calculate the average Data_Usage by Device_Model for each Gender, displaying only results where the average is above 500 MB.
select Gender,Device_Model,avg(Data_Usage) Avg_Datausage 
from user_behavior_dataset group by Gender,Device_Model 
having Avg_datausage > 500 order by avg_datausage desc;

-- 13)Compare the total and average App_Usage_Time between males and females, and find the percentage difference in average usage.
select Gender,sum(App_Usage_Time) Total_Time , avg(App_Usage_Time) Avg_Time 
from user_behavior_dataset group by Gender;

-- 14) Determine the most popular Operating_System within each age group
select 
case
when age between 18 and 30 then "Young"
when age between 31 and 45 then "Middle"
else "Old" end as Age_Group,Operating_System,count(User_ID) Total_Users 
from user_behavior_dataset group by Operating_System,Age_group 
order by Total_users desc;

--  15) For each Operating_System, find the top 3 Device_Models with the highest average Battery_Drain.
select Operating_System,Device_Model,avg(Battery_Drain) Avg_Battery_Drain
from user_behavior_dataset group by Operating_System,Device_Model
order by Avg_Battery_Drain desc limit 3;

--  16) Find Device_Models within each Operating_System where App_Usage_Time is above the average for that system.
select Device_Model,Operating_System,App_Usage_Time 
from user_behavior_dataset where App_Usage_Time > 
any (select avg(App_Usage_Time) from user_behavior_dataset) 
order by App_Usage_Time desc;

-- 17) For each Operating_System, determine the Age_Group with the highest average App_Usage_Time.
SELECT Operating_System, 
       CASE 
           WHEN Age BETWEEN 18 AND 30 THEN 'Young'
           WHEN Age BETWEEN 31 AND 45 THEN 'Middle'
           ELSE 'Old'
       END AS Age_Group,
       AVG(App_Usage_Time) AS Avg_App_Usage
FROM user_behavior_dataset
GROUP BY Operating_System, Age_Group
ORDER BY Operating_System, Avg_App_Usage DESC;
