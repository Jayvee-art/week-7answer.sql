-- ==========================================
-- Question 1: Achieving First Normal Form (1NF)
-- ==========================================

CREATE TABLE ProductDetail (
    OrderID INT,
    CustomerName VARCHAR(100),
    Products VARCHAR(255)
);

INSERT INTO ProductDetail (OrderID, CustomerName, Products) VALUES
(101, 'John Doe', 'Laptop, Mouse'),
(102, 'Jane Smith', 'Tablet, Keyboard, Mouse'),
(103, 'Emily Clark', 'Phone');

-- Transform to 1NF using JSON_TABLE (MySQL 8.0+)
SELECT 
    OrderID,
    CustomerName,
    TRIM(product) AS Product
FROM (
    SELECT 
        OrderID,
        CustomerName,
        JSON_TABLE(
            CONCAT('["', REPLACE(Products, ', ', '","'), '"]'),
            "$[*]" COLUMNS(product VARCHAR(100) PATH "$")
        ) AS jt
    FROM ProductDetail
) AS normalized_data;

-- ==========================================
-- Question 2: Achieving Second Normal Form (2NF)
-- ==========================================

CREATE TABLE OrderDetails (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(100),
    Quantity INT
);

INSERT INTO OrderDetails (OrderID, CustomerName, Product, Quantity) VALUES
(101, 'John Doe', 'Laptop', 2),
(101, 'John Doe', 'Mouse', 1),
(102, 'Jane Smith', 'Tablet', 3),
(102, 'Jane Smith', 'Keyboard', 1),
(102, 'Jane Smith', 'Mouse', 2),
(103, 'Emily Clark', 'Phone', 1);

-- Normalize into Customers and OrderProductDetails

CREATE TABLE Customers (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

INSERT INTO Customers (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails;

CREATE TABLE OrderProductDetails (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Customers(OrderID)
);

INSERT INTO OrderProductDetails (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity
FROM OrderDetails;

-- ==========================================
-- Question 3: Achieving Third Normal Form (3NF)
-- ==========================================

-- Create Suppliers table
CREATE TABLE Suppliers (
    SupplierName VARCHAR(100) PRIMARY KEY,
    SupplierContact VARCHAR(15)
);

INSERT INTO Suppliers (SupplierName, SupplierContact)
VALUES
('TechStore', '0712345678'),
('GadgetWorld', '0798765432'),
('MobileMart', '0788888888');

-- Update OrderProductDetails to include SupplierName as FK
DROP TABLE OrderProductDetails;

CREATE TABLE OrderProductDetails (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT,
    SupplierName VARCHAR(100),
    FOREIGN KEY (OrderID) REFERENCES Customers(OrderID),
    FOREIGN KEY (SupplierName) REFERENCES Suppliers(SupplierName)
);

INSERT INTO OrderProductDetails (OrderID, Product, Quantity, SupplierName)
VALUES
(101, 'Laptop', 2, 'TechStore'),
(101, 'Mouse', 1, 'TechStore'),
(102, 'Tablet', 3, 'GadgetWorld'),
(102, 'Keyboard', 1, 'GadgetWorld'),
(103, 'Phone', 1, 'MobileMart');
