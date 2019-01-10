/*
*	Connects the total # of days in an eval period
*	and actual number of days present
*/

SELECT da.StudentID, da.StartDate, da.EndDate, da.GroupNumber, da.DaysAbsent, dp.DayCnt,
	CASE WHEN da.DaysAbsent IS NULL THEN dp.DayCnt ELSE CAST(dp.DayCnt as int) - CAST(da.DaysAbsent as  int) END AS TotalDays
FROM (

-- Links the days absent with the associated eval period
SELECT dr2.StudentID, dr2.StartDate, dr2.EndDate, dr2.GroupNumber, tmp.AbsentCnt AS DaysAbsent
FROM ZZ_TEST_NSSEO_Behavior20DayRange dr2 LEFT OUTER JOIN
(

-- Counts days absent for TR students for each eval period
SELECT dr.StudentID, dr.StartDate, dr.EndDate, dr.GroupNumber, FLOOR(SUM(am.DAYSABSENT)) as AbsentCnt
FROM ZZ_TEST_NSSEO_Behavior20DayRange AS dr INNER JOIN (

-- Gets days absent for each student
SELECT DISTINCT ad.PrimarySite, ad.StudentID, 1 as DAYSABSENT, ad.AttendanceDate
FROM ZZ_TEST_ATNStudentDetail AS ad INNER JOIN
	ZZ_TEST_ATNAttendanceMarks AS am ON ad.StudentID = am.StudentID AND CONVERT(Date,ad.AttendanceDate) = CONVERT(Date,am.AbsentDate)
WHERE (ad.DAYSABSENT = 1) AND (am.ReasonCode IN ('X','M','P'))

UNION

-- Handles the half-day cases
SELECT Site, StudentID, 1 as DAYSABSENT, AbsentDate
FROM ZZ_TEST_ATNAttendanceMarks
WHERE CONVERT(Date,AbsentDate) IN (SELECT CONVERT(Date,HalfDay) FROM ZM_TEST_BB_Half_Day_Dates)
	AND ReasonCode IN ('X','E','L','M','P')
	AND CAST(MinutesAbsent as float) >= 150
		
) AS am ON dr.StudentID = am.StudentID

WHERE CONVERT(Date,am.AttendanceDate,101) BETWEEN dr.StartDate AND dr.EndDate
	AND am.DAYSABSENT = 1
GROUP BY dr.StudentID, dr.StartDate, dr.EndDate, dr.GroupNumber) as tmp ON dr2.StudentID = tmp.StudentID AND dr2.GroupNumber = tmp.GroupNumber) as da INNER JOIN

	-- Gets total possible days
	(SELECT dr.StudentID, dr.StartDate, dr.EndDate, dr.GroupNumber, COUNT(ad.Date) as DayCnt
	FROM (ZZ_TEST_NSSEO_Behavior20DayRange AS dr LEFT OUTER JOIN
		ZZ_TEST_ATNAttendancePossible AS ad ON dr.StudentID = ad.StudentID)
	WHERE CONVERT(Date,ad.Date,101) >= dr.StartDate AND CONVERT(Date,ad.Date,101) <= dr.EndDate
	GROUP BY dr.StudentID, dr.StartDate, dr.EndDate, dr.GroupNumber) as dp ON da.StudentID = dp.StudentID AND da.GroupNumber = dp.GroupNumber

ORDER BY StudentID, GroupNumber