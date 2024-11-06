CREATE DATABASE BIKE_SHOWROOM;
USE BIKE_SHOWROOM;

-- 01
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    phone_number VARCHAR(15) NOT NULL UNIQUE,
    email VARCHAR(100) UNIQUE,
    address VARCHAR(255),
    date_of_birth DATE,
    license_number VARCHAR(20) UNIQUE
);

-- 02
CREATE TABLE Bike_Models (
    model_id INT PRIMARY KEY,
    model_name VARCHAR(100) NOT NULL,
    engine_capacity VARCHAR(10),
    fuel_type ENUM('Petrol', 'Electric') NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    available_color_options VARCHAR(255),
    launch_date DATE,
    discontinuation_date DATE
);

-- 03
CREATE TABLE Bikes (
    bike_id INT PRIMARY KEY,
    model_id INT,
    engine_number VARCHAR(50) UNIQUE NOT NULL,
    chassis_number VARCHAR(50) UNIQUE NOT NULL,
    purchase_date DATE,
    warranty_start_date DATE,
    warranty_end_date DATE,
    FOREIGN KEY (model_id) REFERENCES Bike_Models(model_id)
);

-- 04
CREATE TABLE Sales (
    sale_id INT PRIMARY KEY,
    customer_id INT,
    bike_id INT,
    sale_date DATE NOT NULL,
    sale_price DECIMAL(10, 2) NOT NULL,
    payment_method ENUM('Cash', 'Financing', 'Debit Card') NOT NULL,
    status ENUM('Completed', 'Pending', 'Canceled') DEFAULT 'Pending',
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (bike_id) REFERENCES Bikes(bike_id)
);

-- 05
CREATE TABLE Sales_Representatives (
    sales_rep_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    phone_number VARCHAR(15) UNIQUE,
    email VARCHAR(100) UNIQUE,
    hire_date DATE,
    commission_rate DECIMAL(5, 2)
);

-- 06
CREATE TABLE Service_Types (
    service_type_id INT PRIMARY KEY,
    service_name VARCHAR(100) NOT NULL,
    description TEXT,
    service_cost DECIMAL(10, 2),
    average_duration DECIMAL(4, 2)  -- in hours
);

-- 07
CREATE TABLE Technicians (
    technician_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    specialization VARCHAR(100),
    phone_number VARCHAR(15) UNIQUE,
    email VARCHAR(100) UNIQUE,
    experience_years INT
);

-- 08
CREATE TABLE Service_Records (
    service_record_id INT PRIMARY KEY,
    bike_id INT,
    service_type_id INT,
    technician_id INT,
    service_date DATE NOT NULL,
    comments TEXT,
    total_cost DECIMAL(10, 2),
    FOREIGN KEY (bike_id) REFERENCES Bikes(bike_id),
    FOREIGN KEY (service_type_id) REFERENCES Service_Types(service_type_id),
    FOREIGN KEY (technician_id) REFERENCES Technicians(technician_id)
);
-- 09
CREATE TABLE Inventory (
    part_id INT PRIMARY KEY,
    part_name VARCHAR(100) NOT NULL,
    description TEXT,
    unit_cost DECIMAL(10, 2) NOT NULL,
    quantity_in_stock INT NOT NULL,
    supplier_id INT,
    last_restocked_date DATE,
    FOREIGN KEY (supplier_id) REFERENCES Suppliers(supplier_id)
);

-- 10
CREATE TABLE Suppliers (
    supplier_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    contact_number VARCHAR(15),
    email VARCHAR(100),
    address VARCHAR(255)
);

-- 11
CREATE TABLE Parts_Used_In_Service (
    service_record_id INT,
    part_id INT,
    quantity_used INT NOT NULL,
    FOREIGN KEY (service_record_id) REFERENCES Service_Records(service_record_id),
    FOREIGN KEY (part_id) REFERENCES Inventory(part_id),
    PRIMARY KEY (service_record_id, part_id)
);

