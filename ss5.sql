use sqlnangcao;

-- B2 
ALTER TABLE `building`
ADD CONSTRAINT `fk_host_id` 
FOREIGN KEY (`host_id`) REFERENCES `host`(`id`);
ALTER TABLE `building`
ADD CONSTRAINT `fk_contractor_id` 
FOREIGN KEY (`contractor_id`) REFERENCES `contractor`(`id`);
ALTER TABLE `work`
ADD CONSTRAINT `fk_building_id`
FOREIGN KEY (building_id) REFERENCES building(id);
ALTER TABLE `work`
ADD CONSTRAINT `fk_worker_id`
FOREIGN KEY (worker_id) REFERENCES worker(id);
ALTER TABLE design
ADD CONSTRAINT `fk_buildingd_id`
FOREIGN KEY(building_id) REFERENCES  building(id);
ALTER TABLE design
ADD CONSTRAINT `fk_architect_id`
FOREIGN KEY(architect_id) REFERENCES  architect(id);

-- B3
-- Hiển thị thông tin công trình có chi phí cao nhất
-- Hiển thị thông tin công trình có chi phí lớn hơn tất cả các công trình được xây dựng ở Cần Thơ
-- Hiển thị thông tin công trình có chi phí lớn hơn một trong các công trình được xây dựng ở Cần Thơ
-- Hiển thị thông tin công trình chưa có kiến trúc sư thiết kế
-- Hiển thị thông tin các kiến trúc sư cùng năm sinh và cùng nơi tốt nghiệp

SELECT * FROM building
WHERE cost = (SELECT MAX(cost) AS cost FROM building);

SELECT * FROM building
WHERE cost > ALL (SELECT cost FROM building WHERE city ='can tho');

SELECT * FROM building
WHERE  city <> 'can tho' AND cost > ANY (SELECT cost FROM building WHERE city ='can tho') ;

SELECT * FROM building as b
JOIN design AS d
ON d.building_id=b.id
WHERE architect_id =NULL;

SELECT * FROM architect
WHERE (birthday,place) IN (
SELECT birthday,place
FROM architect
GROUP BY birthday,place
HAVING count(*)>1
);

-- B4
-- Hiển thị thù lao trung bình của từng kiến trúc sư
SELECT architect_id, AVG(benefit) AS avgbenefit FROM design
GROUP BY architect_id;

-- Hiển thị chi phí đầu tư cho các công trình ở mỗi thành phố
SELECT city,SUM(cost) AS sumcost FROM building
GROUP BY city;
-- Tìm các công trình có chi phí trả cho kiến trúc sư lớn hơn 50
SELECT b.name ,city , a.id , d.benefit, a.name From building AS b
JOIN design AS d
ON d.building_id=b.id
JOIN architect AS a
ON a.id = d.architect_id
WHERE benefit >50;
-- Tìm các thành phố có ít nhất một kiến trúc sư tốt nghiệp
SELECT b.city, d.architect_id From building AS b
JOIN design AS d
ON d.building_id = b.id;

-- B5
-- Hiển thị tên công trình, tên chủ nhân và tên chủ thầu của công trình đó
SELECT b.name AS buidingname ,c.name AS contractorname ,h.name AS hostname From building AS b
JOIN contractor AS c
ON b.contractor_id= c.id
JOIN host AS h
ON h.id =b.host_id;

-- Hiển thị tên công trình (building), tên kiến trúc sư (architect) và thù lao của kiến trúc sư ở mỗi công trình (design)
SELECT b.name, a.name AS architectname, d.benefit From building AS b
JOIN design AS d
ON d.building_id=b.id
JOIN architect as a
On a.id= d.architect_id;

-- Hãy cho biết tên và địa chỉ công trình (building) do chủ thầu Công ty xây dựng số 6 thi công (contractor)
SELECT b.name AS buildingname , b.address ,c.name AS contractorname From building AS b
JOIN contractor AS c
ON c.id=b.contractor_id
WHERE c.name='cty xd so 6';
-- Tìm tên và địa chỉ liên lạc của các chủ thầu (contractor) thi công công trình ở Cần Thơ (building) do kiến trúc sư Lê Kim Dung thiết kế (architect, design)
SELECT c.name AS contractorname , c.address AS contractoradd , b.address AS buildingadd , a.name AS architectname  FROM contractor AS c
Join building AS b
ON b.contractor_id = c.id
JOIN design AS d
ON d.building_id=b.id
JOIN architect as a
On a.id= d.architect_id
WHERE b.city='can tho' AND a.name='le kim dung';

