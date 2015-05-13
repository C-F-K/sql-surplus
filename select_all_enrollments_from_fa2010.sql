SELECT u.user_id, course_main.course_id, cu.available_ind,
cu.row_status, cu.data_src_pk1 as ENR_DSRC,
u.data_src_pk1 as USER_DSRC, cu.dtmodified
FROM bb_bb60.course_users cu INNER JOIN bb_bb60.course_main cm on cu.crsmain_pk1 = cm.pk1
INNER JOIN bb_bb60.users u ON cu.users_pk1 = u.pk1
WHERE course_main.course_id LIKE '%FA2010%'AND
cu.data_src_pk1 < '20' AND u.user_id NOT LIKE 'stu_%' AND
u.user_id not like '%student%' AND u.user_id not like '%faculty%' AND
u.user_id <> 'bross' AND u.user_id NOT LIKE 'temp-olw%' AND
cu.role = 'S' and u.institution_roles_pk1 = '1';
