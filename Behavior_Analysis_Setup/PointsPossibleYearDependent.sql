/*
*
*	Edit so ESY doesn't get the 24 point total
*	that the regular year does by checking if ArchYear
*	has 'SS' in it
*
*/

/*
*	Sets the goal points based on school year type (ESY or Regular)
*	and calculates the amount of points possible
*/

DECLARE @goal as float
DECLARE @period as float
DECLARE @yeartype as varchar(15)
SET @yeartype = (SELECT [Type] FROM NSSEOPulse.dbo.ZM_TEST_BB_SchoolYear WHERE [Description] = 'Current')

IF @yeartype = 'Summer'
	SET @goal = 20
ELSE
	SET @goal = 24;

SET @period = 8

SELECT ArchYear, Site, StudentID, StartDate, EndDate, RngS, RngE, ServiceCode, ProgramDescription, EntryValue,
	CASE
		WHEN ProgramDescription IN ('BeSafe','BeRespectful','BeResponsible','PersonalGoal','MondayGoal1','MondayGoal2',
			'TuesdayGoal1','TuesdayGoal2','WednesdayGoal1','WednesdayGoal2','ThursdayGoal1','ThursdayGoal2',
			'FridayGoal1','FridayGoal2') THEN
			CASE
				WHEN PeriodsAbsent IS NULL THEN
					CASE
						WHEN CONVERT(Date,DayDate) IN (SELECT CONVERT(Date,HalfDay) FROM ZM_TEST_BB_Half_Day_Dates) THEN @goal/2.0
						ELSE @goal
					END
				ELSE
					CASE
						WHEN CONVERT(Date,DayDate) IN (SELECT CONVERT(Date,HalfDay) FROM ZM_TEST_BB_Half_Day_Dates) THEN (@goal) - (PeriodsAbsent*2)
						ELSE @goal - (PeriodsAbsent*2)
					END
			END
		WHEN ProgramDescription IN ('Arrival','TotalPeriod1','TotalPeriod10','TotalPeriod11','TotalPeriod2','TotalPeriod3','TotalPeriod4',
			'TotalPeriod5','TotalPeriod6','TotalPeriod7','TotalPeriod8','TotalPeriod9') THEN @period
		ELSE NULL
	END AS PtsPoss,
	GroupNumber, StartWk, EndWk, DayDate, DtRng, TotalDays, PeriodsAbsent
FROM ZZ_TEST_BB_20DayDataPrep5

ORDER BY StudentID, GroupNumber, DayDate