-- 12
CREATE TABLE Payments (
    payment_id INT PRIMARY KEY,
    sale_id INT,
    service_record_id INT,
    payment_date DATE NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    payment_method ENUM('Cash', 'Debit Card', 'UPI') NOT NULL,
    payment_status ENUM('Paid', 'Unpaid', 'Pending') DEFAULT 'Pending',
    FOREIGN KEY (sale_id) REFERENCES Sales(sale_id),
    FOREIGN KEY (service_record_id) REFERENCES Service_Records(service_record_id)
);

-- 13
CREATE TABLE Feedback (
    feedback_id INT PRIMARY KEY,
    customer_id INT,
    sale_id INT,
    service_record_id INT,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    comments TEXT,
    feedback_date DATE NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (sale_id) REFERENCES Sales(sale_id),
    FOREIGN KEY (service_record_id) REFERENCES Service_Records(service_record_id)
);

-- iNSERT vALUES

INSERT INTO Customers (customer_id, name, phone_number, email, address, date_of_birth, license_number) VALUES
(1, 'Rohan Sharma', '9876543210', 'rohan.sharma@example.com', 'Mumbai, Maharashtra', '1990-05-15', 'MH01A12345'),
(2, 'Aarti Gupta', '9123456789', 'aarti.gupta@example.com', 'Delhi, Delhi', '1985-11-20', 'DL05B67890'),
(3, 'Vikram Desai', '9823456780', 'vikram.desai@example.com', 'Bangalore, Karnataka', '1993-04-12', 'KA03C11223'),
(4, 'Sanjana Iyer', '9876543123', 'sanjana.iyer@example.com', 'Chennai, Tamil Nadu', '1988-09-18', 'TN09D22456'),
(5, 'Abhishek Verma', '9988776655', 'abhishek.verma@example.com', 'Pune, Maharashtra', '1995-02-02', 'MH12E33445'),
(6, 'Rahul Mehta', '9123456721', 'rahul.mehta@example.com', 'Ahmedabad, Gujarat', '1989-03-11', 'GJ01A78945'),
(7, 'Pooja Singh', '9876543222', 'pooja.singh@example.com', 'Kolkata, West Bengal', '1992-08-27', 'WB09B12345'),
(8, 'Aniket Kumar', '9801234567', 'aniket.kumar@example.com', 'Lucknow, Uttar Pradesh', '1985-07-16', 'UP14C56789'),
(9, 'Rekha Patel', '9776543219', 'rekha.patel@example.com', 'Indore, Madhya Pradesh', '1993-12-23', 'MP09D34567'),
(10, 'Neeraj Kapoor', '9445678901', 'neeraj.kapoor@example.com', 'Hyderabad, Telangana', '1987-01-29', 'TS08E98765');


INSERT INTO Bike_Models (model_id, model_name, engine_capacity, fuel_type, price, available_color_options, launch_date) VALUES
(1, 'TVS Apache RTR 160', '160cc', 'Petrol', 114000, 'Red, Blue, Black', '2020-01-15'),
(2, 'TVS Ntorq 125', '125cc', 'Petrol', 83000, 'Yellow, Red, Blue, Black', '2019-06-10'),
(3, 'TVS Jupiter', '110cc', 'Petrol', 75000, 'Grey, Blue, White, Black', '2018-09-20'),
(4, 'TVS XL100', '100cc', 'Petrol', 54000, 'Green, Black', '2017-04-25'),
(5, 'TVS iQube Electric', '0cc', 'Electric', 140000, 'White, Black', '2021-02-01'),
(6, 'TVS Apache RTR 200', '200cc', 'Petrol', 130000, 'Red, Black, White', '2021-07-10'),
(7, 'TVS Radeon', '110cc', 'Petrol', 70000, 'Black, Grey, Beige', '2018-10-12'),
(8, 'TVS Star City+', '110cc', 'Petrol', 69000, 'Red, Black, Grey', '2019-08-01'),
(9, 'TVS Sport', '100cc', 'Petrol', 62000, 'Blue, Black, Red', '2020-05-15'),
(10, 'TVS Zest Electric', '0cc', 'Electric', 145000, 'Yellow, Black', '2023-01-30'),
(11, 'TVS Electron+', '0cc', 'Electric', 160000, 'Blue, Black, White', '2024-02-15'),
(12, 'TVS Blaze E+', '0cc', 'Electric', 175000, 'Red, Silver', '2024-03-22'),
(13, 'TVS Spark E', '0cc', 'Electric', 140000, 'Black, Blue', '2024-04-05'),
(14, 'TVS Evo Electric', '0cc', 'Electric', 180000, 'White, Silver', '2024-06-01'),
(15, 'TVS Creon', '0cc', 'Electric', 170000, 'White, Red, Grey', '2023-08-05');




