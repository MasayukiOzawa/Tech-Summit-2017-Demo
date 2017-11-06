-- http://www.ekidata.jp/
DROP TABLE IF EXISTS LineGraph
CREATE TABLE LineGraph (
	company_cd		int, 
	company_name	nvarchar(80), 
	company_name_r	nvarchar(80), 
	company_type	int, 
	rr_cd			int,
	pref_cd			int,
	pref_name		nvarchar(10),
	line_cd			int,
	line_name		nvarchar(80), 
	line_type		int,
	station_cd		int,
	station_name	nvarchar(80),
	station_name_r	nvarchar(80),
	lon				float,
	lat				float
CONSTRAINT PK_LineGraph PRIMARY KEY (company_cd, station_cd)) AS NODE
GO
INSERT INTO LineGraph
SELECT 
	c.company_cd, 
	c.company_name,
	c.company_name_r,
	c.company_type,
	c.rr_cd,
	p.pref_cd,
	p.pref_name,
	l.line_cd,
	l.line_name,
	l.line_type,
	s.station_cd, 
	s.station_name,
	s.station_name_r,
	s.lon,-- Œo“x 
	s.lat -- ˆÜ“x
FROM 
	[station]  s
LEFT JOIN [line] AS l
ON l.line_cd = s.line_cd
LEFT JOIN [company] AS c
ON c.company_cd = l.company_cd
LEFT JOIN [pref] AS p
ON p.pref_cd = s.pref_cd
WHERE
c.e_status = 0 AND l.e_status = 0 AND s.e_status = 0
