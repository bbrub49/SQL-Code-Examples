/*
*	Establishes the week of the entries and
*	pulls the goal points entered for each day
*	of the week for level 4 students
*/

SELECT StudentID,
	CAST(DATEADD(dd, - (DATEPART(dw, CONVERT(Date,StartDate)) - 1), CONVERT(Date,StartDate)) as Date) as StartWk,
	CAST(DATEADD(dd, 7 - (DATEPART(dw, CONVERT(Date,EndDate))), CONVERT(Date,EndDate)) as Date) as EndWk,
	CONVERT(Date,DayDate) as DayDate, DATEPART(wk, CONVERT(Date, StartDate)) as Wk, DATEPART(yy, CONVERT(Date,StartDate)) as Yr,
	ProgramDescription, EntryValue, PtsPoss, GroupNumber
FROM ZZ_TEST_BB_20DayDataPrepared bn1
WHERE ProgramDescription IN ('MondayGoal1','TuesdayGoal1','WednesdayGoal1','ThursdayGoal1','FridayGoal1','MondayGoal2','TuesdayGoal2','WednesdayGoal2',
	'ThursdayGoal2','FridayGoal2')
	AND CONVERT(Date,StartDate) BETWEEN (SELECT CONVERT(Date,StartDate) FROM ZM_TEST_BB_SchoolYear WHERE Description = 'Current')
		AND (SELECT CONVERT(Date,EndDate) FROM ZM_TEST_BB_SchoolYear WHERE Description = 'Current')
ORDER BY StudentID, Wk