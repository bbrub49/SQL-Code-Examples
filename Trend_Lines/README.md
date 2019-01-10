Since the data visualization tool used does not have a way to automatically
calculate trend lines like Excel or Tableau, this series of SQL code calculates
the trend line based on the data using the following formulas for the slope
and interecept:

slope -> (n*SUM(xy) - SUM(x)*SUM(y)) / (n*SUM(x^2) - (SUM(x))^2)

intercept -> (SUM(y) - slope*SUM(x)) / n

The code was adapted from the below link to accommodate multiple categories instead of one:

https://www.mssqltips.com/sqlservertip/3432/add-a-linear-trendline-to-a-graph-in-sql-server-reporting-services/
