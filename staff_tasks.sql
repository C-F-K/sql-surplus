/* Note the ROLE='P' which determines this user is an instructor */
/* The other roles you can check are:
   S - Student
   P - Instructor
   T - Teaching Assistant
   B - Course Builder
   G - Grader
   U - Guest */

SELECT CM.COURSE_ID, 
       CM.COURSE_NAME, 
	T.SUBJECT, 
	T.DESCRIPTION, 
	T.DUEDATE DUEDATE, 
       REPLACE(T.PRIORITY, 'L', 'S') PRIORITY 
  FROM BB_BB60.COURSE_MAIN CM, 
       BB_BB60.TASKS T, 
      (SELECT CRSMAIN_PK1 
	 FROM BB_BB60.COURSE_USERS 
	WHERE ROLE='P'
	  AND USERS_PK1 IN (SELECT PK1 
		              FROM BB_BB60.USERS 
			     WHERE USER_ID ='dbrown')) ID 
 WHERE CM.PK1 = T.CRSMAIN_PK1 
   AND T.CRSMAIN_PK1 = ID.CRSMAIN_PK1 
   AND TO_DATE(DUEDATE,'DD/MM/YYYY') >= TO_DATE(SYSDATE,'DD/MM/YYYY') 
   AND TO_DATE(DUEDATE,'DD/MM/YYYY') <= TO_DATE((SYSDATE+7),'DD/MM/YYYY')
ORDER BY DUEDATE, PRIORITY ASC;	