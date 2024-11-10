use ss4;
-- Alisases bí danh , đặt lại tên cho cột
SELECT `name` AS `Họ và tên`, address AS `Địa chỉ` FROM `host`; 

SELECT MAX(birthday) AS `Nam Sinh lon nhat` FROM architect;
SELECT MIN(birthday) AS `Nam Sinh be nhat` FROM architect;


SELECT COUNT(address) AS `KTS có địa chỉ` FROM architect;
SELECT AVG(cost) AS `Doanh thu trung bình`FROM architect;
SELECT `place` AS `thanh pho` , count(id) FROM architect
GROUP BY `place`
HAVING count(id)>=2;

SELECT * FROM building 
WHERE cost <(SELECT MAX(cost) FROM building);

SELECT * FROM building
WHERE cost > ALL (
SELECT cost FROM building
WHERE city='ha noi');

SELECT * FROM worker
WHERE birthday < all ( SELECT birthday from architect);

SELECT * FROM building
WHERE id IN(SELECT DISTINCT building_id FROM design);

SELECT b.id , b.`name`,h.`name`
FROM building AS b
Right JOIN `host` AS h
ON b.host_id = h.id;