/*
*	Pivots the data so each day's goal is associated with
*	that day of the week within the date range
*/

SELECT *
FROM (
	SELECT StudentID, CONVERT(Date,DayDate) as NewDate, StartDate, EndDate, RngS, RngE, ServiceCode, ProgramDescription, EntryValue, GroupNumber, TotalDays, PtsPoss
	FROM ZZ_TEST_BB_20DayDataPrepared
	WHERE ServiceCode ='4'
		AND EntryValue <> '9999'
) AS SQ1
PIVOT
(
MAX(EntryValue)
FOR [ProgramDescription] IN (MondayGoal1,MondayGoal2,TuesdayGoal1,TuesdayGoal2,WednesdayGoal1,WednesdayGoal2,ThursdayGoal1,ThursdayGoal2,FridayGoal1,FridayGoal2)
) AS PVT
