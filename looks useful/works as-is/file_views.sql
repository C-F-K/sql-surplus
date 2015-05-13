select c.course_id, u.user_id, a.TIMESTAMP
from bb_bb60.ACTIVITY_ACCUMULATOR a, bb_bb60.USERS u, bb_bb60.COURSE_MAIN c
where
--where COURSE_PK1=6341 and CONTENT_PK1=1065312 and 
a.USER_PK1=u.PK1 and a.COURSE_PK1=c.PK1 and
Timestamp > sysdate - 31;
