CREATE DATABASE Employees_DB

USE Employees_DB;

---------------------------------------------Task Tables------------------------------------------------------------
CREATE TABLE JOBS (
	Job_ID TINYINT IDENTITY(1,1) PRIMARY KEY,
	Job_title VARCHAR(255),
	Min_Salary NUMERIC(20,2),
	Max_Salary NUMERIC(20,2)
);

CREATE TABLE DEPARTMENTS(
	Department_ID TINYINT IDENTITY(1,1) PRIMARY KEY,
	Department_Name VARCHAR(255),
	Manager_ID BIGINT,
	Location_ID BIGINT
);

CREATE TABLE EMPLOYEES(
	Employee_ID BIGINT IDENTITY(1,1) PRIMARY KEY,
	First_Name VARCHAR(255),
	Last_Name VARCHAR(255),
	Email VARCHAR(255) UNIQUE,
	Phone_Number NUMERIC(11,0) UNIQUE ,
	Hire_Date date,
	Job_ID TINYINT FOREIGN KEY REFERENCES JOBS(Job_ID),
	Salary NUMERIC(10, 2),
	Commission_pct NUMERIC(5, 2),
	Manager_ID BIGINT,
	Department_ID TINYINT
);

--------------------------------------------Task Data----------------------------------------------------------------------
INSERT JOBS(Job_title, Min_Salary, Max_Salary)
VALUES ('Front_End_Devloper',30000,200000),
		('Back_End_Devloper',50000,750000),
		('HR',20000,150000),
		('Manager',70000,250000),
		('Salesmen',30000,400000),
		('QA',45000,450000),
		('Intern', 0, 10000);

--SELECT * FROM JOBS;

INSERT DEPARTMENTS(Department_Name, Manager_ID, Location_ID)
VALUES ('Front_End',6,1),
	('Back_End',5,2),
	('HR',4,3),
	('Sales', 8,4),
	('QA',20,5);

--SELECT * FROM DEPARTMENTS;

INSERT EMPLOYEES (First_Name, Last_Name, Email, Phone_Number, Hire_Date, Job_ID, Salary, Commission_pct, Manager_ID, Department_ID)
VALUES('Sahil', 'Parsaniya', 'SP@gmail.com', 9638527410, '2021-06-15', 7, 7000, 0.4, 5, 2),
	('Rishit', 'Kalyani', 'RK@gmail.com', 1234512345, '2022-06-15', 7, 9000, 0.8, 5, 2),
	('Ashok', 'Maru', 'AM@gmail.com', 9876598765, '2020-03-29', 2, 190000, 2.9, 5, 2),
	('Hardi', 'Govani', 'HG@gmail.com',9409249079,'2021-06-16', 7, 8000, 0.7, 6, 1),
	('Hemangi', 'Nirmal', 'HN@gmail.com', 9409249080, '2022-06-16', 7, 9500, 0.3, 6, 1),
	('Nishita', 'Kalyani', 'NK@gmail.com', 9409249082, '2022-02-16', 1, 40000, 1.3, 6, 1),
	('Shivraj', 'Chavda', 'SR@gmail.com', 1237894654, '2020-06-16', 1, 60000, 1.4, 8, 4),
	('Shery', 'Dadhaniya', 'SD@gmail.com', 9409249098, '2019-06-16', 4, 125000, 2.2, 5, 2),
	('Pratipansinh', 'Gohil', 'PG@gmail.com', 1237418529, '2019-03-01', 6, 180000, 2.3, 20, 3),
	('Janvi', 'Desai', 'JD@gmail.com', 7418529630, '2020-09-30', 3, 56000, 1.2, 4, 3);

SELECT * FROM EMPLOYEES;

--------------------------------------------Task Queries--------------------------------------------------------------------
/*
1. Given SQL query will execute successfully: TRUE/FALSE SELECT last_name, job_id, salary AS Sal FROM employees; -------> TRUE
2. Identity errors in the following statement: SELECT employee_id, last_name, sal*12 ANNUAL SALARY FROM employees; --------> NOT Using AS keword, sal is invelid tocken
3. Write a query to determine the structure of the table 'DEPARTMENTS'
4. Write a query to determine the unique Job IDs from the EMPLOYEES table.
5. Write a query to display the employee number, lastname, salary (oldsalary), salary increased by 15.5% name it has NewSalary and subtract the (NewSalary from OldSalary) name the column as Increment.
6. Write a query to display the minimum, maximum, sum and average salary for each job type.
7. The HR department needs to find the names and hire dates of all employees who were hired before their managers, along with their managers’ names and hire dates.
8. Create a report for the HR department that displays employee last names, department numbers, and all the employees who work in the same department as a given employee.
9. Find the highest, lowest, sum, and average salary of all employees. Label the columns Maximum, Minimum, Sum, and Average, respectively. Round your results to the nearest whole number.
10. Create a report that displays list of employees whose salary is more than the salary of any employee from department 60.
11. Create a report that displays last name and salary of every employee who reports to King(Use any manager name instead of King).
12. Write a query to display the list of department IDs for departments that do not contain the job Id ST_CLERK(Add this job ST_CLERK to Job table). Use SET Operator for this query
13. Write a query to display the list of employees who work in department 50 and 80. Show employee Id, job Id and department Id by using set operators. - Add 50 and 80 department Id to department table
*/
-------------------------------------Task 1---------------------------------------------------------------
SELECT last_name, job_id, salary AS Sal 
FROM employees;

