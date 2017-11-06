USE Train
GO
SELECT TOP 5 * FROM LineGraph
SELECT TOP 5 * FROM JoinGraph
GO

SELECT
	l1.pref_name,
	l1.company_name,
	l1.line_cd from_line_cd,
	l1.line_name from_line_name,
	l1.station_name from_station,
	l2.line_cd to_line_cd,
	l2.line_name to_line_name,
	l2.station_name to_station
FROM LineGraph l1, JoinGraph, LineGraph l2
WHERE MATCH(l1 <- (JoinGraph) - l2)
AND l1.line_name = 'JRŽRŽèü'
GO
