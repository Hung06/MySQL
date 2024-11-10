CREATE TABLE Sales(
    SalesID INT PRIMARY KEY,
    SaleDate DATE,
    CustomerID INT,
    TotalAmount DECIMAL(10,2) CHECK (TotalAmount >= 0),
);
CREATE TABLE SalesDetails(
    SalesDetailsID INT PRIMARY KEY,
    SalesID INT,
    ProductID INT,
    Quantity INT,
    UnitPrice DECIMAL(10,2),
    FOREIGN KEY (SalesID) REFERENCES Sales(SalesID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
CREATE TABLE Products(
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(255),
    Category VARCHAR(255),
    Price DECIMAL(10,2)
);
SELECT 
    p.Category,
    SUM(sd.Quantity * sd.UnitPrice) AS TotalRevenue
FROM Sales s
JOIN SalesDetails sd ON s.SalesID = sd.SalesID
JOIN Products p ON sd.ProductID = p.ProductID
WHERE s.SaleDate >= DATE_SUB(CURDATE(), INTERVAL 3 MONTH)
GROUP BY p.Category
ORDER BY TotalRevenue DESC
LIMIT 1;