DECLARE @dayint int, @day1 datetime, @day2 datetime, @wkdy varchar

SET @dayint = 7

WHILE @dayint > 0
BEGIN
SET @day1 = CONVERT(varchar, DATEADD(day, -@dayint, CURRENT_TIMESTAMP), 101)
SET @day2 = CONVERT(varchar, DATEADD(day, -(@dayint -1), CURRENT_TIMESTAMP), 101)
SET @wkdy = DATEPART(DW, DATEADD(day, -@dayint, CURRENT_TIMESTAMP))
SELECT CONVERT(varchar,@day1,101) as Date, @wkdy as Day,
       DATEPART(hh,aa.timestamp) AS Hour,
       COUNT(DISTINCT u.user_id) AS UserCount,
       COUNT(DISTINCT aa.pk1) AS ActivityCount
FROM activity_accumulator aa
INNER JOIN dbo.course_main cm ON aa.course_pk1 = cm.pk1
INNER JOIN users u ON aa.user_pk1 = u.pk1
WHERE aa.timestamp BETWEEN @day1 AND @day2
GROUP BY DATEPART(hh,aa.timestamp);
SET @dayint -= 1;
END