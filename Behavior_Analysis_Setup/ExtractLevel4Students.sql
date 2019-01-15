-- Stores level 4 students for future edits

SELECT ArchYear, StudentID, StartDate, EndDate, RngS, RngE, ServiceCode, ProgramDescription, EntryValue, PeriodsAbsent, GroupNumber,
	StartWk, EndWk, DayDate, DtRng, TotalDays, Site
FROM ZZ_TEST_BB_20DayDataPrep2
WHERE ServiceCode = '4'
ORDER BY StudentID, GroupNumber, DayDate