-- Combines the level 1, 2, and 3 table with the level 4 table

SELECT ArchYear, Site, StudentID, StartDate, EndDate, RngS, RngE, ServiceCode, ProgramDescription, EntryValue, GroupNumber, StartWk, EndWk, DayDate, DtRng, TotalDays, PeriodsAbsent
FROM ZZ_TEST_BB_20DayDataPrep3
UNION
SELECT ArchYear, Site, StudentID, StartDate, EndDate, RngS, RngE, ServiceCode, ProgramDescription, EntryValue, GroupNumber, StartWk, EndWk, DayDate, DtRng, TotalDays, PeriodsAbsent
FROM ZZ_TEST_BB_20DayDataPrep4

ORDER BY StudentID, GroupNumber, DayDate