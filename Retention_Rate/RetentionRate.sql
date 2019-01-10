/*
*	Examines the weekly retention rate of cohorts of students based
*	on the date they were enrolled in the programs.
*/

-- Retrieves student possible attendance days and calculates the start of week date
WITH attend_dates AS (

	SELECT StudentID, CONVERT(Date, (CONVERT(Date,Date)) - DATEADD(dd, -1, DATEPART(dw, (CONVERT(Date,Date))))) as Date
	FROM ZZ_TEST_ATNAttendancePossible
	GROUP BY StudentID, CONVERT(Date, (CONVERT(Date,Date)) - DATEADD(dd, -1, DATEPART(dw, (CONVERT(Date,Date)))))

),

-- Retrieves a student's first week of attendance
attend_date_first AS (

	SELECT StudentID, Date,
		FIRST_VALUE(Date) OVER (PARTITION BY StudentID ORDER BY Date) as f_week
	FROM attend_dates

),

-- Counts the number of students that started during a given start week
cohort AS (

	SELECT f_week, COUNT(DISTINCT StudentID) as Cnt
	FROM attend_date_first
	GROUP BY f_week

),

-- Calculates week difference between a student's start week and each
-- week of attendance they are enrolled upto the current date
wk_period AS (

	SELECT StudentID, Date, f_week, DATEDIFF(wk, f_week, Date) as wks
	FROM attend_date_first
	WHERE CONVERT(Date,Date) < CONVERT(Date,GETDATE())

)

-- Displays the cohort week start date, the number of weeks since the start week,
-- number in the cohort, and calculates the retention rate for each week
SELECT cohort.f_week as Cohort, wk_period.wks as Retention_Week, cohort.Cnt as Cohort_Cnt,
	ROUND((CAST(COUNT(DISTINCT wk_period.StudentID) as float) / CAST(cohort.Cnt as float))*100.0,2) as Retention_Rate
FROM wk_period LEFT OUTER JOIN cohort ON wk_period.f_week = cohort.f_week
GROUP BY cohort.f_week, wk_period.wks, cohort.Cnt




