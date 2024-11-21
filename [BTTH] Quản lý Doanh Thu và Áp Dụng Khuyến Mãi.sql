CREATE DATABASE SalesDB;

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(255) Not NULL,
    LastName VARCHAR(255) Not NULL,
    Email VARCHAR(255) Not NULL
);
CREATE TABLE Product(
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(255) Not NULL,
    Price DECIMAL(10,2) NOT NULL
);
CREATE TABLE Oders(
    OrderID INT PRIMARY KEY,
    OrderDate DATE NOT NULL,
    CustomerID INT,
    TotalAmount DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);
CREATE TABLE Promotions (
    PromotionID INT PRIMARY KEY,
    PromotionName VARCHAR(255) Not NULL,
    DiscountPercentage  DECIMAL(10,2) NOT NULL
);
CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    OrderID INT,
    SaleDate DATE NOT NULL,
    SaleAmount DECIMAL(10,2) NOT NULL,
);

--Tính tổng doanh thu hàng tháng cho từng khách hàng.
--Nếu tổng doanh thu của một khách hàng vượt qua revenueThreshold, áp dụng khuyến mãi bằng cách thêm một bản ghi vào bảng Promotions.

DELIMITER $$
CREATE PROCEDURE CalculateMonthlyRevenueAndApplyPromotion(IN monthYear VARCHAR, IN revenueThreshold DECIMAL)
Begin 
    DECLARE FirstName VARCHAR ;
    SELECT c.FirstName INTO FirstName
    From Oders o
    Join Customers c
    ON o.CustomerID = c.CustomerID
    WHERE MONTH(OrderDate) like monthYear
    GROUP BY CustomerID
    HAVING SUM(TotalAmount) > revenueThreshold;
    SELECT c.
END$$
DELIMITER ;
CALL CalculateMonthlyRevenueAndApplyPromotion('2024-07', 5000);