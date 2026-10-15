-- BANKING SCENARIO 

-- CREATE DATABASE
-- CREATE DATABASE Banking_Project_DB;
CREATE DATABASE IF NOT EXISTS Banking_Project_DB;

-- SELECT DATABASE
USE Banking_Project_DB;

--  CREATE CUSTOMERS TABLE
CREATE TABLE IF NOT EXISTS customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    city VARCHAR(50)
);

--  CREATE ACCOUNTS TABLE
CREATE TABLE IF NOT EXISTS accounts (
    account_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    account_type VARCHAR(20),
    balance DECIMAL(10,2),
    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);

--  INSERT DATA INTO CUSTOMERS
INSERT INTO customers (name, city)
VALUES
('Janani', 'Chennai'),
('Arun', 'Coimbatore'),
('Priya', 'Madurai'),
('Karthik', 'Salem');

--  INSERT DATA INTO ACCOUNTS
INSERT INTO accounts (customer_id, account_type, balance)
VALUES
(1, 'Savings', 50000),
(1, 'Current', 20000),
(2, 'Savings', 30000),
(3, 'Savings', 15000),
(4, 'Current', 40000);

--  DISPLAY ALL CUSTOMERS
SELECT * FROM customers;

--  DISPLAY ALL ACCOUNTS
SELECT * FROM accounts;

-- BANKING SCENARIO - QUESTIONS 1 TO 15

-- QUESTION 1:
-- Retrieve all accounts with balance greater than 20,000
SELECT * FROM accounts
WHERE balance > 20000;

-- QUESTION 2:
-- Find customers who live in Chennai
SELECT * FROM customers
WHERE city = 'Chennai';

-- QUESTION 3:
-- Display accounts with balance between 20,000 and 50,000
SELECT * FROM accounts
WHERE balance BETWEEN 20000 AND 50000;

-- QUESTION 4:
-- Find customers whose names start with 'J'
SELECT * FROM customers
WHERE name LIKE 'J%';

-- QUESTION 5:
-- Retrieve accounts of type Savings or Current
SELECT * FROM accounts
WHERE account_type IN ('Savings', 'Current');

-- QUESTION 6:
-- Display accounts that are not Savings
SELECT * FROM accounts
WHERE account_type != 'Savings';

-- QUESTION 7:
-- Find customers whose names contain the letter 'a'
SELECT * FROM customers
WHERE name LIKE '%a%';

-- QUESTION 8:
-- Retrieve accounts with balance less than or equal to 30,000
SELECT * FROM accounts
WHERE balance <= 30000;

-- QUESTION 9:
-- Find customers who are not from Madurai
SELECT * FROM customers
WHERE city != 'Madurai';

-- QUESTION 10:
-- Display accounts where balance is not between 10,000 and 40,000
SELECT * FROM accounts
WHERE balance NOT BETWEEN 10000 AND 40000;

-- QUESTION 11:
-- Retrieve customers whose names end with 'i'
SELECT * FROM customers
WHERE name LIKE '%i';

-- QUESTION 12:
-- Find accounts with balance equal to 50,000
SELECT * FROM accounts
WHERE balance = 50000;

-- QUESTION 13:
-- Display customers whose city is Chennai or Salem
SELECT * FROM customers
WHERE city IN ('Chennai', 'Salem');

-- QUESTION 14:
-- Find accounts with balance greater than 10,000
-- and less than 40,000
SELECT * FROM accounts
WHERE balance > 10000 AND balance < 40000;

-- QUESTION 15:
-- Retrieve accounts where account type is not Current
SELECT * FROM accounts
WHERE account_type NOT IN ('Current');

-- ORDER BY (16–18)

-- 16. Display all accounts sorted by balance in descending order
SELECT *
FROM accounts
ORDER BY balance DESC;

-- 17. List customers sorted alphabetically by name
SELECT *
FROM customers
ORDER BY name ASC;

-- 18. Sort by account type and then balance descending
SELECT *
FROM accounts
ORDER BY account_type ASC, balance DESC;

-- AGGREGATE FUNCTIONS (19–23)

-- 19. Find total balance of all accounts
SELECT SUM(balance) AS total_balance
FROM accounts;

-- 20. Calculate average balance of accounts
SELECT AVG(balance) AS average_balance
FROM accounts;