INSERT INTO Bikes (bike_id, model_id, engine_number, chassis_number, purchase_date, warranty_start_date, warranty_end_date) VALUES
(1, 1, 'ENG123456789', 'CHS987654321', '2024-01-20', '2024-01-20', '2026-01-20'),
(2, 2, 'ENG987654321', 'CHS123456789', '2023-11-05', '2023-11-05', '2025-11-05'),
(3, 3, 'ENG567890123', 'CHS456789012', '2024-03-15', '2024-03-15', '2026-03-15'),
(4, 4, 'ENG135790246', 'CHS357924680', '2024-05-30', '2024-05-30', '2026-05-30'),
(5, 5, 'ENG246813579', 'CHS468135792', '2023-10-10', '2023-10-10', '2025-10-10'),
(6, 6, 'ENG112233445', 'CHS554433221', '2023-09-18', '2023-09-18', '2025-09-18'),
(7, 7, 'ENG223344556', 'CHS665544332', '2024-01-10', '2024-01-10', '2026-01-10'),
(8, 8, 'ENG334455667', 'CHS776655443', '2024-02-22', '2024-02-22', '2026-02-22'),
(9, 9, 'ENG445566778', 'CHS887766554', '2023-12-01', '2023-12-01', '2025-12-01'),
(10, 10, 'ENG556677889', 'CHS998877665', '2024-03-14', '2024-03-14', '2026-03-14'),
(11, 11, 'ENG667788990', 'CHS009988776', '2024-04-05', '2024-04-05', '2026-04-05'),
(12, 12, 'ENG778899001', 'CHS110099887', '2024-05-20', '2024-05-20', '2026-05-20'),
(13, 13, 'ENG889900112', 'CHS221100998', '2023-11-22', '2023-11-22', '2025-11-22'),
(14, 14, 'ENG990011223', 'CHS332211009', '2024-06-01', '2024-06-01', '2026-06-01'),
(15, 15, 'ENG001122334', 'CHS443322110', '2024-07-10', '2024-07-10', '2026-07-10');


INSERT INTO Sales (sale_id, customer_id, bike_id, sale_date, sale_price, payment_method, status) VALUES
(1, 1, 1, '2024-01-20', 114000, 'Cash', 'Completed'),
(2, 1, 2, '2023-11-05', 83000, 'Debit Card', 'Completed'),
(3, 3, 3, '2024-03-15', 75000, 'Financing', 'Pending'),
(4, 2, 4, '2024-05-30', 54000, 'Cash', 'Completed'),
(5, 1, 5, '2023-10-10', 140000, 'Debit Card', 'Completed'),
(6, 6, 6, '2023-12-15', 130000, 'Cash', 'Completed'),
(7, 10, 7, '2024-02-01', 70000, 'Financing', 'Completed'),
(8, 8, 8, '2024-03-22', 69000, 'Debit Card', 'Completed'),
(9, 9, 9, '2024-01-10', 62000, 'Cash', 'Completed'),
(10, 5, 10, '2024-04-30', 145000, 'Cash', 'Pending'),
(11, 4, 11, '2024-05-05', 160000, 'Debit Card', 'Completed'),
(12, 4, 12, '2024-06-10', 175000, 'Financing', 'Completed'),
(13, 5, 13, '2024-07-15', 140000, 'Cash', 'Completed'),
(14, 7, 14, '2024-08-20', 180000, 'Debit Card', 'Pending'),
(15, 10, 15, '2024-09-25', 170000, 'Cash', 'Completed');


