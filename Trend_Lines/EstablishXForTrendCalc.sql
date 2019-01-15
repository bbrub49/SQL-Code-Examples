-- Sums the rolling days present and establishes X for trend calc

SELECT Site, StudentID, Date, DayPres, RunTotal,
	ROW_NUMBER() OVER (PARTITION BY StudentID, TermName ORDER BY StudentID, CONVERT(Date,DATE)) as X,
	TermName, TermOrder
FROM (
SELECT Site, StudentID, Date, DayPres, TermName, TermOrder,
	SUM(DayPres) OVER (PARTITION BY StudentID, TermName ORDER BY CONVERT(Date,Date)) as RunTotal
FROM ZZ_TEST_BB_RollingAttendance_Prep0_5
) as tot
ORDER BY StudentID, CONVERT(Date,Date)