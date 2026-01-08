-- DATE MANIPULATION Starts AT line 845
-- WINDOW FUNCTIONS start at LIne 1110


CREATE DATABASE bike_sales;
USE bike_sales;
DESCRIBE customers;
DROP TABLE customers;

SELECT FirstName, Lastname, gender 
FROM customers
WHERE Gender="F"
LIMIT 10;

SELECT FirstName, Lastname, gender,MaritalStatus
FROM customers
WHERE Gender="F" AND MaritalStatus="M"
LIMIT 10;

SELECT * FROM customers;

SELECT FirstName, LastName, TotalChildren FROM customers
WHERE Totalchildren>=2;

SELECT FirstName, LastName, AnnualIncome,EducationLevel, Occupation FROM customers
WHERE EducationLevel="Bachelors" AND Occupation="Professional";

SELECT FirstName FROM customers
WHERE Firstname LIKE "h%";

SELECT LastName FROM customers
WHERE Lastname LIKE "%A_%G";

-- Find the name pattern:  Any letter, then "a", then any 2 letters and ends in "e"

SELECT Firstname FROM customers
WHERE Firstname LIKE "%A__E";

SELECT Firstname FROM customers
WHERE Firstname LIKE "_A__E";

-- Filter out all customers having occupation in Professional, Management , Clerical

SELECT Firstname, Lastname, Occupation FROM customers
WHERE Occupation IN ("Professional", "Management", "Clerical");

-- Filter out all customers having occupation in Professional, Management , Clerical OR 
-- EducationLevel is Bachelors OR Graduate Degree

SELECT Firstname, Lastname, Occupation, EducationLevel FROM customers
WHERE Occupation IN ("Professional", "Management", "Clerical") AND
EducationLevel IN ("Bachelors", "Graduate Degree")
LIMIT 20;

SELECT * FROM Products;

CREATE TABLE customerdetails AS
SELECT * FROM customers;

SELECT Firstname, Lastname, Gender, AnnualIncome, Totalchildren
FROM customerdetails
LIMIT 10;

SET SQL_SAFE_UPDATES=0;

UPDATE customerdetails
SET AnnualIncome= NULL
WHERE AnnualIncome ="";

CREATE TABLE CodingNinjas(
user_id INT PRIMARY KEY AUTO_INCREMENT,
Name varchar(50) NOT NULL,
Gender char(1),
email varchar(100) UNIQUE,
Age INT,
IsActive BOOLEAN
);

INSERT INTO CodingNinjas
Values(1,"Arshiya", "F","arsh123@gmail.com",24,1),
(2,"Ayesha", "F","ayesh231@gmail.com",23,1);

SELECT * FROM CodingNinjas;

INSERT INTO CodingNinjas (name, age, gender)
Values("Yasmeen", 38, "F");

SELECT Prefix,CustomerKey, FirstName, Lastname, AnnualIncome FROM customers
WHERE Prefix= "";

Update customers
SET Prefix= NULL
Where Prefix= " ";

Update customers
SET Prefix= " "
Where Prefix IS NULL;

ALTER TABLE customers
DROP COLUMN MyUnknownColumn;

ALTER TABLE Customers
ADD Column Country Varchar(50) AFTER Birthdate;

ALTER TABLE customers
MODIFY COLUMN EmailAddress Varchar(50);

ALTER TABLE customers
MODIFY COLUMN Phone_number TEXT;

ALTER TABLE Customers
RENAME COLUMN BirthDate TO DateOfBirth;

SELECT CustomerKey, Firstname,
Length(Firstname) AS firstname_length 
FROM customers
LIMIT 10;

SELECT TRIM('         codingNINJAS       ') AS trimmed;
SELECT LTRIM('     codingNINJAS--------') AS left_trimmed;
SELECT RTRIM('-------codingNINJAS       ') AS right_trimmed;
SELECT TRIM('_' FROM(TRIM('x' FROM 'xxxxxcodingNINJAS_____')))AS TRIMMED;
SELECT TRIM(BOTH FROM (' codingNINJAS    ')) AS trimmed;

SELECT Prefix, Firstname, Lastname, 
CONCAT(Prefix, "-"," ", Firstname, " ", Lastname) AS Full_Name
FROM customers
LIMIT 10;
-- Adding a column "Fullname" After the column Lastname
ALTER TABLE customers
ADD column Fullname Varchar(100) AFTER Lastname;

-- Updated the Fullname column with concat firstname and Lastname
 UPDATE Customers
 SET Fullname=concat(Firstname, " ", Lastname);
 
 SELECT fullname FROM customers;
 
 -- DELETED the firstname and Lastname
 
 ALTER TABLE customers
 DROP Column Firstname, 
 DROP COLUMN Lastname;
 
 SELECT * FROM customers;
 
 ALTER TABLE customers
 ADD Column FirstName Varchar(50) AFTER Prefix,
 ADD COLUMN Lastname Varchar(50) AFTER Firstname;

UPDATE customers
SET Firstname= substring_Index(Fullname, " ", 1);

UPDATE customers
SET Lastname= substring_Index(Fullname, " ", -1);


-- LEFT()?RIGHT()
SELECT CustomerKey, Firstname, Lastname, EmailAddress,
LEFT(EmailAddress,7) AS Trimmed_Address FROM customers
LIMIT 10;

SELECT CustomerKey, Firstname, Lastname, EmailAddress,
RIGHT(EmailAddress,4) AS Trimmed_Address FROM customers
LIMIT 10;

SELECT customerkey, Firstname,Lastname, EmailAddress,
LEFT(emailaddress, LOCATE("@", Emailaddress)-1) AS find_Left
 FROM customers
LIMIT 10;

SELECT customerkey, Firstname,Lastname, EmailAddress,
RIGHT(emailaddress, LENGTH(EmailAddress)-LOCATE("@", Emailaddress)) AS find_right
 FROM customers
LIMIT 10;

ALTER TABLE customers
MODIFY Phone_number TEXT;

