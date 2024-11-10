CREATE TABLE Product (
    ProductID INT PRIMARY KEY,
    Name VARCHAR(255),
    type VARCHAR(255),
    Price DECIMAL(10,2)
);
CREATE TABLE Warehouse (
    WarehouseID INT PRIMARY KEY,
    Name VARCHAR(255),
    Address VARCHAR(255)
);
CREATE TABLE Stock (
    StockID INT PRIMARY KEY,
    ProductID INT,
    WarehouseID INT,
    Quantity INT,
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
    FOREIGN KEY (WarehouseID) REFERENCES Warehouse(WarehouseID)
);
CREATE TABLE Order (
    OrderID INT PRIMARY KEY,
    StockID INT,
    OrderDate DATE,
    shipDate DATE,
    Price INT,
    FOREIGN KEY (StockID) REFERENCES Stock(StockID)
);