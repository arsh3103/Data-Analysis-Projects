CREATE DATABASE SQLASMT1;
USE SQLASMT1;

DESC Users;
SELECT * FROM users;
SELECT count(*) FROM users
WHERE  Gender="female";

SELECT * FROM sessions_data;

SELECT Device_type, sum(secs_elapsed) FROM sessions_data
GROUP BY Device_type
ORDER BY 2 DESC;

SELECT action_type,count(action_type) FROM sessions_data
GROUP BY action_type;

 SELECT country_destination, count(id)
 FROM users
 WHERE country_destination !="NDF"
 GROUP BY 1
 ORDER BY 2 DESC;
 
 SELECT gender, signup_method, count(*) FROM users
 WHERE country_destination <> "NDF" AND date_first_booking IS NOT NULL 
 GROUP BY 1,2;
 
 SELECT signup_method, count(id) FROM users
 WHERE gender="Female" AND country_destination != "NDF"
 GROUP BY 1;
 
 SELECT country_destination, AVG(age) AS average_age  FROM users
 WHERE country_destination != "NDF"
 GROUP BY 1
 ORDER BY 2;
 
 SELECT count(age) FROM users
 WHERE age>100;
 
 SELECT id, count(*) AS session_count  FROM sessions_data AS sd
 JOIN users AS u
 ON u.id = sd.user_id
 WHERE country_destination="US"
 GROUP BY 1
 HAVING session_count<5
 ORDER BY 2 DESC;
 
 SELECT u.affiliate_provider, count(sd.action_type)
 FROM users AS u
 INNER JOIN sessions_data AS sd
 ON u.id=sd.user_id
 WHERE action_type = "click"
 GROUP BY 1;
 
SELECT sd.action, sd.device_type, count(sd.action) AS action_count 
FROM sessions_data AS sd
INNER JOIN users AS u
ON u.id=sd.user_id
WHERE country_destination <> "NDF"
GROUP BY 1,2
ORDER BY 3 DESC
LIMIT 5;

SELECT action_type, device_type, AVG(secs_elapsed) AS average_time_spent 
FROM sessions_data AS sd
INNER JOIN users AS u
ON u.id=sd.user_id
WHERE country_destination != "NDF"
GROUP BY 1,2
ORDER BY 3 DESC;


 SELECT sd1.action AS first_action, sd2.action AS second_action,
 count(sd1.action) AS action_pair_count, SUM(sd1.secs_elapsed+sd2.secs_elapsed) AS total_time_spent
 FROM sessions_data AS sd1
 JOIN sessions_data AS sd2
 ON sd1.user_id= sd2.user_id
 JOIN users AS u 
 ON u.id=sd1.user_id
 WHERE sd1.device_type="Windows Desktop" AND 
  sd2.device_type="Windows Desktop" AND
 sd1.action <> sd2.action AND 
 country_destination != "NDF"
 GROUP BY 1,2
 Order BY 4 DESC
 LIMIT 10;
 
SELECT first_affiliate_tracked AS affiliate_channel, count(*) AS total_users, 
sum(country_destination<> "NDF") AS bookings ,  
ROUND((sum(country_destination<> "NDF")/count(*)) *100 ,4) AS conversion_rate
 FROM users
 GROUP BY 1
 HAVING bookings>0 AND 
 affiliate_channel<>""
 ORDER BY 4 desc;
 
 SELECT affiliate_provider, signup_method, 
 count(*) AS total_users, SUM(country_destination <> "NDF") AS bookings,
 ROUND((sum(country_destination<> "NDF")/count(*)) *100 ,4) AS conversion_rate
 FROM users
 GROUP BY 1,2
 ORDER BY 5 DESC, 1 ASC;
 
 SELECT affiliate_channel, count(*) AS total_users, SUM(country_destination<>"NDF") AS bookings,
 ROUND((sum(country_destination<> "NDF")/count(*)) *100 ,4) AS conversion_rate
 FROM users
 GROUP BY 1
 ORDER BY 4 DESC;
 
 
 
 
 
 

