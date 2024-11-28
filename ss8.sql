SELECT * FROM dml.architect;
use dml;
-- Tạo 1 thủ tục có tên là checkmaleexist
-- thủ tục này sẽ kiểm tra trong bảng architect nếu tồn tại cá architect có giới tính =1 
--  thì trả veef một kết quả là :" Tồn tại"
--  nếu không tồn tại các architect có giới tính = 1
--  thì trả về một kết quả là " không tồn tại"
 DELIMITER $$
 CREATE PROCEDURE checkmaleexist(OUT exist varchar(50) )
 BEGIN
	DECLARE countmale INT DEFAULT 0;
	SELECT count(*) INTO countmale From architect
    WHERE sex = 1;
    IF countmale > 0 Then
		SET exist = 'Tồn tại ';
	ELSE 
		SET exist="Không tồn tại ";
	END IF;
 END $$
 DELIMITER ;
 
 CALL checkmaleexist(@a);
 
 SELECT @a;
 
 CREATE database phenikaaEmployee;
 use phenikaaEmployee;
CREATE TABLE Employee(
id INT AUTO_INCREMENT PRIMARY KEY not null,
name VARCHAR(20) not null,
gender VARCHAR(10),
email VARCHAR(50)
);
DELIMITER $$
 CREATE PROCEDURE autoInsertEmployee()
 BEGIN
	DECLARE i INT DEFAULT 1;
    LOOP_LABEL: LOOP
		INSERT INTO Employee(id,name,gender,email)
		VALUES (i, CONCAT('abc-', i), NULL, CONCAT('abc', i, '@gmail.com'));
		SET i=i+1;
        IF i>=101 THEN
			LEAVE LOOP_LABEL;
		END IF;
	END LOOP LOOP_LABEL;
 END $$
 DELIMITER ;
 CALL autoInsertEmployee;
 DELIMITER $$
 CREATE PROCEDURE autoInsertEmployee2()
 BEGIN
	DECLARE i INT DEFAULT 1;
    WHILE i<=101 DO
		INSERT INTO Employee(id,name,gender,email)
		VALUES (i, CONCAT('abc-', i), NULL, CONCAT('abc', i, '@gmail.com'));
		SET i=i+1;
	END WHILE;
 END $$
 DELIMITER ;
 CALL autoInsertEmployee2;
 
 DELIMITER $$
  CREATE PROCEDURE autoInsertEmployee3()
 BEGIN
	DECLARE i INT DEFAULT 1;
    DECLARE maxid int DEFAULT 0;
    SELECT max(id) INTO maxid From employee;
    if(maxid is NULL) Then
		SEt maxid=0;
	END if;
    REPEAT
		INSERT INTO Employee(id,name,gender,email)
		VALUES (maxid+i, CONCAT('abc-', maxid+i), NULL, CONCAT('abc', maxid+i, '@gmail.com'));
		SET i=i+1;
	UNTIL i >=101
    END REPEAT;
 END $$
 DELIMITER ;
 CALL autoInsertEmployee3;
 
 
 
 
 
 CREATE TABLE employee_log(
 id int AUTO_INCREMENT PRIMARY key,
 content varchar(50),
 count int 
 );
 
DELIMITER $$
 CREATE TRIGGER saveEmployeeNumbter
 AFTER INSERT
 ON `employee`
 FOR EACH ROW
 BEGIN
 DECLARE count INt DEFAULT 0;
 DECLARE log_id INT DEFAULT 0;
 SELECT MAX(id)
 INTO log_id
 FROM employee;
 SELECT count(*)
 INTO count
 From employee;
 INSERT INTO employee_log(id, content , count) VALUES(log_id,'Thành công',count);
END $$
 DELIMITER ;
 
 SHOW TRIGGERS;
 DROP TRIGGER saceEmployeeNumbter;
 INSERT INTO employee(id, name , gender,email)
 VALUES(101,'abc-101',NULL,'abc101@gmail.com');
 
--  Tạo 1 trigger before insert 
--  checkExceedLimit
--  Trigger có tác dụng kiểm tra xem số lượng bản ghi hiện tại có trong bảng có vượt quá 120 hay không 
--  Nếu có thì không cho insert vào trong bảng employee và hiển thị "Vượt giới hạn"

DELIMITER $$
 CREATE TRIGGER checkExceedLimit
BEFORE INSERT
ON employee
FOR EACH ROW
BEGIN
	DECLARE count INt DEFAULT 0;
    SELECT count(*) 
    INTO count
    From employee;
    IF count >102 Then
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Qua gioi han';
    END IF;
END $$
 DELIMITER ;
DRop TRigger checkExceedLimit;
 INSERT INTO employee(id, name , gender,email)
 VALUES(104,'abc-104',NULL,'abc104@gmail.com');
