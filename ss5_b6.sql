-- Tạo bảng nhân viên
CREATE TABLE Employee (
    employee_id INT PRIMARY KEY,
    name VARCHAR(255),
    age INT,
    salary DECIMAL(10, 2)
);

-- Tạo bảng bộ phận
CREATE TABLE Department (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(255) UNIQUE
);

-- Tạo bảng liên kết nhân viên và bộ phận
CREATE TABLE Employee_Department (
    employee_id INT,
    department_id INT,
    PRIMARY KEY (employee_id, department_id),
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id),
    FOREIGN KEY (department_id) REFERENCES Department(department_id)
);


-- a. 
-- Viết câu lệnh SQL để liệt kê tất cả các nhân viên trong bộ phận có tên là "Kế toán". Kết quả cần hiển thị mã nhân viên và tên nhân viên.


SELECT e.employee_id, e.name
FROM Employee AS e
JOIN Employee_Department AS ed ON e.employee_id = ed.employee_id
JOIN Department AS d ON ed.department_id = d.department_id
WHERE d.department_name = 'Kế toán';

-- b.
-- Viết câu lệnh SQL để tìm các nhân viên có mức lương lớn hơn 50,000. Kết quả trả về cần bao gồm mã nhân viên, tên nhân viên và mức lương.
SELECT employee_id, name, salary
FROM Employee
WHERE salary > 50000;


-- c.
-- Viết câu lệnh SQL để hiển thị tất cả các bộ phận và số lượng nhân viên trong từng bộ phận. Kết quả trả về cần bao gồm tên bộ phận và số lượng nhân viên.

SELECT d.department_name, COUNT(ed.employee_id) AS num_employees
FROM Department AS d
LEFT JOIN Employee_Department AS ed ON d.department_id = ed.department_id
GROUP BY d.department_name;

-- d.
-- Viết câu lệnh SQL để tìm ra các thành viên có mức lương cao nhất theo từng bộ phận. Kết quả trả về là một danh sách theo bất cứ thứ tự nào. Nếu có nhiều nhân viên bằng lương nhau nhưng cũng là mức lương cao nhất thì hiển thị tất cả những nhân viên đó ra.
SELECT d.department_name, e.employee_id, e.name, e.salary
FROM Department AS d
JOIN Employee_Department AS ed ON d.department_id = ed.department_id
JOIN Employee AS e ON ed.employee_id = e.employee_id
WHERE e.salary = (
    SELECT MAX(e2.salary)
    FROM Employee_Department AS ed2
    JOIN Employee AS e2 ON ed2.employee_id = e2.employee_id
    WHERE ed2.department_id = d.department_id
);

-- e.
-- Viết câu lệnh SQL để tìm các bộ phận có tổng mức lương của nhân viên vượt quá 100,000 (hoặc một mức tùy chọn khác). Kết quả trả về bao gồm tên bộ phận và tổng mức lương của bộ phận đó.
SELECT d.department_name, SUM(e.salary) AS total_salary
FROM Department AS d
JOIN Employee_Department AS ed ON d.department_id = ed.department_id
JOIN Employee AS e ON ed.employee_id = e.employee_id
GROUP BY d.department_name
HAVING SUM(e.salary) > 100000;

-- f.
-- Viết câu lệnh SQL để liệt kê tất cả các nhân viên làm việc trong hơn 2 bộ phận khác nhau. Kết quả cần hiển thị mã nhân viên, tên nhân viên và số lượng bộ phận mà họ tham gia.
SELECT e.employee_id, e.name, COUNT(ed.department_id) AS department_count
FROM Employee AS e
JOIN Employee_Department AS ed ON e.employee_id = ed.employee_id
GROUP BY e.employee_id, e.name
HAVING COUNT(ed.department_id) > 2;

