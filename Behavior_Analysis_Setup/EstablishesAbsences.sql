/*
*	Setup for the 20-day data
*	
*	Gathers the data for the date ranges that
*	excludes absences
*/

SELECT ArchYear, dr.Site, bna.StudentID, bna.StartDate, bna.EndDate, bna.ServiceCode, bna.ProgramDescription, bna.EntryValue, bna.StartWk, bna.EndWk, bna.DayDate, 
	dr.StartDate AS RngS, dr.EndDate AS RngE, dr.GroupNumber, dr.DtRng
FROM ZZ_TEST_BB_Behavior_No_Absence AS bna INNER JOIN
	ZZ_TEST_NSSEO_Behavior20DayRange AS dr ON bna.StudentID = dr.StudentID AND (CONVERT(Date,bna.DayDate) >= CONVERT(Date,dr.StartDate) AND
		CONVERT(Date,bna.DayDate) <= CONVERT(Date,dr.EndDate))
ORDER BY bna.StudentID, CONVERT(Date,bna.StartDate), bna.DayDate