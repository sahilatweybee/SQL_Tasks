--------------SQL STORED PROCEDURES
--CREATE PROCEDURE select_all AS SELECT * FROM customers
--GO
--EXEC select_all;
USE w3schools;
GO


----------------SQL SYNTAX
--SELECT * FROM customers;
--SELECT DISTINCT City FROM customers;

----------------SQL WHERE
--SELECT * FROM customers WHERE Country = 'France';

----------------SQL AND, OR, NOT
--SELECT * FROM customers WHERE City = 'Berlin' AND PostalCode = '12209';
--SELECT * FROM customers WHERE Country = 'UK' OR Country = 'Spain';
--SELECT * FROM customers WHERE NOT (Country = 'France' OR Country = 'Mexico');

----------------SQL ORDER BY
--SELECT * FROM customers ORDER BY CustomerName;

----------------SQL INSERT INTO
--INSERT INTO customers (CustomerID, CustomerName, ContactName, City, Country) 
--VALUES (999, 'Sahil', 'Sahil Parsaniya', 'Rajkot', 'India');
--INSERT INTO customers (CustomerID, CustomerName, ContactName, City, Country) 
--VALUES (92, 'Rishit', 'Rishit KAlyani', 'Rajkot', 'India');

----------------SQL NULL VALUES
--SELECT * FROM customers WHERE PostalCode IS NULL;

----------------SQL UPDATE
--UPDATE customers SET PostalCode = '360003' WHERE PostalCode IS NULL;

----------------SQL DELETE
--DELETE FROM customers WHERE CustomerID = 999;

----------------SQL TOP
--SELECT TOP 5 PERCENT OrderID, Quantity FROM order_details;
--SELECT TOP 10 * FROM customers;

----------------SQL MIN(), MAX()
--SELECT TOP 3 ProductID, MIN(Quantity) AS Min_Quantities, MAX(Quantity) AS Max_Quantities FROM order_details GROUP BY ProductID;

----------------SQL COUNT(), SUM(), AVG()
--SELECT COUNT(Quantity) AS Orders, SUM(Quantity) AS Total_Sale, AVG(QUantity) AS Average_Order_Quantity  FROM order_details;
--SELECT COUNT(DISTINCT City) FROM customers;

----------------SQL WildCards
--SELECT * FROM employees WHERE FirstName LIKE '_n%e%';
--SELECT * FROM employees WHERE FirstName LIKE '[ASN]%';
--SELECT * FROM employees WHERE LastName LIKE '[A-D]%';

----------------SQL IN
--SELECT * FROM suppliers WHERE Country NOT IN ('USA', 'UK','Canada');
--SELECT * FROM suppliers WHERE Country IN (SELECT Country FROM customers);

----------------SQL BETWEEN
--SELECT * FROM orders WHERE OrderID BETWEEN 10300 AND 10400;
--SELECT * FROM employees WHERE FirstName BETWEEN 'Janet' AND 'Nancy' ORDER BY FirstName;

----------------SQL Aliases
--SELECT CustomerName, Address + ', ' + City + ', ' + PostalCode + ', ' + Country AS Address FROM customers;

----------------SQL JOINS
--SELECT orders.OrderID, customers.CustomerName, orders.OrderDate FROM orders INNER JOIN customers ON customers.CustomerID = orders.CustomerID WHERE OrderDate LIKE '%-08-%';
--SELECT customers.CustomerName,orders.OrderID, orders.OrderDate FROM customers LEFT JOIN orders ON customers.CustomerID = orders.CustomerID;
--SELECT orders.OrderID,  employees.FirstName + ' ' + employees.LastName AS EmployeeName FROM orders RIGHT JOIN employees ON employees.EmployeeID = orders.EmployeeID ORDER BY orders.OrderID;
--SELECT orders.OrderID,  employees.FirstName + ' ' + employees.LastName AS EmployeeName FROM orders FULL JOIN employees ON employees.EmployeeID = orders.EmployeeID;
--SELECT Customers.CustomerName, Orders.OrderID FROM customers FULL OUTER JOIN orders ON Customers.CustomerID=Orders.CustomerID ORDER BY Customers.CustomerName;
--SELECT A.CustomerName AS Cuestomer1, B.CustomerName AS Customer2, A.City FROM customers A, customers B WHERE A.CustomerName != B.CustomerName AND A.City = B.City;