-- LPAD/RPAD(column_name of TYPE string, Lenghth that you want to maintain, Padded_Str(what you want to fill towards the left)

SELECT LPAD(Phone_number,10,'0') AS Formatted_Number
FROM Customers
LIMIT 15;

SELECT RPAD(Phone_number,10,'0') AS Formatted_Number
FROM Customers
LIMIT 15;

SELECT LPAD(Phone_number,14,'(+1)0') AS Formatted_Number
FROM Customers
LIMIT 15;

SELECT Concat('(+1)',RPAD(Phone_number,10,'0')) AS Formatted_Number
FROM Customers
LIMIT 15;

-- USE OF REPLACE AND REVERSE

SELECT Firstname, REVERSE(Firstname) AS Reverse_String 
FROM customers
LIMIT 5;
-- CREATING A PALINDROME
SELECT Firstname, REVERSE(Firstname) AS Reverse_String, 
CONCAT(Firstname, REVERSE(Firstname)) AS Pali
FROM customers
LIMIT 5;
-- CHECKING IF IT IS A PALINDROME
SELECT Firstname, REVERSE(Firstname) AS Reverse_String, 
CONCAT(Firstname, REVERSE(Firstname)) AS Pali,
IF(Firstname=REVERSE(Firstname), "YES", "NO") AS If_Pali
FROM customers
LIMIT 5;

-- REPLACE
SELECT Productstyle, REPLACE(Productstyle, "0", "NA") FROM Products
WHERE Productstyle="0"
LIMIT 5;
SET SQL_SAFE_UPDATES=0;
-- Updating the AnnualIncome. Replacing $ and , with ""--->ALTER Command

UPDATE customers
SET AnnualIncome=REPLACE(REPLACE(AnnualIncome, "$", ""), ",", "");

UPDATE Customers
SET AnnualIncome= NULL
WHERE AnnualIncome="";

-- NOW WE CAN CONVERT TEH DATATYPE OF AnnualIncome FROM text to INT

ALTER TABLE Customers
MODIFY COLUMN AnnualIncome INT;

-- USE OF CAST

SELECT AnnualIncome, 
CAST(AnnualIncome AS Decimal(10,2)) AS CastedAnnualIncome
FROM customers
LIMIT 10;

SELECT EmailAddress,
LEFT(EmailAddress, INSTR(EmailAddress, "@")-1) AS "Before@"
FROM customers
LIMIT 5;

SELECT EmailAddress,
RIGHT(EmailAddress, Length(emailAddress)-INSTR(EmailAddress, "@")) AS "Right@"
FROM customers
LIMIT 5;

SELECT "Mumbai#Maharashtra#India" AS String_name,
LEFT(
RIGHT("Mumbai#Maharashtra#India#", LENGTH("Mumbai#Maharashtra#India#")-INSTR("Mumbai#Maharashtra#India#", "#"))
,INSTR(RIGHT("Mumbai#Maharashtra#India#", LENGTH("Mumbai#Maharashtra#India#")-INSTR("Mumbai#Maharashtra#India#", "#")), "#")-1);

/*SELECT "Mumbai#Maharashtra#India" AS String_name,
INSTR(RIGHT("Mumbai#Maharashtra#India#", LENGTH("Mumbai#Maharashtra#India#")-INSTR("Mumbai#Maharashtra#India#", "#")), "#"); */

SELECT SUBSTRING_INDEX(SUBSTRING_INDEX('Mumbai#Maharashtra#India', '#',2), "#", -1);

-- Count the no.of Distinct products sols =d on 2015/2016/2017
USE bike_sales;
SELECT   Count( DISTINCT ProductKey) FROM sales2015;
SELECT   Count( DISTINCT ProductKey) FROM sales2016;
SELECT   Count( DISTINCT ProductKey) FROM sales2017;

SELECT Count(Productkey) FROM products
WHERE ProductCost>1000;

SELECT SUM(productPrice), 
SUM(productCost),
sum(ProductPrice)-sum(productcost) 
 FROM Products;
 
 SELECT 
 CAST(SUM(productPrice) AS DECIMAL (10,2)), 
ROUND(SUM(productCost),2),
Round(sum(ProductPrice)-sum(productcost),2)
 FROM Products;
 
 SELECT Productsubcategorykey, sum(productcost)
 FROM Products
 Group BY ProductSubcategorykey
 ORDER BY Productsubcategorykey ASC;
 
 SELECT Productsubcategorykey,
 CAST(SUM(productPrice) AS DECIMAL (10,2)) AS TotalSales, 
ROUND(SUM(productCost),2) AS TotalProfit,
Round(sum(ProductPrice)-sum(productcost),2) AS GrossProfit
 FROM Products
 Group BY ProductSubcategorykey
 ORDER BY  GrossProfit DESC;

SELECT Group_concat(Subcategoryname SEPARATOR "#") fROM productsubcategories;

SELECT EducationLevel, Count(customerkey)
FROM Customers
Group BY EducationLevel;

SELECT Occupation, Count(customerkey)
FROM Customers
Group BY Occupation;

SELECT EducationLevel, Occupation , Count(customerkey)
FROM Customers
Group BY EducationLevel, Occupation;

SELECT EducationLevel, Occupation , Count(customerkey)
FROM Customers
Group BY EducationLevel, Occupation
HAVING  Count(customerkey)>300;

SELECT EducationLevel, Occupation , Count(customerkey)
FROM Customers
WHERE Occupation != "Clerical"
Group BY EducationLevel, Occupation
HAVING  Count(customerkey)>150;

SELECT EducationLevel, Sum(AnnualIncome)
FROM customers
GROUP BY EducationLevel;

SELECT Occupation, Sum(AnnualIncome)
FROM customers
GROUP BY Occupation;

SELECT Gender, Sum(AnnualIncome)
FROM customers
GROUP BY Gender;

SELECT Occupation, EducationLevel, Sum(AnnualIncome)
FROM customers
WHERE Gender= "M"
GROUP BY Occupation, EducationLevel;

SELECT ProductSubcategoryKey, Round(Avg(ProductCost),2),
ROUND(Avg(ProductPrice),2),
Round(ABS(Avg(ProductCost)-Avg(ProductPrice)),2) AS Avg_Profit
FROM Products
GROUP BY ProductSubcategoryKey 
HAVING Avg_Profit>100
ORDER BY Avg_Profit DESC;



USE bike_sales;
 ALTER TABLE Products
 ADD CONSTRAINT check_positive_qty
 CHECK (productprice>0);
 
 INSERT INTO Products(ProductPrice)
 VALUES(-20);
 
 ALTER TABLE Returns
 ADD CONSTRAINT check_return_qty
 CHECK (ReturnQuantity>0);
 
 INSERT INTO Returns(ReturnQuantity)
 VALUES(-20);
 
 
 
 -- JOINS (INNER JOIN)
 SELECT p.productkey,p.productname,
 SUM(ReturnQuantity) AS TotalReturns
 FROM Products AS p
 INNER JOIN Returns AS r
 ON p.productkey=r.productkey
 GROUP BY productkey, productname
 ORDER BY TotalReturns DESC
 LIMIT 10;
 -- Find all the products that are never returned
 SELECT p.productkey,p.productname,
 SUM(ReturnQuantity) AS TotalReturns
 FROM Products AS p
 LEFT JOIN Returns AS r
 ON p.productkey=r.productkey
 GROUP BY productkey, productname
 HAVING TotalReturns IS NULL;
 -- Find all the products that are returned
 SELECT p.productkey,p.productname,
 SUM(ReturnQuantity) AS TotalReturns
 FROM Products AS p
 LEFT JOIN Returns AS r
 ON p.productkey=r.productkey
 GROUP BY productkey, productname
 HAVING TotalReturns IS NOT NULL;
 
 -- RIGHT JOIN
 SELECT t.salesterritorykey,
 t.region,
 t.country,
SUM( r.returnQuantity) AS TotalReturns
FROM territories AS t
RIGHT JOIN Returns AS r
ON t.salesterritorykey=r.territorykey
GROUP BY 1,2,3;

-- FULL JOIN(LEFTJOIN UNION RIGHTJOIN)
SELECT t.*, r.*
FROM territories AS t
LEFT JOIN Returns AS r
ON t.salesterritorykey=r.territorykey
UNION
SELECT t.*, r.*
FROM territories AS t
RIGHT JOIN Returns AS r
ON t.salesterritorykey=r.territorykey;

-- UNION ALL
SELECT t.*, r.*
FROM territories AS t
LEFT JOIN Returns AS r
ON t.salesterritorykey=r.territorykey
UNION ALL
SELECT t.*, r.*
FROM territories AS t
RIGHT JOIN Returns AS r
ON t.salesterritorykey=r.territorykey;

-- CHALLENGES ON JOINS
-- Display the customer Fullname and what product they bought from all the sales records

SELECT 
CONCAT(c.Firstname, " ", c.Lastname) AS FullName,
ProductName,
s.OrderQuantity
FROM (SELECT * FROM sales2015
UNION ALL
SELECT * FROM sales2016
UNION ALL
SELECT * FROM sales2017) AS s
INNER JOIN Customers AS c
ON c.customerkey=s.customerkey
INNER JOIN Products AS p
ON p.productkey=s.productkey;


SELECT 
CONCAT(c.Firstname, " ", c.Lastname) AS FullName,
ProductName,
SUM(s.OrderQuantity) AS TotalQty
FROM (SELECT * FROM sales2015
UNION ALL
SELECT * FROM sales2016
UNION ALL
SELECT * FROM sales2017) AS s
INNER JOIN Customers AS c
ON c.customerkey=s.customerkey
INNER JOIN Products AS p
ON p.productkey=s.productkey
GROUP BY 1,2
ORDER BY 3 DESC;

-- Which Product is sold all the three years?

/* SELECT DISTINCT p.productName
FROM products AS p
INNER JOIN (
SELECT * FROM sales2015
UNION 
SELECT * FROM sales2016
UNION 
SELECT * FROM sales2017) AS s
ON p.productkey=s.productkey;
NOT RECOMMENDED as UNION will merge all the sales data and inner will check if each productkey from products table is present
atleast once in Mergeed table NOT checking if the productkey is present in all three sales (whereas we want product key in all sales)*/

SELECT DISTINCT p.productName
FROM Products AS p
WHERE p.productkey IN (SELECT productkey FROM sales2015)
AND p.productkey IN (SELECT productkey FROM sales2016)
AND p.productkey IN (SELECT productkey FROM sales2017);
/* Now the product MUST appear:
in 2015 AND in 2016 AND in 2017
Which gives only 16 products → correct answer*/

-- CROSS JOIN
SELECT pc.categoryName, ps.subcategoryName
FROM productcategories AS pc
CROSS JOIN productsubcategories AS ps;

-- SELF JOIN
-- Using Aliases c1 & c2 on customers helping us to perform self join
-- Find the customer pair who share the same last name.???

SELECT 
c1.customerkey AS customer1_ID,
CONCAT(c1.FirstName, " ", c1.Lastname) AS c1_Name,
c2.customerkey AS customer2_ID,
CONCAT(c2.FirstName, " ", c2.Lastname) AS c2_Name,
c1.Lastname
 FROM customers AS c1
 JOIN Customers AS c2
 ON c1.Lastname=c2.Lastname
 AND c1.customerkey<c2.customerkey;

-- Q1)Display productname, Totalsales, Totalexpenses,Quantitysold For sales 2016

 SELECT p.productname,
 ROUND(sum(p.productcost*s.OrderQuantity),0) AS TotalSales,
 ROUND(sum(p.productprice*s.OrderQuantity),0) AS TotalExpenses,
 ROUND(SUM(r.returnQuantity),0) AS Totalreturns,
 ROUND(Sum(s.Orderquantity),0) AS QuantitySold
 FROM sales2016 AS s
 INNER JOIN  products AS p
 ON p.productkey=s.productkey
 INNER JOIN Returns as r
 ON r.productkey=p.productkey
 GROUP BY productname;
 
 -- Q2)Display Category Name and Total Returns
 SELECT pc.categoryname, 
 ROUND(sum(r.returnQuantity),0) AS Totalreturns
 FROM productcategories as pc
 INNER JOIN productsubcategories AS ps
 ON ps.ProductCategoryKey= pc.ProductCategoryKey
 INNER JOIN products AS P
 ON p.ProductSubcategoryKey=ps.ProductSubcategoryKey
 INNER JOIN Returns as r
 ON r.productkey=p.productkey
 GROUP BY 1;
 
