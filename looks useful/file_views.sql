select c.course_id, u.user_id, a.TIMESTAMP
from ACTIVITY_ACCUMULATOR a, USERS u, COURSE_MAIN c
where COURSE_PK1=6341 and CONTENT_PK1=1065312 and a.USER_PK1=u.PK1 and a.COURSE_PK1=c.PK1 and
Timestamp > sysdate -31