INSERT INTO Service_Types (service_type_id, service_name, description, service_cost, average_duration) VALUES
(1, 'Regular Maintenance', 'Basic checkup and oil change', 1000, 1.5),
(2, 'Engine Overhaul', 'Complete engine inspection and repair', 5000, 4),
(3, 'Electrical Repair', 'Repair of electrical components', 1500, 2),
(4, 'Brake Service', 'Brake inspection and replacement', 800, 1),
(5, 'Tyre Replacement', 'Replace old tyres with new ones', 1200, 1);


INSERT INTO Service_Records (service_record_id, bike_id, service_type_id, technician_id, service_date, comments, total_cost) VALUES
(1, 1, 1, 101, '2024-01-22', 'Regular maintenance done', 1000),
(2, 2, 3, 102, '2023-11-10', 'Fixed electrical wiring issues', 1500),
(3, 3, 2, 101, '2024-03-20', 'Engine overhaul completed', 5000),
(4, 4, 4, 103, '2024-06-01', 'Brake pads replaced', 800),
(5, 5, 5, 104, '2023-10-15', 'Front tyre replaced', 1200),
(6, 6, 1, 101, '2024-01-15', 'Regular maintenance performed', 900),
(7, 7, 2, 102, '2024-02-05', 'Oil change and filter replacement', 1200),
(8, 8, 3, 103, '2024-03-10', 'Battery replacement completed', 2000),
(9, 9, 4, 104, '2024-04-22', 'Chain lubrication and adjustment', 500),
(10, 10, 5, 101, '2024-05-01', 'General check-up', 700),
(11, 11, 1, 102, '2024-06-15', 'Brake system inspection', 800),
(12, 12, 2, 103, '2024-07-20', 'Tire rotation and balance', 1100),
(13, 13, 3, 104, '2024-08-30', 'Engine diagnostic check', 1500),
(14, 14, 4, 101, '2024-09-05', 'Clutch adjustment done', 900),
(15, 15, 5, 102, '2024-10-18', 'Battery check and replacement', 1800);



INSERT INTO Technicians (technician_id, name, specialization, phone_number, email, experience_years) VALUES
(101, 'Arjun Patel', 'Engine Repair', '9876543120', 'arjun.patel@tvsmotors.com', 5),
(102, 'Priya Nair', 'Electrical Work', '9123456710', 'priya.nair@tvsmotors.com', 3),
(103, 'Manish Kumar', 'Brake Service', '9987654321', 'manish.kumar@tvsmotors.com', 4),
(104, 'Swati Joshi', 'Tyre Replacement', '9876501234', 'swati.joshi@tvsmotors.com', 2);


INSERT INTO Inventory (part_id, part_name, description, unit_cost, quantity_in_stock, supplier_id, last_restocked_date) VALUES
(1, 'Oil Filter', 'Engine oil filter', 200, 50, 201, '2024-01-10'),
(2, 'Brake Pads', 'Front and rear brake pads', 400, 30, 202, '2024-02-15'),
(3, 'Spark Plug', 'Ignition spark plug', 150, 100, 201, '2024-03-01'),
(4, 'Battery', 'Electric bike battery', 5000, 10, 203, '2024-01-25'),
(5, 'Tyre', 'Standard 17-inch tyre', 1200, 20, 204, '2024-02-05');


INSERT INTO Suppliers (supplier_id, name, contact_number, email, address) VALUES
(201, 'Auto Parts Ltd', '9123456789', 'contact@autopartsltd.in', 'Mumbai, Maharashtra'),
(202, 'BrakeMaster Supplies', '9876543210', 'sales@brakemaster.com', 'Delhi, Delhi'),
(203, 'Battery World', '9988776655', 'support@batteryworld.in', 'Bangalore, Karnataka'),
(204, 'TyreHouse', '9898989898', 'info@tyrehouse.com', 'Chennai, Tamil Nadu');


