-- SQL project 
-- Netflix Userbase
-- TOPIC
-- Understanding User Behavior, Subscription Trends, and Revenue Insights in a Global Userbase 

-- Team Moyin Odumewu, Ridwan Rahmon, Ota Ugorji Okorie

--------------

create database Netflix;
use netflix;
-- import userbase into database
-- Show table 
SELECT 
    *
FROM
    netflixuserbase;
    
ALTER table netflixuserbase
drop column planduration;
# DISCLAIMER; this data set is based on a monthly subscription by user (1-month plan) hence the removal of planduration column. 

--------
-- Query Questions 

-- Understanding User Behavior

# total no of subscribers(users)
SELECT 
    COUNT(*) AS total_subscribers
FROM
    netflixuserbase;

# Count the number of users for each device type within each country.
SELECT 
    country, device, COUNT(*) AS Users
FROM
    netflixuserbase
GROUP BY country , device
ORDER BY users DESC;

# what are the top 5 countries with the most users?
select country, count(*) as users
from netflixuserbase
group by country
order by users desc
limit 5;

# Compare the total revenue generated by male and female users.
SELECT 
    gender, SUM(MonthlySubsrciption) AS TotalRevenue
FROM
    netflixuserbase
GROUP BY gender
ORDER BY TotalRevenue DESC;

# Identify the most popular device type for each Age-Group.
SELECT 
    agegroup, device, COUNT(*) AS Users
FROM
    netflixuserbase
GROUP BY agegroup , device
ORDER BY agegroup ASC;

# Analyze the demographics (age group and gender) of users subscribed to the Premium plan.
SELECT 
	gender, agegroup, COUNT(*) AS users
FROM
    netflixuserbase
WHERE
    SubscriptionType = 'premium'
GROUP BY agegroup , gender
ORDER BY users DESC;

# Identify users who have been subscribed for more than one year.
SELECT 
    *
FROM
    netflixuserbase
WHERE
    DATEDIFF('2023-06-30', JoinDate) > 365;

# Find the age group, gender, and device type combination that generates the highest average revenue.
SELECT 
    agegroup,
    gender,
    device,
    subscriptiontype,
    ROUND(AVG(monthlysubsrciption), 2) AS avg_revenue
FROM
    netflixuserbase
GROUP BY agegroup , gender , device, subscriptiontype
ORDER BY avg_revenue DESC
LIMIT 1;

# Segment users based on AgeGroup and calculate their average monthly revenue and total count.
SELECT 
    agegroup,
    COUNT(*) AS Users,
    ROUND(AVG(MonthlySubsrciption), 2) AS AvgRevenue
FROM
    netflixuserbase
GROUP BY agegroup
ORDER BY avgrevenue DESC;


------

-- SUBSCRIPTION TREND
# What is the retention rate for each subscription type (users active for over a year)?
SELECT 
    SubscriptionType,
    ROUND(COUNT(*) * 100.0 / (SELECT 
                    COUNT(*)
                FROM
                    netflixuserbase
                WHERE
                    DATEDIFF('2023-06-30', JoinDate) > 365),
            2) AS RetentionRate
FROM
    netflixuserbase
WHERE
    DATEDIFF('2023-06-30', JoinDate) > 365
GROUP BY SubscriptionType;


# Which countries contribute the highest revenue
SELECT 
    SUM(MonthlySubsrciption) AS TotalRevenue, country
FROM
    netflixuserbase
GROUP BY country
ORDER BY TotalRevenue DESC;

# Identify countries with a total revenue above $2500. 
SELECT 
    country,
    SUM(MonthlySubsrciption) AS TotalSubscriptionPayment
FROM
    netflixuserbase
GROUP BY country
HAVING TotalSubscriptionPayment > 2500
ORDER BY totalsubscriptionpayment DESC;


---

-- REVENUE INSIGHT
# Calculate the total revenue generated across all subscriptions.
SELECT 
    SUM(MonthlySubsrciption) as TotalRevenue
FROM
    netflixuserbase;
    
#  Determine the average MonthlySubscription for each Age-Group.
SELECT 
    agegroup, ROUND(AVG(MonthlySubsrciption), 2) AS AvgRevenue
FROM
    netflixuserbase
GROUP BY agegroup;

#  Calculate the total revenue for each SubscriptionType within each country.

SELECT 
    SUM(MonthlySubsrciption) AS TotalSubscriptionPayment,
    SubscriptionType,
    country
FROM
    netflixuserbase
GROUP BY SubscriptionType , country
ORDER BY Totalsubscriptionpayment desc, country asc;

#  Find the average revenue per user for each country.

SELECT 
    ROUND(AVG(MonthlySubsrciption), 2) AS AvgRevenue, country
FROM
    netflixuserbase
GROUP BY country
ORDER BY Avgrevenue DESC;

# identify the subscriptiontype and device used the most
SELECT 
    SubscriptionType, device, COUNT(*) AS users
FROM
    netflixuserbase
GROUP BY SubscriptionType , device
ORDER BY users DESC;

# Which gender prefers which subscription type the most?
select 
gender, SubscriptionType, count(*) as users
from
netflixuserbase
group by gender, SubscriptionType
order by users desc;

# What percentage of users access the platform through each type of device?
SELECT 
 device,
 round(count(*)/(select count(*) from netflixuserbase)* 100.00,2) as percentage
 from
	netflixuserbase
group by device
order by percentage DESC;
 