-- 21. Find maximum account balance
SELECT MAX(balance) AS maximum_balance
FROM accounts;

-- 22. Find minimum account balance
SELECT MIN(balance) AS minimum_balance
FROM accounts;

-- 23. Count total number of customers
SELECT COUNT(*) AS total_customers
FROM customers;

-- GROUP BY + HAVING (24–28)

-- 24. Find total balance grouped by account type
SELECT account_type, SUM(balance) AS total_balance
FROM accounts
GROUP BY account_type;

-- 25. Find average balance for each account type
SELECT account_type, AVG(balance) AS average_balance
FROM accounts
GROUP BY account_type;

-- 26. Account types having average balance greater than 20,000
SELECT account_type, AVG(balance) AS average_balance
FROM accounts
GROUP BY account_type
HAVING AVG(balance) > 20000;

-- 27. Count number of accounts for each customer
SELECT customer_id, COUNT(*) AS total_accounts
FROM accounts
GROUP BY customer_id;

-- 28. Display customers having more than one account
SELECT customer_id, COUNT(*) AS total_accounts
FROM accounts
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- JOINS (29–35)

-- 29. Retrieve customer names with account balances
SELECT c.name, a.balance
FROM customers c
INNER JOIN accounts a
ON c.customer_id = a.customer_id;

-- 30. Display all customers and their accounts,
-- including customers without accounts
SELECT c.*, a.account_id, a.account_type, a.balance
FROM customers c
LEFT JOIN accounts a
ON c.customer_id = a.customer_id;

-- 31. Display all accounts and corresponding customer details
SELECT a.*, c.name, c.city
FROM accounts a
INNER JOIN customers c
ON a.customer_id = c.customer_id;

-- 32. Customer names and account types where balance > 20,000
SELECT c.name, a.account_type, a.balance
FROM customers c
INNER JOIN accounts a
ON c.customer_id = a.customer_id
WHERE a.balance > 20000;

-- 33. Customers with their total balance using JOIN
SELECT c.customer_id, c.name,
       SUM(a.balance) AS total_balance
FROM customers c
INNER JOIN accounts a
ON c.customer_id = a.customer_id
GROUP BY c.customer_id, c.name;

-- 34. Display customer names and balances sorted by balance
SELECT c.name, a.balance
FROM customers c
INNER JOIN accounts a
ON c.customer_id = a.customer_id
ORDER BY a.balance ASC;

-- 35. Count number of accounts for each city using JOIN
SELECT c.city, COUNT(a.account_id) AS total_accounts
FROM customers c
LEFT JOIN accounts a
ON c.customer_id = a.customer_id
GROUP BY c.city;

-- SUBQUERIES (36–40)

-- 36. Accounts with balance greater than average balance
SELECT *
FROM accounts
WHERE balance > (
    SELECT AVG(balance)
    FROM accounts
);

-- 37. Retrieve customers who have accounts
SELECT *
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM accounts
);

-- 38. Find customers who do not have any accounts
SELECT *
FROM customers
WHERE customer_id NOT IN (
    SELECT customer_id
    FROM accounts
);

-- 39. Display account(s) with the maximum balance
SELECT *
FROM accounts
WHERE balance = (
    SELECT MAX(balance)
    FROM accounts
);

-- 40. Customers whose total balance is greater than 40,000
SELECT c.customer_id, c.name,
       SUM(a.balance) AS total_balance
FROM customers c
INNER JOIN accounts a
ON c.customer_id = a.customer_id
GROUP BY c.customer_id, c.name
HAVING SUM(a.balance) > 40000;


-- RAILWAY RESERVATION SCENARIO
-- QUESTIONS 41 TO 50

-- Create database for the Railway Reservation project
CREATE DATABASE IF NOT EXISTS Railway_Reservation_DB;
USE Railway_Reservation_DB;

-- CREATE TRAINS TABLE

CREATE TABLE IF NOT EXISTS trains (
    train_id INT PRIMARY KEY AUTO_INCREMENT,
    train_name VARCHAR(50),
    source VARCHAR(50),
    destination VARCHAR(50)
);


-- CREATE BOOKINGS TABLE