----------------SQL UNION
--SELECT Country FROM customers UNION SELECT Country FROM suppliers;
--SELECT Country FROM customers UNION ALL SELECT Country FROM suppliers;

----------------SQL GROUP BY
--SELECT COUNT(CustomerID), Country FROM Customers GROUP BY Country ORDER BY Country;

------------------SQL HAVING 
--SELECT COUNT(CustomerID), Country FROM customers GROUP BY Country HAVING COUNT(CustomerID) > 7;

------------------SQL EXISTS
--SELECT CustomerName FROM customers WHERE EXISTS (SELECT CustomerID FROM orders WHERE OrderDate = '1996-12-12' AND customers.CustomerID = orders.CustomerID);

------------------SQL ANY, ALL
--SELECT CustomerName From customers WHERE CustomerID =  ANY (SELECT CustomerID FROM orders WHERE ShipperID = 2);
--SELECT ProductName FROM products WHERE ProductID = ANY (SELECT ProductID FROM order_details WHERE Quantity > 70);

------------------SQL SELECT INTO
--SELECT * INTO my_table FROM customers;
--SELECT * FROM my_table;

------------------SQL INSERT INTO SELECT
--INSERT INTO my_table (CustomerID, CustomerName) SELECT CustomerID, CustomerName FROM customers WHERE CustomerID > 50;
--SELECT * FROM my_table;

------------------SQL CASE
--SELECT ProductID, ProductName, Price,
--CASE 
--	WHEN Price > 10 AND Price < 20 THEN 'AVERAGE'
--	WHEN Price > 20 AND Price < 30 THEN 'EXPENSIVE'
--	WHEN Price > 30 THEN 'VERY EXPENSIVE'
--	ELSE 'CHEAP'
--END AS Price_category FROM products;

------------------SQL NULL FUNCTION
--SELECT CustomerName, ISNULL(Address, City)+ ', ' + Country  FROM customers WHERE PostalCode IS NULL;
--SELECT CustomerName, COALESCE(Address, City)+ ', ' + Country  FROM customers WHERE PostalCode IS NULL;

------------------SQL Operators 
--SELECT 30 + 20;
--SELECT 30 - 20;
--SELECT 30 * 20;
--SELECT 30 / 2;

--SELECT * FROM products WHERE Price = 18;
--SELECT * FROM products WHERE Price < 18;
--SELECT * FROM products WHERE Price > 18;
--SELECT * FROM products WHERE Price >= 18;
--SELECT * FROM products WHERE Price <= 18;
--SELECT * FROM products WHERE Price != 18;

--SELECT ProductName FROM Products WHERE ProductID = ALL (SELECT ProductID FROM order_details WHERE Quantity = 10);
--SELECT ProductName FROM Products WHERE ProductID = ANY (SELECT ProductID FROM order_details WHERE Quantity = 10);
--SELECT * FROM Customers WHERE City = 'London' AND Country = 'UK';
--SELECT * FROM Customers WHERE City = 'London' OR Country = 'UK';
--SELECT * FROM products WHERE Price BETWEEN 50 AND 60;
--SELECT * FROM products WHERE Price IN (50, 55, 60);
--SELECT * FROM customers WHERE City NOT LIKE 's%';
--SELECT * FROM customers WHERE City LIKE 's%';
--SELECT * FROM Products WHERE Price > SOME (SELECT Price FROM Products WHERE Price > 20);