--  Q3) Calculate teh tOtalReturns By categoryname and Subcategoryname
 SELECT pc.categoryname, ps.subcategoryname,
 SUM(r.Returnquantity) AS TotalReturns
 FROM productcategories AS pc
 INNER JOIN productsubcategories AS ps
 ON ps.Productcategorykey=pc.productcategorykey
 INNER JOIN products as p
 ON p.productsubcategorykey=ps.productsubcategorykey
 INNER JOIN Returns AS r
 ON p.productkey=r.productkey
 GROUP BY 1,2
 ORDER BY 3 DESC;
 -- Q3) Display total returns by each territory
 SELECT t.salesterritorykey,t.region,t.country,
 ROUND(SUM(returnquantity),0) AS totalReturns
 FROM territories as t
 INNER JOIN returns as r
 ON r.territorykey = t.salesterritorykey
 GROUP BY 1,2,3
 ORDER BY 4 DESC;
 
 -- Q4) Find the categoryname wih TotalSales, TotalExpenses And TotalProfits for all the three years
 SELECT pc.categoryname,
 ROUND(SUM(p.Productprice*s.OrderQuantity),0) AS TotalSales,
 ROUND(SUM(p.Productcost*s.OrderQuantity),0) AS TotalExpenses,
 Round(SUM(p.Productprice*s.OrderQuantity)- SUM(Productcost*OrderQuantity),0) AS TotalProfit,
 ROUND(SUM(returnquantity),0) AS TotalReturns
 FROM (SELECT * FROM sales2015
 UNION ALL
 SELECT * FROM sales2016
 UNION ALL
 SELECT * FROM sales2017) AS s
 INNER JOIN Products AS p
 ON p.productkey=s.productkey
 INNER JOIN Productsubcategories AS ps
ON  ps.ProductsubcategoryKey= p.ProductsubcategoryKey
INNER JOIN productcategories AS pc
ON pc.productcategorykey=ps.productcategorykey
INNER JOIN returns as r
ON r.productkey=p.productkey
GROUP BY 1;

-- Q5) Display teh top 5 customers that brought the highest products

SELECT c.customerkey,CONCAT(c.Firstname, " ", c.Lastname) AS CustomerName,
SUM(s.OrderQuantity) AS Totalqty
FROM customers AS c
INNER JOIN (
SELECT * FROM sales2015
 UNION ALL
 SELECT * FROM sales2016
 UNION ALL
 SELECT * FROM sales2017) AS s
 ON s.customerkey=c.customerkey
 GROUP BY 1,2
 ORDER BY 3 DESC
 LIMIT 5;
 
 Use bike_sales;
 
 ALTER TABLE customers
 ADD COLUMN Incomecategory Varchar(100)
 AFTER AnnualIncome;
 
 DESC Customers;
 
 SET SQL_SAFE_UPDATES=0;
 
 UPDATE Customers
 SET Incomecategory=CASE
 WHEN AnnualIncome IS NULL THEN "Unavailable"
 WHEN AnnualIncome<50000 THEN "Low Income" 
  WHEN AnnualIncome BETWEEN 50000 AND 100000 THEN "Moderate Income" 
ELSE "High Income"
END;
 
 SELECT * FROM customers;
-- CONDITIONAL AGGREGATION WITH CASE STATEMENTS 
 -- Find the territorykrywise Total OrderQuantity and classify them as
 -- high(>2), medium[1,2] and low(<2)
 
 SELECT Territorykey,
 SUM(CASE WHEN OrderQuantity>2 THEN OrderQuantity ELSE 0 END) AS High_sales,
  SUM(CASE WHEN OrderQuantity BETWEEN 1 AND 2 THEN OrderQuantity ELSE 0 END) AS Medium_sales,
   SUM(CASE WHEN OrderQuantity<1 THEN OrderQuantity ELSE 0 END) AS Low_sales
   FROM sales2017
   GROUP BY 1;
   
   ALTER TABLE CUSTOMERS
   ADD COLUMN Fullname Varchar(150)
   AFTER lastname;
   
   UPDATE Customers
   SET Fullname = concat(Firstname, " " , Lastname);


-- Classify the customer based on how frequently they return the product?


SELECT c.customerkey,c.Fullname, SUM(COALESCE(r.returnQuantity,0)) AS TotalReturns, CASE 
WHEN SUM(r.ReturnQuantity)>10 THEN "Frequent returner" 
WHEN  SUM(r.ReturnQuantity) BETWEEN 1 AND 10 THEN "Occasional Returner" 
ELSE "Non Returner"
END AS ReturnBehaviour
FROM customers AS c
LEFT JOIN sales2015 AS s15
ON c.customerkey=s15.customerkey
LEFT JOIN Returns AS r
ON s15.productkey=r.productkey
GROUP BY 1,2
ORDER BY 3 DESC;

SELECT distinct categoryname FROM productcategories;

 -- Create a categoryname as a new column and find the returns based on region.
 
 SELECT t.SalesTerritoryKey, t.region,
 SUM(CASE WHEN pc.categoryname="Bikes" THEN r.returnquantity ELSE 0 END) AS BikeReturns,
 SUM(CASE WHEN pc.categoryname="Components" THEN r.returnquantity ELSE 0 END) AS ComponentReturns,
  SUM(CASE WHEN pc.categoryname="Clothing" THEN r.returnquantity ELSE 0 END) AS ClothingReturns,
   SUM(CASE WHEN pc.categoryname="Accessories" THEN r.returnquantity ELSE 0 END) AS AccessoriesReturns
   FROM territories AS t
   JOIN returns AS r
   ON r.territorykey=t.SalesTerritoryKey
   JOIN products AS p
   ON p.productkey= r.productkey
   JOIN productsubcategories AS ps
   ON ps.productsubcategorykey=p.productsubcategorykey
   JOIN productcategories AS pc
   ON pc.productcategorykey=ps.productcategorykey
   GROUP BY 1,2;
   
   
   SELECT t.Region, pc.categoryname,
   SUM(r.returnQuantity) AS TotalReturnns,
   CASE WHEN SUM(r.returnQuantity)>50 THEN "High Return"
   WHEN SUM(r.returnQuantity)>25 THEN "Moderate Return"
   ELSE "Low Return"
   END AS Returncategory
   FROM Territories AS t
   JOIN Returns AS r
   ON t.Salesterritorykey=r.territorykey
   JOIN Products AS p
   ON p.productkey=r.productkey
   JOIN productsubcategories AS ps
   ON ps.ProductSubcategoryKey=p.ProductSubcategoryKey
   JOIN productcategories AS pc
   ON pc.ProductCategoryKey=ps.ProductCategoryKey
   GROUP BY 1,2
   ORDER BY 3 DESC;
   -- COMMON TABLE EXPRESSIONS
   Use bike_sales;
   
   -- Find the products Having cost more than the average cost in their subcategory
   
   WITH avgcostpersubcategory AS(SELECT 
   ProductSubcategoryKey,
   ROUND(Avg(ProductPrice),0) AS AvgCost
   FROM Products
   GROUP BY 1
   ) 
   SELECT p.Productkey, p.productname, p.productcost, acps.AvgCost
   FROM Products AS p
   JOIN avgcostpersubcategory AS acps
   ON p.productsubcategorykey=acps.productsubcategorykey
   WHERE p.productcost>acps.Avgcost 
   ORDER BY p.productCost DESC;
    
    
    -- Calculate the Total Sales and Total Returns for each product Category
    
   WITH categorySales AS (
   SELECT pc.categoryname,
   SUM(OrderQuantity*p.productPrice) AS TotalSales
   FROM sales2017 AS s17
   JOIN products AS p
   ON s17.productkey=p.productkey
   JOIN productsubcategories AS ps
   ON ps.ProductSubcategoryKey=p.ProductSubcategoryKey
   JOIN productcategories AS pc
   ON pc.ProductCategoryKey=ps.ProductCategoryKey
   GROUP BY 1
   ),
   categoryReturns AS (
   SELECT pc.categoryname,
   SUM(ReturnQuantity) AS TotalReturns
   FROM Returns AS r
   JOIN products AS p
   ON p.productkey=r.productkey
   JOIN productsubcategories AS ps
   ON ps.ProductSubcategoryKey=p.ProductSubcategoryKey
   JOIN productcategories AS pc
   ON pc.ProductCategoryKey=ps.ProductCategoryKey
   GROUP BY 1
   )
   
   SELECT cr.categoryname, cs.totalSales, cr.totalreturns
   FROM categoryReturns AS cr
   JOIN categorysales AS cs
   ON cr.categoryname=cs.categoryname;
   
   
   
   SELECT pc.categoryname,
   SUM(OrderQuantity*p.productPrice) AS TotalSales
   FROM sales2017 AS s17
   JOIN products AS p
   ON s17.productkey=p.productkey
   JOIN productsubcategories AS ps
   ON ps.ProductSubcategoryKey=p.ProductSubcategoryKey
   JOIN productcategories AS pc
   ON pc.ProductCategoryKey=ps.ProductCategoryKey
   GROUP BY 1;
   
   USE bike_sales;
   -- FInd the products that are returned more than 50 times
   SELECT productkey, productname,Modelname, ProductPrice
   FROM products AS p
   WHERE (
   SELECT  SUM(returnQuantity)
   FROM Returns AS r
   WHERE p.productkey=r.productkey)>50;
   
   -- List top 10 products by totalRevenue WITHOUT using JOINS
   SELECT p.productkey, p.productname, t.totalrevenue
   FROM Products AS p, (SELECT p.productkey, ROUND(SUM(p.Productprice * s17.OrderQuantity),0) AS TotalRevenue
         FROM products AS p
         JOIN sales2017 AS s17
         ON p.productkey=s17.productkey
         GROUP BY p.productkey) AS t
	WHERE p.productkey=t.productkey
    ORDER BY t.totalRevenue DESC
    LIMIT 10;
         
         SELECT t.productkey, t.totalrevenue
   FROM (SELECT p.productkey, p.productname,ROUND(SUM(p.Productprice * s17.OrderQuantity),0) AS TotalRevenue
         FROM products AS p
         JOIN sales2017 AS s17
         ON p.productkey=s17.productkey
         GROUP BY p.productkey) AS t

    ORDER BY t.totalRevenue DESC
    LIMIT 10;
    Use bike_sales;
    -- FIND the products whose productprice>avgPrice within the subcategory
    
    USE bike_sales;
    -- -------SOLUTION---------- --
    SELECT p.productname, p.productprice,t.avg_price
    FROM products AS p
