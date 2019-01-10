/*
*	Unpivot the period data so percentages
*	become row data
*/

SELECT u.StudentID, u.DayPeriod, u.PtPercent
FROM (
	SELECT StudentID,Arrival,Period1,Period2,Period3,Period4,Period5,Period6,Period7,Period8,Period9,Period10,Period11
	FROM ZZ_TEST_BB_Behavior_Percentages
) AS SQ1
UNPIVOT
(
	PtPercent FOR DayPeriod IN
		(Arrival,Period1,Period2,Period3,Period4,Period5,Period6,Period7,Period8,Period9,Period10,Period11)
) AS u