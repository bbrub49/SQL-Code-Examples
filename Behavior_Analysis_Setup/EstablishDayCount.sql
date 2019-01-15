-- Combines initial prep with the student day counts

SELECT ArchYear, dd.Site, dd.StudentID, dd.StartDate, dd.EndDate, dd.RngS, dd.RngE, dd.ServiceCode, dd.ProgramDescription, dd.EntryValue, dd.GroupNumber, dd.StartWk, dd.EndWk, 
	dd.DayDate, dd.DtRng, dc.TotalDays
FROM ZZ_TEST_BB_20DayData AS dd INNER JOIN
	ZZ_TEST_BB_TR_StudentDayCount AS dc ON dd.StudentID = dc.StudentID AND dd.GroupNumber = dc.GroupNumber