JOIN (SELECT pc.ProductSubcategoryKey, pc.subcategoryName, AVG(p2.productPrice) AS avg_price
						FROM products AS p2
                        JOIN productsubcategories AS pc
                        ON pc.ProductSubcategoryKey=p2.ProductSubcategoryKey
                        GROUP BY pc.ProductSubcategoryKey,pc.subcategoryname) AS t
ON p.productsubcategorykey=t.productsubcategorykey
WHERE p.productPrice > t.avg_price;
-- -----------------
-- --------------
SELECT p.productname, p.productprice 
FROM products AS p
WHERE p.productprice>(SELECT AVG(p2.productprice)  AS Avg_price
                FROM Products AS p2
               WHERE p.productsubcategorykey=p2.productsubcategorykey
              );
              
-- Find the Products which ARe returned more than the Avg of total return Qty;
SELECT p.productkey, p.productname, SUM(r.returnQuantity) AS total_returns
FROM products AS p
JOIN Returns AS r
ON r.productkey=p.productkey
GROUP BY p.productkey,p.productname
HAVING  SUM(r.returnQuantity)> (SELECT AVG(t.total_returns) 
FROM ( SELECT SUM(r1.returnQuantity) AS total_returns
            FROM  Returns r1
            GROUP BY r1.productkey) AS t
            );
            
-- Find the regions with their returnQuantity
SELECT t.region, sub.total_returns
FROM territories AS t
JOIN (SELECT r.territorykey, SUM(r.ReturnQuantity) AS total_returns
      FROM Returns AS r
      GROUP BY r.territorykey) AS sub
ON t.SalesTerritoryKey= sub.TerritoryKey;

   
   Use bike_sales;
   -- Find the products which are returned more than the Avg Return Qty
   SELECT p.productkey,p.productname,p.modelname, r.returnQuantity
   FROM Products AS p
   JOIN Returns AS r
   ON p.productkey=r.productkey
   WHERE r.returnQuantity>(SELECT AVG(r2.ReturnQuantity)
                            FROM Returns AS r2
                            JOIN Products AS p2   -- ye samajh nai aaya.. Why are we joining here?
                            ON r2.productkey=p2.productkey
                            WHERE p2.Productsubcategorykey=p.productsubcategorykey
 );
 

		-- Return the region with the max return quantity
        /* SELECT t.region, sub.totalReturnQuantity
        FROM territories AS t
        JOIN (SELECT  t1.Salesterritorykey, SUM(r.returnQuantity) AS totalReturnQuantity
              FROM returns AS r
              JOIN territories AS t1
              ON t1.salesterritorykey= r.territorykey
              GROUP BY t1.salesterritorykey) AS sub
		ON sub.salesterritorykey=t.salesterritorykey
        WHERE sub.totalReturnQuantity = (SELECT Max(totalReturnQuantity) FROM sub);*/-- WRONG coz you cannot use "sub" AT RHS
        
        
SELECT t.region, sub.totalReturnQuantity
FROM territories AS t
JOIN (SELECT t1.salesterritorykey, SUM(r.returnQuantity) AS totalReturnQuantity
        FROM returns AS r
        JOIN territories AS t1
        ON t1.salesterritorykey = r.territorykey
        GROUP BY t1.salesterritorykey
     ) AS sub
ON sub.salesterritorykey = t.salesterritorykey
WHERE sub.totalReturnQuantity = 
      (SELECT MAX(innerSub.totalReturnQuantity)
       FROM (SELECT  SUM(r2.returnQuantity) AS totalReturnQuantity
              FROM returns AS r2
              GROUP BY r2.territorykey
            ) AS innerSub);
            
	 -- CTE Version of the above query-------
WITH sub AS (
    SELECT t1.Salesterritorykey, 
           SUM(r.returnQuantity) AS totalReturnQuantity
    FROM returns AS r
    JOIN territories AS t1
        ON t1.salesterritorykey = r.territorykey
    GROUP BY t1.salesterritorykey
)
SELECT t.region, sub.totalReturnQuantity
FROM territories AS t
JOIN sub
    ON sub.salesterritorykey = t.salesterritorykey
WHERE sub.totalReturnQuantity = (
      SELECT MAX(totalReturnQuantity) FROM sub
);
-- *******************DATE MANIPULATION ******************
-- DATE FORMT IN SQL IS YYYY-MM-DD
-- TIMESTAMP FORMT IN SQL IS YYYY-MM-DD HH:MM:SS
SELECT CURRENT_DATE();
SELECT current_timestamp();

-- Let's create a table now
CREATE TABLE EVENTS (
event_id INT AUTO_INCREMENT,
event_name VARCHAR(100),
event_date DATETIME DEFAULT CURRENT_TIMESTAMP(),
delivery_date DATE,
PRIMARY KEY (event_id)
);
DESC events;
SET SQL_SAFE_UPDATES=0;

INSERT INTO events(event_name, event_date, delivery_date)
VALUES  ('Audit' , '2025-07-20' , '2025-07-18'), 
('Product Launch', '2025-07-15', '2025-07-10'),
('Annual Meetup', '2025-08-01', '2025-07-25'),
('Marketing Campaign', '2025-07-05', '2025-07-01'),
('Customer Webinar', '2025-06-30', '2025-06-25'),
('Software Deployment', '2025-07-20', '2025-07-18');

INSERT INTO events(event_name, event_date, delivery_date)
VALUES('Project X', Current_Timestamp(), current_date());

SELECT * FROM events;
 
 ALTER TABLE Events
 ADD COLUMN event_time TIME;
 
 INSERT INTO events(event_name, delivery_date, event_time)
VALUES('Team Sync',  current_date(), current_time());


SELECT YEAR(current_date());
SELECT Month(current_date());
SELECT day(current_date());

-- Using EXTRACT to extract year/month/day from a date
SELECT EXTRACT(YEAR FROM CURRENT_DATE()) AS CURRENT_YEAR;

SELECT 
event_name,
 event_date, 
 EXTRACT(MONTH FROM event_date) AS event_month
FROM Events;

-- --> DATE_FORMAT-->"o5th of december 2025"--similar to TEXT in excel
-- SYNTAX: DATE_FORMAT(date,format)-- date is the date coulum and format is 
-- the format that you want to specify

SELECT 
event_name,
 event_date, 
 EXTRACT(MONTH FROM event_date) AS event_month,
 DATE_FORMAT(event_date, "%D of %M-%Y") AS Formatted_date
FROM Events;
-- SEE HOW DIFFERENT cases effect the formatted_date
SELECT 
event_name,
 event_date, 
 EXTRACT(MONTH FROM event_date) AS event_month,
 DATE_FORMAT(event_date, "%d of %m-%y") AS Formatted_date
FROM Events;
  
  -- DATE_GROUPING: Grouping based on Date
  SELECT EXTRACT(MONTH FROM event_date) AS month,
  Count(*) AS event_count
  FROM Events
  GROUP BY 1;
  
  -- DATE Arithemtic
  SELECT Current_date(), DATE_ADD(current_date(), INTERVAL 10 DAY) AS added_date;
  
  SELECT Current_date(), DATE_ADD(current_date(), INTERVAL 10 MONTH) AS added_month;

SELECT Current_date(), DATE_ADD(current_date(), INTERVAL 10 YEAR) AS added_date;  

SELECT event_date, MONTH(event_date) AS month, 
CONCAT("Q", CEIL(MONTH(event_date)/3)) AS Quarter
FROM Events;

-- CHAINING OF INTERVALS
SELECT Date_add( DATE_ADD('2024-05-11', INTERVAL 1 MONTH), 
INTERVAL 10 DAY) AS Chained_date;

-- Update all the delivery dates by 3 days from teh event_date
DESC Events;
SET SQL_SAFE_UPDATES=0;
UPDATE Events
SET delivery_date = DATE_ADD(event_date, INTERVAL 3 DAY);

SELECT * FROM events;

SELECT DATE_ADD('2024-06-28 19:25:57', INTERVAL 24 hour);

-- DATEDIFF()
SELECT event_id, event_name, event_date, delivery_date,
DATEDIFF(delivery_date, event_date) AS delivery_date_diff
FROM Events;

-- USING "* , " to add a new column.. Rewriting the above query

SELECT *,
DATEDIFF(delivery_date, event_date) AS delivery_date_diff
FROM Events;

-- HANDLING NEGATIVE DATES
SELECT *,
ABS(DATEDIFF(event_date, delivery_date)) AS delivery_date_diff
FROM Events;

SELECT STR_TO_DATE('30th MAY 2026', '%D %M %Y');

