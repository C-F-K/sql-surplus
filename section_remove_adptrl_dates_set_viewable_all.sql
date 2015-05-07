update cc
set start_date = NULL, end_date = NULL, available_ind = 'Y'
FROM course_contents cc
INNER JOIN course_main cm on cc.crsmain_pk1 = cm.pk1
WHERE cm.course_id = 'dev-cc-bs0607-1'