/*
*	Starts the rolling sum of incidents
*/

SELECT Site, StudentID, Date, TermName, TermOrder, Cnt,
	SUM(Cnt) OVER (PARTITION BY StudentID, TermName ORDER BY CONVERT(Date,Date)) as RunTotal,
	ROW_NUMBER() OVER (PARTITION BY StudentID, TermName ORDER BY StudentID, CONVERT(Date,DATE)) as DayNum
FROM ZZ_TEST_BB_RollingAttendance_Prep4_5
ORDER BY StudentID, CONVERT(Date,Date)