-- DATE CLEANING/DATE PREPROCESSING IN original Tables
DESC Calendar;
SELECT * FROM Calendar;
-- pattern found in this table is DD-MM-YYYY
-- First rename the column "date" to "calendar_date"

ALTER TABLE Calendar
RENAME COLUMN date TO calendar_date;
UPDATE Calendar
SET calendar_date = STR_TO_DATE(calendar_date,"%d-%m-%Y");

ALTER TABLE Calendar
MODIFY COLUMN calendar_date DATE;
-- --------------------------------------------
-- DATE CLEANING ON Customers TABLE
Desc Customers;
SELECT * FROM Customers;
-- Pattern: dd/mm/yyyy
UPDATE Customers
SET BirthDate= STR_TO_DATE(BirthDate, "%d/%m/%Y");

ALTER TABLE Customers
MODIFY COLUMN Birthdate DATE;
-- -----------------------------------------------------
-- DATE CLEANING ON Returns TABLE
Desc Returns;
SELECT * FROM Returns;
-- Pattern mm/dd/yyyy -- month/date is in single digit
UPDATE Returns
SET ReturnDate = STR_TO_DATE(ReturnDate, "%c/%e/%Y"); -- updated 1809 records
-- %c for single digit month, %e for single digit date, %Y for 4 digit Year

SELECT COUNT(*) FROM returns; -- 1809 records
 
ALTER TABLE Returns
MODIFY COLUMN Returndate DATE;

-- ---------------------
-- DATE cleaning/preprocessing on Sales2015
DESC sales2015;
SELECT COUNT(*) FROM sales2015; -- 2630 records
SELECT * FROM sales2015;
-- Pattern  on
-- OrderDate: mm-dd-YYYY
-- 			: m/dd/YYYY
-- Pattern  on
-- StockDate: m/dd/YYYY
-- 			: mm-dd-YYYY

-- USING CASE STATEMENT TO UPDATE OrderDate (coz there are 2 2 patterns observed)

UPDATE sales2015
SET OrderDate = CASE 
                  WHEN OrderDate LIKE '__-__-____' THEN STR_TO_DATE(OrderDate, '%m-%d-%Y')
                  ELSE STR_TO_DATE(orderdate, "%c/%d/%Y")
                  END;

-- Preprocessing StockDate without CASE
UPDATE sales2015
SET Stockdate= STR_TO_DATE(StockDate, "%m-%d-%Y")
WHERE Stockdate LIKE '__-__-____';

UPDATE sales2015
SET Stockdate= STR_TO_DATE(StockDate, "%c/%d/%Y")
WHERE Stockdate LIKE '%/%/%' ;

ALTER TABLE sales2015
MODIFY COLUMN Orderdate DATE,
MODIFY COLUMN Stockdate DATE;

DESC sales2015;

-- DATE preprocessing on sales2016
DESC Sales2016;
SELECT COUNT(*) FROM sales2016; -- 23935 records
SELECT * FROM sales2016;
-- Pattern on 
-- OrderDate: m/dd/YYYY
 --             m/d/YYYY -- 
 -- using "%" wildcard to handle both single and 2 digits month/date  in the WHERE clause
 -- AS "%" wildcard is for zero or more characters
 
 -- Pattern on
 -- Stockdate : m/dd/YYYY 
--             :mm/dd/YYY

UPDATE Sales2016
SET OrderDate = STR_TO_DATE(OrderDate, '%c/%e/%Y')
WHERE Orderdate LIKE '%/%/%';

UPDATE Sales2016
SET StockDate = STR_TO_DATE(StockDate, '%c/%e/%Y')
WHERE Stockdate LIKE '%/%/%';

ALTER TABLE sales2016
MODIFY COLUMN OrderDate DATE,
MODIFY COLUMN Stockdate DATE;

-- DATE PReprocessing Sales2017
DESC Sales2017;
SELECT COUNT(*) FROM sales2017; -- 29481 records

SELECT * FROM sales2017;
-- -- Pattern on 
-- OrderDate: m/dd/YYYY
 --             m/d/YYYY -- 
 -- using "%" wildcard to handle both single and 2 digits month/date  in the WHERE clause
 -- AS "%" wildcard is for zero or more characters
 
 -- Pattern on
 -- Stockdate : m/dd/YYYY 
--             :mm/dd/YYY

UPDATE sales2017
SET OrderDate = STR_TO_DATE(OrderDate, "%c/%d/%Y")
WHERE OrderDate LIKE "%/%/%";

UPDATE sales2017
SET StockDate = STR_TO_DATE(StockDate, "%c/%d/%Y")
WHERE StockDate LIKE "%/%/%";

ALTER TABLE sales2017
MODIFY COLUMN OrderDate DATE,
MODIFY COLUMN Stockdate DATE;
-- ------ WINDOW FUNCTIONS-------------------------------------------------------------------------
Use bike_sales;
ALTER TABLE `session 13 dataset`
RENAME TO sales;
DESC sales;
SELECT * FROM sales;
-- Find the cumulative total sales per salesperson in sales table
SELECT *, 
SUM(SaleAmount) OVER (
PARTITION BY Salesperson
ORDER BY SaleDate) AS CumulativeSalesPerPerson 
FROM sales;
-- Rank the sales by sales Amount
SELECT *, 
RANK () OVER(
ORDER BY saleamount) AS Sale_rank
FROM sales;
-- DENSE_RANK()
SELECT *, 
DENSE_RANK () OVER(
ORDER BY saleamount) AS Sale_rank
FROM sales;

-- Comparing the differnce of Avg(annualIncome) and each individuapl's income

SELECT customerkey,Fullname,AnnualIncome,
AnnualIncome-AVG(AnnualIncome) Over() 
FROM customers;

 SELECT Distinct prefix from customers;
 SET SQL_SAFE_UPDATES= 0;
 UPDATE customers
 SET prefix = "NULL"
 WHERE prefix = "";
 
 -- Find the maximum income based on gender
 SELECT Customerkey, prefix,Fullname,AnnualIncome,
 MAX(AnnualIncome) OVER(
 PARTITION BY Prefix
 ) AS max_income_by_prefix
 FROM customers
 WHERE Prefix IS NOT NULL;
 -- CASE WITH WINDOW FUNCTIONS
 SELECT productsubcategorykey,
 Productname, productcost,
 CASE
 WHEN productcost=MAX(productcost) OVER (partition by productsubcategorykey) THEN "Highest"
 WHEN productcost=MIN(productcost) OVER (partition BY productsubcategorykey) THEN "Lowest"
 ELSE "Middle"
 END AS Product_cost_category
 FROM Products;
 
 -- WITHIN A GENDER, I WANT TO FIND THE RANKING BASED ON ANNUALINCOME
 Select Customerkey,
 Fullname, Gender, AnnualIncome,
 RANK() OVER (
 PARTITION BY Gender 
 ORDER BY Annualincome DESC) AS income_rank_within_gender
 FROM customers
 WHERE annualincome IS NOT NULL;
 
 -- Rank the customers based on Maritalstaus and order by birthdate(oldest to youngest)
 Select Customerkey,
 Fullname, MaritalStatus, Birthdate,AnnualIncome,
 RANK() OVER (
 PARTITION BY Maritalstatus 
 ORDER BY Birthdate ASC) AS income_rank_within_gender
 FROM customers;
 
 -- RANK the product and create a category with case statement where
 -- the product is being ranked based on it s subcategory
 
 SELECT 
 productsubcategorykey, productname, productcost,
 Rank() OVER(PARTITION BY productsubcategorykey ORDER BY Productcost DESC) AS product_rank,
 CASE 
 WHEN Rank() OVER(PARTITION BY productsubcategorykey ORDER BY Productcost DESC) =1 THEN "HIGH RANK"
 WHEN Rank() OVER(PARTITION BY productsubcategorykey ORDER BY productcost DESC)<=5 THEN "Medium Rank"
 ELSE "Bottom Rank"
 END AS Product_rank_category
 FROM products;
 
 WITH productranking AS (
 SELECT productsubcategorykey, productname, productcost,
 RANK() OVER (PARTITION BY productsubcategorykey ORDER BY productcost DESC) AS product_rank
FROM products
)
SELECT *,
CASE WHEN pr.product_rank=1 THEN "HIGH RANK"
WHEN pr.product_rank<=5 THEN "Medium Rank"
ELSE "Bottom Rank"
END AS product_rank_category
FROM productranking AS pr;

-- DENSE_RANK()
Select Customerkey,
 Fullname, Gender, AnnualIncome,
 DENSE_RANK() OVER (
 PARTITION BY Gender 
 ORDER BY Annualincome DESC) AS income_rank_within_gender
 FROM customers
 WHERE annualincome IS NOT NULL;
 -- Example-2
 WITH productranking AS (
 SELECT productsubcategorykey, productname, productcost,
 DENSE_RANK() OVER (PARTITION BY productsubcategorykey ORDER BY productcost DESC) AS product_rank
FROM products
)
SELECT *,
CASE WHEN pr.product_rank=1 THEN "HIGH RANK"
WHEN pr.product_rank<=3 THEN "Medium Rank"
ELSE "Bottom Rank"
END AS product_rank_category
FROM productranking AS pr;

