#DATA CLEANING AND PROCESSING IN SQL

DESCRIBE Orders;
DESCRIBE Restaurants;

SELECT * FROM Orders;
SELECT * FROM Restaurants;

ALTER TABLE Orders ADD COLUMN O_TIME TIME;

UPDATE Orders
	SET O_TIME= RIGHT(`Order Date`,5) ;    
      
ALTER TABLE orders ADD COLUMN Delivery_time_Status VARCHAR(50);

UPDATE orders
	SET Delivery_time_Status = 
    CASE WHEN `Delivery Time Taken (mins)`>=45 THEN "More than 45 min"
		 WHEN `Delivery Time Taken (mins)`>=30 THEN "More than 30 min"
		 WHEN `Delivery Time Taken (mins)`>=15 THEN "More than 15 min"
    ELSE "Less than 15 min" 
    END;
         

#DATA ANALYSIS

#Which restaurant received the most orders?

SELECT R.RestaurantName, COUNT(O.`Order ID`) AS Order_count FROM restaurants R 
	JOIN orders O 
	ON R.RestaurantID = O.`Restaurant ID`
		GROUP BY RestaurantName
		ORDER BY Order_count DESC;
        
#Which restaurant saw most sales?

SELECT R.RestaurantName, SUM(O.`Order Amount`) AS Sale_Amount FROM restaurants R 
	JOIN orders O 
	ON R.RestaurantID = O.`Restaurant ID`
		GROUP BY RestaurantName
		ORDER BY Sale_Amount DESC;
        
#Which customer ordered the most?

SELECT `Order ID`, `Customer Name`, `Quantity of Items` 
	FROM Orders
		ORDER BY `Quantity of Items` DESC;

#When do customers order more in a day?

SELECT HOUR(O_TIME) AS Hour, 
    COUNT(`Order ID`) AS Order_in_hr FROM ORDERS
		GROUP BY HOUR(O_TIME)
		ORDER BY Order_in_hr DESC ;
        
#What is the most liked cuisine?

SELECT R.Cuisine, O.`Customer Rating-Food`,
 COUNT(O.`Customer Rating-Food`) AS Food_rating_count FROM restaurants R
	JOIN orders O
	ON R.RestaurantID= O.`Restaurant ID`
		GROUP BY Cuisine, `Customer Rating-Food`
		ORDER BY `Customer Rating-Food`  DESC,
					Food_rating_count DESC;

#Which zone has most sales?

SELECT R.Zone, SUM(O.`Order Amount`) AS Sale_Amount FROM restaurants R
JOIN Orders O
	ON R.RestaurantID= O.`Restaurant ID`
		GROUP BY Zone
		ORDER BY Sale_Amount DESC;
        
#What is the most preferred mode of payment by customers?

SELECT `Payment Mode`, COUNT(`Order ID`) AS Payment_Count FROM orders
	GROUP BY `Payment Mode`
	ORDER BY Payment_Count DESC;

#Who sales more Pro category restaurants or ordinary category restaurants? 

SELECT R.Category, SUM(O.`Order Amount`) AS Sale_amount FROM restaurants R 
	JOIN orders O 
	ON R.RestaurantID =O.`Restaurant ID`
		GROUP BY Category
		ORDER BY Sale_amount DESC;
        
#How many restaurants are under Pro and ordinary category?

 SELECT Category, COUNT(RestaurantID) AS Restaurant_Count FROM Restaurants 
 GROUP BY CATEGORY;
 
 #How much delivery time is taken according to zones?
 
 SELECT R.Zone, O.Delivery_time_Status, COUNT(Delivery_time_Status) AS Delivery_count FROM restaurants R 
	JOIN orders O 
    ON R.RestaurantID = O.`Restaurant ID`
		GROUP BY Zone , Delivery_time_Status
		ORDER BY Zone, delivery_count;
        
        
    

