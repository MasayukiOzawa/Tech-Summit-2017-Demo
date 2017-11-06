DECLARE @TargetName  nvarchar(50)= 'Alice';
WITH F_CTE (name, start_date, from_id, to_id) AS(
	SELECT CAST(Person1.name + '->' + Person2.name AS nvarchar(max)), start_date, $from_id , $to_id
	FROM Person Person1, friend, Person Person2
	WHERE MATCH(Person1-(friend)->Person2) AND Person1.name = @TargetName

	UNION ALL

	SELECT CAST( F_CTE.name + '->' + F_T.P2_name AS nvarchar(max)), F_T.start_date, F_T.from_id, F_T.to_id
	FROM F_CTE
	INNER JOIN
	(
		SELECT 	Person1.name AS P1_name, Person2.name AS P2_name,start_date, $from_id AS from_id, $to_id AS to_id
		FROM Person Person1, friend, Person Person2
		WHERE MATCH(Person1-(friend)->Person2)
	) AS F_T
	ON F_CTE.to_id = F_T.from_id
)
SELECT name, start_date FROM F_CTE