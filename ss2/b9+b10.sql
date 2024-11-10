CREATE DATABASE ECommerceDB ;
CREATE TABLE Users(
    UserID INT PRIMARY KEY,
    UserName VARCHAR(255) Not NULL UNIQUE ,
    Email VARCHAR(255) Not NULL UNIQUE ,
    PasswordHash VARCHAR(255) NOT NULL ,
    Createat DATE
);
CREATE TABLE Orders(
    OrderID INT PRIMARY KEY,
    UserID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10,2) CHECK (TotalAmount >= 0) Not NULL,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)   
);
CREATE TABLE Productsd(s
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(255) Not NULL,
    Description VARCHAR(255),
    Price DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL
);
CREATE TABLE Reviews(
    ReviewID INT PRIMARY KEY,
    ProductID INT,
    UserID INT,
    Rating INT CHECK (Rating >= 1 AND Rating <= 5) Not NULL,
    Reviewtext VARCHAR(255),
    Createat DATE,
    FOREIGN KEY (ProductID) REFERENCES Productsd(ProductID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);
CREATE TABLE Orderdetails(
    OrderDetailsID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT NOT NULL CHECK (Quantity >= 0),
    PriceAtOrder DECIMAL(10,2) NOT NULL CHECK (PriceAtOrder >= 0),  
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Productsd(ProductID)
);

