select min(timestamp), max(timestamp), user_pk1, course_pk1, session_id
from bb_bb60.activity_accumulator
where timestamp > sysdate-30
--and user_pk1=(select pk1 from users where user_id='glparker')
--and course_pk1=(select pk1 from course_main where course_id='ACT_TESTCOURSE')
group by user_pk1, course_pk1, session_id
order by min(timestamp)
;