-- ROW_NUMBER()
Select Customerkey,
 Fullname, Gender, AnnualIncome,
 ROW_NUMBER() OVER (
 PARTITION BY Gender 
 ORDER BY Annualincome DESC) AS income_rank_within_gender
 FROM customers;
 -- LEAD() AND LAG()
 SELECT *, 
 LAG(SaleAmount) OVER (PARTITION BY Salesperson ORDER BY SaleDate) AS previousSale,
 LEAD(SaleAmount) OVER (PARTITION BY Salesperson ORDER BY SaleDate) AS Nextsale
 FROM sales;
 
 -- LEAD AND LAG WITH CTE
 WITH understanding_Revenue AS (
 SELECT 
 Date_format(s.orderdate, "%Y-%M") AS year_and_month,
 ROUND(SUM(p.productprice * s.orderquantity),0) AS TotalRevenue
 FROM sales2015 AS s
 JOIN Products AS p
 ON p.productkey=s.productkey
 GROUP BY 1
 ORDER BY 1
 )
 SELECT *,
 LAG(TotalRevenue) OVER (ORDER BY year_and_month) AS PreviousMonthSales,
 LEAD(TotalRevenue) OVER (ORDER BY year_and_month) AS NextMonthSales
 FROM understanding_revenue
 ORDER BY year_and_month ASC;
 
 Use bike_sales;
 WITH understanding_Revenue AS (
 SELECT 
 Date_format(s.orderdate, "%Y-%m") AS year_and_month,
 ROUND(SUM(p.productprice * s.orderquantity),0) AS TotalRevenue
 FROM sales2015 AS s
 JOIN Products AS p
 ON p.productkey=s.productkey
 GROUP BY 1
 ORDER BY 1
 )
 SELECT *,
 LAG(TotalRevenue) OVER (ORDER BY year_and_month) AS PreviousMonthSales,
TotalRevenue-LAG(TotalRevenue) OVER (ORDER BY year_and_month)  AS  sale_amount_change ,
CASE 
WHEN TotalRevenue-LAG(TotalRevenue) OVER (ORDER BY year_and_month)<0 THEN "Loss"
WHEN TotalRevenue-LAG(TotalRevenue) OVER (ORDER BY year_and_month) IS NULL THEN "Null"
ELSE "Profit"
END AS 'Profit /Loss'
 FROM understanding_revenue
 ORDER BY year_and_month ASC;
 -- ALTERNATE APPROACH FOR SALES_TREND
 WITH understanding_Revenue AS (
 SELECT 
 Date_format(s.orderdate, "%Y-%m") AS year_and_month,
 ROUND(SUM(p.productprice * s.orderquantity),0) AS TotalRevenue
 FROM sales2015 AS s
 JOIN Products AS p
 ON p.productkey=s.productkey
 GROUP BY 1
 ORDER BY 1
 )
 SELECT *,
 LAG(TotalRevenue) OVER (ORDER BY year_and_month) AS PreviousMonthSales,
TotalRevenue-LAG(TotalRevenue) OVER (ORDER BY year_and_month)  AS  sale_amount_change ,
CASE 
WHEN TotalRevenue>LAG(TotalRevenue) OVER (ORDER BY year_and_month) THEN "Increase"
WHEN TotalRevenue<LAG(TotalRevenue) OVER (ORDER BY year_and_month) THEN "Decrease"
ELSE "No change"
END AS 'Sales_trend'
 FROM understanding_revenue
 ORDER BY year_and_month ASC;
 -- ANOTHER ALTERNATE hehheheheehheheh<3
 WITH understanding_Revenue AS (
 SELECT 
 Date_format(s.orderdate, "%Y-%m") AS year_and_month,
 ROUND(SUM(p.productprice * s.orderquantity),0) AS TotalRevenue
 FROM sales2015 AS s
 JOIN Products AS p
 ON p.productkey=s.productkey
 GROUP BY 1
 ORDER BY 1
 )
 SELECT *,
 LAG(TotalRevenue) OVER (ORDER BY year_and_month) AS PreviousMonthSales,
TotalRevenue-LAG(TotalRevenue) OVER (ORDER BY year_and_month)  AS  sale_amount_change ,
CASE 
WHEN TotalRevenue-LAG(TotalRevenue) OVER (ORDER BY year_and_month)<0 THEN "Decrease"
WHEN TotalRevenue-LAG(TotalRevenue) OVER (ORDER BY year_and_month) IS NULL THEN "Null"
ELSE "Increase"
END AS 'Profit /Loss'
 FROM understanding_revenue
 ORDER BY year_and_month ASC;
 
 SELECT * FROM sales;
 
 -- Analyse the company's Year_over_year sales trend and classsify each trend as 
 -- "Increased","Decreased" or "No chnage" compared to the previous year
 
 WITH YOY_Analysis AS (
 SELECT
 DATE_FORMAT(OrderDate, "%Y") AS SaleYear,
 ROUND(SUM(p.productprice*s.OrderQuantity),0) AS totalSales,
 LAG(ROUND(SUM(p.productprice*s.OrderQuantity),0)) OVER (ORDER BY DATE_FORMAT(OrderDate, "%Y")) AS previousyearsales
 FROM (SELECT * FROM sales2015
 UNION 
 SELECT * FROM sales2016
 UNION 
 SELECT * FROM sales2017) AS s
 JOIN Products AS p
 ON p.productkey=s.productkey
 GROUP BY 1
 ORDER BY 1
 )
 SELECT *, 
 totalSales- previousyearsales AS sales_change,
  CONCAT(ROUND((totalsales-previousyearsales)/previousyearsales*100,0),"%") AS percent_change,
 CASE 
 WHEN totalSales - previousyearsales IS NULL  THEN "Null"
 WHEN totalSales - previousyearsales < 0  THEN "Decrease"
 WHEN totalSales - previousyearsales > 0  THEN "Increase"
 ELSE "No change"
 END AS sale_trend
 FROM YOY_Analysis
 ORDER BY saleyear;
 
 -- ***********   NTILE  ********** Used to bucket our data into 'n' groups
-- SPLIT the zproductPrice Column into quartile
SELECT productname, ProductPrice,
NTILE(4) OVER (ORDER BY ProductPrice) AS Price_Quartile
FROM products;

WITH buckets AS (
SELECT productname, ProductPrice,
NTILE(4) OVER (ORDER BY ProductPrice) AS Price_Quartile
FROM products
)
 SELECT count(*) FROM buckets
 WHERE Price_quartile=1;
 
 -- Divide each month's total sales into 3 performance tiers(terciles)
 -- to categorise months as low, medium or high-performing.
 
