SELECT course_main.course_id, SUBSTR(course_id,-1,REGEXP_INSTR('%-%',REVERSE(course_id))-1) AS Term
FROM bb_bb60.course_main
WHERE course_main.course_id like 'WBCT-%';