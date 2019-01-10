/*
*	Calculates the percent of points a student has earned
*	each day and counts the number of days based on the bins
*	of percentages. A pivot is performed for display purposes
*	so bins are now columns/fields instead of row data.
*/

WITH cte AS (

SELECT Site, StudentID, ServiceCode,
	CASE
		WHEN ProgramDescription IN ('BeRespectful','BeResponsible','BeSafe','PersonalGoal') THEN ProgramDescription
		ELSE SUBSTRING(ProgramDescription,CHARINDEX('G',ProgramDescription),LEN(ProgramDescription))
	END AS Goal,
	ROUND(((CAST(EntryValue as float))/(CAST(PtsPoss as float)))*100.00,2) as Perc, GroupNumber, DayDate
FROM ZZ_TEST_BB_20DayDataPrepared
WHERE ProgramDescription IN ('BeRespectful','BeResponsible','BeSafe','PersonalGoal','WednesdayGoal1','WednesdayGoal2','ThursdayGoal1','ThursdayGoal2','FridayGoal1',
	'FridayGoal2','MondayGoal1','MondayGoal2','TuesdayGoal1','TuesdayGoal2')

),

cte1 AS (

SELECT Site, StudentID, ServiceCode, Goal, Perc, GroupNumber,
	CASE
		WHEN Perc < 50 THEN '< 50'
		WHEN Perc BETWEEN 50 AND 60 THEN '50 - 60'
		WHEN Perc BETWEEN 60 AND 70 THEN '60 - 70'
		WHEN Perc BETWEEN 70 AND 80 THEN '70 - 80'
		WHEN Perc BETWEEN 80 AND 85 THEN '80 - 85'
		WHEN Perc BETWEEN 85 AND 90 THEN '85 - 90'
		WHEN Perc BETWEEN 90 AND 95 THEN '90 - 95'
		WHEN Perc > 95 THEN '> 95'
		ELSE 'Unknown'
	END AS Bins, CONVERT(Date, DayDate) as DayDate
FROM cte
--ORDER BY Site, StudentID, GroupNumber, DayDate, ServiceCode, Goal

),

cte2 AS (

SELECT Site, StudentID, ServiceCode, Goal, GroupNumber, Bins,
	COUNT(Bins) as Cnt
FROM cte1
GROUP BY Site, StudentID, ServiceCode, Goal, GroupNumber, Bins
--ORDER BY Site, StudentID, GroupNumber, ServiceCode, Goal

),

cte3 AS (

SELECT *
FROM (
	SELECT *
	FROM cte2
) AS SQ1
PIVOT
(
	MAX(Cnt)
	FOR [Bins] IN ([< 50],[50 - 60],[60 - 70],[70 - 80],[80 - 85],[85 - 90],[90 - 95],[> 95])
) AS PVT
--ORDER BY Site, StudentID, GroupNumber, ServiceCode, Goal

)

SELECT cte3.Site, cte3.StudentID, en.StudentName, ServiceCode, Goal, GroupNumber, cte3.[< 50], cte3.[50 - 60], cte3.[60 - 70],
	cte3.[70 - 80], cte3.[80 - 85], cte3.[85 - 90], cte3.[90 - 95], cte3.[> 95]
FROM cte3 LEFT OUTER JOIN ZZ_TEST_ENEnrollDataConsolidated en ON cte3.StudentID = en.StudentID
ORDER BY Site, StudentID, GroupNumber, ServiceCode, Goal