WITH Terciles AS ( SELECT Date_format(s.Orderdate, "%Y-%m") AS saledate,
 ROUND(SUM(p.productprice*s.orderquantity),0) AS TotalSales
 FROM 
 (SELECT * FROM sales2015
 UNION
 SELECT * FROM sales2016
 UNION
 SELECT * FROM sales2017) AS s
 JOIN Products AS p
 ON p.productkey=s.productkey
 GROUP BY 1)
 
  SELECT *, 
  NTILE(3) OVER (ORDER BY t.totalsales) AS tercile_num,
   CASE WHEN NTILE(3) OVER (ORDER BY t.totalsales)= 1 THEN "low"
  WHEN NTILE(3) OVER (ORDER BY t.totalsales)=2 THEN "medium"
  ELSE "high-performing"
  END AS tile_category
  FROM terciles AS t
  ORDER BY t.saledate;
  -- ------------------------------------------------------------------------------------
  /* The first NTILE uses ORDER BY TotalSales to correctly rank and categorize months by performance; 
  the second NTILE uses an empty OVER(), resulting in unstable, arbitrary buckets that are not based on sales value. */
  
  WITH Terciles AS ( SELECT Date_format(s.Orderdate, "%Y-%m") AS saledate,
 ROUND(SUM(p.productprice*s.orderquantity),0) AS TotalSales
 FROM 
 (SELECT * FROM sales2015
 UNION
 SELECT * FROM sales2016
 UNION
 SELECT * FROM sales2017) AS s
 JOIN Products AS p
 ON p.productkey=s.productkey
 GROUP BY 1)
 
  SELECT *, 
  NTILE(3) OVER () AS tercile_num,
   CASE WHEN NTILE(3) OVER ()= 1 THEN "low" -- Observe the empty over() clause
  WHEN NTILE(3) OVER ()=2 THEN "medium"
  ELSE "high-performing"
  END AS tile_category
  FROM terciles AS t
  ORDER BY t.saledate;
  
  -- Find the products that are below the lower bound or above the upper bound[Outliers]
  WITH quartile_calc AS (
  SELECT productkey, productname, productprice,
  NTILE(4) OVER (ORDER BY productprice) AS Quartile
  FROM products
  ),
  iqr_bound AS (
  SELECT Max(CASE WHEN Quartile=1 THEN Productprice END) AS Q1,
   Max(CASE WHEN Quartile=3 THEN Productprice END) AS Q3
   FROM quartile_calc
   )
   SELECT 
   p.productkey, p.productname, p.productprice,
   Q3-Q1 AS IQR,
   (Q1-1.5*(Q3-Q1)) AS Lower_bound,
   (Q3+1.5*(Q3-Q1)) AS Upper_bound
   FROM products AS p
   JOIN iqr_bound AS iqr
   ON p.productprice BETWEEN (Q1-1.5*(Q3-Q1))  AND  (Q3+1.5*(Q3-Q1)) ;
   
   -- ALTERNATE WAY ------
   
   WITH quartile_calc AS (
  SELECT  productprice,
  NTILE(4) OVER (ORDER BY productprice) AS Quartile
  FROM products
  ),
  Max_Quartile_range AS (
  SELECT Max(CASE WHEN Quartile=1 THEN Productprice END) AS Q1,
   Max(CASE WHEN Quartile=3 THEN Productprice END) AS Q3
   FROM quartile_calc
   ),
   iqr_bounds AS(
    SELECT Q1, Q3, 
    Q3-Q1 AS IQR,
    Q1-(1.5*(Q3-Q1)) AS Lower_bound,
   Q3+(1.5*(Q3-Q1)) AS Upper_bound
   FROM Max_Quartile_range
   )
   SELECT 
   p.productkey, p.productname, p.productprice
   FROM products AS p
   JOIN iqr_bounds AS iqr
   ON p.productprice < iqr.lower_bound  OR p.productprice > iqr.upper_bound
   ORDER BY p.productprice;
   
   -- ****** First_value() ********************************-------------------------------------------------------
  -- Find the customers who purchased each product on the earliest date
  SELECT s.productkey, c.Fullname, 
  p.productname,s.orderdate,
  First_value(c.fullname) OVER (Partition BY s.productkey ORDER BY s.orderdate) AS customername
  FROM (
  SELECT * FROM sales2015
  UNION 
  SELECT * FROM sales2016
  UNION
  SELECT * FROM sales2017
  ) AS s
  JOIN Products AS p
  ON s.productkey=p.productkey 
  JOIN customers AS c
  ON c.customerkey=s.customerkey
  ORDER BY s.productkey;
  
  -- ******************LAST_VALUE() ---- **************************************************************
  -- Q) Find teh last region where each product was sold based on latest order date?
  SELECT s.productkey, t.region,p.productname,s.orderdate,
  Last_value(t.region) OVER (Partition BY s.productkey ORDER BY s.orderdate
  RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_region
  FROM (
  SELECT * FROM sales2015
  UNION 
  SELECT * FROM sales2016
  UNION
  SELECT * FROM sales2017
  ) AS s
  JOIN Products AS p
  ON s.productkey=p.productkey 
  JOIN territories AS t
  ON t.SalesTerritoryKey=s.TerritoryKey
  ORDER BY s.productKey;
  
  -- ********** NTH_VALUE() ***************------------------------
  -- Q) For each Product, retrieve the price of the 3rd sales based on the 
  -- product sales price order.
  
  SELECT s.productkey, p.productname, p.productprice, s.orderdate, c.fullname,
  NTH_VALUE(c.fullname, 3) OVER (PARTITION BY s.productkey 
  ORDER BY s.orderdate 
  RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS third_customer
    FROM sales2017 AS s
    JOIN Products AS p
    ON p.productkey=s.productkey
    JOIN Customers c
    ON c.customerkey=s.customerkey
    ORDER BY s.productkey;
    
    -- For each customer and product subactegory, count the avg number
    -- of days b/w consecutive orders
    WITH days_calc AS (
    SELECT s.customerkey,p.productsubcategorykey, s.orderdate,
    datediff(s.orderdate, Lag(s.orderdate) OVER 
    (PARTITION BY s.customerkey,p.productsubcategorykey ORDER BY s.orderdate)) AS days -- this in CTE
    FROM sales2017 AS s
    JOIN products AS p
    ON p.productkey=s.productkey
     )
    SELECT dc.customerkey,dc.productsubcategorykey,
    ROUND(AVG(days),0) AS avg_days
    FROM days_calc AS dc
    WHERE days IS NOT NULL
    GROUP BY 1,2
    HAVING COUNT(*)>1;
     
    -- ALTERNATE query
    WITH subcategory_orders AS (
    SELECT s.customerkey, p.productsubcategorykey, s.orderdate,
    LAG(s.orderdate) OVER (
    PARTITION BY s.customerkey, p.productsubcategorykey
    ORDER BY s.orderdate)
    AS prevOrderDate
    FROM products AS p
    JOIN sales2017 AS s
    ON p.productkey=s.productkey
    )
    SELECT customerkey, productsubcategorykey,
    ROUND(AVG(DATEDIFF(orderdate,prevOrderDate)),0) AS avg_days -- this is main select
    FROM subcategory_orders
    WHERE prevOrderDate IS NOT NULL
    GROUP BY customerkey, Productsubcategorykey
    HAVING Count(*)>1;
    -- Find the product that remained out of stock for the longest time
    -- And calculate how many days it was unavailable?
    WITH stock_date_calc AS (
    SELECT s.stockdate, s.productkey,
    DATEDIFF(LEAD(s.stockdate) OVER (
    PARTITION BY s.productkey
    ORDER BY s.stockdate), s.stockdate) AS Nextstockdate
    FROM sales2017 AS s
    )
    SELECT productkey,
    MAX(Nextstockdate) AS  days_out_of_stock
    FROM stock_date_calc
    GROUP BY 1
    ORDER BY 2 DESC;
    
    -- Q3) Show total sales per year and calculate the 
    -- percentage growth or decline from the previous year
    
    WITH Sales_calc AS (
    SELECT Date_format(s.orderdate, "%Y") AS saleyear,
    ROUND(SUM(p.productprice*s.orderquantity),0) AS totalsales
    FROM (
    SELECT * FROM sales2015
    UNION
    SELECT * FROM sales2016 
    UNION 
    SELECT * FROM sales2017 ) AS s
    JOIN products AS p
    ON p.productkey=s.productkey
    GROUP BY saleyear
    ),
    Last_and_Next AS ( 
    SELECT sc.saleyear,
   LAG(totalsales) OVER (ORDER BY sc.saleyear) AS previoussale,
   LEAD(totalsales) OVER (ORDER BY sc.saleyear) AS nextsales
    FROM sales_calc AS sc
    )
    SELECT 
    sc.saleyear,totalsales, previoussale,nextsales,
   CONCAT(ROUND(((totalsales-previoussale)/previoussale)*100,0), "%")  AS sales_percentage,
    CASE 
    WHEN ((totalsales-previoussale)/previoussale)*100 > 0 THEN "Increase" 
    WHEN ((totalsales-previoussale)/previoussale)*100 < 0 THEN "Decrease"
    ELSE "NULL"
    END AS sales_insight
    FROM Sales_calc AS sc
    JOIN Last_and_Next  AS ln
    ON sc.saleyear=ln.saleyear
    ORDER BY sc.saleyear;
    
    -- Q4) For each sale, show the first,last and third sale amount
    -- within its product's transaction history
    WITH Sales_calc AS (
    SELECT s.productkey, s.orderdate,
    p.productprice*s.orderquantity AS totalsales
    FROM (
    SELECT * FROM sales2015
    UNION
    SELECT * FROM sales2016 
    UNION 
    SELECT * FROM sales2017 ) AS s
    JOIN products AS p
    ON p.productkey=s.productkey
    )
    SELECT sc.productkey, sc.orderdate,
    First_value(totalsales) OVER (PARTITION BY productkey ORDER BY sc.orderdate) AS first_sale,
     Last_value(totalsales) OVER (
     PARTITION BY productkey 
     ORDER BY sc.orderdate
     RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_sale,
     Nth_value(totalsales,3) OVER (
     PARTITION BY productkey 
     ORDER BY sc.orderdate
     RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS third_sale
     FROM Sales_calc AS sc;
    
    use bike_sales;
    -- ************* VIEWS ***************
  CREATE OR REPLACE VIEW Children AS 
  SELECT Customerkey, Fullname, TotalChildren
  FROM customers 
  WHERE Totalchildren>3;
  SELECT * FROM children;
  SELECT COUNT(*) FROM children;
  
  CREATE OR REPLACE VIEW `SalesTrend` AS 
  SELECT 
  DATE_FORMAT(s.orderdate, "%Y-%m")  AS year_and_month,
  ROUND(SUM(p.productprice*s.orderquantity),0) AS TotalRevenue
  FROM sales2015 AS s
  JOIN Products AS p
  On p.productkey=s.productkey
  GROUP BY year_and_month
  ORDER BY year_and_month;
  
  SELECT * FROM salestrend;
  
-- ********** INDEX *******************
    SELECT * FROM Customers WHERE customerkey=13061;
    CREATE INDEX idx_customerkey ON Customers(Customerkey);
    SHOW INDEXES FROM Customers;
    CREATE INDEX idx_occupation ON Customers(occupation (25));
    SELECT DISTINCT Occupation FROM customers;
    
    -- *** STORED PROCEDURES *****************************
  Use bike_sales;
  CREATE TABLE student_info (
    stu_id INT PRIMARY KEY,
    stu_code VARCHAR(10),
    stu_name VARCHAR(50),
    subject VARCHAR(30),
    marks INT,
    phone VARCHAR(15)
);

INSERT INTO student_info (stu_id, stu_code, stu_name, subject, marks, phone) VALUES
(1, 'S001', 'Arjun Kumar', 'Mathematics', 85, '9876543210'),
(2, 'S002', 'Priya Sharma', 'Science', 92, '9876543211'),
(3, 'S003', 'Rohan Singh', 'History', 78, '9876543212'),
(4, 'S004', 'Ananya Iyer', 'Mathematics', 95, '9876543213'),
(5, 'S005', 'Vikram Rathore', 'Science', 64, '9876543214'),
(6, 'S006', 'Sneha Gupta', 'History', 88, '9876543215'),
(7, 'S007', 'Rahul Verma', 'Mathematics', 45, '9876543216'),
(8, 'S008', 'Meera Reddy', 'Science', 72, '9876543217'),
(9, 'S009', 'Aditya Joshi', 'History', 81, '9876543218');

SELECT * FROM student_info;
-- Get the students whose marks>70 and count those students

DELIMITER // 
CREATE PROCEDURE students_and_count ()
BEGIN
SELECT stu_name, marks
FROM student_info
WHERE marks>70;
SELECT COUNT(*) FROM student_info AS total_students;
END //
DELIMITER ;
CALL students_and_count();

SHOW PROCEDURE status;
 -- THERE IS NO OPTION TO ALTER THE PROCEDURE-- jUST DROP NAD RECREATE IT!
 DROP PROCEDURE IF EXISTS students_and_count;
 DELIMITER // 
CREATE PROCEDURE students_and_count ()
BEGIN
SELECT stu_name, marks
FROM student_info
WHERE marks>70;
-- SELECT COUNT(*) FROM student_info AS total_students;
END //
DELIMITER ;

CALL students_and_count();

DELIMITER $$ 
CREATE PROCEDURE grace_marks (IN p_subject Varchar(25))
BEGIN
UPDATE student_info 
SET marks= marks+5
WHERE subject=p_subject;
SELECT * FROM student_info;
END $$ 
DELIMITER ;
 SET SQL_SAFE_UPDATES=0;
 CALL grace_marks("Mathematics");
 
 -- OUT parameter
 -- Display the highest marks from student_info
DROP PROCEDURE IF EXISTS high_marks;
DELIMITER //
CREATE PROCEDURE high_marks(OUT maximum_marks INT)
BEGIN
    SELECT MAX(marks)
    INTO maximum_marks
    FROM student_info;
END //
DELIMITER ;

 CALL high_marks(@m);
 SELECT @m;
 
SELECT MAX(marks) FROM student_info;
SHOW PROCEDURE STATUS WHERE Name = 'highest_marks';

SELECT 
    COUNT(*) AS total_rows, 
    COUNT(marks) AS rows_with_marks,
    MAX(marks) AS check_max
FROM student_info;
-- IN OUT parameters
-- Count the number of students by subject 
DELIMITER $$ 
CREATE PROCEDURE student_num (IN p_subject VARCHAR(30), OUT numstudents INT)
BEGIN 
SELECT count(*) 
INTO  numstudents
FROM student_info 
WHERE subject = p_subject;
END $$ 
DELIMITER ;

CALL student_num("History", @n);
SELECT @n;

SELECT * FROM student_info;

-- CALCULATE the AVERAGE MARKS PER GIVEN SUBJECT
DELIMITER //
CREATE PROCEDURE get_avg_marks (IN p_sub VARCHAR(25), OUT avgmarks INT)
BEGIN 
SELECT avg(marks) 
INTO avgmarks 
FROM student_info
WHERE subject=p_sub;
END //
DELIMITER ;

CALL get_avg_marks ("History", @avg_marks);
SELECT @avg_marks;

-- INOUT PARAMETER *********************
DELIMITER $$ 
CREATE PROCEDURE get_marks(INOUT var1 INT)-- Input nad Output both are integer datatype
BEGIN
SELECT marks 
INTO var1 
FROM student_info
WHERE stu_id=var1;
END $$ 
DELIMITER ; 

SET @score=3;
CALL get_marks(@score);
SELECT @score;
USE bike_sales;

CREATE DATABASE triggers_database;
USE triggers_database;

CREATE TABLE student_info (
    stu_id INT PRIMARY KEY,
    stu_code VARCHAR(10),
    stu_name VARCHAR(50),
    subject VARCHAR(30),
    marks INT,
    phone VARCHAR(15)
);

INSERT INTO student_info (stu_id, stu_code, stu_name, subject, marks, phone) VALUES
(1, 'S001', 'Arjun Kumar', 'Mathematics', 85, '9876543210'),
(2, 'S002', 'Priya Sharma', 'Science', 92, '9876543211'),
(3, 'S003', 'Rohan Singh', 'History', 78, '9876543212'),
(4, 'S004', 'Ananya Iyer', 'Mathematics', 95, '9876543213'),
(5, 'S005', 'Vikram Rathore', 'Science', 64, '9876543214'),
(6, 'S006', 'Sneha Gupta', 'History', 88, '9876543215'),
(7, 'S007', 'Rahul Verma', 'Mathematics', 45, '9876543216'),
(8, 'S008', 'Meera Reddy', 'Science', 72, '9876543217'),
(9, 'S009', 'Aditya Joshi', 'History', 81, '9876543218'),
(10, 'S010', 'Ishani Bose', 'Mathematics', 99, '9876543219'),
(11, 'S011', 'Karan Mehta', 'Science', 55, '9876543220'),
(12, 'S012', 'Sana Khan', 'History', 93, '9876543221'),
(13, 'S013', 'Abhishek Das', 'Mathematics', 76, '9876543222'),
(14, 'S014', 'Zoya Williams', 'Science', 89, '9876543223'),
(15, 'S015', 'Nitin Gadkari', 'History', 67, '9876543224'),
(16, 'S016', 'Riya Sen', 'Mathematics', 82, '9876543225'),
(17, 'S017', 'Deepak Hooda', 'Science', 41, '9876543226'),
(18, 'S018', 'Pooja Hegde', 'History', 75, '9876543227'),
(19, 'S019', 'Sahil Taneja', 'Mathematics', 90, '9876543228'),
(20, 'S020', 'Tara Sutaria', 'Science', 96, '9876543229');
DROP TRIGGER IF EXISTS check_student_marks; 
DELIMITER $$
CREATE trigger check_student_marks 
BEFORE INSERT
ON student_info
FOR EACH ROW
BEGIN 
IF NEW.marks>100 OR NEW.marks<0 THEN 
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = "Marks should be between 0 and 100";
END IF; 
END $$
DELIMITER ;

SELECT * FROM student_info;

INSERT INTO student_info  
VALUES (21, 'S021', 'Peter Parker', 'Mathematics', 105, '9871234567');

-- ******** AFTER INSERT [Audit Log] *****************
CREATE TABLE Audit_Log(
log_id INT AUTO_INCREMENT PRIMARY KEY,
action ENUM('INSERT', 'UPDATE', 'DELETE'),
stu_id INT,
log_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER $$
CREATE trigger  trg_after_insert_student
AFTER INSERT
ON student_info
FOR EACH ROW
BEGIN 
 INSERT INTO Audit_Log(action, stu_id)
 VALUES ('INSERT', NEW.stu_id);
END $$
DELIMITER ;

INSERT INTO student_info  
VALUES (21, 'S021', 'David Beckham', 'Mathematics', 95, '9871234567');

SELECT * FROM student_info;
SELECT * FROM Audit_Log;
Use triggers_database;

use triggers_database;

DELIMITER $$
CREATE trigger  trg_after_update_student
AFTER UPDATE
ON student_info
FOR EACH ROW
BEGIN 
 INSERT INTO Audit_Log(action, stu_id)
 VALUES ('UPDATE', NEW.stu_id);
END $$
DELIMITER ;

SET SQL_SAFE_UPDATES=0;

UPDATE student_info
SET marks=marks+3
WHERE stu_id=3;

UPDATE student_info
SET marks=marks+10
WHERE subject="Mathematics";

-- AFTER DELETE Trigger-- ***************

DELIMITER //
CREATE TRIGGER after_delete_tgr 
AFTER DELETE 
ON student_info
FOR EACH ROW 
BEGIN 
INSERT INTO Audit_log (action, stu_id)
VALUES("DELETE", OLD.stu_id);
END //
DELIMITER ;

DELETE FROM student_info
WHERE stu_id=20;

-- BEFORE UPDATE TRIGGER-- **********
DELIMITER $$
CREATE TRIGGER before_update_tgr_marks_drop
BEFORE UPDATE 
ON student_info
FOR EACH ROW 
BEGIN 
IF NEW.marks < OLD.marks THEN 
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Reducing marks not allowed' ;
END IF;
END $$
DELIMITER ;

UPDATE student_info
SET marks=marks-2
WHERE stu_id=3;

-- BEFORE DELETE -- *************
DELIMITER //
CREATE TRIGGER before_delete_check_tgr
BEFORE DELETE
ON student_info
FOR EACH ROW 
BEGIN 
IF OLD.marks>90 THEN 
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT= "Can't delete topper student";
END IF;
END //
DELIMITER ;

SELECT * FROM student_info;

DELETE FROM student_info
WHERE stu_id =1 ;

CREATE TABLE marks_update_log (
Serial_no  INT AUTO_INCREMENT PRIMARY KEY,
stu_id INT,
old_marks INT,
new_marks INT,
update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER $$ 
CREATE TRIGGER update_history_tgr
AFTER UPDATE 
ON student_info 
FOR EACH ROW 
BEGIN 
IF NEW.marks <> OLD.marks THEN 
INSERT INTO marks_update_log (stu_id, old_marks, new_marks)
VALUES (OLD.stu_id, OLD.marks, NEW.marks);
END IF;
END $$
DELIMITER ;

UPDATE student_info 
SET marks = 100 
WHERE stu_id=1;

SELECT * FROM marks_update_log;





 


 
 
 
 
 
 
 
 
 
 
 





 
