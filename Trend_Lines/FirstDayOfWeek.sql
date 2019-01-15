-- Establishes the first day of each week in the trend

SELECT p6.Site, p6.StudentID, en.STUDENTNAME,
	CASE
		WHEN DayNum % 7 = 1 THEN Date
		ELSE NULL
	END AS Date,
	TermName, TermOrder, DayNum, X, Slope, Intercept, Trend, DayPres, AbsRun, Cnt, BDFRun
FROM ZZ_TEST_BB_RollingAttendance_Prep6 p6 INNER JOIN ZZ_TEST_ENEnrollDataConsolidated en ON p6.Site=en.SITE AND p6.StudentID=en.STUDENTID
WHERE en.ENDDATE = '00/00/00'
	AND en.ENDSTATUS = 'Currently Enrolled'
ORDER BY p6.StudentID, TermOrder, DayNum
