INSERT INTO Products (ProductID, ProductName, Category, Price, StockQuantity)
VALUES
    (1, 'Apple', 'Fruit', 1.00, 100),
    (2, 'Banana', 'Fruit', 0.50, 200),
    (3, 'Orange', 'Fruit', 0.75, 150);  
INSERT INTO Orders (OrderID, ProductID, OrderDate, Quantity,TotalAmount)
VALUES
    (1, 1, '2020-01-01', 10, 10.00),
    (2, 2, '2020-01-02', 20, 10.00),
    (3, 3, '2020-01-03', 30, 10.00);

UPDATE Products
SET Price = 10
WHERE ProductID = 1;    

UPDATE Orders
SET TotalAmount = o.Quantity * p.Price
FROM Orders AS o
JOIN Products AS p ON o.ProductID = p.ProductID;

SELECT * FROM Orders;
SELECT * FROM Products; 