-- Hãy cho biết nơi tốt nghiệp của các kiến trúc sư (architect) đã thiết kế (design) công trình Khách Sạn Quốc Tế ở Cần Thơ (building)
SELECT b.name AS buildingname,a.place AS noitotnghiep From building AS b
JOIN design AS d
ON d.building_id=b.id
JOIN architect as a
On a.id= d.architect_id
WHERE b.name ='khach san quoc te' AND b.city ='can tho';

-- Cho biết họ tên, năm sinh, năm vào nghề của các công nhân có chuyên môn hàn hoặc điện (worker) đã tham gia các công trình (work) mà chủ thầu Lê Văn Sơn (contractor) đã trúng thầu (building)
SELECT wr.name AS wokername, wr.birthday AS wrbirthday , wr.year AS wryear ,wr.skill,c.name AS contractorname From worker AS wr
JOIN work as w
ON wr.id=w.worker_id
JOIN building as b
ON b.id =w.building_id
JOIN contractor AS c
ON c.id=b.contractor_id
WHERE wr.skill IN ('han','dien');
-- Những công nhân nào (worker) đã bắt đầu tham gia công trình Khách sạn Quốc Tế ở Cần Thơ (building) trong giai đoạn từ ngày 15/12/1994 đến 31/12/1994 (work) số ngày tương ứng là bao nhiêu
SELECT wr.name AS wokername, b.name AS bname, w.date From worker AS wr
JOIN work as w ON wr.id=w.worker_id
JOIN building as b
ON b.id =w.building_id
WHERE b.name LIKE 'khach san quoc te' AND w.date BETWEEN '19941215' AND '19941231';
-- Cho biết họ tên và năm sinh của các kiến trúc sư đã tốt nghiệp ở TP Hồ Chí Minh (architect) và đã thiết kế ít nhất một công trình (design) có kinh phí đầu tư trên 400 triệu đồng (building)
SELECT a.name AS architectname, a.birthday AS abirthday,a.place ,b.cost From building AS b
JOIN design AS d
ON d.building_id=b.id
JOIN architect as a
On a.id= d.architect_id
WHERE b.cost >400 AND a.place='tp hcm';
-- Cho biết tên công trình có kinh phí cao nhất
SELECT * From building
WHERE cost = (SELECT MAX(cost) from building);
-- Cho biết tên các kiến trúc sư (architect) vừa thiết kế các công trình (design) do Phòng dịch vụ sở xây dựng (contractor) thi công vừa thiết kế các công trình do chủ thầu Lê Văn Sơn thi công
SELECT a.name AS aname , c.name AS cname From architect as a
JOIN design as d
ON d.architect_id=a.id
Join building AS b
ON b.id =d.building_id
JOIN contractor AS c
On c.id=b.contractor_id
WHERE c.name IN ('phong dich vu so xd','le van son');

 
-- Cho biết họ tên các công nhân (worker) có tham gia (work) các công trình ở Cần Thơ (building) nhưng không có tham gia công trình ở Vĩnh Long
SELECT wr.name AS wokername, b.name AS bname , b.city From worker AS wr
JOIN work as w ON wr.id=w.worker_id
JOIN building as b
ON b.id =w.building_id
WHERE  wr.name not in(
	SELECT wr.name From building AS b 
    JOIN work as w ON b.id=w.building_id 
    JOIN worker as wr ON wr.id= w.worker_id
    WHERE b.city ='vinh long'
    ) AND b.city ='can tho';
-- Cho biết tên của các chủ thầu đã thi công các công trình có kinh phí lớn hơn tất cả các công trình do chủ thầu phòng Dịch vụ Sở xây dựng thi công
SELECT c.name , b.cost From contractor AS c
JOIN building AS b
ON b.contractor_id=c.id
WHERE b.cost > ALL (
	SELECT cost from building AS b
	JOIN contractor AS c
	ON b.contractor_id=c.id
    WHERE c.name ='phong dich vu so xd'
);

-- Cho biết họ tên các kiến trúc sư có thù lao thiết kế một công trình nào đó dưới giá trị trung bình thù lao thiết kế cho một công trình
SELECT d.architect_id, a.name, d.benefit
FROM design AS d
JOIN architect AS a
ON a.id = d.architect_id
JOIN (
    SELECT architect_id, AVG(benefit) AS avg_benefit
    FROM design
    GROUP BY architect_id
) AS avg_table
ON d.architect_id = avg_table.architect_id
WHERE d.benefit < avg_table.avg_benefit;



