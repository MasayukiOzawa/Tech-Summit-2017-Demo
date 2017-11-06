DROP TABLE IF EXISTS JoinGraph
CREATE TABLE JoinGraph AS EDGE
GO
USE [Train]
GO

CREATE NONCLUSTERED INDEX [JoinGraph_From_To] ON [dbo].[JoinGraph]
(
	$from_id ASC,
	$to_id ASC
)WITH (DATA_COMPRESSION=PAGE)
GO

CREATE NONCLUSTERED INDEX [JoinGraph_To_From] ON [dbo].[JoinGraph]
(
	$to_id ASC,
	$from_id ASC
)WITH (DATA_COMPRESSION=PAGE)
GO

INSERT INTO JoinGraph
SELECT DISTINCT
	g1.$node_id,
	g2.$node_id
FROM [join] AS j
LEFT JOIN	[line] AS l
	ON j.line_cd = l.line_cd
INNER JOIN	[station] AS s1
	ON j.station_cd1 = s1.station_cd
INNER JOIN	[station] AS s2
	ON j.station_cd2 = s2.station_cd
INNER JOIN [company] AS c
	ON l.company_cd = c.company_cd
INNER JOIN LineGraph AS g1
	ON s1.station_cd = g1.station_cd 
	AND c.company_cd = g1.company_cd
INNER JOIN LineGraph AS g2
	ON s2.station_cd = g2.station_cd 
	AND c.company_cd = g2.company_cd
GO
/*
INSERT INTO JoinGraph
SELECT DISTINCT
	g2.$node_id,
	g1.$node_id
FROM [join] AS j
LEFT JOIN	[line] AS l
	ON j.line_cd = l.line_cd
INNER JOIN	[station] AS s1
	ON j.station_cd1 = s1.station_cd
INNER JOIN	[station] AS s2
	ON j.station_cd2 = s2.station_cd
INNER JOIN [company] AS c
	ON l.company_cd = c.company_cd
INNER JOIN LineGraph AS g1
	ON s1.station_cd = g1.station_cd 
	AND c.company_cd = g1.company_cd
INNER JOIN LineGraph AS g2
	ON s2.station_cd = g2.station_cd 
	AND c.company_cd = g2.company_cd
GO
*/