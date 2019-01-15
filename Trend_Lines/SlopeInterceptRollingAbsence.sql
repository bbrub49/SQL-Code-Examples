-- Calcs the slope, intercept, and trend for rolling absence

SELECT Site, StudentID, Date, TermName, TermOrder, DayPres, RunTotal, X, Slope, Intercept,
	(Slope*X + CASE WHEN Intercept < 0 THEN 0 ELSE Intercept END) as Trend
FROM (

SELECT p1.Site, p1.StudentID, Date, p1.TermName, p1.TermOrder, DayPres, RunTotal, X,
	CASE
		WHEN SS = 1 THEN 0
		ELSE (SXY) / (SXX)
	END AS Slope,
	CASE
		WHEN SS = 1 THEN 0
		ELSE ((SY) - ((SXY) / (SXX))*SX) / SS
	END AS Intercept
FROM ZZ_TEST_BB_RollingAttendance_Prep1 p1 INNER JOIN ZZ_TEST_BB_RollingAttendance_Prep2 p2 ON p1.Site=p2.Site AND p1.StudentID=p2.StudentID AND
	p1.TermName=p2.TermName AND p1.TermOrder=p2.TermOrder

) as si
ORDER BY StudentID, CONVERT(Date,Date)