-- Tìm tên và địa chỉ những chủ thầu đã trúng thầu công trình có kinh phí thấp nhất
SELECT h.name, h.address ,b.cost
FROM host As h
JOIN building AS b
ON b.host_id=h.id
WHERE cost=(SELECT MIN(cost) From building);


-- Tìm họ tên và chuyên môn của các công nhân (worker) tham gia (work) các công trình do kiến trúc sư Le Thanh Tung thiet ke (architect) (design)
SELECT wr.name , wr.skill 
From worker As wr
JOIN work AS w
ON w.worker_id =wr.id
JOIN building AS b
ON b.id=w.building_id
Join design AS d
ON d.building_id=b.id
JOIN architect AS a
On a.id=d.architect_id
WHERE a.name='le thanh tung';


-- Tìm các cặp tên của chủ thầu có trúng thầu các công trình tại cùng một thành phố
SELECT h1.name AS host1, h2.name AS host2, b1.city
FROM host AS h1
INNER JOIN building AS b1 ON b1.host_id = h1.id
INNER JOIN host AS h2
INNER JOIN building AS b2 ON b2.host_id = h2.id
WHERE b1.city = b2.city AND h1.id < h2.id;


-- Tìm tổng kinh phí của tất cả các công trình theo từng chủ thầu
SELECT SUM(cost) AS sumcost ,b.host_id
From building AS b
GROUP BY host_id;



-- Cho biết họ tên các kiến trúc sư có tổng thù lao thiết kế các công trình lớn hơn 25 triệu
SELECT d.architect_id,a.name,SUM(d.benefit) AS Sumbenefit
From design AS d
JOIN architect as a
ON a.id=d.architect_id
GROUP BY architect_id
HAVING SUM(d.benefit)>25;

-- Cho biết số lượng các kiến trúc sư có tổng thù lao thiết kế các công trình lớn hơn 25 triệu
SELECT COUNT(*) AS architect_count
FROM (
    SELECT a.id
    FROM architect AS a
    JOIN design AS d ON a.id = d.architect_id
    GROUP BY a.id
    HAVING SUM(d.benefit) > 25
) AS subquery;

-- Tìm tổng số công nhân đã than gia ở mỗi công trình
SELECT b.name, COUNT( w.worker_id) AS total_workers
FROM building AS b
JOIN work AS w ON b.id = w.building_id
GROUP BY b.name;


-- Tìm tên và địa chỉ công trình có tổng số công nhân tham gia nhiều nhất
SELECT b.name, b.address
FROM building AS b
JOIN work AS w ON b.id = w.building_id
GROUP BY b.id, b.name, b.address
HAVING COUNT(DISTINCT w.worker_id) = (
    SELECT MAX(worker_count)
    FROM (
        SELECT COUNT(DISTINCT w.worker_id) AS worker_count
        FROM building AS b
        JOIN work AS w ON b.id = w.building_id
        GROUP BY b.id
    ) AS subquery
);



-- Cho biêt tên các thành phố và kinh phí trung bình cho mỗi công trình của từng thành phố tương ứng
SELECT b.city ,AVG(b.cost) AS AVGcost
FROM building AS b
GROUP BY b.city;
-- Cho biết họ tên các công nhân có tổng số ngày tham gia vào các công trình lớn hơn tổng số ngày tham gia của công nhân Nguyễn Hồng Vân
SELECT w.name
FROM worker AS w
JOIN work AS wo ON w.id = wo.worker_id
GROUP BY w.name
HAVING SUM(wo.total) > (
    SELECT SUM(wo.total)
    FROM worker AS w
    JOIN work AS wo ON w.id = wo.worker_id
    WHERE w.name = 'nguyen hong van'
);

-- Cho biết tổng số công trình mà mỗi chủ thầu đã thi công tại mỗi thành phố
SELECT c.name, b.city, COUNT(b.id) AS total_buildings
FROM contractor AS c
JOIN building AS b ON c.id = b.contractor_id
GROUP BY c.name, b.city;

-- Cho biết họ tên công nhân có tham gia ở tất cả các công trình

SELECT w.name
FROM worker AS w
JOIN work AS wo ON w.id = wo.worker_id
GROUP BY w.id, w.name
HAVING COUNT(DISTINCT wo.building_id) = (
    SELECT COUNT(DISTINCT b.id)
    FROM building AS b
);