CREATE TABLE IF NOT EXISTS bookings (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    train_id INT,
    passenger_name VARCHAR(50),
    fare DECIMAL(10,2),
    status VARCHAR(20),
    FOREIGN KEY (train_id)
        REFERENCES trains(train_id)
);

--  INSERT TRAIN DATA

INSERT INTO trains (train_name, source, destination)
VALUES
('Express1', 'Chennai', 'Madurai'),
('Express2', 'Coimbatore', 'Salem'),
('Express3', 'Madurai', 'Chennai');

-- INSERT BOOKING DATA

INSERT INTO bookings (train_id, passenger_name, fare, status)
VALUES
(1, 'Janani', 500, 'Confirmed'),
(1, 'Arun', 500, 'Waiting'),
(2, 'Priya', 300, 'Confirmed'),
(3, 'Karthik', 450, 'Cancelled'),
(2, 'Meena', 300, 'Confirmed');

-- RAILWAY RESERVATION QUESTIONS (41-45)

-- 41. Retrieve all bookings with fare greater than 400
SELECT *
FROM bookings
WHERE fare > 400;

-- 42. Find bookings where status is not Confirmed
SELECT *
FROM bookings
WHERE status != 'Confirmed';

-- 43. Display trains starting from Chennai
SELECT *
FROM trains
WHERE source = 'Chennai';

-- 44. Retrieve bookings with fare between 300 and 500
SELECT *
FROM bookings
WHERE fare BETWEEN 300 AND 500;

-- 45. Find passengers whose names start with A
SELECT *
FROM bookings
WHERE passenger_name LIKE 'A%';

-- JOINS + GROUP BY + ORDER BY (46-48)

-- 46. Retrieve train names along with passenger names
SELECT t.train_name, b.passenger_name
FROM trains t
INNER JOIN bookings b
ON t.train_id = b.train_id;

-- 47. Count number of bookings for each train
SELECT t.train_name,
       COUNT(b.booking_id) AS total_bookings
FROM trains t
LEFT JOIN bookings b
ON t.train_id = b.train_id
GROUP BY t.train_id, t.train_name;

-- 48. Display train names and total fare for each train
SELECT t.train_name,
       COALESCE(SUM(b.fare), 0) AS total_fare
FROM trains t
LEFT JOIN bookings b
ON t.train_id = b.train_id
GROUP BY t.train_id, t.train_name;

-- SUBQUERIES (49-50)

-- 49. Find bookings with fare equal to the highest fare
SELECT *
FROM bookings
WHERE fare = (
    SELECT MAX(fare)
    FROM bookings
);

-- 50. Retrieve trains that have more than one booking
SELECT *
FROM trains
WHERE train_id IN (
    SELECT train_id
    FROM bookings
    GROUP BY train_id
    HAVING COUNT(*) > 1
);

 CREATE DATABASE IF NOT EXISTS SQL_Practice_Project_DB;
USE SQL_Practice_Project_DB;

-- EMPLOYEE TABLE
CREATE TABLE IF NOT EXISTS Employee (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    department VARCHAR(30),
    salary DECIMAL(10,2),
    city VARCHAR(30),
    joining_date DATE
);

INSERT IGNORE INTO Employee VALUES
(101,'John','IT',60000,'Chennai','2022-01-15'),
(102,'David','HR',45000,'Bangalore','2021-03-10'),
(103,'Smith','IT',70000,'Chennai','2020-07-12'),
(104,'Mary','Finance',55000,'Mumbai','2023-01-20'),
(105,'James','HR',48000,'Delhi','2022-05-05'),
(106,'Linda','Finance',65000,'Mumbai','2021-08-18');

-- CUSTOMERS TABLE
CREATE TABLE IF NOT EXISTS Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(30)
);

-- ORDERS TABLE
CREATE TABLE IF NOT EXISTS Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    amount DECIMAL(10,2),
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

INSERT IGNORE INTO Customers VALUES
(1,'Arun','Chennai'),
(2,'Priya','Bangalore'),
(3,'Karthik','Mumbai'),
(4,'Meena','Delhi'),
(5,'Ravi','Chennai'),
(6,'Divya','Coimbatore');

