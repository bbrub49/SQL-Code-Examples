/*
*	Counts the number of periods a student has missed
*	based on minutes absent from previous table
*/

SELECT ArchYear, Site, StudentID, StartDate, EndDate, RngS, RngE, ServiceCode, ProgramDescription, EntryValue,
	GroupNumber, StartWk, EndWk, DayDate, DtRng, TotalDays,
	CASE
		WHEN CAST(MinutesAbsent as float) < 25 THEN 0
		WHEN CAST(MinutesAbsent as float) >= 25 AND CAST(MinutesAbsent as float) < 55 THEN 1
		WHEN CAST(MinutesAbsent as float) >= 55 AND CAST(MinutesAbsent as float) < 85 THEN 2
		WHEN CAST(MinutesAbsent as float) >= 85 AND CAST(MinutesAbsent as float) < 115 THEN 3
		WHEN CAST(MinutesAbsent as float) >= 115 AND CAST(MinutesAbsent as float) < 145 THEN 4
		WHEN CAST(MinutesAbsent as float) >= 145 AND CAST(MinutesAbsent as float) < 175 THEN 5
		WHEN CAST(MinutesAbsent as float) >= 175 AND CAST(MinutesAbsent as float) < 205 THEN 6
		WHEN CAST(MinutesAbsent as float) >= 205 AND CAST(MinutesAbsent as float) < 235 THEN 7
		WHEN CAST(MinutesAbsent as float) >= 235 AND CAST(MinutesAbsent as float) < 265 THEN 8
		WHEN CAST(MinutesAbsent as float) >= 265 AND CAST(MinutesAbsent as float) < 295 THEN 9
		WHEN CAST(MinutesAbsent as float) >= 295 AND CAST(MinutesAbsent as float) < 325 THEN 10
		WHEN CAST(MinutesAbsent as float) >= 325 AND CAST(MinutesAbsent as float) < 355 THEN 11
		WHEN CAST(MinutesAbsent as float) >= 355 THEN 12
	ELSE NULL END AS PeriodsAbsent
FROM ZZ_TEST_BB_20DayDataPrep1

ORDER BY StudentID, DayDate