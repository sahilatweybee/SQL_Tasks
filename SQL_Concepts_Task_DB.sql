CREATE DATABASE SQL_Task_db;
GO

USE SQL_Task_db;

CREATE TABLE AUTHOR(
	Author_ID VARCHAR(255) NOT NULL PRIMARY KEY,
	Author_Name VARCHAR(255) DEFAULT NULL
);

CREATE TABLE SHIPPING_TYPE(
	Shipping_Type VARCHAR(255) NOT NULL PRIMARY KEY,
	Shipping_Price INT DEFAULT 0
);

CREATE TABLE CREDIT_CARD_DETAILS(
	Credit_Card_Number VARCHAR(255) NOT NULL PRIMARY KEY,
	Credit_card_Type VARCHAR(255) DEFAULT NULL,
	Expiry_Date date DEFAULT NULL
);

CREATE TABLE PUBLISHER(
	Publisher_ID VARCHAR(255) NOT NULL PRIMARY KEY,
	Publisher_Name VARCHAR(255) DEFAULT NULL
);

CREATE TABLE BOOKS(
	Book_ID VARCHAR(255) NOT NULL PRIMARY KEY,
	Book_Name VARCHAR(255) DEFAULT NULL,
	Author_ID VARCHAR(255) FOREIGN KEY REFERENCES AUTHOR(Author_ID),
	Price INT DEFAULT 0,
	Publisher_ID VARCHAR(255) FOREIGN KEY REFERENCES PUBLISHER(Publisher_ID)
);

CREATE TABLE SHOPPING_CART(
	Shopping_Cart_ID INT NOT NULL PRIMARY KEY,
	Book_ID VARCHAR(255) FOREIGN KEY REFERENCES BOOKS(Book_ID),
	Price INT DEFAULT 0,
	Order_Date date DEFAULT NULL,
	Quantity INT DEFAULT 0
);

CREATE TABLE CUSTOMER(
	Customer_ID VARCHAR(255) NOT NULL PRIMARY KEY,
	Customer_Name VARCHAR(255) DEFAULT NULL,
	Street_Address VARCHAR(255) DEFAULT NULL,
	City VARCHAR(255) DEFAULT NULL,
	Phone_Number VARCHAR(255) DEFAULT NULL,
	Credit_Card_Number VARCHAR(255) FOREIGN KEY REFERENCES CREDIT_CARD_DETAILS(Credit_Card_Number)
);

CREATE TABLE ORDER_DETAILS(
	Order_ID INT NOT NULL PRIMARY KEY,
	Customer_ID VARCHAR(255) FOREIGN KEY REFERENCES CUSTOMER(Customer_ID),
	Shipping_Type VARCHAR(255) FOREIGN KEY REFERENCES SHIPPING_TYPE(Shipping_Type),
	Order_Date date DEFAULT NULL,
	Shopping_Cart_ID INT FOREIGN KEY REFERENCES SHOPPING_CART(Shopping_Cart_ID)
);

CREATE TABLE PURCHASE_HISTORY(
	Customer_ID VARCHAR(255) FOREIGN KEY REFERENCES CUSTOMER(Customer_ID),
	Order_ID INT FOREIGN KEY REFERENCES ORDER_DETAILS(Order_ID)
);

------------------------------------------------------------------------INSERTING VALUES---------------------------------------------------

INSERT INTO AUTHOR (Author_ID, Author_Name) 
VALUES (1, 'J. K. Rollings'),
	(2, 'George R. R. MARTIN')

INSERT PUBLISHER (Publisher_ID, Publisher_Name) 
VALUES (1, 'Bloomsbury Publishing'),
	(2, 'HarperCollins Publishers');

INSERT BOOKS 
VALUES (1, 'Harry Potter and the Philoshopher''s stone', 1, 399, 1),
	(2, 'A Dance With The Dragons: A Song of Ice and FIre', 2, 899, 1);

INSERT CREDIT_CARD_DETAILS 
VALUES ('9999-9999-9999-9999', 'VISA-CARD', '2050-12-30'),
	('8888-8888-8888-8888', 'RuPay-CARD', '2050-10-31');

INSERT SHOPPING_CART 
VALUES (1, 1, 399, '2021-12-26', 5),
	(2, 2, 899, '2020-08-26', 3);

INSERT SHIPPING_TYPE
VALUES ('Two Day Shipping', 50),
	('Same Day Shipping', 100);

INSERT CUSTOMER 
VALUES (1, 'John', '22 Abbey Row', 'Nottingham', '+44 079 7904 1318', '9999-9999-9999-9999'),
	(2, 'Alex', '65 Hudson Street', 'Dulford', '+44 070 8030 0869', '8888-8888-8888-8888');

INSERT ORDER_DETAILS 
VALUES (101902, 1, 'Same Day Shipping', '2021-12-26', 1),
	(86928, 2, 'Two Day Shipping', '2020-08-26', 2);

INSERT PURCHASE_HISTORY
VALUES (1, 101902),
	(2, 86928);