INSERT INTO Payments (payment_id, sale_id, service_record_id, payment_date, amount, payment_method, payment_status) VALUES
(1, 1, NULL, '2024-01-20', 114000, 'Cash', 'Paid'),
(2, 2, NULL, '2023-11-05', 83000, 'Debit Card', 'Paid'),
(3, NULL, 1, '2024-01-22', 1000, 'Cash', 'Paid'),
(4, NULL, 3, '2024-03-20', 5000, 'Cash', 'Pending'),
(5, 5, NULL, '2023-10-10', 140000, 'Debit Card', 'Paid'),
(6, 3, NULL, '2024-03-15', 75000, 'Debit Card', 'Pending'),
(7, 4, NULL, '2024-05-30', 54000, 'Cash', 'Paid'),
(8, NULL, 2, '2023-11-15', 1500, 'UPI', 'Paid'),
(9, NULL, 4, '2024-06-01', 800, 'UPI', 'Paid'),
(10, 6, NULL, '2024-01-15', 130000, 'Debit Card', 'Paid'),
(11, NULL, 5, '2024-03-10', 1200, 'Cash', 'Pending'),
(12, 7, NULL, '2024-04-22', 70000, 'Debit Card', 'Paid'),
(13, NULL, 6, '2024-07-01', 500, 'UPI', 'Paid'),
(14, 8, NULL, '2024-05-10', 69000, 'Cash', 'Paid'),
(15, NULL, 7, '2024-08-25', 2000, 'UPI', 'Paid');



INSERT INTO Feedback (feedback_id, customer_id, sale_id, service_record_id, rating, comments, feedback_date) VALUES
(1, 1, 1, NULL, 5, 'Great service and bike quality!', '2024-01-25'),
(2, 2, 2, NULL, 4, 'Happy with the purchase, but delivery was delayed.', '2023-11-15'),
(3, 2, NULL, 3, 5, 'Excellent service, bike feels new!', '2024-03-25'),
(4, 4, NULL, 4, 3, 'Brake service was satisfactory.', '2024-06-05'),
(5, 5, 5, NULL, 5, 'Love the iQube, fantastic experience!', '2023-10-20'),
(6, 3, 6, NULL, 4, 'Overall good experience, bike is smooth.', '2024-02-05'),
(7, 7, NULL, 2, 5, 'Service was quick and effective!', '2024-04-10'),
(8, 8, NULL, 5, 2, 'Expected better quality after service.', '2024-05-15'),
(9, 9, NULL, 3, 4, 'Bike performance improved significantly after service.', '2024-03-30'),
(10, 1, NULL, NULL, 5, 'The sales staff was very helpful and knowledgeable.', '2024-01-10'),
(11, 9, 7, NULL, 4, 'Great bike, but the color options are limited.', '2024-02-20'),
(12, 10, NULL, 6, 3, 'Satisfactory service, but could be improved.', '2024-06-15'),
(13, 2, NULL, 4, 5, 'Amazing experience with the service team!', '2024-07-01'),
(14, 1, 8, NULL, 4, 'Pleased with the bike performance.', '2024-05-20'),
(15, 3, NULL, 1, 5, 'Love my new bike! Highly recommend!', '2024-08-10');

INSERT INTO Sales_Representatives (sales_rep_id, name, phone_number, email, hire_date, commission_rate) VALUES
(1, 'Amit Sharma', '9876543210', 'amit.sharma@example.com', '2021-04-15', 0.05),
(2, 'Priya Desai', '9823456789', 'priya.desai@example.com', '2022-06-20', 0.04),
(3, 'Rajesh Kumar', '9988776655', 'rajesh.kumar@example.com', '2023-01-10', 0.06),
(4, 'Sneha Verma', '9876512345', 'sneha.verma@example.com', '2020-09-01', 0.03),
(5, 'Vikram Joshi', '9765432109', 'vikram.joshi@example.com', '2019-11-05', 0.07),
(6, 'Meera Patel', '9898765432', 'meera.patel@example.com', '2023-07-18', 0.05);

SELECT * FROM Customers ; 
SELECT * FROM Bike_Models ;
SELECT * FROM Bikes ;
SELECT * FROM Sales ; 
SELECT * FROM Service_Types ;
SELECT * FROM Sales_Representatives ;
SELECT * FROM Service_Records ;
SELECT * FROM Technicians ;
SELECT * FROM Inventory ;
SELECT * FROM Suppliers ;
SELECT * FROM Payments ; 
SELECT * FROM Feedback ; 

