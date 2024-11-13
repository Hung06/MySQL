CREATE TABLE Suppliers (
    SupplierID INT PRIMARY KEY,
    SupplierName VARCHAR(255) Not NULL,
    contactEmail VARCHAR(255) Not NULL
);

CREATE TABLE Products(
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(255) Not NULL,
    Price DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL,
    SupplierID INT,
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID)
);

INSERT INTO Suppliers (SupplierID, SupplierName, contactEmail)
VALUES 
(1, 'Supplier A', '1@gmail.com'),
(2, 'Supplier B', '2@gmail.com'),
(3, 'Supplier C', '3@gmail.com');

INSERT INTO Products (ProductID, ProductName, Price, stock, SupplierID)
VALUES 
(1, 'Product A', 100, 10, 1),
(2, 'Product B', 200, 20, 2),
(3, 'Product C', 300, 30, 3),
(4, 'Product D', 400, 40, 1);

UPDATE Products
SET Price =45.99
WHERE ProductID = 2;

UPDATE Suppliers
SET SupplierName ='Supplier D'
WHERE SupplierID = 1;


DELETE FROM Suppliers
WHERE SupplierID = 3;

DELETE FROM Products
WHERE ProductID = 4;

SELECT p.*, s.*
FROM Products p 
JOIN Suppliers s ON p.SupplierID = s.SupplierID;
GROUP BY p.ProductID;