INSERT IGNORE INTO Orders VALUES
(101,1,3000,'2025-01-10'),
(102,1,4000,'2025-02-15'),
(103,1,2500,'2025-03-20'),
(104,1,2000,'2025-04-05'),
(105,2,5000,'2025-01-12'),
(106,2,3500,'2025-02-18'),
(107,3,7000,'2025-03-01'),
(108,3,4500,'2025-04-10'),
(109,4,1500,'2025-05-15'),
(110,5,9000,'2025-06-20'),
(111,5,2500,'2025-07-01'),
(112,6,2200,'2025-08-12');

-- STUDENTS TABLE
CREATE TABLE IF NOT EXISTS Students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50),
    department VARCHAR(30),
    marks INT
);

INSERT IGNORE INTO Students VALUES
(1,'Anu','IT',85),
(2,'Bala','IT',92),
(3,'Cathy','IT',78),
(4,'Deepak','IT',88),
(5,'Eva','IT',95),
(6,'Farhan','IT',72),
(7,'Gita','HR',80),
(8,'Hari','HR',76),
(9,'Isha','HR',90),
(10,'Jaya','HR',68),
(11,'Kiran','HR',82),
(12,'Latha','HR',74),
(13,'Manoj','Finance',91),
(14,'Nisha','Finance',84),
(15,'Om','Finance',79),
(16,'Pooja','Finance',96),
(17,'Rahul','Finance',70),
(18,'Sara','Finance',87); 

-- Employee Table
USE SQL_Practice_Project_DB;

-- 1. Total number of employees in each department
SELECT department, COUNT(*) AS total_employees
FROM Employee
GROUP BY department;

-- 2. Average salary in each department
SELECT department, AVG(salary) AS average_salary
FROM Employee
GROUP BY department;

-- 3. Departments having more than one employee
SELECT department, COUNT(*) AS total_employees
FROM Employee
GROUP BY department
HAVING COUNT(*) > 1;

-- 4. Highest salary in each department
SELECT department, MAX(salary) AS highest_salary
FROM Employee
GROUP BY department;

-- 5. Lowest salary in each department
SELECT department, MIN(salary) AS lowest_salary
FROM Employee
GROUP BY department;

-- 6. Departments whose average salary is greater than 50000
SELECT department, AVG(salary) AS average_salary
FROM Employee
GROUP BY department
HAVING AVG(salary) > 50000;

-- 7. Total salary expenditure for each department
SELECT department, SUM(salary) AS total_salary
FROM Employee
GROUP BY department;

-- 8. Employees sorted by salary in descending order
SELECT *
FROM Employee
ORDER BY salary DESC;

-- 9. Sort by department, then salary descending
SELECT *
FROM Employee
ORDER BY department ASC, salary DESC;

-- 10. Cities having more than one employee
SELECT city, COUNT(*) AS total_employees
FROM Employee
GROUP BY city
HAVING COUNT(*) > 1;

-- 11. Total salary paid in each city
SELECT city, SUM(salary) AS total_salary
FROM Employee
GROUP BY city;

-- 12. Departments ordered by total salary, highest to lowest
SELECT department, SUM(salary) AS total_salary
FROM Employee
GROUP BY department
ORDER BY total_salary DESC;

-- 13. Employees in each department earning more than 50000
SELECT department, COUNT(*) AS employee_count
FROM Employee
WHERE salary > 50000
GROUP BY department;

-- 14. Difference between highest and lowest salary
SELECT department, MAX(salary) - MIN(salary) AS salary_difference
FROM Employee
GROUP BY department;

-- 15. Top 3 highest-paid employees
SELECT *
FROM Employee
ORDER BY salary DESC
LIMIT 3;

-- Customers & Orders Tables
USE SQL_Practice_Project_DB;

-- 16. Total order amount for each customer
SELECT c.customer_name, COALESCE(SUM(o.amount), 0) AS total_amount
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;

-- 17. Customers who placed more than 3 orders
SELECT c.customer_name, COUNT(o.order_id) AS total_orders
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(o.order_id) > 3;

-- 18. Average order amount for each customer
SELECT c.customer_name, AVG(o.amount) AS average_amount
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;

-- 19. Highest order amount for each customer
SELECT c.customer_name, MAX(o.amount) AS highest_order
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;

-- 20. Customers sorted by total purchase amount
SELECT c.customer_name, COALESCE(SUM(o.amount), 0) AS total_purchase
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_purchase DESC;