DESC Customers ; 
DESC Bike_Models ;
DESC Bikes ;
DESC Sales ; 
DESC Service_Types ;
DESC Sales_Representatives ;
DESC Service_Records ;
DESC Technicians ;
DESC Inventory ;
DESC Suppliers ;
DESC Payments ; 
DESC Feedback ; 

-- find engine capacities greater than 110cc
SELECT *
FROM Bike_Models
WHERE ENGINE_CAPACITY > 110;
		
-- CHANGE CUSTOMER ADD FOR CUST_ID 3?
UPDATE CUSTOMERS
SET ADDRESS = 'MUMBAI,MAHARASHTRA'
WHERE CUSTOMER_ID = 3;

-- List all bike models with their price and fuel type
SELECT model_name, price, fuel_type FROM Bike_Models;

-- Find all bikes purchased in the year 2024
SELECT bike_id, model_id, purchase_date 
FROM Bikes 
WHERE YEAR(purchase_date) = 2024;

-- Get the total sales amount
SELECT SUM(sale_price) AS total_sales FROM Sales;

-- Find all service records for a specific bike (e.g., bike_id = 1)
SELECT * FROM Service_Records WHERE bike_id = 1;

-- List customers who bought bikes with a specific model (e.g., model_id = 5)
SELECT c.name, c.phone_number 
FROM Customers AS c
JOIN Sales AS s ON c.customer_id = s.customer_id
JOIN Bikes AS b ON s.bike_id = b.bike_id
WHERE b.model_id = 5;

-- Get feedback for all services with a rating of 4 or higher
SELECT customer_id, sale_id, service_record_id, rating, comments 
FROM Feedback 
WHERE rating >= 4;

-- Find all technicians with more than 3 years of experience
SELECT * FROM Technicians WHERE experience_years > 3;

-- Show all bike models available in Electric fuel type
SELECT model_name, price 
FROM Bike_Models 
WHERE fuel_type = 'Electric';

-- List out sales representatives hired before 2024
SELECT * FROM Sales_Representatives 
WHERE hire_date < '2023-01-01';

-- Find Sales Representatives with a Commission Rate Above 5%
SELECT name, commission_rate
FROM Sales_Representatives
WHERE commission_rate > 0.05;

-- Count Total Number of Sales Representatives
SELECT COUNT(*) AS total_sales_reps
FROM Sales_Representatives;

-- Find Sales Representative by Phone Number
SELECT *
FROM Sales_Representatives
WHERE phone_number = '9876543210';

-- Update Commission Rate for a Specific Sales Representative
UPDATE Sales_Representatives
SET commission_rate = 0.06
WHERE sales_rep_id = 3;

-- List Sales Representatives and Their Hire Dates in Descending Order
SELECT name, hire_date
FROM Sales_Representatives
ORDER BY hire_date DESC;

-- Find Bikes Available in a Specific Color:
SELECT model_name, available_color_options 
FROM Bike_Models 
WHERE available_color_options LIKE '%Red%';

-- Retrieve Bike Models Launched After a Certain Date:
SELECT model_name, launch_date 
FROM Bike_Models 
WHERE launch_date > '2023-01-01';

-- Count Bikes Sold by Payment Method:
SELECT payment_method, COUNT(*) AS bikes_sold 
FROM Sales 
GROUP BY payment_method;

-- Find the Total Number of Bikes Sold to Each Customer:
SELECT c.name AS customer_name, COUNT(s.sale_id) AS total_bikes_sold 
FROM Customers c
JOIN Sales s ON c.customer_id = s.customer_id 
GROUP BY c.name;

-- Calculate Total Service Costs per Bike:
SELECT b.bike_id, SUM(sr.total_cost) AS total_service_cost 
FROM Bikes b 
JOIN Service_Records sr ON b.bike_id = sr.bike_id 
GROUP BY b.bike_id;

