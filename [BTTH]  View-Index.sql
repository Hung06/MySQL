CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(255) Not NULL,
    contactEmail VARCHAR(255) Not NULL,
    country VARCHAR(255) Not NULL
);
CREATE TABLE Oders(
    OrderID INT PRIMARY KEY,
    OrderDate DATE NOT NULL,
    CustomerID INT,
    TotalAmount DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);
CREATE TABLE Products(
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(255) Not NULL,
    Price DECIMAL(10,2) NOT NULL
);
 CREATE TABLE OrderDetails(
    OrderDetailsID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Oders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

CREATE VIEW TTdonhang AS
SELECT * From Oders;

CREATE VIEW CTdonhang AS
SELECT * From OrderDetails;

CREATE INDEX CustomerID_index ON Oders (CustomerID);

CREATE INDEX OrderID_index ON OrderDetails (OrderID);