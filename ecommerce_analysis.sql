CREATE DATABASE ecommerce_analysis;
USE ecommerce_analysis;
SELECT DATABASE();
CREATE TABLE customers (
customer_id INT PRIMARY KEY,
customer_name VARCHAR(100),
city VARCHAR(50),
state VARCHAR(50),
country VARCHAR(50)
);
DESCRIBE customer;
DESCRIBE customers;
CREATE TABLE orders(
order_id INT PRIMARY KEY,
customer_id INT,
order_date DATE,
total_amount DECIMAL(10,2),
order_status VARCHAR(30),
FOREIGN KEY(customer_id)
REFERENCES customers(customer_id)
);
CREATE TABLE products(
product_id INT PRIMARY KEY,
product_name VARCHAR(100),
category VARCHAR(50),
price DECIMAL(10,2),
stock_quantity INT 
);
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price DECIMAL(10,2),
    FOREIGN KEY (order_id)
        REFERENCES orders(order_id),
    FOREIGN KEY (product_id)
        REFERENCES products(product_id)
);
SHOW TABLES;
INSERT INTO customers
(customer_id, customer_name, city, state, country)
VALUES
(1, 'Arun', 'Chennai', 'Tamil Nadu', 'India'),
(2, 'Priya', 'Coimbatore', 'Tamil Nadu', 'India'),
(3, 'Karthik', 'Bangalore', 'Karnataka', 'India'),
(4, 'Divya', 'Salem', 'Tamil Nadu', 'India'),
(5, 'Rahul', 'Mumbai', 'Maharashtra', 'India');
SELECT * FROM customers;
INSERT INTO orders
(order_id, customer_id, order_date, total_amount, order_status)
VALUES
(101, 1, '2026-01-05', 2500.00, 'Delivered'),
(102, 2, '2026-01-08', 1500.00, 'Delivered'),
(103, 3, '2026-01-10', 3200.00, 'Pending'),
(104, 4, '2026-01-12', 1800.00, 'Shipped'),
(105, 5, '2026-01-15', 4500.00, 'Delivered');
INSERT INTO products
(product_id, product_name, category, price, stock_quantity)
VALUES
(201, 'Laptop', 'Electronics', 45000.00, 20),
(202, 'Mobile Phone', 'Electronics', 18000.00, 35),
(203, 'Headphones', 'Electronics', 1500.00, 50),
(204, 'Keyboard', 'Accessories', 800.00, 40),
(205, 'Mouse', 'Accessories', 500.00, 60),
(206, 'Office Chair', 'Furniture', 5500.00, 15),
(207, 'Table', 'Furniture', 7000.00, 10),
(208, 'Backpack', 'Bags', 1200.00, 30),
(209, 'Shoes', 'Fashion', 2500.00, 25),
(210, 'Watch', 'Fashion', 3200.00, 18);
SELECT * FROM products;
INSERT INTO order_items
(order_item_id, order_id, product_id, quantity, unit_price)
VALUES
(1, 101, 201, 1, 45000.00),
(2, 101, 203, 2, 1500.00),
(3, 102, 202, 1, 18000.00),
(4, 102, 205, 2, 500.00),
(5, 103, 204, 2, 800.00),
(6, 103, 206, 1, 5500.00),
(7, 104, 208, 1, 1200.00),
(8, 104, 209, 1, 2500.00),
(9, 105, 210, 1, 3200.00),
(10, 105, 207, 1, 7000.00);
SELECT
    c.customer_name,
    o.order_id,
    o.order_date,
    p.product_name,
    oi.quantity,
    oi.unit_price
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN products p
    ON oi.product_id = p.product_id;
    SELECT
    SUM(total_amount) AS total_sales
FROM orders;
SELECT
    order_status,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY order_status;
SELECT
    c.customer_name,
    SUM(o.total_amount) AS total_purchase
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_name
ORDER BY total_purchase DESC;
SELECT
    p.product_name,
    SUM(oi.quantity) AS total_quantity_sold
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.product_name
ORDER BY total_quantity_sold DESC;
SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS sales_month,
    SUM(total_amount) AS monthly_sales
FROM orders
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY sales_month;
SELECT
    p.category,
    SUM(oi.quantity * oi.unit_price) AS category_revenue
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.category
ORDER BY category_revenue DESC;
SELECT
    c.customer_name,
    SUM(o.total_amount) AS total_purchase
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_name
ORDER BY total_purchase DESC
LIMIT 3;
SELECT
    COUNT(order_id) AS total_orders,
    SUM(total_amount) AS total_sales,
    AVG(total_amount) AS average_order_value
FROM orders;
SELECT
    order_status,
    SUM(total_amount) AS total_revenue
FROM orders
GROUP BY order_status
ORDER BY total_revenue DESC;
