--CREATE DATABASE my_DB;
--GO
--BACKUP DATABASE my_DB 
--TO DISK = 'D:/backups/practice_DB.bak';
--DROP DATABASE my_DB

USE w3schools;
---- CREATE TABLE tbnme AS NOT AVAILABLE IN SQL SERVER INSTEAD USE THIS;
---- SELECT INTO myDB IN dbnme NOT AVAILABLE IN ms SQL server
--SELECT CustomerName AS Name, CustomerID AS ID INTO CustomerNames FROM customers;
--SELECT * FROM CustomerNames;

--ALTER TABLE CustomerNames ADD Email varchar(255);
--ALTER TABLE CustomerNames DROP COLUMN Email;
--ALTER TABLE CustomerNames ADD BirthDate date;
--ALTER TABLE CustomerNames ALTER COLUMN BirthDate varchar(255);

--ALTER TABLE CustomerNames ADD Id int NOT NULL IDENTITY(1,1) PRIMARY KEY(ID);
--ALTER TABLE Customernames DROP COLUMN BirthDate;

--ALTER TABLE orders DROP CONSTRAINT Cid
--ALTER TABLE orders ADD CONSTRAINT orders_Cid_FK FOREIGN KEY(Cid) REFERENCES CustomerNames(Id);
--ALTER TABLE orders DROP CONSTRAINT orders_Cid_FK;

--ALTER TABLE orders ADD Cid int;
--ALTER TABLE orders ADD constraint FK_Cid FOREIGN KEY (Cid) REFERENCES CustomerNames(Id);
--CREATE INDEX index1 ON CustomerNames(Name);
--DROP INDEX CustomerNames.index1;
--ALTER TABLE CustomerNames ADD DOB date NOT NULL DEFAULT '1800-01-01';
--SELECT * FROM CustomerNames;

--CREATE VIEW selectedCustomers AS SELECT * FROM customers WHERE Country = 'UK';
--SELECT * FROM selectedCustomers;

--SELECT * FROM CustomerNames WHERE Name ='' or ''='';