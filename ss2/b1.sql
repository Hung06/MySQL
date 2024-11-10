CREATE DATABASE CompanyDB;
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(255),
    LastName VARCHAR(255),
    HireDate DATE,
    Salary DECIMAL(10,2)
);

ALTER TABLE Employees
ADD COLUMN Department VARCHAR(255);

ALTER TABLE Employees
ALTER COLUMN Salary DECIMAL(10, 2);

