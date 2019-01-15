-- Counts # of incidents and sets up running total

SELECT ap.Site, ap.StudentID, ap.Date,
	COUNT(dc.IncidentDate) AS Cnt, 0.0 AS RunTot
FROM ZZ_TEST_ATNAttendancePossible AS ap LEFT OUTER JOIN
	ZZ_TEST_DISDisciplineConsolidated AS dc ON ap.Site = dc.SITE AND ap.StudentID = dc.STUDENTID AND CONVERT(Date, ap.Date) = CONVERT(Date, dc.IncidentDate)
GROUP BY ap.Site, ap.StudentID, ap.Date
ORDER BY ap.StudentID, CONVERT(Date, ap.Date)