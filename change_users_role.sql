/* Shows Current courses and the role on those courses */

SELECT COURSE_NAME, COURSE_ID, ROLE
  FROM (SELECT CRSMAIN_PK1, ROLE
  	  FROM BB_BB60.COURSE_USERS
  	 WHERE USERS_PK1 = (SELECT PK1
  	 		      FROM BB_BB60.USERS
  	 		     WHERE USER_ID = 'USER_ID')) A,
       (SELECT COURSE_NAME, COURSE_ID, PK1
          FROM BB_BB60.COURSE_MAIN) B
 WHERE A.CRSMAIN_PK1 = B.PK1
 

/* Changes the user's role on all courses from COURE_BUILDER to instructor */
/* You can search and change for all roles using the following roles 
   S - Student
   P - Instructor
   T - Teaching Assistant
   B - Course Builder
   G - Grader
   U - Guest */

UPDATE BB_BB60.COURSE_USERS
   SET ROLE = 'P'
 WHERE USERS_PK1 = (SELECT PK1
 		      FROM BB_BB60.USERS
 		     WHERE USER_ID = 'USER_ID')
   AND ROLE='B'