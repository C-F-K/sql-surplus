


SELECT COUNT(*) FROM bb_bb60.course_main WHERE pk1 IN ( SELECT crsmain_pk1 FROM bb_bb60.course_contents WHERE cnthndlr_handle = 'resource/x-bb-externallink' GROUP BY crsmain_pk1) and dtmodified BETWEEN TO_DATE('01-09-2005', 'DD-MM-YYYY') AND TO_DATE('31-08-2006', 'DD-MM-YYYY')

SELECT COUNT(*) FROM bb_bb60.course_main WHERE pk1 IN ( SELECT crsmain_pk1 FROM bb_bb60.course_contents WHERE cnthndlr_handle = 'resource/x-bb-courselink' GROUP BY crsmain_pk1) AND dtmodified BETWEEN TO_DATE('01-09-2005', 'DD-MM-YYYY') AND TO_DATE('31-08-2006', 'DD-MM-YYYY')

SELECT COUNT(*) FROM bb_bb60.course_main WHERE pk1 IN ( SELECT crsmain_pk1 FROM bb_bb60.course_contents WHERE cnthndlr_handle = 'resource/x-plugin-scorm' GROUP BY crsmain_pk1) AND dtmodified BETWEEN TO_DATE('01-09-2005', 'DD-MM-YYYY') AND TO_DATE('31-08-2006', 'DD-MM-YYYY')

SELECT COUNT(*) FROM bb_bb60.course_main WHERE pk1 IN ( SELECT crsmain_pk1 FROM bb_bb60.course_contents WHERE cnthndlr_handle = 'resource/x-turnitin-assignment' GROUP BY crsmain_pk1) AND dtmodified BETWEEN TO_DATE('01-09-2005', 'DD-MM-YYYY') AND TO_DATE('31-08-2006', 'DD-MM-YYYY')

SELECT COUNT(*) FROM bb_bb60.course_main WHERE pk1 IN ( SELECT crsmain_pk1 FROM bb_bb60.course_contents WHERE cnthndlr_handle = 'resource/x-wimba' GROUP BY crsmain_pk1) AND dtmodified BETWEEN TO_DATE('01-09-2005', 'DD-MM-YYYY') AND TO_DATE('31-08-2006', 'DD-MM-YYYY')

SELECT COUNT(*) FROM bb_bb60.course_main WHERE pk1 IN ( SELECT crsmain_pk1 FROM bb_bb60.course_contents WHERE cnthndlr_handle = 'resource/x-bb-assignment' GROUP BY crsmain_pk1) AND dtmodified BETWEEN TO_DATE('01-09-2005', 'DD-MM-YYYY') AND TO_DATE('31-08-2006', 'DD-MM-YYYY')




/*Courses which have used the Tests*/
SELECT COUNT(*) FROM (
SELECT course_name, course_id FROM bb_bb60.COURSE_MAIN
WHERE pk1 IN (SELECT course_pk1 FROM bb_bb60_stats.activity_accumulator
WHERE INTERNAL_HANDLE LIKE 'cp_test_manager'
AND TIMESTAMP BETWEEN TO_DATE('01-09-2005', 'DD-MM-YYYY') AND TO_DATE('31-08-2006', 'DD-MM-YYYY')
GROUP BY course_pk1)
AND course_name NOT LIKE '%Personal Test Module%'
ORDER BY COURSE_ID)

/*Courses which have used the Tasks*/
SELECT COUNT(*) FROM (
SELECT course_name, course_id FROM bb_bb60.COURSE_MAIN
WHERE pk1 IN (SELECT course_pk1 FROM bb_bb60_stats.activity_accumulator
WHERE INTERNAL_HANDLE LIKE 'cp_tasks'
AND TIMESTAMP BETWEEN TO_DATE('01-09-2005', 'DD-MM-YYYY') AND TO_DATE('31-08-2006', 'DD-MM-YYYY')
GROUP BY course_pk1)
AND course_name NOT LIKE '%Personal Test Module%'
ORDER BY COURSE_ID)