-- Find Customers Who Bought More Than One Bike:
SELECT c.name, COUNT(s.bike_id) AS bikes_purchased 
FROM Customers c
JOIN Sales s ON c.customer_id = s.customer_id 
GROUP BY c.name 
HAVING COUNT(s.bike_id) > 1;

-- Find the bike model with the highest price.
SELECT model_id, model_name, price
FROM Bike_Models
WHERE price = (SELECT MAX(price) FROM Bike_Models);

-- Which customer made the most recent purchase?
SELECT customer_id, name, phone_number, email
FROM Customers
WHERE customer_id = (SELECT customer_id FROM Sales ORDER BY sale_date DESC LIMIT 1);

-- Find the customer who made the highest sale for the most expensive bike model.
SELECT name FROM Customers
WHERE customer_id = 
    (SELECT customer_id FROM Sales
     WHERE sale_price = 
        (SELECT MAX(price)  FROM Bike_Models));

-- Finding the Most Expensive Bike Sold by Each Sales Representative IN DESC ORDER:
SELECT sr.sales_rep_id, sr.name,
       (SELECT MAX(s.sale_price)
        FROM Sales s
        WHERE s.customer_id = sr.sales_rep_id) AS max_sale_price
FROM Sales_Representatives sr
ORDER BY max_sale_price DESC;


-- Finding the Top 3 Most Popular Bike Models Sold
SELECT bm.model_name, COUNT(s.bike_id) AS sales_count
FROM Sales s
JOIN Bikes b ON s.bike_id = b.bike_id
JOIN Bike_Models bm ON b.model_id = bm.model_id
GROUP BY bm.model_name
ORDER BY sales_count DESC
LIMIT 3;

-- retrieves all columns from the Sales table where the sale_price is greater than 1,40,000.
SELECT * FROM Sales WHERE sale_price > 140000;

-- retrieves CUST NAME IN ASC ORDER
SELECT * FROM Customers ORDER BY name ASC;

-- retrieves THE CUSTOMER WHO LIVE IN MAHARASHTRA
SELECT * FROM Customers
WHERE address LIKE '%Maharashtra%';

-- Retrieve all service records along with their service names:
SELECT SR.service_record_id, SR.bike_id, SR.technician_id, SR.service_date, SR.comments, SR.total_cost, ST.service_name
FROM Service_Records SR
JOIN Service_Types ST ON SR.service_type_id = ST.service_type_id;

-- Get all the services performed by a specific technician
SELECT SR.service_record_id, SR.bike_id, SR.service_date, SR.comments, SR.total_cost
FROM Service_Records SR
WHERE SR.technician_id = 101;

-- Find all service records where the total cost is greater than 1500:
SELECT service_record_id, bike_id, service_date, comments, total_cost
FROM Service_Records
WHERE total_cost > 1500;

-- Find the total cost of all services performed in January 2024:
SELECT SUM(total_cost) AS total_cost_in_january
FROM Service_Records
WHERE service_date BETWEEN '2024-01-01' AND '2024-01-31';

-- Find the number of services performed for each service type:
SELECT ST.service_name, COUNT(SR.service_record_id) AS service_count
FROM Service_Records SR
JOIN Service_Types ST ON SR.service_type_id = ST.service_type_id
GROUP BY ST.service_name;

-- Get all records where the service cost is less than 1000:
SELECT service_record_id, bike_id, service_date, comments, total_cost
FROM Service_Records
WHERE total_cost < 1000;

-- Find the most expensive service performed (maximum total cost):
SELECT service_record_id, bike_id, service_type_id, technician_id, service_date, comments, total_cost
FROM Service_Records
WHERE total_cost = (SELECT MAX(total_cost) FROM Service_Records);

-- Find all services where the service date is after March 1, 2024:
SELECT service_record_id, bike_id, service_type_id, technician_id, service_date, comments, total_cost
FROM Service_Records
WHERE service_date > '2024-03-01' LIMIT 5;

-- Find the service records for bikes serviced by technician 102:
SELECT SR.service_record_id, SR.bike_id, SR.service_date, SR.comments, ST.service_name
FROM Service_Records SR
JOIN Service_Types ST ON SR.service_type_id = ST.service_type_id
WHERE SR.technician_id = 102;
