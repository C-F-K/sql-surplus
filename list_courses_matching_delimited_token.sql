SELECT course_main.course_id, RIGHT(course_id,PATINDEX('%-%',REVERSE(course_id))-1) AS Term
FROM course_main
WHERE course_main.course_id like 'WBCT-%'