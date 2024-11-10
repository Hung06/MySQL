CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(255),
    Category VARCHAR(255),
    Price DECIMAL(10, 2),
    StockQuantity INT
);

INSERT INTO Products (ProductID, ProductName, Category, Price, StockQuantity) 
VALUES 
    (1, 'Apple', 'Fruit', 1.00, 100),
    (2, 'Banana', 'Fruit', 0.50, 200),
    (3, 'Orange', 'Fruit', 0.75, 150);
