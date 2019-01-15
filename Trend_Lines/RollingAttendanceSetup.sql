-- Setup for rolling absence count by counting # of days
-- and summing the days absence

DECLARE @day as float
DECLARE @interval as float
SET @day = 360.0
SET @interval = 4.0

SELECT ap.Site, ap.StudentID, ap.Date,
	ROW_NUMBER() OVER (PARTITION BY ap.StudentID ORDER BY ap.StudentID, CONVERT(Date,ap.Date)) as DayNum,
	CASE
		WHEN SUM(CAST(MinutesAbsent as float)) >= 0 AND SUM(CAST(MinutesAbsent as float)) < @day/@interval THEN 0.0
		WHEN SUM(CAST(MinutesAbsent as float)) >= @day/@interval AND SUM(CAST(MinutesAbsent as float)) < (@day/@interval)*2.0 THEN 0.25
		WHEN SUM(CAST(MinutesAbsent as float)) >= (@day/@interval)*2.0 AND SUM(CAST(MinutesAbsent as float)) < (@day/@interval)*3.0 THEN 0.5
		WHEN SUM(CAST(MinutesAbsent as float)) >= @day THEN 1.0
		ELSE 0.0
	END AS DaysAbs,
	0.0 as RunTotal
FROM ZZ_TEST_ATNAttendancePossible ap LEFT OUTER JOIN ZZ_TEST_ATNAttendanceMarks am ON ap.StudentID = am.StudentID AND CONVERT(Date,ap.Date) = CONVERT(Date,am.AbsentDate)
WHERE CONVERT(Date,ap.Date) <= GETDATE()
GROUP BY ap.Site, ap.StudentID, ap.Date
ORDER BY ap.StudentID, CONVERT(Date,ap.Date)