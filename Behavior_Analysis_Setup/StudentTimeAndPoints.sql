/*
*	Establishes the reason and minutes a student is absent
*	if the absence is excused in order to remove those
*	minutes from the students total time and total points
*	possible to earn that day
*/

DECLARE @yeartype as varchar(15)
SET @yeartype = (SELECT [Type] FROM NSSEOPulse.dbo.ZM_TEST_BB_SchoolYear WHERE [Description] = 'Current')

IF @yeartype = 'Summer'

SELECT ArchYear, dp.Site, dp.StudentID, StartDate, EndDate, RngS, RngE, ServiceCode, ProgramDescription, EntryValue,
	GroupNumber, StartWk, EndWk, DayDate, DtRng, TotalDays,
	(CAST(MinPossible as float) - CAST(MinPresent as float)) as MinutesAbsent,
	'ESY' as ReasonCode, 0.00 as ActualAbsence
FROM ZZ_TEST_BB_20DayDataPrep dp LEFT OUTER JOIN (

SELECT SIte, SchoolYear, StudentID, AtnDate, SubjSec, MinPresent, MinPossible, ATNSpecialCode, ATNSpecialComment
FROM ZZ_TEST_ATNSpecialAdditional
WHERE SIte = 'TR'

) as ma ON dp.StudentID = ma.StudentID AND dp.DayDate = CONVERT(Date,ma.AtnDate)

ELSE

SELECT ArchYear, dp.Site, dp.StudentID, StartDate, EndDate, RngS, RngE, ServiceCode, ProgramDescription, EntryValue,
	GroupNumber, StartWk, EndWk, DayDate, DtRng, TotalDays,
	CASE
		WHEN TotalMinutesAbs IS NULL THEN 0
		ELSE TotalMinutesAbs
	END AS ActualAbsence,
	CASE
		WHEN (ReasonCode IN ('E','L','X','M')) OR (ReasonCode = 'G' AND ServiceCode IN ('1','2','3')) THEN TotalMinutesAbs
		ELSE 0
	END AS MinutesAbsent,
	ReasonCode
FROM ZZ_TEST_BB_20DayDataPrep dp LEFT OUTER JOIN (

SELECT DISTINCT PrimarySite, ma.StudentID, ma.TotalMinutesAbs, Minutespossible, ma.AttendanceDate, ReasonCode
FROM ZZ_TEST_ATNStudentDetail ma INNER JOIN ZZ_TEST_ATNAttendanceMarks am ON ma.StudentID = am.StudentID AND ma.AttendanceDate = am.AbsentDate
WHERE PrimarySite = 'TR'

) as ma ON dp.StudentID = ma.StudentID AND CONVERT(Date,dp.DayDate) = CONVERT(Date,ma.AttendanceDate)