/*
*	Joins the absence/present info with the
*	count of BDFs
*/

SELECT p5.Site, p5.StudentID, p5.Date, p5.TermName, p5.TermOrder, p5.DayNum,
	X, Slope, Intercept, Trend, DayPres, p3.RunTotal as AbsRun, Cnt, p5.RunTotal as BDFRun
FROM ZZ_TEST_BB_RollingAttendance_Prep5 p5 INNER JOIN ZZ_TEST_BB_RollingAttendance_Prep3 p3 ON p5.Site=p3.Site AND p5.StudentID=p3.StudentID AND p5.Date=p3.Date
ORDER BY p5.StudentID, CONVERT(Date,p5.Date)