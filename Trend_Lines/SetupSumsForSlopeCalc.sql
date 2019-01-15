-- Establishes sums and such for the trend calc

SELECT SS.Site, SS.StudentID, SS.TermName, SS.TermOrder, SS, SXY, SX, SY, SXX, SX2
FROM (

SELECT Site, StudentID, TermName, TermOrder, COUNT(*) as SS
FROM ZZ_TEST_BB_RollingAttendance_Prep0_5
GROUP BY Site, StudentID, TermName, TermOrder

) as SS INNER JOIN (

SELECT Site, StudentID, TermName, TermOrder, SUM(X*RunTotal) as SXY
FROM ZZ_TEST_BB_RollingAttendance_Prep1
GROUP BY Site, StudentID, TermName, TermOrder

) as SXY ON SS.Site=SXY.Site AND SS.StudentID=SXY.StudentID AND SS.TermName=SXY.TermName AND SS.TermOrder=SXY.TermOrder INNER JOIN (

SELECT Site, StudentID, TermName, TermOrder, SUM(X) as SX
FROM ZZ_TEST_BB_RollingAttendance_Prep1
GROUP BY Site, StudentID, TermName, TermOrder

) as SX ON SS.Site=SX.Site AND SS.StudentID=SX.StudentID AND SS.TermName=SX.TermName AND SS.TermOrder=SX.TermOrder INNER JOIN (

SELECT Site, StudentID, TermName, TermOrder, SUM(RunTotal) as SY
FROM ZZ_TEST_BB_RollingAttendance_Prep1
GROUP BY Site, StudentID, TermName, TermOrder

) as SY ON SS.Site=SY.Site AND SS.StudentID=SY.StudentID AND SS.TermName=SY.TermName AND SS.TermOrder=SY.TermOrder INNER JOIN (

SELECT Site, StudentID, TermName, TermOrder, SUM(X*X) as SXX
FROM ZZ_TEST_BB_RollingAttendance_Prep1
GROUP BY Site, StudentID, TermName, TermOrder

) as SXX ON SS.Site=SXX.Site AND SS.StudentID=SXX.StudentID AND SS.TermName=SXX.TermName AND SS.TermOrder=SXX.TermOrder INNER JOIN (

SELECT Site, StudentID, TermName, TermOrder, POWER(SUM(X),2) as SX2
FROM ZZ_TEST_BB_RollingAttendance_Prep1
GROUP BY Site, StudentID, TermName, TermOrder

) as SX2 ON SS.Site=SX2.Site AND SS.StudentID=SX2.StudentID AND SS.TermName=SX2.TermName AND SS.TermOrder=SX2.TermOrder
ORDER BY StudentID, SS.TermOrder