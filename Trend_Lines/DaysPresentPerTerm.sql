-- Calcs the days present for each term

SELECT Site, StudentID, Date, (1.0 - CAST(DaysAbs as float)) as DayPres, RunTotal, TermName, TermOrder
FROM ZZ_TEST_BB_RollingAttendance_Prep p INNER JOIN (

SELECT TermName, StartDate, EndDate, TermOrder
FROM ZM_TEST_Terms
WHERE (TermName IN ('T1', 'T2', 'T3', 'T4'))

) as t ON CONVERT(Date,p.Date) >= CONVERT(Date,t.StartDate) AND CONVERT(Date,p.Date) <= CONVERT(Date,t.EndDate)
ORDER BY Site, StudentID, CONVERT(Date,Date)