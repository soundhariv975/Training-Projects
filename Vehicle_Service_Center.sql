-- Vehicle Service Center Management System

-- 1. Create database
CREATE DATABASE IF NOT EXISTS vehicle_service_db;

-- 2. Select database
USE vehicle_service_db;

-- 3. Create Customers table
CREATE TABLE IF NOT EXISTS customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100) NOT NULL,
    phone VARCHAR(15) NOT NULL,
    email VARCHAR(100),
    address VARCHAR(200)
);

-- 4. Create Vehicles table
CREATE TABLE IF NOT EXISTS vehicles (
    vehicle_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    vehicle_number VARCHAR(20) UNIQUE NOT NULL,
    vehicle_model VARCHAR(100) NOT NULL,
    vehicle_type VARCHAR(50),

    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);

-- 5. Create Service Records table
CREATE TABLE IF NOT EXISTS service_records (
    service_id INT PRIMARY KEY AUTO_INCREMENT,
    vehicle_id INT NOT NULL,
    service_date DATE NOT NULL,
    service_type VARCHAR(100) NOT NULL,
    service_cost DECIMAL(10,2) DEFAULT 0.00,
    service_status VARCHAR(30) DEFAULT 'Pending',

    FOREIGN KEY (vehicle_id)
        REFERENCES vehicles(vehicle_id)
);

-- 6. Display all customers
SELECT * FROM customers;

-- 7. Display all vehicles
SELECT * FROM vehicles;

-- 8. Display all service records
SELECT * FROM service_records;

-- 9. Display complete service details
SELECT
    c.customer_name,
    c.phone,
    v.vehicle_number,
    v.vehicle_model,
    v.vehicle_type,
    s.service_id,
    s.service_date,
    s.service_type,
    s.service_cost,
    s.service_status
FROM customers c
JOIN vehicles v
    ON c.customer_id = v.customer_id
JOIN service_records s
    ON v.vehicle_id = s.vehicle_id;


