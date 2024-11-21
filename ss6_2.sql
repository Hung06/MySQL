USE dml;
CREATE VIEW contract AS
SELECT b.name AS cong_trinh, h.name AS chu_nhan, c.name AS chu_thau
FROM building AS b, host AS h, contractor AS c
WHERE b.host_id = h.id
AND b.contractor_id = c.id;

CREATE VIEW chuwanghihuu AS
SELECT * From architect 
WHERE birthday >1964;

SELECT * From chuwanghihuu