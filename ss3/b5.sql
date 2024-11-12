INSERT INTO Students (StudentID, StudentName, Major)
VALUES 
(1, 'David', 'Computer Science'),
(2, 'Eve', 'Mathematics'),
(3, 'Frank', 'Physics'),
(4, 'Grace', 'Biology');

INSERT INTO Courses (CourseID, CourseName, istructor)
VALUES 
(1, 'Intro to Computer Science', 'Dr. Smith'),
(2, 'Calculus I', 'Dr. Brown'),
(3, 'Modern Physics', 'Dr. White'),
(4, 'Organic Chemistry', 'Dr. Black');

UPDATE Courses
SEt CourseName ='Advanced Mathematics'
WHERE CourseID = 2;

UPDATE Students
SET Major='Engineering'
WHERE StudentID = 3;

DELETE FROM Students
WHERE StudentID = 1;

DELETE FROM Courses
WHERE CourseID = 3;

SELECT * FROM Students;
SELECT * FROM Courses;