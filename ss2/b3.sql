SELECT e.*,d.*
FROM employees AS e
INNER JOIN departments AS d
ON e.DepartmentID = d.DepartmentID;

UPDATE employees 
Set salary = salary * 1.1
WHERE DepartmentID = 1;

DELETE FROM Employees
WHERE Salary < 300000; 
