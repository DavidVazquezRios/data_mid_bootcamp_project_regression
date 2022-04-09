#1. Create a database called `house_price_regression`.
CREATE SCHEMA IF NOT EXISTS house_price_regresion;

#
USE house_price_regresion;

#2. Create a table `house_price_data` with the same columns as given in the csv file. Please make sure you use the correct data types for the columns.
CREATE TABLE house_price_data (
    id BIGINT UNSIGNED,
    date CHAR(8),
    bedrooms TINYINT UNSIGNED,
    bathrooms DECIMAL(4 , 2 ),
    sqft_living MEDIUMINT UNSIGNED,
    sqft_lot MEDIUMINT UNSIGNED,
    floors DECIMAL(3 , 1 ),
    waterfront TINYINT UNSIGNED,
    view TINYINT UNSIGNED,
    `condition` TINYINT UNSIGNED,
    grade TINYINT UNSIGNED,
    sqft_above INTEGER,
    sqft_basement INTEGER,
    yr_built SMALLINT,
    yr_renovated SMALLINT,
    zipcode MEDIUMINT UNSIGNED,
    lat DECIMAL(6 , 4 ),
    `long` DECIMAL(6 , 3 ),
    sqft_living15 MEDIUMINT UNSIGNED,
    sqft_lot15 MEDIUMINT UNSIGNED,
    price MEDIUMINT UNSIGNED
);



#3. Import the data from the csv file into the table. Before you import the data into the empty table, make sure that you have deleted the headers from the csv file. To not modify the original data, if you want you can create a copy of the csv file as well. Note you might have to use the following queries to give permission to SQL to import data from csv files in bulk:

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/regression_data.csv' 
INTO TABLE house_price_data
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
;

#4.  Select all the data from table `house_price_data` to check if the data was imported correctly
SELECT 
    *
FROM
    house_price_data;

#5.  Use the alter table command to drop the column `date` from the database, as we would not use it in the analysis with SQL. Select all the data from the table to verify if the command worked. Limit your returned results to 10.
ALTER TABLE house_price_data DROP COLUMN `date`;

SELECT 
    *
FROM
    house_price_data
LIMIT
	5;

#6.  Use sql query to find how many rows of data you have.
SELECT 
    COUNT(*) AS number_of_rows
FROM
    house_price_data;

#7.  Now we will try to find the unique values in some of the categorical columns:
#- What are the unique values in the column `bedrooms`?
SELECT 
    distinct(bedrooms) AS unique_bedrooms
FROM
    house_price_data;

#    - What are the unique values in the column `bathrooms`?
SELECT 
    distinct(bathrooms) AS unique_bathrooms
FROM
    house_price_data;

#    - What are the unique values in the column `floors`?
SELECT 
    distinct(floors) AS unique_floors
FROM
    house_price_data;

#    - What are the unique values in the column `condition`?
SELECT 
    distinct(house_price_data.condition) AS unique_condition
FROM
    house_price_data;

#    - What are the unique values in the column `grade`?    
SELECT 
    distinct(grade) AS unique_grade
FROM
    house_price_data;
    
#8.  Arrange the data in a decreasing order by the price of the house. Return only the IDs of the top 10 most expensive houses in your data.
SELECT 
    *
FROM
    house_price_data
ORDER BY price DESC
LIMIT 10;

#9.  What is the average price of all the properties in your data?
SELECT 
    AVG(price) AS average_price
FROM
    house_price_data;
    
#10. In this exercise we will use simple group by to check the properties of some of the categorical variables in our data
#    - What is the average price of the houses grouped by bedrooms? The returned result should have only two columns, bedrooms and Average of the prices. Use an alias to change the name of the second column.
SELECT 
    bedrooms, AVG(price) AS average_price
FROM
    house_price_data
GROUP BY bedrooms
ORDER BY bedrooms ASC;

#    - What is the average `sqft_living` of the houses grouped by bedrooms? The returned result should have only two columns, bedrooms and Average of the `sqft_living`. Use an alias to change the name of the second column.
SELECT 
    bedrooms, AVG(sqft_living) AS average_living_sqf
FROM
    house_price_data
GROUP BY bedrooms
ORDER BY bedrooms ASC;

#    - What is the average price of the houses with a waterfront and without a waterfront? The returned result should have only two columns, waterfront and `Average` of the prices. Use an alias to change the name of the second column.
SELECT 
    waterfront, AVG(price) AS average_price
FROM
    house_price_data
GROUP BY waterfront
ORDER BY waterfront ASC;

SELECT 
    CASE
        WHEN waterfront = 1 THEN 'Yes'
        ELSE 'No'
    END AS waterfront,
    AVG(price) AS average_price
FROM
    house_price_data
GROUP BY waterfront
ORDER BY waterfront ASC;
    
#    - Is there any correlation between the columns `condition` and `grade`? You can analyse this by grouping the data by one of the variables and then aggregating the results of the other column. Visually check if there is a positive correlation or negative correlation or no correlation between the variables.
SELECT 
    grade, avg(house_price_data.condition) AS "condition"
FROM
    house_price_data
GROUP BY grade
ORDER BY grade;

SELECT 
    house_price_data.condition, avg(grade) AS "grade"
FROM
    house_price_data
GROUP BY house_price_data.condition
ORDER BY house_price_data.condition;


# I don´t see any correlacion

#11. One of the customers is only interested in the following houses:
#    - Number of bedrooms either 3 or 4
#    - Bathrooms more than 3
#    - One Floor
#    - No waterfront
#    - Condition should be 3 at least
#    - Grade should be 5 at least
#    - Price less than 300000
#    For the rest of the things, they are not too concerned. Write a simple query to find what are the options available for them?

SELECT 
    *
FROM
    house_price_data
WHERE
    bedrooms BETWEEN 3 AND 4
        AND bathrooms > 3
        AND floors = 1
        AND waterfront = 0
        AND 'condition' >= 3
        AND grade >= 5
        AND price < 300000
;

#12. Your manager wants to find out the list of properties whose prices are twice more than the average of all the properties in the database. Write a query to show them the list of such properties. You might need to use a sub query for this problem.
SELECT 
    *
FROM
    house_price_data
WHERE
    price > 2 * (SELECT 
            AVG(price) AS price_average
        FROM
            house_price_data)
;

#13. Since this is something that the senior management is regularly interested in, create a view of the same query.

CREATE VIEW expensive_properties as
SELECT 
    *
FROM
    house_price_data
WHERE
    price > 2 * (SELECT 
            AVG(price) AS price_average
        FROM
            house_price_data)
;
select * from expensive_properties;

#14. Most customers are interested in properties with three or four bedrooms. What is the difference in average prices of the properties with three and four bedrooms?

SELECT 
    bedrooms, AVG(price) AS price_average
FROM
    house_price_data
GROUP BY bedrooms
HAVING bedrooms BETWEEN 3 AND 4
;

#15. What are the different locations where properties are available in your database? (distinct zip codes)
SELECT DISTINCT
    (zipcode) AS properries_locations
FROM
    house_price_data;
    
 #16. Show the list of all the properties that were renovated.
 
 SELECT 
    *
FROM
    house_price_data
WHERE
    yr_renovated != 0
        OR sqft_living15 != sqft_living
        OR sqft_lot != sqft_lot15
;
 
 #17. Provide the details of the property that is the 11th most expensive property in your database.
 
 SELECT * FROM 
 (SELECT *, DENSE_RANK() OVER (ORDER BY price DESC) AS `price_rank`
FROM house_price_data 
 ) AS renked
 WHERE price_rank = 11
 ;
 
 