/*Courses which have used the Surveys*/
SELECT COUNT(*) FROM (
SELECT course_name, course_id FROM bb_bb60.COURSE_MAIN
WHERE pk1 IN (SELECT course_pk1 FROM bb_bb60_stats.activity_accumulator
WHERE INTERNAL_HANDLE LIKE 'cp_survey_manager'
AND TIMESTAMP BETWEEN TO_DATE('01-09-2005', 'DD-MM-YYYY') AND TO_DATE('31-08-2006', 'DD-MM-YYYY')
GROUP BY course_pk1)
AND course_name NOT LIKE '%Personal Test Module%'
ORDER BY COURSE_ID)

/*Courses which have used the Digital Drop Box*/
SELECT COUNT(*) FROM (
SELECT course_name, course_id FROM bb_bb60.COURSE_MAIN
WHERE pk1 IN (SELECT course_pk1 FROM bb_bb60_stats.activity_accumulator
WHERE INTERNAL_HANDLE LIKE 'cp_digital_dropbox'
AND TIMESTAMP BETWEEN TO_DATE('01-09-2005', 'DD-MM-YYYY') AND TO_DATE('31-08-2006', 'DD-MM-YYYY')
GROUP BY course_pk1)
AND course_name NOT LIKE '%Personal Test Module%'
ORDER BY COURSE_ID)

/*Courses which have used the Discussion Board*/
SELECT COUNT(*) FROM (
SELECT course_name, course_id FROM bb_bb60.COURSE_MAIN
WHERE pk1 IN (SELECT course_pk1 FROM bb_bb60_stats.activity_accumulator
WHERE INTERNAL_HANDLE LIKE 'cp_discussion_board'
AND TIMESTAMP BETWEEN TO_DATE('01-09-2005', 'DD-MM-YYYY') AND TO_DATE('31-08-2006', 'DD-MM-YYYY')
GROUP BY course_pk1)
AND course_name NOT LIKE '%Personal Test Module%'
ORDER BY COURSE_ID)

/*Courses which have used the Announcements*/
SELECT COUNT(*) FROM (
SELECT course_name, course_id FROM bb_bb60.COURSE_MAIN
WHERE pk1 IN (SELECT course_pk1 FROM bb_bb60_stats.activity_accumulator
WHERE INTERNAL_HANDLE LIKE 'cp_announcements'
AND TIMESTAMP BETWEEN TO_DATE('01-09-2005', 'DD-MM-YYYY') AND TO_DATE('31-08-2006', 'DD-MM-YYYY')
GROUP BY course_pk1)
AND course_name NOT LIKE '%Personal Test Module%'
ORDER BY COURSE_ID)

/*Courses which have used the Groups*/
SELECT COUNT(*) FROM (
SELECT course_name, course_id FROM bb_bb60.COURSE_MAIN
WHERE pk1 IN (SELECT course_pk1 FROM bb_bb60_stats.activity_accumulator
WHERE INTERNAL_HANDLE LIKE 'cp_add_group'
AND TIMESTAMP BETWEEN TO_DATE('01-09-2005', 'DD-MM-YYYY') AND TO_DATE('31-08-2006', 'DD-MM-YYYY')
GROUP BY course_pk1)
AND course_name NOT LIKE '%Personal Test Module%'
ORDER BY COURSE_ID)

/*Courses which have used the email*/
SELECT COUNT(*) FROM (
SELECT course_name, course_id FROM bb_bb60.COURSE_MAIN
WHERE pk1 IN (SELECT course_pk1 FROM bb_bb60_stats.activity_accumulator
WHERE INTERNAL_HANDLE LIKE 'cp_send_email%'
AND TIMESTAMP BETWEEN TO_DATE('01-09-2005', 'DD-MM-YYYY') AND TO_DATE('31-08-2006', 'DD-MM-YYYY')
GROUP BY course_pk1)
AND course_name NOT LIKE '%Personal Test Module%'
ORDER BY COURSE_ID)
