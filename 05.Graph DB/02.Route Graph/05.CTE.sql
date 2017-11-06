DECLARE @From nvarchar(100) = N'';

WITH ST (line_name, From_Cd, From_Name, To_Name, Route, From_Id, To_Id) 
AS(
	SELECT * FROM
	(SELECT From_Station.line_name, From_Station.station_cd, From_Station.station_name AS From_Name, To_Station.station_name AS To_Name, 
	CAST(From_Station.station_name + '->' + To_Station.station_name AS nvarchar(max)) AS Route, 
Å@ $from_id AS From_Id, $to_id AS To_Id
	FROM LineGraph AS From_Station, JoinGraph, LineGraph AS To_Station
	WHERE	MATCH(From_Station <- (JoinGraph) - To_Station)
	) AS T1
	WHERE From_Name = @From 

	UNION ALL

	SELECT T1.line_name, T1.Station_Cd, T1.From_Name,  T1.To_Name,  
	CAST(ST.Route + '->' + T1.To_Name AS nvarchar(max)) AS Route,  
	T1.From_Id, T1.To_Id
	FROM ST
	INNER JOIN
	(SELECT From_Station.line_name, From_Station.station_cd,From_Station.station_name AS From_Name, To_Station.station_name AS To_Name, 
	$from_id AS From_Id, $to_id AS To_Id
	FROM LineGraph From_Station, JoinGraph, LineGraph AS To_Station
	WHERE	MATCH(From_Station <- (JoinGraph) - To_Station)
	) AS T1
	ON ST.From_Id = T1.To_Id
)
SELECT * FROM ST ORDER BY 1,2 DESC