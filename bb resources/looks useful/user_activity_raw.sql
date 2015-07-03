USE BBLEARN
SELECT u.user_id, aa.event_type, cm.course_id,
aa.internal_handle, aa.data, aa.timestamp, aa.messages, aa.session_id,
datediff(dy, timestamp, CURRENT_TIMESTAMP) as ddiff
FROM bb_bb60.activity_accumulator aa
INNER JOIN bb_bb60.course_main cm ON aa.course_pk1 = cm.pk1
INNER JOIN bb_bb60.users u ON aa.user_pk1 = u.pk1
WHERE u.user_id = 'someuser'
AND datediff(dy, timestamp, CURRENT_TIMESTAMP) < 10
AND course_id <> ''