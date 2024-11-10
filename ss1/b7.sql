CREATE TABLE Guest (
    GuestID INT PRIMARY KEY,
    `Name` VARCHAR(255),
    Email VARCHAR(255)
);
CREATE TABLE room (
    RoomID INT PRIMARY KEY,
    GuestID INT,
    `type` VARCHAR(255),
    Price DECIMAL(10,2),
    FOREIGN KEY (GuestID) REFERENCES Guest(GuestID)
);
CREATE TABLE Reservation {
    ReservationID INT PRIMARY KEY,
    RoomID INT,
    GuestID INT,
    CheckIn DATE,
    CheckOut DATE,
    FOREIGN KEY (RoomID) REFERENCES Room(RoomID),
    FOREIGN KEY (GuestID) REFERENCES Guest(GuestID)
};
CREATE TABLE `Service`( 
    ServiceID INT PRIMARY KEY,
    `Name` VARCHAR(255),
    Price DECIMAL(10,2)
);
CREATE TABLE ServiceUsage (
    ServiceUsageID INT PRIMARY KEY,
    ServiceID INT,
    ReservationID INT,
    Date DATE,
    FOREIGN KEY (ServiceID) REFERENCES `Service`(ServiceID),
    FOREIGN KEY (ReservationID) REFERENCES Reservation(ReservationID)
);