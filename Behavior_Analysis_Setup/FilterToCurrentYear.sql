-- Gets the point sheet prepared data and filters to current school year

DECLARE @archyr AS VARCHAR(4)
SET @archyr = (SELECT ArchYearCode FROM ZM_TEST_BB_SchoolYear WHERE [Description] = 'Current')

SELECT ArchYear, Site, StudentID, StartDate, EndDate, RngS, RngE, ServiceCode, ProgramDescription, EntryValue, PtsPoss, GroupNumber, StartWk, EndWk, DayDate, DtRng, TotalDays
FROM ZZ_TEST_BB_20DayDataPrep6
WHERE ArchYear = @archyr
ORDER BY StudentID, CONVERT(DATE,DayDate)