-- Employee Leave Management System

-- 1. Create database
CREATE DATABASE IF NOT EXISTS employee_leave_db;

-- 2. Select database
USE employee_leave_db;

-- 3. Create employees table
CREATE TABLE IF NOT EXISTS employees (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_name VARCHAR(100) NOT NULL,
    department VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(15)
);

-- 4. Create leave_balance table
CREATE TABLE IF NOT EXISTS leave_balance (
    employee_id INT PRIMARY KEY,
    total_leaves INT DEFAULT 12,
    leaves_taken INT DEFAULT 0,
    FOREIGN KEY (employee_id)
        REFERENCES employees(employee_id)
);

-- 5. Create leave_requests table
CREATE TABLE IF NOT EXISTS leave_requests (
    leave_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id INT NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
    reason VARCHAR(255),
    status VARCHAR(20) DEFAULT 'Pending',
    FOREIGN KEY (employee_id)
        REFERENCES employees(employee_id)
);

-- 6. Check all tables
SHOW TABLES;

-- 7. Check table structures
DESCRIBE employees;
DESCRIBE leave_balance;
DESCRIBE leave_requests;

-- 8. View all employees
SELECT * FROM employees;

-- 9. View leave balances
SELECT * FROM leave_balance;

-- 10. View leave requests
SELECT * FROM leave_requests;

-- 11. View employees with their leave balances
SELECT
    e.employee_id,
    e.employee_name,
    e.department,
    lb.total_leaves,
    lb.leaves_taken,
    (lb.total_leaves - lb.leaves_taken) AS remaining_leaves
FROM employees e
JOIN leave_balance lb
    ON e.employee_id = lb.employee_id;

-- 12. View leave requests with employee names
SELECT
    lr.leave_id,
    e.employee_name,
    lr.from_date,
    lr.to_date,
    lr.reason,
    lr.status
FROM leave_requests lr
JOIN employees e
    ON lr.employee_id = e.employee_id;
