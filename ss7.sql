USE dml;
DROP PROCEDURE timarchitect;

DELIMITER $$

CREATE PROCEDURE timarchitect()
BEGIN 
	SELECT * From architect WHERE sex =@gender;
END $$
DELIMITER ;
CALL timarchitect();
DELIMITER $$
CREATE PROCEDURE timarchitect2()
BEGIN
	SELECT b.name , b.city ,a.sex,a.name As aname
	From building AS b
	JOIN design AS d
	ON d.building_id=b.id
	JOIN architect AS a
	ON a.id=d.architect_id
	WHERE a.sex =0;
END$$
DELIMITER ;
CALL timarchitect2();

SET @gender=1;
SELECT @gender;


DELIMITER $$

CREATE PROCEDURE timarchitect()
BEGIN 
	DECLARE localvaliable INT DEFAULT 0;
    
	SELECT Sum(d.benefit) INTO localvaliable
	From design d
	JOIN architect a
	ON a.id= d.architect_id
	WHERE a.sex=@gender;
    
    SELECT localvaliable AS SUMbenefit;
END $$
DELIMITER ;
CALL timarchitect();