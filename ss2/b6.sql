CREATE TABLE Customers(
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(255),
    phone VARCHAR(255),
    Email VARCHAR(255)
);
CREATE TABLE Orderdetails(
    OrderdetailsID INT PRIMARY KEY,
    OrderID INT ,
    ProductID INT,
    Quantity INT,
    UnitPrice DECIMAL(10,2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
);
CREATE TABLE Orders(
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
    FOREIGN KEY (OrderID) REFERENCES Orderdetails(OrderID)
);

INSERT INTO Customers(CustomerID, CustomerName, phone, Email) 
VALUES
(1, 'John Doe', '1234567890', '1@gmail.com'),
(2, 'Jane Doe', '0987654321', '2@gmail.com');

INSERT INTO Orders(OrderID, CustomerID, OrderDate)
VALUES
(1, 1, '2020-01-01'),
(2, 2, '2020-01-02'),
(3, 1, '2020-01-03');

INSERT INTO Orderdetails(OrderdetailsID, OrderID, ProductID, Quantity, UnitPrice)
VALUES
(1, 1, 1, 10, 1.00),
(2, 1, 2, 20, 0.50),
(3, 2, 1, 5, 1.00),
(4, 3, 2, 10, 0.50),
(5, 3, 3, 15, 0.75);


UPDATE Customers
SET phone = '1234567890'
WHERE CustomerID = 1;

DELETE o
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

SELECT c.*, COUNT(o.order_id) AS order_count
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id;

SELECT * FROM Orderdetails
GROUP BY OrderID;
