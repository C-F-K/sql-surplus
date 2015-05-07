--Return the user logintime (first activity for the session) and logouttime (last activity for the session) for the last 14 days:

SELECT DISTINCT user_pk1, logintime, logouttime
FROM
(
SELECT user_pk1, data
, min(timestamp) over (PARTITION BY user_pk1, session_id) logintime
, max(timestamp) over (PARTITION BY user_pk1, session_id) logouttime
FROM bb_bb60_stats.activity_accumulator
WHERE timestamp >= sysdate-14
)
WHERE data = 'Login succeeded.'
ORDER BY logintime
/

/*
USER_PK1, LOGINTIME,          LOGOUTTIME
123456    09.03.2009 14:08:36 10.03.2009 00:28:42
234567    09.03.2009 14:08:45 09.03.2009 14:08:45
234567    09.03.2009 14:09:00 09.03.2009 14:09:00
345678    09.03.2009 14:09:03 09.03.2009 14:17:59

*/


--Return the logintime by day/hour and session login count.

SELECT dayhour, Count(session_id)
FROM
(
SELECT Trunc(TIMESTAMP, 'HH') dayhour, TIMESTAMP , event_type ,
session_id , data
FROM bb_bb60_stats.activity_accumulator
WHERE data = 'Login succeeded.'
)
GROUP BY dayhour
ORDER BY dayhour
/


/*
DAYHOUR,            COUNT(SESSION_ID)
22.03.2009 00:00:00	101
22.03.2009 01:00:00	75
22.03.2009 02:00:00	67
22.03.2009 03:00:00	50
22.03.2009 04:00:00	34
22.03.2009 05:00:00	25
22.03.2009 06:00:00	25
22.03.2009 07:00:00	45
22.03.2009 08:00:00	95
22.03.2009 09:00:00	159
22.03.2009 10:00:00	194
22.03.2009 11:00:00	302
22.03.2009 12:00:00	384
22.03.2009 13:00:00	459
22.03.2009 14:00:00	521
22.03.2009 15:00:00	547
22.03.2009 16:00:00	596
22.03.2009 17:00:00	569
22.03.2009 18:00:00	457
22.03.2009 19:00:00	529
22.03.2009 20:00:00	621
22.03.2009 21:00:00	641
22.03.2009 22:00:00	628
22.03.2009 23:00:00	538
*/