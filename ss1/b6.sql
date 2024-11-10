CREATE TABLE Event (
    EventID INT PRIMARY KEY,
    `Name` VARCHAR(255),
    `Date` DATE,
    `Address` VARCHAR(255),
    budget DECIMAL(10,2),
);
CREATE TABLE Attendee (
    AttendeeID INT PRIMARY KEY,
    EventID INT,
    Name VARCHAR(255),
    Email VARCHAR(255),
    FOREIGN KEY (EventID) REFERENCES Event(EventID)
);
CREATE TABLE Sponsor (
    SponsorID INT PRIMARY KEY,
    EventID INT,
    Name VARCHAR(255),
    Email VARCHAR(255),
    funding DECIMAL(10,2),
    FOREIGN KEY (EventID) REFERENCES Event(EventID)
);  