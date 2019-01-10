The files here are the code used to setup and execute the analysis of
behavior data collected. Some queries use subqueries.

There are 4 possible levels or tiers someone could be on depending on the
behaviors and points earned. These levels are: 1 for new or worsening cases,
2 for good cases, 3 for better cases, and 4 for best cases.

Levels 2-4 are evaluated every 20 days while level 1 is evaluted every 10. Days are
based on presence and unexcused absence. For example, though on a calendar 24 days are
counted, the individual was only present or unexcused for 20 of them and those are what
are used in the analysis not the 24.

The series of queries examines the levels and adjusts the day counts based on those levels.
So if a student switches from level 1 to level 2, the days are adjusted from 10 to 20 and
vice versa. The total points possible changes throughout the calendar year and the process
accounts for these changes as well.

Attempts are also made to handle null dates and some missing or duplicate data.