-------------------------------------Task 2---------------------------------------------------------------
--SELECT employee_id, last_name, sal*12 ANNUAL SALARY FROM EMPLOYEES;

-------------------------------------Task 3---------------------------------------------------------------
EXEC sp_help 'dbo.DEPARTMENTS';

-------------------------------------Task 4---------------------------------------------------------------
SELECT DISTINCT Job_ID 
FROM EMPLOYEES;

-------------------------------------Task 5---------------------------------------------------------------
SELECT Employee_ID, Salary AS OLDsALARY, (Salary+(Salary*0.155)) AS NewSalary, (Salary*0.155) AS Increment 
FROM EMPLOYEES;

-------------------------------------Task 6---------------------------------------------------------------
SELECT MAX(Salary) AS Max_Salary, MIN(Salary) AS Min_Salary, SUM(Salary) AS Sum_Of_Salary, AVG(Salary) AS Avg_Salary 
FROM EMPLOYEES;

-------------------------------------Task 7-------------------------------------------------------------
SELECT CONCAT(A.First_Name, ' ', A.Last_Name) AS Name, A.Hire_Date AS Hire_Date, CONCAT(B.First_Name, ' ', B.Last_Name) AS Manager, B.Hire_Date AS Manager_Hire_Date
FROM EMPLOYEES A INNER JOIN EMPLOYEES B ON A.Manager_ID = B.Employee_ID
WHERE A.Hire_Date < B.Hire_Date;

-------------------------------------Task 8---------------------------------------------------------------
GO
CREATE VIEW Employee_Report AS
SELECT DISTINCT CONCAT(A.First_Name, ' ', A.Last_Name) AS Emp_Name, A.Department_ID AS Same_Dept, CONCAT(B.First_Name, ' ', B.Last_Name) AS Other_Emp
FROM EMPLOYEES A INNER JOIN EMPLOYEES B ON A.Department_ID = B.Department_ID
WHERE B.Last_Name != A.Last_Name;

GO
SELECT * FROM Employee_Report;

-------------------------------------Task 9---------------------------------------------------------------
SELECT MAX(Salary) AS Maximum, MIN(Salary)AS Minimum, SUM(Salary) AS Sum, ROUND(AVG(Salary), 0) AS Average FROM EMPLOYEES;

-------------------------------------Task 10--------------------------------------------------------------
GO
CREATE VIEW Salary_List_Report AS
SELECT * FROM EMPLOYEES 
WHERE Salary > (SELECT Salary FROM EMPLOYEES WHERE Department_ID = 4);

GO
SELECT * FROM Salary_List_Report;

-------------------------------------Task 11--------------------------------------------------------------
GO
CREATE VIEW Employee_To_Hemangi AS
SELECT A.Last_Name, A.Salary 
FROM EMPLOYEES A INNER JOIN EMPLOYEES B ON A.Manager_ID = B.Employee_ID WHERE B.First_Name = 'Hemangi';

GO
SELECT * FROM Employee_TO_Hemangi;

-------------------------------------Task 12---------------------------------------------------------------
UPDATE JOBS 
SET Job_title = 'ST_Clerk' WHERE Job_ID = 8;

SELECT Department_ID FROM EMPLOYEES
WHERE Department_ID != 8
UNION 
SELECT Department_ID FROM EMPLOYEES
WHERE Department_ID != 8;

-------------------------------------Task 13---------------------------------------------------------------
SELECT Employee_ID, Job_ID, Department_ID FROM EMPLOYEES
WHERE Department_ID IN (1, 3, 4) ORDER BY Department_ID;

-------------------------------------Getting day/month/year from date--------------------------------------
SELECT DAY(Hire_Date) FROM EMPLOYEES;
SELECT MONTH(Hire_Date) FROM EMPLOYEES;
SELECT YEAR(Hire_Date) FROM EMPLOYEES;

-------------------------------------Using EXISTS to check customer placed an order or not-----------------
USE w3schools;

SELECT CustomerID FROM customers 
WHERE EXISTS (SELECT CustomerID FROM orders WHERE CustomerID = customers.CustomerID);