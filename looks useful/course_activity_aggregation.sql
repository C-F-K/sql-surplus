--List all courses sorted by the amount of activity performed:

select course_id, sum(duration_time) as seconds, sum(click) as activity_clicks
from bb_bb60_stats.bi_data
group by course_id
order by activity_clicks desc;

--List courses and users who accessed them with the most frequently activity at the top:

select course_id, user_id, sum(duration_time) as seconds,
sum(click) as activity_clicks
from bb_bb60_stats.bi_data group by course_id, user_id
order by activity_clicks desc;

---List users who accessed the system sorted by the amount of activity they performed:

select user_id, sum(duration_time) as seconds, sum(click) as activity_clicks;

--List active users per role (how many students, faculty etc.) 

select c.role_name as Roles, count(distinct a.user_pk1) as Count
from bb_bb60_stats.bi_data a, bb_bb60_stats.USERS b,
bb_bb60_stats.INSTITUTION_ROLES c
where a.user_pk1 = b.pk1(+) and b.institution_roles_pk1=c.pk1(+)
group by c.role_name;

--Show users and their activity level 

select student_id, user_id, sum(click) as Activity,
sum(duration_time) as Seconds, count(distinct course_id) as Courses
from bb_bb60_stats.bi_data
group by student_id, user_id order by user_id;
