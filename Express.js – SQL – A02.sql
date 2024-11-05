use dml;
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

-- BÀi3
SELECT * FROM architect;
SELECT `name`, `sex` FROM architect;
SELECT DISTINCT birthday FROM architect;
SELECT `name`,birthday FROM architect
ORDER BY birthday ASC;
SELECT `name`,birthday FROM architect
ORDER BY birthday DESC;
-- BÀi 4
SELECT * FROM architect
WHERE `name` ="le thanh tung";
SELECT `name` , birthday FROM worker
WHERE skill in ('han','dien') and birthday>1948;
SELECT * From worker
WHERE birthday+20>`year`;
SELECT * From worker
WHERE birthday in (1945, 1940, 1948);

SELECT * From worker
WHERE birthday like '194_';

SELECT * From building
WHERE cost BETWEEN 200 and 500;

SELECT * From building
WHERE 200<=cost and cost <=500;

SELECT * FROM worker
WHERE `name` like 'nguyen%';

SELECT * FROM worker
WHERE `name` like '%anh%';
SELECT * FROM worker
WHERE `name` like '%th_';
SELECT * FROM contractor
WHERE phone is Null;
