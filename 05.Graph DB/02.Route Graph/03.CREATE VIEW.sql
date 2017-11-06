USE [Train]
GO

DROP VIEW IF EXISTS vLineGraph
GO
CREATE VIEW vLineGraph
AS
SELECT
	l1.pref_name,
	l1.company_name,
	l1.company_cd,
	l1.line_cd from_line_cd,
	l1.line_name from_line_name,
	l1.station_name from_station,
	l1.lon from_lon,
	l1.lat from_lat,
	l2.line_cd to_line_cd,
	l2.line_name to_line_name,
	l2.station_name to_station,
	l2.lon to_lon,
	l2.lat to_lat
FROM LineGraph l1, JoinGraph, LineGraph l2
WHERE MATCH(l1 <- (JoinGraph) - l2)