-- 21. Customers whose total purchase exceeds 10000
SELECT c.customer_name, SUM(o.amount) AS total_purchase
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING SUM(o.amount) > 10000;

-- 22. Customer names and total number of orders
SELECT c.customer_name, COUNT(o.order_id) AS total_orders
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;

-- 23. Customer who spent the highest total amount
SELECT c.customer_name, SUM(o.amount) AS total_purchase
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_purchase DESC
LIMIT 1;

-- 24. Customer who placed the maximum number of orders
SELECT c.customer_name, COUNT(o.order_id) AS total_orders
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_orders DESC
LIMIT 1;

-- 25. Customers whose average order amount is greater than 2000
SELECT c.customer_name, AVG(o.amount) AS average_amount
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING AVG(o.amount) > 2000;

-- 26. Top 5 customers by total purchase amount
SELECT c.customer_name, SUM(o.amount) AS total_purchase
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_purchase DESC
LIMIT 5;

-- 27. Minimum order amount for each customer
SELECT c.customer_name, MIN(o.amount) AS minimum_order
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;

-- 28. Customers with total orders worth more than 5000
SELECT c.customer_name, SUM(o.amount) AS total_purchase
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING SUM(o.amount) > 5000;

-- 29. Customer wise total orders and total purchase amount
SELECT c.customer_name,
       COUNT(o.order_id) AS total_orders,
       COALESCE(SUM(o.amount), 0) AS total_purchase
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;

-- 30. Customers with more than 2 orders and spending above 8000
SELECT c.customer_name,
       COUNT(o.order_id) AS total_orders,
       SUM(o.amount) AS total_purchase
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(o.order_id) > 2 AND SUM(o.amount) > 8000;

-- Students Table
USE SQL_Practice_Project_DB;

-- 31. Average marks in each department
SELECT department, AVG(marks) AS average_marks
FROM Students
GROUP BY department;

-- 32. Departments with average marks above 75
SELECT department, AVG(marks) AS average_marks
FROM Students
GROUP BY department
HAVING AVG(marks) > 75;

-- 33. Highest mark in each department
SELECT department, MAX(marks) AS highest_mark
FROM Students
GROUP BY department;

-- 34. Total number of students in each department
SELECT department, COUNT(*) AS total_students
FROM Students
GROUP BY department;

-- 35. Departments having more than 5 students
SELECT department, COUNT(*) AS total_students
FROM Students
GROUP BY department
HAVING COUNT(*) > 5;

-- 36. Departments sorted by average marks descending
SELECT department, AVG(marks) AS average_marks
FROM Students
GROUP BY department
ORDER BY average_marks DESC;

-- 37. Top 3 departments based on average marks
SELECT department, AVG(marks) AS average_marks
FROM Students
GROUP BY department
ORDER BY average_marks DESC
LIMIT 3;

-- 38. Departments with average marks between 70 and 90
SELECT department, AVG(marks) AS average_marks
FROM Students
GROUP BY department
HAVING AVG(marks) BETWEEN 70 AND 90;

-- 39. Total marks in each department
SELECT department, SUM(marks) AS total_marks
FROM Students
GROUP BY department;

-- 40. Departments sorted by total number of students
SELECT department, COUNT(*) AS total_students
FROM Students
GROUP BY department
ORDER BY total_students ASC;

-- 41. Lowest mark in each department
SELECT department, MIN(marks) AS lowest_mark
FROM Students
GROUP BY department;

-- 42. Departments where the highest mark is greater than 90
SELECT department, MAX(marks) AS highest_mark
FROM Students
GROUP BY department
HAVING MAX(marks) > 90;

-- 43. Number of students scoring above 80 in each department
SELECT department, COUNT(*) AS students_above_80
FROM Students
WHERE marks > 80
GROUP BY department;

-- 44. Departments where more than 3 students scored above 75
SELECT department, COUNT(*) AS students_above_75
FROM Students
WHERE marks > 75
GROUP BY department
HAVING COUNT(*) > 3;

-- 45. Departments ordered by highest mark descending
SELECT department, MAX(marks) AS highest_mark
FROM Students
GROUP BY department
ORDER BY highest_mark DESC;


