CREATE TABLE Project (
    ProjectID INT PRIMARY KEY,
    `Name` VARCHAR(255),
    startDate DATE,
    endDate DATE,
    Budget DECIMAL(10,2)
);
CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    `Name` VARCHAR(255),
    position VARCHAR(255),
);
CREATE TABLE Assignment (
    AssignmentID INT PRIMARY KEY,
    ProjectID INT,
    EmployeeID INT,
    startDate DATE,
    endDate DATE,
    FOREIGN KEY (ProjectID) REFERENCES Project(ProjectID),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);
CREATE TABLE Task (
    TaskID INT PRIMARY KEY,
    `Name` VARCHAR(255),
    startDate DATE,
    endDate DATE,
    ProjectID INT,
    FOREIGN KEY (ProjectID) REFERENCES Project(ProjectID),
);