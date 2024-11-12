CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(255) Not NULL,
    Age INT CHECK (Age >= 0) Not NULL,
    Major VARCHAR(255) Not NULL
);
INSERT INTO Students (StudentID, StudentName, Age, Major) 
VALUES 
(1, 'Alice', 20, 'Computer Science'),
(2, 'Bob', 21, 'Mathematics'),
(3, 'Charlie', 22, 'Physics');

UPDATE Students
SET Age = 23
WHERE StudentID = 2;

DELETE FROM Students
WHERE StudentID = 1;

SELECT * FROM Students;

