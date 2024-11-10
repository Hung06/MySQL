CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(255),
    Address VARCHAR(255),
    Email VARCHAR(255)
);
CREATE TABLE Car (
    CarID INT PRIMARY KEY,
    CustomerID INT,
    Make VARCHAR(255),
    Model VARCHAR(255),
    Price DECIMAL(10,2),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);
CREATE TABLE Rental (
    RentalID INT PRIMARY KEY,
    CarID INT,
    CustomerID INT,
    RentalDate DATE,
    ReturnDate DATE,
    Price DECIMAL(10,2),
    FOREIGN KEY (CarID) REFERENCES Car(CarID),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);