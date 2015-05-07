SELECT cm.course_id, COUNT(gg.pk1) AS GradeCount
FROM course_main cm
INNER JOIN course_users cu ON cm.pk1 = cu.crsmain_pk1
LEFT JOIN gradebook_grade gg ON cu.pk1 = gg.course_users_pk1
WHERE cm.available_ind = 'Y' AND cm.row_status = '0'
GROUP BY cm.course_id 
ORDER BY GradeCount ASC